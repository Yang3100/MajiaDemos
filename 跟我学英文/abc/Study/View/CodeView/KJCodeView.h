//
//  KJCodeView.h
//  跟我学英文
//
//  Created by 杨科军 on 2018/12/3.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSString+StringToWords.h"


typedef NS_ENUM(NSInteger,CodeViewType) {
    CodeViewTypeCustom,  //普通样式
    CodeViewTypeSecret   //密码风格
};

@interface KJCodeView : UIView

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame LineColor:(UIColor* )lColor TextFont:(CGFloat)font;

// 输入完成回调
@property (nonatomic, copy) void(^EndEditBlcok)(NSString *text);
// 样式
@property (nonatomic, assign) CodeViewType codeType;
// 是否需要分隔符, 默认为NO
@property (nonatomic, assign) BOOL hasSpaceLine;
// 是否有下标线, 默认为YES
@property (nonatomic, assign) BOOL hasUnderLine;
// 是否需要输入之后清空，再次输入使用,默认为NO
@property (nonatomic, assign) BOOL emptyEditEnd;

// 下标线距离底部高度
@property (nonatomic, assign) CGFloat LineBottomHeight;
// 密码风格 圆点半径
@property (nonatomic, assign) CGFloat Radius;
// 内容
@property (nonatomic, strong) NSString *content;
// 设置需要输入的内容长度
- (void)setWithNum:(NSInteger)num;

@end
