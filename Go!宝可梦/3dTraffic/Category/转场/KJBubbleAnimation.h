//
//  KJBubbleAnimation.h
//  MoLiao
//
//  Created by 杨科军 on 2018/7/29.
//  Copyright © 2018年 杨科军. All rights reserved.
//  气泡缩放动画

#import "KJBaseAnimationModel.h"

@interface KJBubbleAnimation : KJBaseAnimationModel

// 动画开始的frame
@property (assign, nonatomic) CGRect sourceRect;

// 填充颜色
@property (strong, nonatomic) UIColor *strokeColor;


@end
