//
//  KJHomeVC.m
//  GuessWho
//
//  Created by 杨科军 on 2018/11/18.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJGameVC.h"
#import <SceneKit/SceneKit.h>
#import <AVFoundation/AVFoundation.h>
#import "KJAccView.h"
#import "UIImage+DiscernColor.h" // 获取图片主要颜色
#import "KJErrorView.h" // 错误渐变效果

@interface KJGameVC (){
    AVAudioPlayer *audioPlayer;
    NSInteger sure_index;
    UIColor *mainColor;
    BOOL isSure;
}
@property (weak, nonatomic) IBOutlet UIView *DisplayScnview;
@property (nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger kj_index;
@property (weak, nonatomic) IBOutlet UIButton *A_Button;
@property (weak, nonatomic) IBOutlet UIButton *B_Button;
@property (weak, nonatomic) IBOutlet UIButton *C_Button;
@property (weak, nonatomic) IBOutlet UIButton *D_Button;
@property (weak, nonatomic) IBOutlet UIImageView *leftBoxImageView;

@end

@implementation KJGameVC

- (void)dealloc{
    audioPlayer = nil;
    _DisplayScnview = nil;
}
- (instancetype)initWithSCNFileName:(NSString*)fileName Name:(NSString*)name{
    if (self=[super init]) {
        self.name = name;
        self.fileName = fileName;
        // 获取主色调
//        mainColor = [UIImage kj_mostColor:[UIImage imageNamed:fileName]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setSubview];
    
    // 播放背景音乐
    [self playMusic];
    
    // 随机答案
    [self kj_randomAnswer];
}

- (void)_setSubview{
    // 1. 加载场景
    NSString *sceneFilePath = [NSString stringWithFormat:@"art.scnassets/%@.scn",_fileName];
    SCNScene *scene = [SCNScene sceneNamed:sceneFilePath];
    // 2. 加载相机
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.position = SCNVector3Make(0, 0, 15);// 设置起始位置
    cameraNode.camera = [SCNCamera camera];
    [scene.rootNode addChildNode:cameraNode];
    
    // 3. 场景显示视图
    SCNView *scnView = (SCNView *)self.DisplayScnview;
    scnView.backgroundColor = UIColor.clearColor;
    scnView.scene = scene;
    
    // 4. 添加手势
    scnView.allowsCameraControl = YES; // 允许用户手势操作
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:scnView.gestureRecognizers];
    scnView.gestureRecognizers = gestureRecognizers;
    
    // 5. 加载精灵
    SCNNode *node = scene.rootNode.childNodes.firstObject;//把节点添加到场景
    
    // 设置起始位置
    SCNVector3 position = node.presentationNode.position;
    position.x += -0.4;
    position.y += -5;
    position.z += -1.2;
    node.position = position;
    // 角度
    SCNVector3 euler = node.presentationNode.eulerAngles;
    euler.x += 0;
    euler.y += 0;
    euler.z += 0;
    node.eulerAngles = euler;
    // 大小尺寸
    SCNVector3 scale = node.presentationNode.scale;
    scale.x -= 0.96;
    scale.y -= 0.96;
    scale.z -= 0.96;
    node.scale = scale;
    
    // 绕y轴一直旋转
    SCNAction *action = [SCNAction repeatActionForever:[SCNAction rotateByX:0 y:1 z:0 duration:2]];
    [node runAction:action];
    
    if (!isSure) {
        // 6. 添加环境光源
        SCNNode *lightNode = [SCNNode node];
        lightNode.light = [SCNLight light];
        lightNode.light.type = SCNLightTypeOmni;
        lightNode.position = SCNVector3Make(0, 20, 0);
        [scene.rootNode addChildNode:lightNode];
        
        // 7. 修改颜色
        for (SCNMaterial *material in node.geometry.materials) {
            material.emission.contents = [UIColor blackColor];
            material.diffuse.intensity = 0;
        }
    }
}

// 重新加载scnview
- (void)reloadScnview{
    isSure = YES;
    [self _setSubview];
}

#pragma mark - 点击事件
- (void)handleTap:(UIGestureRecognizer*)gestureRecognize{
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration:0.5];
    [SCNTransaction commit];
}

- (void)playMusic{
    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"shenqibaobei" ofType:@"mp3"]; //创建音乐文件路径
    NSURL *musicURL = [[NSURL alloc] initFileURLWithPath:musicFilePath];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    //创建播放器
    [audioPlayer prepareToPlay];
    [audioPlayer setVolume:1];   //设置音量大小
    audioPlayer.numberOfLoops = -1;//设置音乐播放次数  -1为一直循环
    [audioPlayer play]; //播放
}

- (IBAction)backClickButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)soundClickButton:(UIButton *)sender {
    if (audioPlayer.playing) {
        [audioPlayer pause];
    }else{
        [audioPlayer play];
    }
}

