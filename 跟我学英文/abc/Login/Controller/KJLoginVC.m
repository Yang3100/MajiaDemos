//
//  KJLoginAnimationViewController.h
//  AnimationDemo
//
//  Created by 杨科军 on 2017/11/22.
//  Copyright © 2017年 杨科军. All rights reserved.
//  登陆页面

#import "KJLoginVC.h"
#import "KJTextFiled.h"
#import "KJForgetPasswordVC.h"
#import "KJRegisterVC.h"
#import "AppDelegate.h"
#import "KJHomeVC.h"

@interface KJLoginVC ()<CAAnimationDelegate,UITextFieldDelegate>

/**
 背景图片
 */
@property(nonatomic,weak) UIImageView *bgImageView;
/** 头label*/
@property(nonatomic,weak) UILabel *headingLabel;
/** 用户名*/
@property(nonatomic,weak) KJTextFiled *userNameTextField;
/** 密码*/
@property(nonatomic,weak) KJTextFiled *passWordTextField;
/** 登录按钮*/
@property(nonatomic,weak) UIButton *loginBtn;
/** 忘记密码按钮*/
@property(nonatomic,weak) UIButton *forgetBtn;
/** 注册按钮*/
@property(nonatomic,weak) UIButton *registerBtn;

/** 云1*/
@property(nonatomic,weak)UIImageView *cloud1ImageV;
/** 云2*/
@property(nonatomic,weak)UIImageView *cloud2ImageV;
/** 云3*/
@property(nonatomic,weak)UIImageView *cloud3ImageV;
/** 云4*/
@property(nonatomic,weak)UIImageView *cloud4ImageV;

/** 菊花*/
@property(nonatomic,weak)UIActivityIndicatorView *spinner;
/** 状态*/
@property(nonatomic,weak)UIImageView *statusImageV;
/** 状态描述*/
@property(nonatomic,weak)UILabel *label;
/** 状态信息*/
@property(nonatomic,strong)NSArray *messages;
@property(nonatomic,assign)CGPoint statusPoint;

/**
 是否显示
 */
@property(nonatomic,assign,getter=isAppear)BOOL appear;
@end

@implementation KJLoginVC

#pragma mark --Lazy
-(NSArray *)messages {
    if (!_messages) {
        _messages = @[@"Loading"];
    }
    return _messages;
}

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    //设置显示
    self.appear                          = YES;
    
    CABasicAnimation *flyRightAnimation  = [CABasicAnimation animationWithKeyPath:@"position.x"];
    flyRightAnimation.delegate           = self;
    [flyRightAnimation setValue:@"form" forKey:@"name"];
    [flyRightAnimation setValue:self.headingLabel.layer forKey:@"layer"];
    flyRightAnimation.toValue            = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH * 0.5, 0)];
    flyRightAnimation.fromValue          = [NSValue valueWithCGPoint:CGPointMake(-SCREEN_WIDTH * 0.5, 0)];
    flyRightAnimation.duration           = .5;
    flyRightAnimation.fillMode           = kCAFillModeBoth;
    [self.headingLabel.layer addAnimation:flyRightAnimation forKey:nil];
    flyRightAnimation.beginTime          = CACurrentMediaTime() + 0.3;
    [flyRightAnimation setValue:self.userNameTextField.layer forKey:@"layer"];
    [self.userNameTextField.layer addAnimation:flyRightAnimation forKey:nil];
    flyRightAnimation.beginTime          = CACurrentMediaTime() + 0.4;
    [flyRightAnimation setValue:self.passWordTextField.layer forKey:@"layer"];
    [self.passWordTextField.layer addAnimation:flyRightAnimation forKey:nil];
    
    //cloud
    CABasicAnimation *fadeAnimation      = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue              = @0.;
    fadeAnimation.toValue                = @1.;
    fadeAnimation.duration               = .5;
    fadeAnimation.fillMode               = kCAFillModeBackwards;
    fadeAnimation.beginTime              = CACurrentMediaTime() + .5;
    [self.cloud1ImageV.layer addAnimation:fadeAnimation forKey:nil];
    fadeAnimation.beginTime              = CACurrentMediaTime() + .7;
    [self.cloud2ImageV.layer addAnimation:fadeAnimation forKey:nil];
    fadeAnimation.beginTime              = CACurrentMediaTime() + .9;
    [self.cloud3ImageV.layer addAnimation:fadeAnimation forKey:nil];
    fadeAnimation.beginTime              = CACurrentMediaTime() + 1.1;
    [self.cloud4ImageV.layer addAnimation:fadeAnimation forKey:nil];

    //loginBtn
