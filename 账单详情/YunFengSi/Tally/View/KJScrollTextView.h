//
//  KJScrollTextView.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//  纵向滚动展示文字

#import <UIKit/UIKit.h>

@class KJScrollTextView;

@protocol KJScrollTextViewDelegate <NSObject>

@optional
- (void)scrollTextView:(KJScrollTextView *)scrollTextView currentTextIndex:(NSInteger)index;
- (void)scrollTextView:(KJScrollTextView *)scrollTextView clickIndex:(NSInteger)index content:(NSString *)content;

@end


@interface KJScrollTextView : UIView

@property (nonatomic,assign)id <KJScrollTextViewDelegate>delegate;

// textDataArr 支持 NSString 和 NSAttributedString类型
@property (nonatomic,copy)  NSArray *textDataArr; // 显示内容
@property (nonatomic,assign)CGFloat textStayTime;// 文字停留时间，默认为3s。
@property (nonatomic,assign)CGFloat scrollAnimationTime;// 文字滚动动画时间，默认为1s。

@property (nonatomic,copy)  UIFont  *textFont;
@property (nonatomic,copy)  UIColor *textColor;
@property (nonatomic)       NSTextAlignment textAlignment;
@property (nonatomic,assign)BOOL touchEnable; // defualt is YES

- (void)startScrollBottomToTopWithSpace;
- (void)startScrollTopToBottomWithSpace;

- (void)startScrollBottomToTopWithNoSpace;
- (void)startScrollTopToBottomWithNoSpace;

- (void)stop;
- (void)stopToEmpty;

@end

