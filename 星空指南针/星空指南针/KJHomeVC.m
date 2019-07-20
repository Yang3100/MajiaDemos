//
//  HomeVC.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/20.
//  Copyright © 2018年 杨科军. All rights reserved.
//
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "KJHomeVC.h"
#import "KJCompassView.h" // 指南针
#import "KJSelectView.h"
#import "KJHelpVC.h"

@interface KJHomeVC (){
    BOOL isNewView;
}

@property(nonatomic,strong) KJCompassView *compassView;// 指南针
@property(nonatomic,strong) UIImageView *YLanimation4;//语聊入口第四层

/// 自定义的导航条
@property (nonatomic, readwrite, weak)UIView *navBar;

@end

@implementation KJHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    isNewView=YES;
    [self addAnimation];
    
    UITapGestureRecognizer *panGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.YLanimation4 addGestureRecognizer:panGestureRecognizer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)applicationBecomeActive:(UIApplication *)application{
    // app启动或者app从后台进入前台都会调用这个方法
    [self addAnimation];
}

//试图将要出现
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!isNewView) {
        [self addAnimation];
    }
}
//试图已经出现
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (isNewView) {
        [self addAnimation];
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    isNewView = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - SetUI
- (void)setUI{
    KJEmitterView *emitter = [KJEmitterView createEmitterViewWithType:(KJEmitterTypeStarrySky) Block:^(KJEmitterView *obj) {
        obj.KJFrame(self.view.bounds).KJBackgroundColor(MainColor).KJAddView(self.view);
    }];
    
    // 初始化背景天空渐变色
    CAGradientLayer *backgroundLayer = [[CAGradientLayer alloc] init];
    // 设置背景渐变色层的大小
    backgroundLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIColor *darkColor = UIColorFromHEXA(0x000000, 1);
    UIColor *lightColor = UIColorFromHEXA(0x101010, 0.1);
    backgroundLayer.colors = @[(__bridge id)lightColor.CGColor,(__bridge id)darkColor.CGColor];
    // 让变色层成180度角变色
    backgroundLayer.startPoint = CGPointMake(0, 0);
    backgroundLayer.endPoint = CGPointMake(1, 1);
    [emitter.layer addSublayer:backgroundLayer];
    
    [self.YLanimation4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.width.height.mas_equalTo(Handle(350));
    }];
    
    [self.view addSubview:self.compassView];
    
    UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, kSTATUSBAR_NAVIGATION_HEIGHT, kScreenW, kSTATUSBAR_NAVIGATION_HEIGHT)];
    self.navBar = navBar;
    [self.view addSubview:navBar];
    
    UILabel *name = InsertLabel(navBar, CGRectZero, NSTextAlignmentCenter, @"星空指南针", SystemFontSize(22), [UIColor whiteColor]);
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(navBar);
        make.height.mas_equalTo(Handle(20));
        make.top.mas_equalTo(self.view).mas_offset(kSTATUSBAR_NAVIGATION_HEIGHT/2);
    }];
    
    UIButton *leftButton = InsertImageButton(self.view, CGRectZero, 519, GetImage(@"changeZhizheng"), nil, self, @selector(btnClick:));
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(navBar).mas_offset(Handle(20));
        make.height.width.mas_equalTo(Handle(22));
        make.top.mas_equalTo(self.view).mas_offset(kSTATUSBAR_NAVIGATION_HEIGHT/2);
    }];
    
    UIButton *rightButton = InsertImageButton(self.view, CGRectZero, 520, GetImage(@"help"), nil, self, @selector(btnClick:));
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(navBar).mas_offset(Handle(-20));
        make.height.width.mas_equalTo(Handle(22));
        make.top.mas_equalTo(self.view).mas_offset(kSTATUSBAR_NAVIGATION_HEIGHT/2);
    }];
}
- (void)btnClick:(UIButton*)sender{
    switch (sender.tag) {
        case 519:{ // 修改指正
            KJSelectView *emitterView = [KJSelectView createSelectView:^(KJSelectView *obj) {
                
            }];
            emitterView.updateClicked = ^(NSString *str) {
                self.compassView.pointerImage = [UIImage imageNamed:str];
            };
            [self.view addSubview:emitterView];
        }
            break;
        case 520:{ // 使用帮助
            KJHelpVC *vc = [[KJHelpVC alloc]init];
            [self presentViewController:vc animated:NO completion:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UI
- (UIImageView*)YLanimation4{
    if (!_YLanimation4) {
        UIImage *image = [UIImage imageNamed:@"home_sdaf"];
        _YLanimation4 =InsertImageView(self.view, CGRectZero,image);
    }
    return _YLanimation4;
}

- (KJCompassView*)compassView{
    if (!_compassView) {
        KJCompassView *compassView = [KJCompassView sharedWithRect:self.view.bounds radius:(self.view.bounds.size.width-20)/2];
//        compassView.backgroundColor = [UIColor blackColor];
        compassView.alpha = 1;
        compassView.textColor = [UIColor whiteColor];
        compassView.calibrationColor = [UIColor whiteColor];
        compassView.horizontalColor = [UIColor redColor];
        _compassView = compassView;
    }
    return _compassView;
}

#pragma mark - 动画流程
-(void)addAnimation{
    if (isNewView) {
        [KJTools viewAnimationZoom:self.YLanimation4 Multiple:1 Duration:0.2 TransCount:1 isGroup:NO starSize:0 starTime:0];
    }
    [KJTools viewAnimationRotate:self.YLanimation4 isRight:NO speed:50.0 TransCount:0];
    [KJTools viewAnimationOpacity:self.YLanimation4 Alpha:0.2f Duration:1 TransCount:0 isFlash:YES];
}

#pragma mark - addClick
- (void)handlePan:(UITapGestureRecognizer*) recognizer{
    [UIView animateWithDuration:1 animations:^{
        self.YLanimation4.alpha = 0;
        [self.YLanimation4 removeFromSuperview];
        self.compassView.alpha = 1;
    }];
}
@end









