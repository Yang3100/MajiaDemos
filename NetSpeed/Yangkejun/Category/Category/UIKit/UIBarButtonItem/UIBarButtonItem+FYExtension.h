//
//  UIBarButtonItem+FYExtension.h
//  百思不得姐
//
//  Created by fengyang on 16/7/7.
//  Copyright © 2016年 fengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (FYExtension)
/**
 *  快速创建一个 UIBarButtonItem
 *
 *  @param image     普通状态下的图片
 *  @param highImage 高亮状态下的图片
 *  @param title  名字
 *  @param target        目标
 *  @param action        操作
 *
 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;


+ (instancetype)leftItemWithImage:(NSString*)image higthImage:(NSString*)hightImage title:(NSString*)title target:(id)target action:(SEL)action;

@end
