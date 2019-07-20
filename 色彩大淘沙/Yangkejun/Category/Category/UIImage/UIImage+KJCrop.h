//
//  UIImage+KJCrop.h
//  KJDevLibExample
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 Mike_He. All rights reserved.
//
/**
 *  Mike_He
 *  这个分类主要用来 处理图片拉伸 和 裁剪...
 */
#import <UIKit/UIKit.h>

@interface UIImage (KJCrop)
/**
 *  改变Image的任何的大小
 *
 *  @param size 目的大小
 *
 *  @return 修改后的Image
 */
- (UIImage *)kj_cropImageWithAnySize:(CGSize)size;


/**
 *  裁剪和拉升图片
 */
- (UIImage*)kj_imageByScalingAndCroppingForTargetSize:(CGSize)targetSize;

//指定宽度按比例缩放
- (UIImage *)kj_imageCompressForWidth:(CGFloat)defineWidth;


/**
 *  返回圆形图片 直接操作layer.masksToBounds = YES 会比较卡顿
 */
- (UIImage *)kj_circleImage;


@end
