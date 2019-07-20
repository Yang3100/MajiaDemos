//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c)2015 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Awesome)

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor; // 设置navigationBar背景颜色
- (void)lt_setElementsAlpha:(CGFloat)alpha; // 设置基础的透明度
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset; // 重置

@end
