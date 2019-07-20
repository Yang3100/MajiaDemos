//
//  KJCalculatorModel.h
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/16.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJCalculatorModel : NSObject

/// title
@property (nonatomic , readwrite , copy) NSString *title;
/// 宽
@property (nonatomic , readwrite , assign) CGFloat width;
/// 高
@property (nonatomic , readwrite , assign) CGFloat height;

@end

NS_ASSUME_NONNULL_END
