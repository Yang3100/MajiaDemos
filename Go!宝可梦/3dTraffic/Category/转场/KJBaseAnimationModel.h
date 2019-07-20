//
//  KJBaseAnimationModel.h
//  MoLiao
//
//  Created by 杨科军 on 2018/7/29.
//  Copyright © 2018年 杨科军. All rights reserved.
//  转场动画基类

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KJPresentationAnimationStyle){
    /// 显示：present
    KJPresentationAnimationStylePresent = 0,
    /// 消失：dismiss
    KJPresentationAnimationStyleDismiss
};


@interface KJBaseAnimationModel : NSObject<UIViewControllerAnimatedTransitioning>

// 动画的样式：入栈、出栈
@property (assign, nonatomic) KJPresentationAnimationStyle style;
// 动画执行的时间（默认为 0.3s）
@property (assign, nonatomic) NSTimeInterval duration;

// 转场的上下文
@property (weak, nonatomic, readonly) id<UIViewControllerContextTransitioning> transitionContext;
// 源控制器 
@property (weak, nonatomic, readonly) UIViewController *fromViewController;
// 目标控制器
@property (weak, nonatomic, readonly) UIViewController *toViewController;
// 源控制器的 view
@property (weak, nonatomic, readonly) UIView *fromView;
// 目标控制器的 view
@property (weak, nonatomic, readonly) UIView *toView;
// 进行动画过渡的场所
@property (weak, nonatomic, readonly) UIView *contaionerView;


/**
 *  开始动画，具体动画实现细节，由子类去实现
 */
- (void)beginAnimation;

/**
 *  结束动画
 */
- (void)endAnimation;

@end
