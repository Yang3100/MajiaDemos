//
//  KJMapBankModel.h
//  色彩大淘沙
//
//  Created by 杨科军 on 2018/10/28.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJMapBankModel : NSObject

@property(nonatomic,strong) UIView *indicatorView;
@property(nonatomic,strong) UIButton *saveButton;
@property(nonatomic,strong) UIColor *currentColor;
@property(nonatomic,assign) BOOL isSelect;
@property(nonatomic,assign) BOOL isTureAnswer;

@end

NS_ASSUME_NONNULL_END
