//
//  KJCountedColorModel.h
//  色彩大淘沙
//
//  Created by 杨科军 on 2018/10/28.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJCountedColorModel : NSObject

@property(nonatomic,strong) UIColor *color;
@property(nonatomic,assign) NSInteger count;
@property(nonatomic,assign) CGPoint point;

// 获取不重复的颜色数组
+ (NSArray*)getNotRepetitionColors:(NSArray*)sortedColors maxCount:(NSInteger)max;

@end

NS_ASSUME_NONNULL_END
