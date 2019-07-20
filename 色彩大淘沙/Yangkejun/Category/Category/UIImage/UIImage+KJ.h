//
//  UIImage+KJ.h
//  KJDevLibExample
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 Mike_He. All rights reserved.
//


/**
 *  图片相关的分类 头文件
 */


#ifndef UIImage_KJ_h
#define UIImage_KJ_h

#import "UIImage+KJBlur.h"  // 图片高斯模糊
#import "UIImage+KJCrop.h"  // 处理图片拉伸 和 裁剪
#import "UIImage+KJSnap.h"  // 屏幕截图
#import "UIImage+KJExtension.h"
#import "UIImage+KJOrientation.h" // 处理图片旋转的

/*
 基于扫描线的泛洪算法，获取填充同颜色区域后的图片
 泛洪算法通常有3种实现,四邻域，八邻域和基于扫描线
 了解更多泛洪算法可以查看下列链接：
 https://en.wikipedia.org/wiki/Flood_fill
 https://lodev.org/cgtutor/floodfill.html
*/
#import "UIImage+FloodFill.h"

// 处理图片上面的颜色相关
#import "UIImage+DiscernColor.h"

#endif /* UIImage_KJ_h */
