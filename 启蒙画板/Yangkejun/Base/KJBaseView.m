//
//  KJBaseView.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/23.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJBaseView.h"
#import "KJModel.h"

@implementation KJBaseView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.path = [self drawRecta];
        // 绘制背景
        self.shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = self.frame;
        _shapeLayer.path          = _path.CGPath;
        _shapeLayer.fillColor   = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = [self kj_retColor].CGColor;
        _shapeLayer.lineWidth   = [self kj_retLine];
        _shapeLayer.strokeStart = 0;
        _shapeLayer.strokeEnd = 60;
        [self.layer addSublayer:_shapeLayer];
    }
    return self;
}

- (CGFloat)kj_retLine{
    NSInteger index = [UserDefault integerForKey:@"draw_line"];
    CGFloat line = 1.0;
    switch (index) {
        case 620:
            line = 2;
            break;
        case 621:
            line = 7;
            break;
        case 622:
            line = 11;
            break;
    }
    return line;
}

- (UIColor*)kj_retColor{
    NSInteger index = [UserDefault integerForKey:@"draw_color"];
    UIColor *mColor;
    switch (index) {
        case 520:
            mColor = UIColorFromHEXA(0xADCF9C, 1);
            break;
        case 521:
            mColor = UIColorFromHEXA(0xFFCFAC, 1);
            break;
        case 522:
            mColor = UIColorFromHEXA(0x124291, 1);
            break;
        case 523:
            mColor = UIColorFromHEXA(0xB73817, 1);
            break;
        case 524:
            mColor = UIColorFromHEXA(0xB71696, 1);
            break;
        case 525:
            mColor = UIColorFromHEXA(0x200119, 1);
            break;
            
        default:
            break;
    }
    return mColor;
}


- (UIBezierPath*)drawRecta{
    
    //// Path drawing
    UIBezierPath *path = [UIBezierPath bezierPath];
    return path;
}

@end
