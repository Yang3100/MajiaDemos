//
//  UIImage+KJBlur.h
//  KJDevLibExample
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 Mike_He. All rights reserved.
//
/**
 *  Mike_He
 *  这个分类主要用来 处理图片模糊的...
 */
#import <UIKit/UIKit.h>

@interface UIImage (KJBlur)
/**
 *  图片高斯模糊
 *
 *  @param sourceImage 目标图片
 *  @param blurLevel 模糊等级 0~1
 *
 *  @return 返回模糊后的照片
 */
+ (UIImage *)kj_bluredImageWithSourceImage:(UIImage *)sourceImage blurLevel:(CGFloat)blurLevel;
@end
