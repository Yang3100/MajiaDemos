//
//  KJHomeEmitterView.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/30.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJHomeEmitterView.h"

@interface KJHomeEmitterView()

@property(nonatomic,strong) CAEmitterLayer *emitterLayer;  // 粒子容器
@property(nonatomic,strong) CAEmitterCell *emitterCell;    // 粒子

@end

@implementation KJHomeEmitterView

+ (instancetype)createEmitterView:(void(^)(KJHomeEmitterView *obj))block{
    KJHomeEmitterView *obj = [[self alloc] init];
    if (block) {
        block(obj);
    }
    // 初始化背景渐变的天空
//    [obj initBackgroundSky];
    //        }];
    //        [GCDQueue executeInGlobalQueue:^{
    // 添加粒子效果层
    [obj.layer addSublayer:obj.emitterLayer];
    return obj;
}

// 初始化背景天空渐变色
- (void)initBackgroundSky{
    CAGradientLayer *backgroundLayer = [[CAGradientLayer alloc] init];
    // 设置背景渐变色层的大小
    backgroundLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIColor *darkColor = UIColorFromHEXA(0x000000, 1);
    UIColor *lightColor = UIColorFromHEXA(0x101010, 0.1);
    backgroundLayer.colors = @[(__bridge id)lightColor.CGColor,(__bridge id)darkColor.CGColor];
    
    // 让变色层成180度角变色
    backgroundLayer.startPoint = CGPointMake(0, 0);
    backgroundLayer.endPoint = CGPointMake(1, 1);
    
    [self.layer addSublayer:backgroundLayer];
}

#pragma mark - 初始化粒子容器
- (CAEmitterLayer*)emitterLayer{
    if (!_emitterLayer) {
        // 粒子容器
        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
        emitterLayer.emitterPosition = self.center;
        emitterLayer.emitterSize     = self.frame.size;
        emitterLayer.emitterMode     = kCAEmitterLayerVolume;
        emitterLayer.emitterShape    = kCAEmitterLayerRectangle;
        emitterLayer.renderMode      = kCAEmitterLayerOldestFirst;
        
        //        CAEmitterCell *subCell2 = home_Emitter_subCell([KJTools getImageFromColor:[UIColor blueColor] Rect:CGRectMake(0, 0, 10, 10)]);
        // 将色块粒子加入到容器之中
        emitterLayer.emitterCells = @[self.emitterCell];
        
        _emitterLayer = emitterLayer;
    }
    return _emitterLayer;
}

#pragma mark - 粒子设置
- (CAEmitterCell*)emitterCell{
    if (!_emitterCell) {
        _emitterCell = [CAEmitterCell emitterCell];
        
        // 粒子
        // 和CALayer一样，只是用来设置图片
        UIImage *image = GetImage(@"home_emttier_blue");
        _emitterCell.contents = (__bridge id _Nullable)image.CGImage;
        
        _emitterCell.lifetime = 5;    // 粒子存活时间
        _emitterCell.lifetimeRange = 0; // 生命周期范围
        _emitterCell.alphaRange = 0.5f;
        _emitterCell.alphaSpeed = -0.3f;      // 粒子消逝的速度
        _emitterCell.spin = M_PI;             // 自旋转角度
        _emitterCell.spinRange = 2 * M_PI;    // 自旋转角度范围
        
        
        //发射器
        _emitterCell.birthRate = 20;        // 每秒生成粒子的个数
        _emitterCell.yAcceleration = 0.f;   // 粒子的初始加速度
        _emitterCell.xAcceleration = 0.1f;
        _emitterCell.velocity = 20;           // 粒子运动的速度均值
        _emitterCell.velocityRange = 30.f;    // 粒子运动的速度扰动范围
        _emitterCell.emissionRange  = 2*M_PI; // 粒子发射角度范围
        
        _emitterCell.scale = 0.05;             // 缩放比例
        _emitterCell.scaleRange = 0.1;        // 缩放比例范围
        _emitterCell.scaleSpeed = 0.05;
        
        
        
        //
        //    // 7.xAcceleration:粒子x方向的加速度分量
        //    cell.yAcceleration = 2;
        //    // 8.yAcceleration:粒子y方向的加速度分量
        //    cell.xAcceleration = 5;
        //    // 9.zAcceleration:粒子z方向的加速度分量
        //    cell.zAcceleration = 2;
        //
        
        //    cell.contentsScale = 0.1;
        
        //    15.contentsRect：
        //
        //    16.contentsScale：
        //
        //    17.minificationFilter:减小自己的大小
        //    cell.minificationFilter = @"0.1";
        //    18.minificationFilterBias:减小大小的因子
        //
        //    19.enabled:粒子是否被渲染；
        
        //    20.emissionLatitude:发射的z轴方向的角度
        //
        //    21.emissionLongitude:x-y平面的发射方向
        //
        //    22.emissionRange:周围发射角度
        //
        //    23.emitterCells:粒子发射的粒子
        //
        //    24.alphaRange:一个粒子的颜色透明度alpha能改变的范围
        
        //    25.alphaSpeed:粒子透明度在生命周期内的改变速度
    }
    return _emitterCell;
}

#pragma mark - 链接编程设置View的一些属性
- (KJHomeEmitterView *(^)(CGRect))Frame {
    return ^(CGRect frame) {
        self.frame = frame;
        return self;
    };
}
- (KJHomeEmitterView *(^)(UIColor *))BackgroundColor {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}
- (KJHomeEmitterView *(^)(NSInteger))Tag {
    return ^(NSInteger tag){
        self.tag = tag;
        return self;
    };
}

@end
