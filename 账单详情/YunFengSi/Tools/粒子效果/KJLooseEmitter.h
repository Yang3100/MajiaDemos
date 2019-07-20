//
//  KJLooseEmitter.h
//  MoLiao
//
//  Created by 杨科军 on 2018/8/20.
//  Copyright © 2018年 杨科军. All rights reserved.
//  抽奖 - 撒花离子效果

#import <UIKit/UIKit.h>

@interface KJLooseEmitter : UIView

+ (instancetype)createEmitterView:(void(^)(KJLooseEmitter *obj))block;

@end
