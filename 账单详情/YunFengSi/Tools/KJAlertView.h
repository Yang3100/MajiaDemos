//
//  KJAlertView.h
//  MoLiao
//
//  Created by 杨科军 on 2018/7/25.
//  Copyright © 2018年 杨科军. All rights reserved.
//  提示,确认框

#import <UIKit/UIKit.h>

typedef void(^alertBlock)(NSInteger index);

@interface KJAlertView : UIView

@property (nonatomic, copy) alertBlock myBlock;
@property (nonatomic, strong) NSString *type;

- (instancetype)initWithTitle:(NSString *)title Content:(NSString *)contentStr whitTitleArray:(NSArray *)titleArray withType:(NSString *)type;

- (void)showAlertView:(alertBlock)myBlock;

- (void)dissmis;

@end