//    self.loginBtn.centerY        += 30;
    self.loginBtn.alpha              = 0;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    //loginBtn
    CAAnimationGroup *groupAnimation   = [[CAAnimationGroup alloc]init];
    groupAnimation.beginTime           = CACurrentMediaTime() + .5;
    groupAnimation.duration            = .5;
    groupAnimation.fillMode            = kCAFillModeBackwards;
    groupAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *scaleDownAnimation   = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleDownAnimation.fromValue           = @3.5;
    scaleDownAnimation.toValue             = @1.;
    
    CABasicAnimation *rotateAnimation      = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue              = @M_PI_4;
    rotateAnimation.toValue                = @0;
    
    CABasicAnimation *fadeAnimation        = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue                = @0.;
    fadeAnimation.toValue                  = @1.;
    
    groupAnimation.animations              = @[fadeAnimation,scaleDownAnimation,rotateAnimation];
    [self.loginBtn.layer addAnimation:groupAnimation forKey:nil];
     self.loginBtn.alpha                   = 1;
    //云动画
    [self animationCloud:_cloud1ImageV.layer];
    [self animationCloud:_cloud2ImageV.layer];
    [self animationCloud:_cloud3ImageV.layer];
    [self animationCloud:_cloud4ImageV.layer];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //显示导航栏
    self.navigationController.navigationBar.hidden = NO;
    //设置不显示
    self.appear  = NO;
}

