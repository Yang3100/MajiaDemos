//
//  UIButton+EnlargeEdge.h
//  BaseProject
//
//  Created by ZhouChong on 2017/2/24.
//  Copyright © 2017年 HN. All rights reserved.
//  UIButton扩展

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIButton (EnlargeEdge)

// 扩大按钮点击范围
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

// 给button选中加阴影
- (void)setShadowColorForBut:(BOOL)isSelect;


#pragma mark - 加红巴巴
//显示红点
- (void)showBadge;

//隐藏红点
- (void)hideBadge;

// 显示数字红点
- (void)showBadgeWithNum:(NSInteger)num;

@end
