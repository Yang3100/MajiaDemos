//
//  KJHomeEmitterView.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/30.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJEmitterView.h"
#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height
#define UIColorFromHEXA(hex,a)    [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]
@interface KJEmitterView()

@end

@implementation KJEmitterView

+ (instancetype)createEmitterView:(void(^)(KJEmitterView *obj))block{
    KJEmitterView *obj = [[self alloc] init];
    if (block) {
        block(obj);
    }
    
    //开始粒子效果
    AddEmitterLayer(obj);
    
    return obj;
}

#pragma mark - 气泡粒子
- (void)qipaoEmitter:(UIView*)obj{
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.emitterPosition = CGPointMake(obj.bounds.size.width/2, obj.bounds.size.height - 60);
    emitter.emitterSize = CGSizeMake(obj.bounds.size.width, 0);
    emitter.emitterZPosition = -1;
    emitter.emitterShape = kCAEmitterLayerLine;
    emitter.emitterMode = kCAEmitterLayerAdditive;
    emitter.preservesDepth = YES;
    emitter.emitterDepth = 10;
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.birthRate = 2;
    cell.lifetime = 5;
    cell.lifetimeRange = 5;
    cell.velocity = 30;
    cell.velocityRange = 10;
    cell.yAcceleration = -2;
    cell.zAcceleration = -2;
    cell.enabled = YES;
    cell.scale = 0.05;
    cell.scaleRange = 0.05;
    cell.scaleSpeed = 0.01;
    cell.contents = (__bridge id _Nullable)([[UIImage imageNamed:@"jinglingqiu"] CGImage]);
    emitter.emitterCells = @[cell];
    [obj.layer addSublayer:emitter];
}


static CAEmitterLayer *AddEmitterLayer(UIView *view){
    // 色块粒子
    CAEmitterCell *kj_subCell = EmitterSubCell([UIImage imageNamed:@"jinglingqiu"]);
    
    // 粒子容器
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = CGPointMake(SCREEN_WIDTH/2, 20);
    emitterLayer.emitterSize     = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH);
    emitterLayer.emitterMode     = kCAEmitterLayerVolume;
    emitterLayer.emitterShape    = kCAEmitterLayerCircle;
    emitterLayer.renderMode      = kCAEmitterLayerOldestLast;
    
    emitterLayer.emitterCells = @[kj_subCell];
    [view.layer addSublayer:emitterLayer];
    
    return emitterLayer;
}

static CAEmitterCell *EmitterSubCell(UIImage *image){
    CAEmitterCell * _emitterCell = [CAEmitterCell emitterCell];
    // 和CALayer一样，只是用来设置图片
    _emitterCell.contents = (__bridge id _Nullable)image.CGImage;
    
    _emitterCell.lifetime = 5;    // 粒子存活时间
    _emitterCell.lifetimeRange = 0; // 生命周期范围
    _emitterCell.alphaRange = 0.5f;
    _emitterCell.alphaSpeed = -0.3f;      // 粒子消逝的速度
    _emitterCell.spin = M_PI;             // 自旋转角度
    _emitterCell.spinRange = 2 * M_PI;    // 自旋转角度范围
    
    //发射器
    _emitterCell.birthRate = 5;        // 每秒生成粒子的个数
    _emitterCell.yAcceleration = 0.f;   // 粒子的初始加速度
    _emitterCell.xAcceleration = 0.1f;
    _emitterCell.velocity = 20;           // 粒子运动的速度均值
    _emitterCell.velocityRange = 30.f;    // 粒子运动的速度扰动范围
    _emitterCell.emissionRange  = 2*M_PI; // 粒子发射角度范围
    
    _emitterCell.scale = 0.02;             // 缩放比例
    _emitterCell.scaleRange = 0.04;        // 缩放比例范围
    _emitterCell.scaleSpeed = 0.02;

    return _emitterCell;
}

//static UIImage *imageWithColor(UIColor *color){
//    CGRect rect = CGRectMake(0, 0, 13, 17);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
#pragma mark - 链接编程设置View的一些属性
- (KJEmitterView *(^)(CGRect))Frame {
    return ^(CGRect frame) {
        self.frame = frame;
        return self;
    };
}
- (KJEmitterView *(^)(UIColor *))BackgroundColor {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}
- (KJEmitterView *(^)(NSInteger))Tag {
    return ^(NSInteger tag){
        self.tag = tag;
        return self;
    };
}
- (KJEmitterView *(^)(UIView*))AddView {
    return ^(UIView *superView){
        [superView addSubview:self];
        return self;
    };
}

@end