#pragma mark --Action
- (void)onClickForget{
    KJForgetPasswordVC *vc = [[KJForgetPasswordVC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)onClickRegister{
    KJRegisterVC *vc = [[KJRegisterVC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 登录按钮
- (void)onClickLogin:(UIButton*)loginBtn {
    if (self.userNameTextField.text.length < 6) {
//        [self.userNameTextField becomeFirstResponder];
//        [MBProgressHUD showSuccess:@"请输入您的账号"];
        return;
    }
    
    if (self.passWordTextField.text.length < 6) {
//        [MBProgressHUD showSuccess:@"请输入您的密码"];
//        [self.passWordTextField becomeFirstResponder];
        return;
    }
    
    [self.view endEditing:YES];
    loginBtn.enabled = NO;
    //弹簧动画变宽
    __weak typeof(self)weakself = self;
    [UIView animateWithDuration:1.5 delay:0. usingSpringWithDamping:.2 initialSpringVelocity:0. options:(UIViewAnimationOptionCurveLinear) animations:^{
        CGRect loginBounds                = self.loginBtn.bounds;
        loginBounds.size.width           += 80;
        weakself.loginBtn.bounds              = loginBounds;
    } completion:^(BOOL finished) {
        [weakself showMessageWithIndex:0];
    }];
    //spinner
    [UIView animateWithDuration:.33 delay:0 usingSpringWithDamping:.7 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        weakself.loginBtn.centerY         += 60;
        weakself.spinner.x                 = 40;
        weakself.spinner.alpha                = 1;
        weakself.spinner.centerY           = weakself.loginBtn.frame.size.height/2;
    } completion:^(BOOL finished) {
        
    }];
    
    //改变颜色
    UIColor *toColor = [UIColor colorWithRed:0.85 green:0.83 blue:0.45 alpha:1];
    [self tintBackgroundColorWithCALayer:self.loginBtn.layer toColor:toColor];
    //改变圆角
    [self roundCornersWithCALayer:self.loginBtn.layer toRadius:25];
    
    [self network];
}

- (void)network{
    [KJNetManager LoginForIphoneIsNum:self.userNameTextField.text Password:self.passWordTextField.text completionHandler:^(id responseObj, NSError *error) {
        if (KJ_CODE == 200) {
            /// 储存数据
            KJUserModel *model = [KJUserModel initUserModelManager];
            model.face = responseObj[@"data"][@"face"];
            model.nickname = responseObj[@"data"][@"nickname"];
            model.signature = responseObj[@"data"][@"signature"];
            model.userid = responseObj[@"data"][@"userid"];
            model.phone = responseObj[@"data"][@"phone"];
            
            /// 保存在本地
            NSString *acc = self.userNameTextField.text;
            NSString *pas = self.passWordTextField.text;
            [[NSUserDefaults standardUserDefaults] setValue:acc forKey:@"account"];
            [[NSUserDefaults standardUserDefaults] setValue:pas forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"F_install"];
            [[NSUserDefaults standardUserDefaults] setValue:model.userid forKey:@"userid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            KJHomeVC *vc = [[KJHomeVC alloc] init];
            AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            delegate.window.rootViewController = vc;
        }else if(KJ_CODE == 0){
            
        }
    }];
}

/**
 显示一条信息

 @param index 第几条
 */
- (void)showMessageWithIndex:(NSInteger)index {
    self.label.text  = self.messages[index];
    __weak typeof(self)weakself = self;
    [UIView transitionWithView:self.statusImageV duration:.33 options:(UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionTransitionFlipFromBottom) animations:^{
        weakself.statusImageV.hidden = NO;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (index < (weakself.messages.count - 1)) {
                [weakself removeMessageWithIndex:index];
            }else{
                [weakself resetFrom];
            }
        });
    }];
}


/**
 提出一条信息

 @param index 第几条
 */
- (void)removeMessageWithIndex:(NSInteger)index {
    __weak typeof(self)weakself = self;
    [UIView animateWithDuration:.33 animations:^{
        weakself.statusImageV.centerX += SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        weakself.statusImageV.hidden      = YES;
        weakself.statusImageV.center      = self.statusPoint;
        [weakself showMessageWithIndex:index+1];
    }];
}

/**
 云动画
 */
- (void)animationCloud:(CALayer*)layer {
    if (!self.isAppear) {//如果没有显示直接return防止内存泄漏
        return;
    }
    //1
    CGFloat cloudSpeed       = 60/SCREEN_WIDTH;
    NSTimeInterval duration  = (SCREEN_WIDTH - layer.frame.origin.x) * cloudSpeed;
    // 气球动画
    CALayer *balloonLayer    = [[CALayer alloc]init];
    balloonLayer.contents    = (__bridge id _Nullable)([UIImage imageNamed:@"balloon"].CGImage);
    balloonLayer.frame       = CGRectMake(-50, 0, 50, 65);
    [self.view.layer insertSublayer:balloonLayer below:_userNameTextField.layer];
    CAKeyframeAnimation *flightAnimation   = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    flightAnimation.duration               = 12.;
    flightAnimation.values                 = @[[NSValue valueWithCGPoint:CGPointMake(-50, 0.)],
                                               [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH+50 , 160)],
                                               [NSValue valueWithCGPoint:CGPointMake(-50, self.loginBtn.center.y)]
                                               ] ;
    flightAnimation.keyTimes               = @[@0.0, @0.5, @1.0];
    [balloonLayer addAnimation:flightAnimation forKey:nil];
    balloonLayer.position = CGPointMake(-50, self.loginBtn.center.y);
    
    
    // 云动画
    CABasicAnimation *moveAnimation   = [CABasicAnimation animationWithKeyPath:@"position.x"];
    [moveAnimation setValue:@"cloud" forKey:@"name"];
    [moveAnimation setValue:layer forKey:@"layer"];
    moveAnimation.delegate            = self;
    moveAnimation.duration            = duration;
    moveAnimation.fillMode            = kCAFillModeForwards;
    moveAnimation.fromValue           = @(layer.position.x);
    moveAnimation.toValue             = @(self.view.width + layer.bounds.size.width * 0.5);
    [layer addAnimation:moveAnimation forKey:nil];
    layer.position                    = CGPointMake(-layer.bounds.size.width/2, layer.position.y);
}


/**
 重置状态
 */
- (void)resetFrom{
    __weak typeof(self)weakself = self;
    //提示图片消失动画
    [UIView transitionWithView:self.statusImageV duration:.2 options:(UIViewAnimationOptionTransitionFlipFromTop) animations:^{
        weakself.statusImageV.hidden = YES;
        self.statusImageV.center = weakself.statusPoint;
    } completion:nil];
    
    [UIView animateWithDuration:.2 animations:^{
        weakself.spinner.center = CGPointMake(-20, 16);
        weakself.spinner.alpha  = 0.;
        CGRect loginBounds             = weakself.loginBtn.bounds;
        loginBounds.size.width        -= 80;
        weakself.loginBtn.bounds           = loginBounds;
        weakself.loginBtn.centerY      -= 60;
        weakself.loginBtn.enabled          = YES;
    } completion:^(BOOL finished) {
        CAKeyframeAnimation *wobbleAniamtion  = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
        wobbleAniamtion.duration              = 0.25;
        wobbleAniamtion.repeatCount           = 4;
        wobbleAniamtion.values                = @[@0.0, @(-M_PI_4), @0.0, @M_PI_4, @0.0];
        wobbleAniamtion.keyTimes              = @[@0.0, @0.25, @0.5, @0.75, @1.0];
        [weakself.headingLabel.layer addAnimation:wobbleAniamtion forKey:nil];
        //改变颜色
        UIColor             *toColor  = [UIColor colorWithRed:161/255. green:212/255. blue:98/255. alpha:1.];
        [weakself tintBackgroundColorWithCALayer:weakself.loginBtn.layer toColor:toColor];
        //改变圆角
        [self roundCornersWithCALayer:weakself.loginBtn.layer toRadius:8];
    }];
}


/**
 动画来改变layer的背景颜色
 
 @param layer   改变的layer
 @param toColor 改变的颜色
 */
- (void)tintBackgroundColorWithCALayer:(CALayer*)layer toColor:(UIColor*)toColor{
    CASpringAnimation *tintAnimation    = [CASpringAnimation animationWithKeyPath:@"backgroundColor"];
    tintAnimation.fromValue            = (__bridge id _Nullable)(layer.backgroundColor);
    tintAnimation.toValue              = (__bridge id _Nullable)(toColor.CGColor);
    tintAnimation.duration             = tintAnimation.settlingDuration;
    tintAnimation.damping              = 7.;
    tintAnimation.mass                 = 10.;
    [layer addAnimation:tintAnimation forKey:nil];
    layer.backgroundColor              = toColor.CGColor;
}

/**
 设置圆角动画

 @param layer  动画的layer
 @param radius 圆角半径
 */
- (void)roundCornersWithCALayer:(CALayer*)layer toRadius:(CGFloat)radius {
    CASpringAnimation *radiusAnimation     = [CASpringAnimation animationWithKeyPath:@"cornerRadius"];
    radiusAnimation.fromValue             = @(layer.cornerRadius);
    radiusAnimation.toValue               = @(radius);
    radiusAnimation.duration              = radiusAnimation.settlingDuration;
    radiusAnimation.damping               = 17.;
    [layer addAnimation:radiusAnimation forKey:nil];
    layer.cornerRadius                    = radius;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *name                         = [anim valueForKey:@"name"];
    if ([name isEqualToString:@"form"]) {
        CALayer *layer                     = [anim valueForKey:@"layer"];
        [anim setValue:nil forKey:@"layer"];
        //脉冲动画
        CASpringAnimation *pulseAnimation   = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
        pulseAnimation.damping             = 7.5;
        pulseAnimation.fromValue           = @(1.25);
        pulseAnimation.toValue             = @(1.);
        pulseAnimation.duration            = pulseAnimation.settlingDuration;
        [layer addAnimation:pulseAnimation forKey:nil];
    }
    if ([name isEqualToString:@"cloud"]) {
        CALayer *layer                     = [anim valueForKey:@"layer"];
        layer.position                     = CGPointMake(-layer.bounds.size.width/2, layer.position.y);
        [self animationCloud:layer];
    }
}

#pragma mark - UITextFieldDelegate
- (void)codeTextChange:(UITextField *)textField{
    if (textField == self.userNameTextField) {
        if (textField.text.length>11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    else if (textField == self.passWordTextField){  // 密码最长16位
        if (textField.text.length > 16){
            textField.text = [textField.text substringToIndex:16];
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *text = textField.text;
    if (text.length < 5) {
        CASpringAnimation *jumpAnimation   = [CASpringAnimation animationWithKeyPath:@"position.y"];
        jumpAnimation.fromValue            = @(textField.layer.position.y+1);
        jumpAnimation.toValue              = @(textField.layer.position.y);
        jumpAnimation.duration             = jumpAnimation.settlingDuration;
        jumpAnimation.initialVelocity      = 100.;
        jumpAnimation.mass                 = 10.;
        jumpAnimation.stiffness            = 1500.;
        jumpAnimation.damping              = 50.;
        [textField.layer addAnimation:jumpAnimation forKey:nil];
        
        
        textField.layer.borderWidth        = 3.;
        textField.layer.borderColor        = [UIColor clearColor].CGColor;
        CASpringAnimation *flashAniamtion  = [CASpringAnimation animationWithKeyPath:@"borderColor"];
        flashAniamtion.damping             = 7.;
        flashAniamtion.stiffness           = 200.;
        flashAniamtion.fromValue           = (__bridge id _Nullable)([UIColor colorWithRed:1. green:0.27 blue:0 alpha:1.].CGColor);
        flashAniamtion.toValue             = (__bridge id _Nullable)([UIColor whiteColor].CGColor);
        flashAniamtion.duration            = flashAniamtion.settlingDuration;
        [textField.layer addAnimation:flashAniamtion forKey:nil];
        
    }
}

#pragma mark --UI
/**
 创建UI
 */
- (void)setUpUI{
    UIImageView *bgImageView       = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-sunny.jpg"]];
    self.bgImageView               = bgImageView;
    self.bgImageView.frame         = self.view.bounds;
    [self.view addSubview:bgImageView];
    
    UIImageView *cloud1ImageV      = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-sunny-cloud-1"]];
    self.cloud1ImageV              = cloud1ImageV;
    self.cloud1ImageV.frame        = CGRectMake(-120, 131, 159, 50);
    [self.view addSubview:cloud1ImageV];
    
    UIImageView *cloud2ImageV      = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-sunny-cloud-2"]];
    self.cloud2ImageV              = cloud2ImageV;
    self.cloud2ImageV.frame        = CGRectMake(217, 155, 158, 49);
    [self.view addSubview:cloud2ImageV];
    
    UIImageView *cloud3ImageV      = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-sunny-cloud-3"]];
    self.cloud3ImageV              = cloud3ImageV;
    self.cloud3ImageV.frame        = CGRectMake(252, 369, 74, 35);
    [self.view addSubview:cloud3ImageV];
    
    UIImageView *cloud4ImageV      = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-sunny-cloud-4"]];
    self.cloud4ImageV              = cloud4ImageV;
    self.cloud4ImageV.frame        = CGRectMake(20, 397.5, 115, 50);
    [self.view addSubview:cloud4ImageV];
    
    //前景
    UILabel *headingLabel          = [[UILabel alloc]init];
    headingLabel.text              = @"Login";
    headingLabel.textColor         = [UIColor whiteColor];
    headingLabel.font              = [UIFont fontWithName:@"Helvetica Neue" size:30.0];
    headingLabel.textAlignment     = NSTextAlignmentCenter;
    headingLabel.frame             = CGRectMake(80.5, 87.5, 214.5, 34);
    headingLabel.centerX        = self.view.centerX;
    [self.view addSubview:headingLabel];
    self.headingLabel              = headingLabel;
    
    KJTextFiled *userNameTextField = [[ KJTextFiled alloc]init];
    userNameTextField.delegate     = self;
    userNameTextField.frame        = CGRectMake(0, 149, 280, 40);
    userNameTextField.centerX   = self.view.centerX;
    userNameTextField.placeholder  = @"请输入手机号";
    userNameTextField.keyboardType = UIKeyboardTypePhonePad;
    [userNameTextField addTarget:self action:@selector(codeTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:userNameTextField];
    self.userNameTextField = userNameTextField;
    
    KJTextFiled *passWordTextField = [[ KJTextFiled alloc]init];
    passWordTextField.delegate     = self;
    passWordTextField.frame        = CGRectMake(0, 214, 280, 40);
    passWordTextField.centerX   = self.view.centerX;
    passWordTextField.placeholder  = @"6-16位密码";
    passWordTextField.keyboardType = UIKeyboardTypeDefault;
    [passWordTextField addTarget:self action:@selector(codeTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:passWordTextField];
    self.passWordTextField         = passWordTextField;
    
    UIButton *loginBtn             = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.loginBtn                  = loginBtn;
    loginBtn.layer.cornerRadius    = 8;
    loginBtn.backgroundColor       = [UIColor colorWithRed:161/255. green:212/255. blue:98/255. alpha:1.];
    
    [loginBtn setTitle:@"登  陆" forState:(UIControlStateNormal)];
    loginBtn.frame                 = CGRectMake(0, 300, 280, 52);
    loginBtn.centerX            = self.view.centerX;
    [loginBtn addTarget:self action:@selector(onClickLogin:)forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:loginBtn];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    self.spinner                     = spinner;
    spinner.alpha                    = 0.;
    [spinner startAnimating];
    spinner.frame                    = CGRectMake(-20, 6, 20, 20);
    [self.loginBtn addSubview:spinner];
    
    UIImageView *statusImageV        = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"banner"]];
    self.statusImageV                = statusImageV;
    statusImageV.center              = loginBtn.center;
    self.statusImageV.hidden         = YES;
    [self.view addSubview:statusImageV];
    
    UILabel *label                   = [[UILabel alloc]init];
    self.label                       = label;
    label.textColor                  = [UIColor colorWithRed:0.89 green:0.38 blue:0. alpha:1];
    label.textAlignment              = NSTextAlignmentCenter;
    label.font                       = [UIFont fontWithName:@"HelveticaNeue" size:18];
    label.size                   = self.statusImageV.size;
    [self.statusImageV addSubview:label];
    
    self.statusPoint                 = statusImageV.center;
    
    
    UIButton *forgetBtn             = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.forgetBtn                  = forgetBtn;
    [forgetBtn setImage:GetImage(@"forget") forState:UIControlStateNormal];
    [forgetBtn setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
    [forgetBtn addTarget:self action:@selector(onClickForget)forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-50);
        make.left.mas_equalTo(loginBtn.mas_left).mas_offset(5);
        make.height.mas_equalTo(150);
        make.width.mas_equalTo(78*1.5);
    }];
    
    UIButton *registerBtn             = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.registerBtn                  = registerBtn;
    [registerBtn setImage:GetImage(@"register") forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:(UIControlStateNormal)];
    [registerBtn addTarget:self action:@selector(onClickRegister)forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(forgetBtn.mas_bottom).mas_offset(-100);
        make.right.mas_equalTo(self.view).mas_offset(-40);
        make.height.mas_equalTo(120);
        make.width.mas_equalTo(78*1.2);
    }];
}


@end
