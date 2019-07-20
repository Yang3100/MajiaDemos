//
//  UIButton+EnlargeEdge.m
//  BaseProject
//
//  Created by ZhouChong on 2017/2/24.
//  Copyright © 2017年 HN. All rights reserved.
//

#import "UIButton+EnlargeEdge.h"

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

@implementation UIButton (EnlargeEdge)

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge){
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else {
        return self.bounds;
    }
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)){
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point)? YES : NO;
}

- (void)setShadowColorForBut:(BOOL)isSelect{
    if (isSelect){
        self.layer.shadowColor =  MainColor(1).CGColor;//UIColorFromHEXA(0xF7CD0D, 1.0).CGColor;// 阴影的颜色
    }else{
        self.layer.shadowColor = UIColorFromHEXA(0xF0F0F0,1.0).CGColor;
    }
}

//显示红点
- (void)showBadge{
    [self removeBadge];
    
    //新建小红点
    UIView *bview = [[UIView alloc]init];
    bview.tag = 888;
    bview.layer.cornerRadius = 5;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor redColor];
    CGRect btnFrame = self.frame;
    
    float percentX = 0.8;
    CGFloat x = ceilf(percentX*btnFrame.size.width);
    CGFloat y = ceilf(0.1*btnFrame.size.height);
    bview.frame = CGRectMake(x, y - 2.5, 10, 10);
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}

// // 显示数字红点
- (void)showBadgeWithNum:(NSInteger)num{
    [self removeBadge];
    
    //新建小红点
    UIView *bview = [[UIView alloc]init];
    bview.tag = 888;
    bview.layer.cornerRadius = 9;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor redColor];
    CGRect btnFrame = self.frame;
    
    float percentX = 0.8;
    CGFloat x = ceilf(percentX*btnFrame.size.width);
    CGFloat y = ceilf(0.1*btnFrame.size.height);
    bview.frame = CGRectMake(x-2.5, y - 2.5, 18, 18);
    
    UILabel *nu = [[UILabel alloc]init];
    nu.frame = CGRectMake(0, 0, 18, 18);
    nu.textColor = [UIColor whiteColor];
    nu.textAlignment = NSTextAlignmentCenter;
    nu.font = [UIFont systemFontOfSize:11];
    if (num>99){
        nu.text = @"...";
    }else{
        nu.text = [NSString stringWithFormat:@"%ld",(long)num];
    }
    
    [bview addSubview:nu];
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}

//隐藏红点
- (void)hideBadge{
    [self removeBadge];
}

//移除控件
- (void)removeBadge{
    for (UIView*subView in self.subviews){
        if (subView.tag == 888){
            [subView removeFromSuperview];
        }
    }
}

@end
