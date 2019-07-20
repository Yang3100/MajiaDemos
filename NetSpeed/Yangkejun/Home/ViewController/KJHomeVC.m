//
//  KJHomeVC.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/10/23.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJHomeVC.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "QBTools.h"
#import "MeasurNetTools.h"
#import "KJHomeModel.h"

#import "KJHomeEmitterView.h"  // 粒子效果层

@interface KJHomeVC ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) UIView *centerView;
@property (strong, nonatomic) CALayer *needleLayer;
@property (weak, nonatomic) IBOutlet UILabel *currentSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (weak, nonatomic) IBOutlet UIButton *testNetButton;

@property (strong, nonatomic) UILabel *maxLabel,*minLabel,*netState;
@property (nonatomic, assign) CGFloat maxSpeed,minSpeed;
@property (strong, nonatomic) UIView *bezierView;

@property (nonatomic, strong) UIImageView *smallImageView;

@end

@implementation KJHomeVC
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    self.maxSpeed = 0.0;
    self.minSpeed = 1000000000000000.0;
    
    [self _setSubview];
    
    [self setIp];
    
    [self AFNetworkingTest];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
    
}

- (void)_setSubview{
    // 指针
    CALayer *needleLayer = [CALayer layer];
    self.needleLayer = needleLayer;
    needleLayer.anchorPoint = CGPointMake(0.5, 1.0); // 设置锚点位置
    needleLayer.position = self.centerView.center;   // 锚点在父视图上面的位置
    needleLayer.bounds = CGRectMake(0, 0, Handle(5), Handle(80));
    needleLayer.contents = (id)[UIImage imageNamed:@"cwszhizhen"].CGImage;// 添加图片
    [self.bgImageView.layer addSublayer:needleLayer];
    needleLayer.transform = CATransform3DMakeRotation(-0.75*M_PI, 0, 0, 1);
    
    self.maxLabel.text = @"0.0KB/S";
    self.minLabel.text = @"0.0KB/S";
    self.netState.text = @"WiFi";
    
    KJHomeEmitterView *emitterView = [KJHomeEmitterView createEmitterView:^(KJHomeEmitterView *obj) {
        CGRect fram = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        obj.Frame(fram).BackgroundColor([UIColor clearColor]);
    }];
    [self.view addSubview:emitterView];
    
    [self.view bringSubviewToFront:self.testNetButton];
}
- (IBAction)ClickTestNetButton:(UIButton *)sender {
    [self kj_addBezier];
    [self startNetSpeedWith];
    [self AFNetworkingTest];
    self.testNetButton.enabled = NO;
    [self.testNetButton setTitle:@"Speeding.." forState:UIControlStateNormal];
}

- (void)AFNetworkingTest{
    // 在此全程检测网络状态，全局可以获取当前的网络状态
    AFNetworkReachabilityManager *networkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [networkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                [self networkStatus];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSString *name = [self getWifiName];
                name = name==nil?@"":name;
                self.netState.text = [NSString stringWithFormat:@"WiFi %@",name];
            }
                break;
            default:
                break;
        }
    }];
    [networkReachabilityManager startMonitoring];
}

//获取WIFI名字的方法
- (NSString *)getWifiName{
    NSString *ssid = nil;
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    for (NSString *ifname in ifs) {
        NSDictionary *info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifname);
        if (info[@"SSIDD"]){
            ssid = info[@"SSID"];
        }
    }
    return ssid;
}
- (void)networkStatus{
    NSArray *typeStrings2G = @[CTRadioAccessTechnologyEdge,
                               CTRadioAccessTechnologyGPRS,
                               CTRadioAccessTechnologyCDMA1x];
    
    NSArray *typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
                               CTRadioAccessTechnologyWCDMA,
                               CTRadioAccessTechnologyHSUPA,
                               CTRadioAccessTechnologyCDMAEVDORev0,
                               CTRadioAccessTechnologyCDMAEVDORevA,
                               CTRadioAccessTechnologyCDMAEVDORevB,
                               CTRadioAccessTechnologyeHRPD];
    
    NSArray *typeStrings4G = @[CTRadioAccessTechnologyLTE];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CTTelephonyNetworkInfo *teleInfo= [[CTTelephonyNetworkInfo alloc] init];
        NSString *accessString = teleInfo.currentRadioAccessTechnology;
        if ([typeStrings4G containsObject:accessString]) {
            self.netState.text = @"4G Net";
        } else if ([typeStrings3G containsObject:accessString]) {
            self.netState.text = @"3G Net";
        } else if ([typeStrings2G containsObject:accessString]) {
            self.netState.text = @"2G Net";
        } else {
            NSLog(@"未知网络");
        }
    } else {
        NSLog(@"未知网络");
    }
}


