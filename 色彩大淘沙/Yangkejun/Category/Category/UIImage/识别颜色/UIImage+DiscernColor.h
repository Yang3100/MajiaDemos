//
//  UIImage+DiscernColor.h
//  色彩大淘沙
//
//  Created by 杨科军 on 2018/10/28.
//  Copyright © 2018 杨科军. All rights reserved.
//  处理图片上面的颜色相关

#import <UIKit/UIKit.h>


@interface UIImage (DiscernColor)

/**
 获取图片上面的颜色
 
 @param image 图片
 @param count 最大颜色数目
 @return 颜色数组
 */
- (NSArray*)kj_getColorsFromImage:(UIImage *)image count:(NSInteger)count;
// 根据图片获取图片的主色调
+ (UIColor*)kj_mostColor:(UIImage*)image;
// 去除图片的白色背景
+ (UIImage*)kj_imageToTransparent:(UIImage*)image;

// 获取图片上点个颜色
+ (UIColor*)kj_colorFromImage:(UIImage *)image Point:(CGPoint)point;
// 获取图片上点个颜色Hex  (#FFFFFF白色)
+ (NSString*)kj_colorHexFromImage:(UIImage *)image Point:(CGPoint)point;

@end


