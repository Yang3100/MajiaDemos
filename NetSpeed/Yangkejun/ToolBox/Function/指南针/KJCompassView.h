//
//  KJCompassView.h
//  MoLiao
//
//  Created by 杨科军 on 2018/7/20.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJCompassView : UIView

/**
 *  初始化
 *
 *  @param radius 半径（最小不小于50，最大不大于控件短边的一半）
 *
 *  @return 返回罗盘对象
 */
+ (instancetype)sharedWithRect:(CGRect)rect radius:(CGFloat)radius;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *calibrationColor;
@property (nonatomic, strong) UIColor *northColor;
@property (nonatomic, strong) UIColor *horizontalColor;

@property (nonatomic, strong) UIImage *pointerImage;

@end
