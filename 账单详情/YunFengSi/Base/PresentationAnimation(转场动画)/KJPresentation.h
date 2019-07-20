//
//  KJPresentation.h
//  MoLiao
//
//  Created by 杨科军 on 2018/7/29.
//  Copyright © 2018年 杨科军. All rights reserved.
//  控制controller之间的跳转特效

#import <UIKit/UIKit.h>
#import "KJBaseAnimationModel.h"

@interface KJPresentation : UIPresentationController

/**
 *  显示一个 弹框视图控制器
 *
 *  @param presentationAnimation    动画类
 *  @param presentedViewController  目标控制器（最终要展示的控制器）
 *  @param presentingViewController 源控制器（是从哪个控制器推出的
 */
+ (void)presentWithPresentationAnimation:(KJBaseAnimationModel *)presentationAnimation
                 presentedViewController:(UIViewController *)presentedViewController
                presentingViewController:(UIViewController *)presentingViewController;


@end
