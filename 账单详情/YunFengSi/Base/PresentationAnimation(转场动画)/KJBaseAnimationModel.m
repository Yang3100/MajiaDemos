//
//  KJBaseAnimationModel.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/29.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBaseAnimationModel.h"

@implementation KJBaseAnimationModel

- (instancetype)init{
    if (self = [super init]){
        [self setupDefaults];
    }
    return self;
}

// 设置默认参数
- (void)setupDefaults{
    _duration = .3f;
    _style    = KJPresentationAnimationStylePresent;
}

#pragma mark -  Public Method

/**
 *  开始动画，具体动画实现细节，由子类去实现
 */
- (void)beginAnimation {}

/**
 *  结束动画
 */
- (void)endAnimation{
    // 怎么入栈就怎么出栈
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
}

#pragma mark -  UIViewControllerAnimatedTransitioning 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
/**
 *  转场动画时间
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.duration;
}

/**
 *  动画的具体实现
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 保存属性
    _transitionContext = transitionContext;
    _fromViewController = fromVC;
    _toViewController   = toVC;
    _fromView       = fromVC.view;
    _toView         = toVC.view;
    _contaionerView = transitionContext.containerView;
    
    /// 动画事件
    [self beginAnimation];
}


@end
