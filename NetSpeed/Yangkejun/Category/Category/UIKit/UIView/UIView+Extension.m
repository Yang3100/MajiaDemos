//
//  UIView+KJExtension.m
//  KJDevLibExample
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 Mike_He. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

@dynamic borderColor,borderWidth,masksToBounds,cornerRadius;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)kj_isShowingOnKeyWindow{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

/**
 * xib创建的view
 */
+ (instancetype)kj_viewFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self)owner:nil options:nil] lastObject];
}

+ (instancetype)kj_viewFromXibWithFrame:(CGRect)frame {
    UIView *view = [self kj_viewFromXib];
    view.frame = frame;
    return view;
}

/**
 * xib中显示的属性
 */
-(void)setBorderColor:(UIColor *)borderColor {
    [self.layer setBorderColor:borderColor.CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth {
    [self.layer setBorderWidth:borderWidth];
}

-(void)setCornerRadius:(CGFloat)cornerRadius {
    [self.layer setCornerRadius:cornerRadius];
}

- (void)setMasksToBounds:(BOOL)masksToBounds {
    [self.layer setMasksToBounds:masksToBounds];
}
@end
