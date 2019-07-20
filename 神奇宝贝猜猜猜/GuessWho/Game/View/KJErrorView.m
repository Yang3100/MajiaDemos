//
//  KJErrorView.m
//  GuessWho
//
//  Created by 杨科军 on 2018/11/20.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJErrorView.h"

#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height
#define UIColorFromHEXA(hex,a)    [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]

@interface KJErrorView ()<CAAnimationDelegate>

@end

@implementation KJErrorView
+ (instancetype)createErrorView:(void(^)(KJErrorView *obj))block{
    KJErrorView *obj = [[self alloc] init];
//    obj.backgroundColor = [UIColor.redColor colorWithAlphaComponent:0.3];
    if (block) {
        block(obj);
    }
    
    // 初始化背景渐变的天空
    [obj initBackgroundSky];
    
    [obj viewAnimationOpacity:obj Alpha:0.5 Duration:0.3 TransCount:4 isFlash:YES];
    
    UIImageView *errView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    errView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    errView.image = [UIImage imageNamed:@"error"];
    [obj addSubview:errView];
    
    return obj;
}

// 初始化背景天空渐变色
- (void)initBackgroundSky{
    [self GradientLayerDirection:@"top"];
    [self GradientLayerDirection:@"bottom"];
    [self GradientLayerDirection:@"left"];
    [self GradientLayerDirection:@"right"];
}

- (void)GradientLayerDirection:(NSString*)direction{
    CAGradientLayer *backgroundLayer = [[CAGradientLayer alloc] init];
    // 设置背景渐变色层的大小
    UIColor *darkColor = UIColorFromHEXA(0x000000, 0);
    UIColor *lightColor = [UIColor.redColor colorWithAlphaComponent:0.8];
    backgroundLayer.colors = @[(__bridge id)lightColor.CGColor,(__bridge id)darkColor.CGColor];
    
    if ([direction isEqualToString:@"top"]) {
        backgroundLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        // 让变色层成180度角变色
        backgroundLayer.startPoint = CGPointMake(0, 0);
        backgroundLayer.endPoint = CGPointMake(1, 1);
    }else if ([direction isEqualToString:@"bottom"]) {
        backgroundLayer.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        // 让变色层成180度角变色
        backgroundLayer.endPoint = CGPointMake(0, 0);
        backgroundLayer.startPoint = CGPointMake(1, 1);
    }else if ([direction isEqualToString:@"left"]) {
        backgroundLayer.frame = CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        // 让变色层成180度角变色
        backgroundLayer.startPoint = CGPointMake(0, 1);
        backgroundLayer.endPoint = CGPointMake(1, 0);
    }else if ([direction isEqualToString:@"right"]) {
        backgroundLayer.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        // 让变色层成180度角变色
        backgroundLayer.endPoint = CGPointMake(0, 1);
        backgroundLayer.startPoint = CGPointMake(1, 0);
    }
    [self.layer addSublayer:backgroundLayer];
}

// 渐隐  isAlpha:是否为隐藏, Alpha:隐藏系数 Duration:移动持续时间, TransCount:重复次数(0:表示一直转)
- (void)viewAnimationOpacity:(UIView*)myView Alpha:(CGFloat)kj_a Duration:(CGFloat)duration TransCount:(int)num isFlash:(BOOL)flash{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = duration;
    animation.delegate = self;
    animation.repeatCount = num == 0 ? CGFLOAT_MAX : num;  // 重复次数
    if (flash){
        animation.autoreverses = YES; // 动画结束时是否执行逆动画
    }
    animation.toValue = [NSNumber numberWithFloat:kj_a]; // 结束时的倍率
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    [myView.layer addAnimation:animation forKey:@"op"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        // UI更新代码
//        [self removeFromSuperview];
//    });
    //  延时执行
    int64_t delayInSeconds = 1.0; // 延迟的时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

#pragma mark - 链接编程设置View的一些属性
- (KJErrorView *(^)(CGRect))Frame {
    return ^(CGRect frame) {
        self.frame = frame;
        return self;
    };
}
- (KJErrorView *(^)(UIColor *))BackgroundColor {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}
- (KJErrorView *(^)(NSInteger))Tag {
    return ^(NSInteger tag){
        self.tag = tag;
        return self;
    };
}
- (KJErrorView *(^)(UIView*))AddView {
    return ^(UIView *superView){
        [superView addSubview:self];
        return self;
    };
}

@end
