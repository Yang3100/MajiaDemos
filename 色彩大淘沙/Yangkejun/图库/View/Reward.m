//
//  Reward.m
//  HonorTree
//
//  Created by Adu on 2018/9/18.
//  Copyright © 2018年 Adu. All rights reserved.
//

#import "Reward.h"

@interface Reward ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *rewardView;

@end

@implementation Reward

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
//    [self addSubview:self.rewardView];
}

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

#pragma mark - 执行触发的方法
- (void)event:(UITapGestureRecognizer *)gesture{
    [UIView animateWithDuration:0.3 animations:^{
        [self.backgroundView removeFromSuperview];
    } completion:^(BOOL finished) {
    }];
}


- (UIView *)rewardView {
    if (!_rewardView) {
        _rewardView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/2,SCREEN_WIDTH/2)];
        _rewardView.backgroundColor = MainColor(0.8);
        [KJTools makeCornerRadius:10 borderColor:[UIColor whiteColor] layer:_rewardView.layer borderWidth:0.1];
        _rewardView.center = self.backgroundView.center;
    }
    return _rewardView;
}

- (void)show {
    //添加
    [[UIApplication sharedApplication].keyWindow addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.rewardView];
    
    UILabel *suLabel = InsertLabel(self.rewardView, CGRectZero, NSTextAlignmentCenter, @"", SystemFontSize(20), [UIColor whiteColor]);
    suLabel.numberOfLines = 0;
    [suLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rewardView).mas_offset(Handle(20));
        make.centerX.mas_equalTo(self.rewardView);
//        make.height.mas_equalTo(Handle(50));
        make.width.mas_equalTo(SCREEN_WIDTH/2 - 40);
    }];
    UILabel *erLabel = InsertLabel(self.rewardView, CGRectZero, NSTextAlignmentCenter, @"", SystemFontSize(20), [UIColor whiteColor]);
    erLabel.numberOfLines = 0;
    [erLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(suLabel.mas_bottom).mas_offset(Handle(20));
        make.centerX.mas_equalTo(self.rewardView);
//        make.height.mas_equalTo(Handle(50));
        make.width.mas_equalTo(SCREEN_WIDTH/2 - 40);
        make.bottom.mas_equalTo(self.rewardView).mas_offset(-Handle(20));
    }];
    
    suLabel.text = [NSString stringWithFormat:@"正确找出 \"%ld\" 种主要颜色",self.sureColorNum];
    erLabel.text = [NSString stringWithFormat:@"%ld 种主要颜色错误",self.errorColorNum];
    
    //缩放效果
    self.rewardView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    self.rewardView.alpha = 0;
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.rewardView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.rewardView.alpha = 1;
    } completion:nil];
    
    //开始粒子效果
    CAEmitterLayer *emitterLayer = Reward_AddEmitterLayer(self.backgroundView, self.rewardView);
    Reward_startAnimate(emitterLayer);
}

CAEmitterLayer *Reward_AddEmitterLayer(UIView *view, UIView *window) {
    //粒子
    CAEmitterCell *subCell1 = Reward_subCell([UIImage imageNamed:@"yezi"]);
    subCell1.name = @"yezi";
    CAEmitterCell *subCell2 = Reward_subCell([UIImage imageNamed:@"yellow_flower"]);
    subCell2.name = @"yellow_flower";
    CAEmitterCell *subCell3 = Reward_subCell([UIImage imageNamed:@"siyecao"]);
    subCell3.name = @"siyecao";
    CAEmitterCell *subCell4 = Reward_subCell([UIImage imageNamed:@"red_flower"]);
    subCell4.name = @"red_flower";
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = window.center;
    emitterLayer.emitterPosition = window.center;
    emitterLayer.emitterSize = window.bounds.size;
    emitterLayer.emitterMode = kCAEmitterLayerOutline;
    emitterLayer.emitterShape = kCAEmitterLayerRectangle;
    emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    
    emitterLayer.emitterCells = @[subCell1,subCell2,subCell3,subCell4];
    [view.layer addSublayer:emitterLayer];
    
    return emitterLayer;
    
}

void Reward_startAnimate(CAEmitterLayer *emitterLayer) {
    CABasicAnimation *redBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.yezi.birthRate"];
    redBurst.fromValue        = [NSNumber numberWithFloat:30];
    redBurst.toValue            = [NSNumber numberWithFloat:  0.0];
    redBurst.duration        = 0.5;
    redBurst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *yellowBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.yellow_flower.birthRate"];
    yellowBurst.fromValue        = [NSNumber numberWithFloat:30];
    yellowBurst.toValue            = [NSNumber numberWithFloat:  0.0];
    yellowBurst.duration        = 0.5;
    yellowBurst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *blueBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.siyecao.birthRate"];
    blueBurst.fromValue        = [NSNumber numberWithFloat:30];
    blueBurst.toValue            = [NSNumber numberWithFloat:  0.0];
    blueBurst.duration        = 0.5;
    blueBurst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *starBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.red_flower.birthRate"];
    starBurst.fromValue        = [NSNumber numberWithFloat:30];
    starBurst.toValue            = [NSNumber numberWithFloat:  0.0];
    starBurst.duration        = 0.5;
    starBurst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[redBurst,yellowBurst,blueBurst,starBurst];
    
    [emitterLayer addAnimation:group forKey:@"flowersBurst"];
}

CAEmitterCell *Reward_subCell(UIImage *image) {
    CAEmitterCell * cell = [CAEmitterCell emitterCell];
    //粒子的名字
    cell.name = @"flower";
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

@end
