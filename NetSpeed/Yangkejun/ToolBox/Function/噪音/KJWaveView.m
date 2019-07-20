//
//  KJWaveView.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/25.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJWaveView.h"

#define KJWaveTopColor [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1.0f] //前面波浪颜色
#define KJWaveMiddleColor [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:0.7f] //中间波浪颜色
#define KJWaveBottomColor [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:0.4f] //后面波浪颜色
@interface KJWaveView (){
    CGFloat w,h;
}

//计时器对象，可以使用这个对象来保持应用中的绘制与显示刷新的同步
@property (nonatomic, strong) CADisplayLink *displayLink;


//正弦函数，绘制波形  y=Asin(ωx+φ)+k
@property (nonatomic, assign) CGFloat wave_amplitude;  // A: 振幅
@property (nonatomic, assign) CGFloat wave_cycle;      // w: 周期
@property (nonatomic, assign) CGFloat wave_offsety;    // k: 波峰所在位置的y坐标
@property (nonatomic, assign) CGFloat wave_offsetx;    // φ: 偏移
@property (nonatomic, assign) CGFloat wave_h_distance; // 两个波水平之间偏移
@property (nonatomic, assign) CGFloat wave_v_distance; // 两个波竖直之间偏移
@property (nonatomic, assign) CGFloat wave_scale;      // 水波速率
@property (nonatomic, assign) CGFloat wave_move_width; // 移动的距离，配合速率设置
@property (nonatomic, assign) CGFloat offsety_scale;   // 上升的速度

@end

@implementation KJWaveView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        w = frame.size.width;
        h = frame.size.height;
        
        w = w*3;
        
        //初始化信息
        [self initInfo];
    }
    return self;
}
- (void)setProgress:(CGFloat)progress{
    _progress = progress;//2 + 0.48;
//    NSLog(@"%f",progress);
}

- (void)initInfo{
    //进度
    _progress = 0;
    //振幅
    _wave_amplitude = h / 40;
    //周期
    _wave_cycle = M_PI / (w / 2);
    //两个波水平之间偏移
    _wave_h_distance = w * 20;
    //两个波竖直之间偏移
    _wave_v_distance = _wave_amplitude * 0.4;
    //移动的距离，配合速率设置
    _wave_move_width = 0.5;
    //水波速率
    _wave_scale = 0.15;
    //上升的速度
    _offsety_scale = 0.1;
    //波峰所在位置的y坐标，刚开始的时候_wave_offsety是最大值
    _wave_offsety = _wave_amplitude/2;
    [self addDisplayLinkAction];
}
- (void)addDisplayLinkAction{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)displayLinkAction{
    _wave_offsetx += _wave_move_width * _wave_scale;
    //完成
    if (_wave_offsety <= 0.01) [self removeDisplayLinkAction];
    [self setNeedsDisplay];
}
- (void)removeDisplayLinkAction{
    [_displayLink invalidate];
    _displayLink = nil;
}
- (void)drawRect:(CGRect)rect{
    //绘制两个波形图
    [self drawWaveColor:KJWaveTopColor offsetx:0 offsety:0];
//    [self drawWaveColor:KJWaveMiddleColor offsetx:_wave_h_distance offsety:_wave_v_distance];
    [self drawWaveColor:KJWaveBottomColor offsetx:_wave_h_distance*2 offsety:_wave_v_distance*2];
}
- (void)drawWaveColor:(UIColor *)color offsetx:(CGFloat)offsetx offsety:(CGFloat)offsety{
    //波浪动画,进度的实际操作范围是,多加上两个振幅的高度,到达设置进度的位置y
    CGFloat end_offY = (1 - _progress) * (h) + _wave_amplitude;
    if (_wave_offsety != end_offY) {
        if (end_offY < _wave_offsety) {
            _wave_offsety = MAX(_wave_offsety -= (_wave_offsety - end_offY) * _offsety_scale, end_offY);
        }else {
            _wave_offsety = MIN(_wave_offsety += (end_offY - _wave_offsety) * _offsety_scale, end_offY);
        }
    }
    // 贝塞尔曲线绘制波形图
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    for (float next_x = 0.f; next_x <= w; next_x ++) {
        //正弦函数，绘制波形  y=Asin(ωx+φ)+k
        CGFloat next_y = _wave_amplitude * sin(_wave_cycle * next_x + _wave_offsetx + offsetx) + _wave_offsety + offsety;
        if (next_x == 0) { // 起点
            [wavePath moveToPoint:CGPointMake(next_x, next_y - _wave_amplitude)];
        }else {
            [wavePath addLineToPoint:CGPointMake(next_x, next_y - _wave_amplitude)];
        }
    }
    // 波形以下内容
    [wavePath addLineToPoint:CGPointMake(w, h)];
    [wavePath addLineToPoint:CGPointMake(0, h)];
    [color set];
    [wavePath fill];
}

@end
