//
//  KJARVC.m
//  3dTraffic
//
//  Created by 杨科军 on 2018/11/14.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJARVC.h"
#import <ARKit/ARKit.h>
#import "KJModelNode.h"
#import "KJEmitterView.h"
#import <AVFoundation/AVFoundation.h>

@interface KJARVC ()<ARSCNViewDelegate,UINavigationControllerDelegate>{
    AVAudioPlayer *audioPlayer;
}

@property (weak, nonatomic) IBOutlet ARSCNView *scnView;
@property (strong,nonatomic) KJModelNode *node;

@end

@implementation KJARVC
#pragma mark - Status bar
- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}
- (BOOL)shouldAutorotate{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

//注意是 viewWillAppear 方法
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //设置代理即可 - 隐藏navigation
    self.navigationController.delegate = self;
}

- (void)dealloc{
    audioPlayer = nil;
    _scnView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setNavigationBar];
    [self addScnView];
    
    // 添加粒子效果
    [KJEmitterView createEmitterView:^(KJEmitterView *obj) {
        obj.BackgroundColor(UIColor.clearColor).Frame(self.view.bounds).AddView(self.scnView);
    }];
    
    // AR使用后置摄像头，追踪设备的方向和位置以及检测真实世界平面的配置。
    ARWorldTrackingConfiguration *configuration = [[ARWorldTrackingConfiguration alloc]init];
    configuration.planeDetection = ARPlaneDetectionHorizontal;
    // 确定虚拟坐标系如何与现实世界对齐
    configuration.worldAlignment = ARWorldAlignmentCamera;
    [self.scnView.session runWithConfiguration:configuration];
    
    // 播放背景音乐
    [self playMusic];
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
}

- (void)addScnView{
    self.node = [[KJModelNode alloc]initNodeFromFileName:self.name];
    [self.scnView.scene.rootNode addChildNode:_node];
    
    self.scnView.allowsCameraControl = YES;
    // show statistics such as fps and timing information
    self.scnView.showsStatistics = YES;
    self.scnView.delegate = self;
    
//    // add a tap gesture recognizer
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    NSMutableArray *gestureRecognizers = [NSMutableArray array];
//    [gestureRecognizers addObject:tapGesture];
//    [gestureRecognizers addObjectsFromArray:_scnView.gestureRecognizers];
//    _scnView.gestureRecognizers = gestureRecognizers;
}

//- (void)handleTap:(UIGestureRecognizer*)gestureRecognize{
//    // retrieve the SCNView
//    SCNView *scnView = self.scnView;
//
//    // check what nodes are tapped
//    CGPoint p = [gestureRecognize locationInView:scnView];
//    NSArray *hitResults = [scnView hitTest:p options:nil];
//
//    // check that we clicked on at least one object
//    if([hitResults count] > 0){
//        // retrieved the first clicked object
//        SCNHitTestResult *result = [hitResults objectAtIndex:0];
//
//        // get its material
//        SCNMaterial *material = result.node.geometry.firstMaterial;
//
//        // highlight it
//        [SCNTransaction begin];
//        [SCNTransaction setAnimationDuration:0.5];
//
//        // on completion - unhighlight
//        [SCNTransaction setCompletionBlock:^{
//            [SCNTransaction begin];
//            [SCNTransaction setAnimationDuration:0.5];
////            material.emission.contents = UIColor.clearColor;
//            [SCNTransaction commit];
//        }];
//
//        material.emission.contents = [UIColor redColor];
//        [SCNTransaction commit];
//    }
//}

- (void)playMusic{
    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"shenqibaobei" ofType:@"mp3"]; //创建音乐文件路径
    NSURL *musicURL = [[NSURL alloc] initFileURLWithPath:musicFilePath];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    //创建播放器
    [audioPlayer prepareToPlay];
    [audioPlayer setVolume:1];   //设置音量大小
    audioPlayer.numberOfLoops = -1;//设置音乐播放次数  -1为一直循环
    [audioPlayer play];   //播放
}

- (void)_setNavigationBar{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    //    [button setTitle:@"返回" forState:UIControlStateNormal];
    //    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.frame = CGRectMake(10, 20, 50, 50);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:[UIImage imageNamed:@"jingyin"] forState:UIControlStateNormal];
    //    [button2 setTitle:@"静音" forState:UIControlStateNormal];
    //    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // 让按钮内部的所有内容左对齐
    button2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button2.frame = CGRectMake(MainSize.width-50, 20, 50, 50);
    [button2 addTarget:self action:@selector(buttonClick2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)buttonClick{
    if ([KJARVC kj_judgeCurrentVCIsPushOrPrsent:self]){  // push方式进入
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)buttonClick2{
    if (audioPlayer.playing) {
        [audioPlayer pause];
    }else{
        [audioPlayer play];
    }
}
// 判断当前页面是push方式进入还是present方式进入
+ (int)kj_judgeCurrentVCIsPushOrPrsent:(UIViewController*)vc{
    NSArray *viewcontrollers = vc.navigationController.viewControllers;
    if (viewcontrollers.count>1){
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==vc){
            //push方式
            return 1;
        }
    }
    return 0;//present方式
}

#pragma mark - ARSCNViewDelegate
- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor{
    
}

@end
