//
//  KJAccView.m
//  GuessWho
//
//  Created by 杨科军 on 2018/11/19.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJAccView.h"
#import "UIImage+DiscernColor.h" // 获取图片主要颜色

#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height
@interface KJAccView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *rewardView;

@end

@implementation KJAccView

- (void)showWithImage:(UIImage*)image Name:(NSString*)name{
    //添加
    [[UIApplication sharedApplication].keyWindow addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.rewardView];
    
    NSMutableAttributedString *attributedString = [self nameBecomeRichForImage:image Name:name];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.rewardView.frame.size.width-30, 50)];
    label.numberOfLines = 0;
    label.center = CGPointMake(CGRectGetWidth(self.rewardView.frame)/2, CGRectGetHeight(self.rewardView.frame)/2);
    label.attributedText = attributedString;
    label.textAlignment = NSTextAlignmentCenter;
    [self.rewardView addSubview:label];
    
    //缩放效果
    self.rewardView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    self.rewardView.alpha = 0;
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.rewardView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.rewardView.alpha = 1;
    } completion:nil];
    
    // 开始粒子效果
    CAEmitterLayer *emitterLayer = [self AddEmitterLayer:self.backgroundView];
    // 开启动画效果
    [self startAnimate:emitterLayer];
}


- (NSMutableAttributedString*)nameBecomeRichForImage:(UIImage*)image Name:(NSString*)name{
    UIColor *mainColor = [UIImage kj_mostColor:image];
    NSInteger nameLen = [name length];
    name = [NSString stringWithFormat:@"回答正确：%@",name];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:name];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, name.length)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"MarkerFelt-Thin" size:35] range:NSMakeRange(5,nameLen)];
    NSShadow *shadow =[[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(1, 2);
    [attributedString addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(5,nameLen)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:mainColor range:NSMakeRange(5,nameLen)];
    return attributedString;
}

#pragma mark - 执行触发的方法
- (void)event:(UITapGestureRecognizer *)gesture{
    [UIView animateWithDuration:0.3 animations:^{
        [self.backgroundView removeFromSuperview];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - 粒子效果
- (CAEmitterLayer*)AddEmitterLayer:(UIView*)view{
    //粒子
    CAEmitterCell *subCell1 = SubCell([UIImage imageNamed:@"yezi"]);
    subCell1.name = @"yezi";
    CAEmitterCell *subCell2 = SubCell([UIImage imageNamed:@"yellow_flower"]);
    subCell2.name = @"yellow_flower";
    CAEmitterCell *subCell3 = SubCell([UIImage imageNamed:@"siyecao"]);
    subCell3.name = @"siyecao";
    CAEmitterCell *subCell4 = SubCell([UIImage imageNamed:@"red_flower"]);
    subCell4.name = @"red_flower";
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = CGPointMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2);
    emitterLayer.emitterSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH);
    emitterLayer.emitterMode = kCAEmitterLayerOutline;
    emitterLayer.emitterShape = kCAEmitterLayerRectangle;
    emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    
    emitterLayer.emitterCells = @[subCell1,subCell2,subCell3,subCell4];
    [view.layer addSublayer:emitterLayer];
    
    return emitterLayer;
}

static CAEmitterCell *SubCell(UIImage *image) {
    CAEmitterCell * cell = [CAEmitterCell emitterCell];
    //是个CGImageRef的对象,既粒子要展现的图片
    cell.contents = (__bridge id _Nullable)image.CGImage;
    // 缩放比例
    cell.scale = 0.6;
    //缩放比例范围
    cell.scaleRange = 0.6;
    //表示effectCell的生命周期，既在屏幕上的显示时间要多长
    cell.lifetime = 20;
    //速度
    cell.velocity = 200;
    //速度范围
    cell.velocityRange = 200;
    //粒子y方向的加速度分量
    cell.yAcceleration = 9.8;
    //粒子x方向的加速度分量
    cell.xAcceleration = 0;
    //周围发射角度
    cell.emissionRange = M_PI;
    //缩放比例速度
    cell.scaleSpeed = -0.05;
    //子旋转角度
    cell.spin = 2 * M_PI;
    //子旋转角度范围
    cell.spinRange = 2 * M_PI;
    
    return cell;
}

#pragma mark - 粒子动画
- (void)startAnimate:(CAEmitterLayer *)emitterLayer{
    CABasicAnimation *redBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.yezi.birthRate"];
    redBurst.fromValue = [NSNumber numberWithFloat:30];
    redBurst.toValue = [NSNumber numberWithFloat:0.0];
    redBurst.duration = 0.5;
    redBurst.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *yellowBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.yellow_flower.birthRate"];
    yellowBurst.fromValue = [NSNumber numberWithFloat:30];
    yellowBurst.toValue = [NSNumber numberWithFloat:0.0];
    yellowBurst.duration = 0.5;
    yellowBurst.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *blueBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.siyecao.birthRate"];
    blueBurst.fromValue = [NSNumber numberWithFloat:30];
    blueBurst.toValue = [NSNumber numberWithFloat:0.0];
    blueBurst.duration = 0.5;
    blueBurst.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *starBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.red_flower.birthRate"];
    starBurst.fromValue = [NSNumber numberWithFloat:30];
    starBurst.toValue = [NSNumber numberWithFloat:0.0];
    starBurst.duration = 0.5;
    starBurst.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[redBurst,yellowBurst,blueBurst,starBurst];
    
    [emitterLayer addAnimation:group forKey:@"flowersBurst"];
}

#pragma mark - lazy
- (UIView *)backgroundView {
    if (!_backgroundView) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _backgroundView = [[UIView alloc] initWithFrame:window.bounds];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        // 添加手势
        _backgroundView.userInteractionEnabled = YES; // 打开用户交互(不可少)
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
        // 将手势添加到需要相应的view中去
        [_backgroundView addGestureRecognizer:tapGesture];
        // 选择触发事件的方式（默认单机触发）
        [tapGesture setNumberOfTapsRequired:1];
    }
    return _backgroundView;
}
- (UIView *)rewardView {
    if (!_rewardView) {
        _rewardView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/2,100)];
        _rewardView.backgroundColor = UIColor.whiteColor;
        _rewardView.layer.masksToBounds = YES;
        _rewardView.layer.cornerRadius = 10;
        _rewardView.center = self.backgroundView.center;
    }
    return _rewardView;
}



@end