- (void)startNetSpeedWith{
    [self setIp];
    self.needleLayer.transform = CATransform3DMakeRotation(-0.75*M_PI, 0, 0, 1);
    MeasurNetTools *meaurNet = [[MeasurNetTools alloc] initWithblock:^(float speed) {
        speed = speed/timeCount;
        if (speed>self.maxSpeed) {
            self.maxSpeed = speed;
            self.maxLabel.text = [NSString stringWithFormat:@"%@/S", [QBTools formattedFileSize:self.maxSpeed]];
            NSLog(@"max:%f",speed);
        }else if (speed<self.minSpeed && speed>0) {
            self.minSpeed = speed;
            self.minLabel.text = [NSString stringWithFormat:@"%@/S", [QBTools formattedFileSize:self.minSpeed]];
            NSLog(@"min:%f",speed);
        }
        //        NSLog(@"-------%f,%f,%f",speed,self.maxSpeed,self.minSpeed);
        NSString *speedStr = [NSString stringWithFormat:@"%@/S", [QBTools formattedFileSize:speed]];
        self.currentSpeedLabel.text = [NSString stringWithFormat:@"Real-time Speed：%@",speedStr];
        CGFloat llM = 0;;
        CGFloat llMFloat = speedStr.floatValue;
        if ([speedStr containsString:@"KB"]) {
            llM = llMFloat/1024;
        }else if ([speedStr containsString:@"M"]){
            llM = llMFloat;
        }else if ([speedStr containsString:@"bytes"]){
            llM = llMFloat/1024/1024;
        }else if([speedStr containsString:@"GB"]){
            llM = llMFloat*1024;
        }
        CGFloat angle = llM/(float)12 * 1.5*M_PI;
        CGFloat needAngle = angle - 0.75*M_PI;
        [self setRectViewTrans:needAngle];
    } finishMeasureBlock:^(float speed) {
        [self stopTestSpeed:speed];
    } failedBlock:^(NSError *error) {
        self.testNetButton.enabled = YES;
        [self.testNetButton setTitle:@"Test Net" forState:UIControlStateNormal];
    }];
    [meaurNet startMeasur];
}

- (void)stopTestSpeed:(float)speed{
    // 移除心电图效果
    [self kj_removeBezier];
    
    NSString *bandwith = [QBTools formatBandWidth:speed/timeCount];
    self.displayLabel.text = [NSString stringWithFormat:@"Netword Bandwidth：%@",bandwith];
    self.testNetButton.enabled = YES;
    [self.testNetButton setTitle:@"Test Net" forState:UIControlStateNormal];
    
    // 保存到数据库
    NSString *name = self.netState.text;
    NSString *address = [self.regionLabel.text substringFromIndex:15];
    NSString *ip = [self.ipLabel.text substringFromIndex:15];
    NSString *max = self.maxLabel.text;
    NSString *min = self.minLabel.text;
    [[KJHomeModel sharedInstance] saveHistoryName:name Address:address IP:ip Max:max Min:min Bandwith:bandwith];
    
    [self setRectViewTrans:-0.75*M_PI];
}

- (void)setRectViewTrans:(CGFloat)trans{
    self.needleLayer.transform = CATransform3DMakeRotation(trans, 0, 0, 1);
}

- (void)setIp{
    NSURL *url = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:100];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError == nil) {
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
            NSDictionary *dic = dataDic[@"data"];
            self.ipLabel.text = [NSString stringWithFormat:@"The IP Address：%@",dic[@"ip"]];
            NSString *country = dic[@"country"];
            if ([country isKindOfClass:[NSString class]] && [country isEqualToString:@"中国"]) {
                NSString *city = dic[@"city"];
                if ([city isKindOfClass:[NSString class]] && city.length > 0) {
                    country = city;
                }
            }
            self.regionLabel.text = [NSString stringWithFormat:@"Broadband Type：%@%@",country,dic[@"isp"]];
        }
    }];
}


- (UIView*)centerView{
    if (!_centerView) {
        _centerView = InsertView(self.bgImageView, CGRectZero, [UIColor whiteColor]);
        _centerView.frame = CGRectMake(148./375*(kScreenW), 126./375*(kScreenW), 10, 10);
        [KJTools makeCornerRadius:5 borderColor:nil layer:_centerView.layer borderWidth:0];
    }
    return _centerView;
}

- (UILabel*)maxLabel{
    if (!_maxLabel) {
        _maxLabel = InsertLabel(self.bgImageView, CGRectZero, NSTextAlignmentLeft, @"0.0KB/s", SystemFontSize(12), [UIColor whiteColor]);
        [_maxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgImageView).mas_offset(10);
            make.top.mas_equalTo(self.bgImageView).mas_offset(70./375*(kScreenW));
        }];
    }
    return _maxLabel;
}
- (UILabel*)minLabel{
    if (!_minLabel) {
        _minLabel = InsertLabel(self.bgImageView, CGRectZero, NSTextAlignmentLeft, @"0.0KB/s", SystemFontSize(12), [UIColor whiteColor]);
        [_minLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgImageView).mas_offset(10);
            make.top.mas_equalTo(self.bgImageView).mas_offset(120./375*(kScreenW));
        }];
    }
    return _minLabel;
}
- (UILabel*)netState{
    if (!_netState) {
        _netState = InsertLabel(self.bgImageView, CGRectZero, NSTextAlignmentRight, @"WiFi", SystemFontSize(30), [UIColor whiteColor]);
        [_netState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgImageView).mas_offset(-15);
            make.bottom.mas_equalTo(self.bgImageView).mas_offset(-95./375*(kScreenW));
        }];
    }
    return _netState;
}

