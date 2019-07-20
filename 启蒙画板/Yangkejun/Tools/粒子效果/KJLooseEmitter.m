//
//  KJLooseEmitter.m
//  MoLiao
//
//  Created by 杨科军 on 2018/8/20.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJLooseEmitter.h"

@interface KJLooseEmitter()

@property(nonatomic,strong) CAEmitterLayer *emitterLayer;  // 粒子容器
@property(nonatomic,strong) CAEmitterCell *emitterCell;    // 粒子

@end

@implementation KJLooseEmitter

+ (instancetype)createEmitterView:(void(^)(KJLooseEmitter *obj))block{
    KJLooseEmitter *obj = [[self alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (block) {
        block(obj);
    }
    
    //开始粒子效果
    CAEmitterLayer *emitterLayer = addEmitterLayer(obj,nil);
//    startAnimate(emitterLayer);
    
    return obj;
}

CAEmitterLayer *addEmitterLayer(UIView *view,UIView *window){
    //色块粒子
//    CAEmitterCell *subCell1 = subCell(imageWithColor([UIColor redColor]));
//    subCell1.name = @"red";
//    CAEmitterCell *subCell2 = subCell(imageWithColor([UIColor yellowColor]));
//    subCell2.name = @"yellow";
    CAEmitterCell *subCell3 = subCell(imageWithColor([UIColor whiteColor]));
//    subCell3.name = @"blue";
//    CAEmitterCell *subCell4 = subCell(imageWithColor([UIColor greenColor]));
//    subCell3.name = @"green";
    CAEmitterCell *subCell5 = subCell([UIImage imageNamed:@"huaban1"]);
    CAEmitterCell *subCell6 = subCell([UIImage imageNamed:@"huaban2"]);
    CAEmitterCell *subCell7 = subCell([UIImage imageNamed:@"huaban3"]);
    CAEmitterCell *subCell8 = subCell([UIImage imageNamed:@"huaban4"]);
    CAEmitterCell *subCell9 = subCell([UIImage imageNamed:@"huaban5"]);
    CAEmitterCell *subCell10 = subCell([UIImage imageNamed:@"xuehua"]);
    
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = CGPointMake(SCREEN_WIDTH/2, 0);
//    emitterLayer.emitterPosition = view.center;
//    emitterLayer.emitterSize    = CGSizeMake(20, 20);
    emitterLayer.emitterMode    = kCAEmitterLayerPoints;
    emitterLayer.emitterShape   = kCAEmitterLayerRectangle;
    emitterLayer.renderMode     = kCAEmitterLayerOldestFirst;
    
    emitterLayer.emitterCells = @[subCell3,subCell5,subCell6,subCell7,subCell8,subCell9,subCell10];
    [view.layer addSublayer:emitterLayer];
    
    return emitterLayer;
}

//void startAnimate(CAEmitterLayer *emitterLayer){
//    CABasicAnimation *redBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.red.birthRate"];
//    redBurst.fromValue = [NSNumber numberWithFloat:SCREEN_WIDTH/2];
//    redBurst.toValue = [NSNumber numberWithFloat:0.0];
//    redBurst.duration = 0.5;
//    redBurst.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//
//    CABasicAnimation *yellowBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.yellow.birthRate"];
//    yellowBurst.fromValue = [NSNumber numberWithFloat:SCREEN_WIDTH/2];
//    yellowBurst.toValue = [NSNumber numberWithFloat:0.0];
//    yellowBurst.duration = 0.5;
//    yellowBurst.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//
//    CABasicAnimation *blueBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.blue.birthRate"];
//    blueBurst.fromValue = [NSNumber numberWithFloat:SCREEN_WIDTH/2];
//    blueBurst.toValue = [NSNumber numberWithFloat:0.0];
//    blueBurst.duration = 0.5;
//    blueBurst.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//
//    CABasicAnimation *starBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.star.birthRate"];
//    starBurst.fromValue = [NSNumber numberWithFloat:SCREEN_WIDTH/2];
//    starBurst.toValue = [NSNumber numberWithFloat:0.0];
//    starBurst.duration = 0.5;
//    starBurst.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.animations = @[redBurst,yellowBurst,blueBurst,starBurst];
//
//    [emitterLayer addAnimation:group forKey:@"heartsBurst"];
//}

CAEmitterCell *subCell(UIImage *image){
    CAEmitterCell * cell = [CAEmitterCell emitterCell];
    
    cell.name = @"heart";
    cell.contents = (__bridge id _Nullable)image.CGImage;
    
    // 缩放比例
    cell.scale      = 0.7;
    cell.scaleRange = 0.7;
    // 每秒产生的数量
    cell.birthRate  = 20;
    cell.lifetime   = 8;
//    // 每秒变透明的速度
//    cell.alphaSpeed = -0.7;
//    cell.redSpeed = 0.1;
    // 秒速
    cell.velocity      = 200;
    cell.velocityRange = 200;
    cell.yAcceleration = 9.8;
    cell.xAcceleration = 0;
    //掉落的角度范围
    cell.emissionRange  = M_PI;
    
    cell.scaleSpeed     = -0.05;
    ////    cell.alphaSpeed     = -0.3;
    cell.spin           = 2 * M_PI;
    cell.spinRange      = 2 * M_PI;
    
    return cell;
}

UIImage *imageWithColor(UIColor *color){
    CGRect rect = CGRectMake(0, 0, 10, 10);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