- (IBAction)ClickButton:(UIButton *)sender {
    if (sender.tag-520==sure_index) {
        [self reloadScnview];
        KJAccView *accView = [[KJAccView alloc] init];
        [self.view addSubview:accView];
        [accView showWithImage:[UIImage imageNamed:_fileName] Name:_name];
    }
    else{
        [KJErrorView createErrorView:^(KJErrorView * _Nonnull obj) {
            obj.Frame(self.view.bounds).AddView(self.view);
        }];
    }
}

// 渐隐  isAlpha:是否为隐藏, Alpha:隐藏系数 Duration:移动持续时间, TransCount:重复次数(0:表示一直转)
- (void)viewAnimationOpacity:(UIView*)myView Alpha:(CGFloat)kj_a Duration:(CGFloat)duration TransCount:(int)num isFlash:(BOOL)flash{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = duration;
    animation.repeatCount = num == 0 ? CGFLOAT_MAX : num;  // 重复次数
    if (flash){
        animation.autoreverses = YES; // 动画结束时是否执行逆动画
    }
    animation.toValue = [NSNumber numberWithFloat:kj_a]; // 结束时的倍率
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    [myView.layer addAnimation:animation forKey:@"op"];
}

#pragma mark - 内部方法
- (void)kj_randomAnswer{
    sure_index = [self kj_randomSureAnswer];
    NSArray *ran = [self kj_randomThree];
    switch (sure_index) {
        case 0:{
            [self.A_Button setTitle:[NSString stringWithFormat:@"A. %@",self.name] forState:UIControlStateNormal];
            [self.B_Button setTitle:[NSString stringWithFormat:@"B. %@",ran[0]] forState:UIControlStateNormal];
            [self.C_Button setTitle:[NSString stringWithFormat:@"C. %@",ran[1]] forState:UIControlStateNormal];
            [self.D_Button setTitle:[NSString stringWithFormat:@"D. %@",ran[2]] forState:UIControlStateNormal];
        }
            break;
        case 1:{
            [self.A_Button setTitle:[NSString stringWithFormat:@"A. %@",ran[0]] forState:UIControlStateNormal];
            [self.B_Button setTitle:[NSString stringWithFormat:@"B. %@",self.name] forState:UIControlStateNormal];
            [self.C_Button setTitle:[NSString stringWithFormat:@"C. %@",ran[1]] forState:UIControlStateNormal];
            [self.D_Button setTitle:[NSString stringWithFormat:@"D. %@",ran[2]] forState:UIControlStateNormal];
        }
            break;
        case 2:{
            [self.A_Button setTitle:[NSString stringWithFormat:@"A. %@",ran[0]] forState:UIControlStateNormal];
            [self.B_Button setTitle:[NSString stringWithFormat:@"B. %@",ran[1]] forState:UIControlStateNormal];
            [self.C_Button setTitle:[NSString stringWithFormat:@"C. %@",self.name] forState:UIControlStateNormal];
            [self.D_Button setTitle:[NSString stringWithFormat:@"D. %@",ran[2]] forState:UIControlStateNormal];
        }
            break;
        case 3:{
            [self.A_Button setTitle:[NSString stringWithFormat:@"A. %@",ran[0]] forState:UIControlStateNormal];
            [self.B_Button setTitle:[NSString stringWithFormat:@"B. %@",ran[1]] forState:UIControlStateNormal];
            [self.C_Button setTitle:[NSString stringWithFormat:@"C. %@",ran[2]] forState:UIControlStateNormal];
            [self.D_Button setTitle:[NSString stringWithFormat:@"D. %@",self.name] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}
- (NSInteger)kj_randomSureAnswer{
    return arc4random() % 4;
}
- (NSArray*)kj_randomThree{
    NSArray *array = @[@"小拳石",
                       @"隆隆石",
                       @"隆隆岩",
                       @"小火马",
                       @"烈焰马",
                       @"呆呆兽",
                       @"呆河马",
                       @"三合一磁怪",
                       @"大葱鸭",
                       @"嘟嘟",
                       @"嘟嘟利",
                       @"小海狮",
                       @"白海狮",
                       @"臭泥",
                       @"臭臭泥",
                       @"大舌贝",
                       @"铁甲贝",
                       @"鬼斯",
                       @"鬼斯通",
                       @"耿鬼",
                       @"大岩蛇",
                       @"素利普",
                       @"素利拍",
                       @"大钳蟹",
                       @"巨钳蟹",
                       @"雷电球",
                       @"顽皮弹",
                       @"蛋蛋",
                       @"椰蛋树",
                       @"可拉可拉",
                       @"嗄拉嗄拉",
                       @"沙瓦郎",
                       @"艾比郎",
                       @"大舌头",
                       @"瓦斯弹",
                       @"双弹瓦斯",
                       @"铁甲犀牛",
                       @"铁甲暴龙",
                       @"水精灵",
                       @"雷精灵",
                       @"火精灵",
                       @"3D龙",
];
    NSMutableSet *randomSet = [[NSMutableSet alloc] init];
    
    while ([randomSet count] < 3) {
        int r = arc4random() % [array count];
        [randomSet addObject:[array objectAtIndex:r]];
    }
    
    NSArray *randomArray = [randomSet allObjects];
//    NSLog(@"%@",randomArray);
    return randomArray;
}

@end