- (UIImageView*)smallImageView{
    if (!_smallImageView) {
        _smallImageView = InsertImageView(self.view, CGRectZero, GetImage(@"xianjiadian"));
        [_smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.testNetButton.top).mas_offset(Handle(20));
            make.right.mas_equalTo(self.view).mas_offset(Handle(-20));
            make.width.height.mas_equalTo(Handle(40));
        }];
        [self.view bringSubviewToFront:_smallImageView];
    }
    return _smallImageView;
}

- (UIView*)bezierView{
    if (!_bezierView) {
        _bezierView = InsertView(self.view, CGRectZero, [UIColor clearColor]);
//        [_bezierView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(self.bgImageView);
//            make.height.mas_equalTo(50./375*(kScreenW));
//            make.width.mas_equalTo(SCREEN_WIDTH);
//        }];
        _bezierView.frame = self.testNetButton.frame;
        [self.view sendSubviewToBack:_bezierView];
    }
    return _bezierView;
}

- (void)kj_removeBezier{
    [self.bezierView.layer removeAllSublayers];
//    self.smallImageView.hidden = YES;
}

static CAShapeLayer *kj_shapeLayer = nil;
- (void)kj_addBezier{
//    self.smallImageView.hidden = NO;
    [KJTools viewAnimationRotate:self.smallImageView isRight:YES speed:4 TransCount:0];
    
    CABasicAnimation *anim =[CABasicAnimation  animation];
    //    想让哪一个图层做动画,就添加到哪一个图层上面.
    anim.keyPath = @"transform.scale";
    //    缩放到最小
    anim.toValue = @0.8;
    //    设置动画执行的次数
    anim.repeatCount = 2;
    //    设置动画执行的时长
    anim.duration = 0.1;
    //    反转
    anim.autoreverses = YES;
    
    [self.testNetButton.layer addAnimation:anim forKey:nil];

    // Used as background.
//    {
//        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//        kj_shapeLayer = shapeLayer;
//        shapeLayer.frame         = self.bezierView.frame;
//        shapeLayer.path          = [self path].CGPath;
//        shapeLayer.strokeColor = [UIColor redColor].CGColor;
//        shapeLayer.lineWidth   = 2.0f;
//        shapeLayer.opacity     = 0.5f;
//        shapeLayer.position    = CGPointMake(CGRectGetWidth(self.bezierView.bounds) / 2.f, CGRectGetHeight(self.bezierView.bounds) / 2.f);
//        [shapeLayer setTransform:CATransform3DMakeScale(1, 1, 1.f)];
//
//        [self.bezierView.layer addSublayer:shapeLayer];
//    }
    // Red line animation.
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame         = self.bezierView.frame;
        shapeLayer.path          = [self path].CGPath;
        shapeLayer.strokeEnd     = 0.f;
        shapeLayer.strokeColor   = UIColor.whiteColor.CGColor;
        shapeLayer.lineWidth     = 5.f;
        shapeLayer.position      = CGPointMake(CGRectGetWidth(self.bezierView.bounds) / 2.f, CGRectGetHeight(self.bezierView.bounds) / 2.f);
        [self.bezierView.layer addSublayer:shapeLayer];
        
        CGFloat MAX = 0.99f;
        CGFloat GAP = 0.01;
        
//        CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//        aniStart.fromValue         = [NSNumber numberWithFloat:0.f];
//        aniStart.toValue           = [NSNumber numberWithFloat:MAX];
        
        CABasicAnimation *aniEnd   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        aniEnd.fromValue           = [NSNumber numberWithFloat:0.f + GAP];
        aniEnd.toValue             = [NSNumber numberWithFloat:MAX + GAP];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration          = 10.0f;  // 持续时间
        group.repeatCount       = 1;  // 重复次数
        group.autoreverses      = NO; // 动画结束时是否执行逆动画
        group.animations        = @[aniEnd];
        
        [shapeLayer addAnimation:group forKey:nil];
        kj_shapeLayer = shapeLayer;
    }
}
- (UIBezierPath *)path {  // 绘制路径
    CGFloat w = self.bezierView.frame.size.width;
    CGFloat h = self.bezierView.frame.size.height;
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint   : CGPointMake(0, 0)];
    [bezierPath addLineToPoint: CGPointMake(w, 0)];
    [bezierPath addLineToPoint: CGPointMake(w, h)];
    [bezierPath addLineToPoint: CGPointMake(0, h)];
    [bezierPath addLineToPoint: CGPointMake(0, 0)];
    return bezierPath;
}

@end

