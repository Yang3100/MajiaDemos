//
//  InitializationUIMethod.h
//  BaseProject
//
//  Created by ZhouChong on 2017/2/24.
//  Copyright © 2017年 HN. All rights reserved.
//  创建常用UI子类，避免重复编码，造成大量创建代码冗余

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InitializationUIMethod : NSObject

#pragma mark -  UILabel
/// 实例化UILabel
UILabel *InsertLabel(id superView, CGRect cRect, NSTextAlignment align, NSString *contentStr, UIFont *textFont, UIColor *textColor);

/// 实例化UILabel，带阴影
UILabel *InsertLabelWithShadow(id superView, CGRect cRect, NSTextAlignment align, NSString *contentStr, UIFont *textFont, UIColor *textColor, BOOL shadow, UIColor *shadowColor, CGSize shadowOffset);


#pragma mark -UIScrollView
/// 实例化UIScrollView
UIScrollView *InsertScrollView(UIView *superView, CGRect rect, int tag,id<UIScrollViewDelegate> delegate);


#pragma mark -UIButton
/// 实例化UIbutton（带标题的圆角样式）
UIButton *InsertButtonRoundedRect(id superView, CGRect rc, int tag, NSString *title, id target, SEL action);

/// 实例化UIbutton（带图片的自定义样式）
UIButton *InsertImageButton(id superView, CGRect rc, int tag, UIImage *img, UIImage *imgH, id target, SEL action);

/// 实例化UIbutton（带标题与图片的自定义样式）
UIButton *InsertTitleAndImageButton(id superView, CGRect rc, int tag, NSString *title, UIEdgeInsets edgeInsets, UIFont *font, UIColor *color, UIColor *colorH, UIImage *img, UIImage *imgH, id target, SEL action);

/// 实例化UIbutton（带选中图片的自定义样式）
UIButton *InsertImageButtonWithSelectedImage(id superView, CGRect rc, int tag, UIImage *img, UIImage *imgH, UIImage *imgSelected, BOOL selected, id target, SEL action);

/// 实例化UIbutton（带选中图片及标题的自定义样式）
UIButton *InsertImageButtonWithSelectedImageAndTitle(id superView, CGRect rc, int tag, UIImage *img, UIImage *imgH, UIImage *imgSelected, BOOL selected, NSString *title, UIEdgeInsets edgeInsets, UIFont *font, UIColor *color, id target, SEL action);



#pragma mark - UIWebview
/// 实例化UIWebView
UIWebView *InsertWebView(id superView,CGRect cRect, id<UIWebViewDelegate>delegate, int tag);

/// UIWebView使用
void WebSimpleLoadRequest(UIWebView *web, NSString *strURL);
void WebSimpleLoadRequestWithCookie(UIWebView *web, NSString *strURL, NSString *cookies);



#pragma mark - UITableView
/// 实例化UITableView
UITableView *InsertTableView(id superView, CGRect rect, id<UITableViewDataSource> dataSoure, id<UITableViewDelegate> delegate, UITableViewStyle style, UITableViewCellSeparatorStyle cellStyle);



#pragma mark - UITextField
/// 实例化UITextField，未设置字体颜色
UITextField *InsertTextField(id superView, id delegate, CGRect rc, NSString *placeholder, UIFont *font, NSTextAlignment textAlignment, UIControlContentVerticalAlignment contentVerticalAlignment);

/// 实例化UITextField，设置字体颜色
UITextField *InsertTextFieldWithTextColor(id superView, id delegate, CGRect rc, NSString *placeholder, UIFont *font, NSTextAlignment textAlignment, UIControlContentVerticalAlignment contentVerticalAlignment, UIColor *textFieldColor);

/// 实例化UITextField，带边框及圆角
UITextField *InsertTextFieldWithBorderAndCorRadius(id superView, id delegate, CGRect rc, NSString *placeholder, UIFont *font, NSTextAlignment textAlignment, UIControlContentVerticalAlignment contentVerticalAlignment, float borderwidth, UIColor *bordercolor, UIColor *textFieldColor, float cornerRadius);

#pragma mark - UITextView
/// 实例化UITextView，未设置字体颜色
UITextView *InsertTextView(id superView, id delegate, CGRect rc, UIFont *font, NSTextAlignment textAlignment);

/// 实例化UITextView，设置字体颜色
UITextView *InsertTextViewWithTextColor(id superView, id delegate, CGRect rc, UIFont *font, NSTextAlignment textAlignment, UIColor *textcolor);

/// 实例化UITextView，带边框及圆角
UITextView *InsertTextViewWithBorderAndCorRadius(id superView, id delegate, CGRect rc, UIFont *font, NSTextAlignment textAlignment, float borderwidth, UIColor *bordercolor, UIColor *textcolor, float cornerRadius);



#pragma mark - UIImageView
/// 实例化UIImageView
UIImageView *InsertImageView(id superView, CGRect rect, UIImage *image);



#pragma mark -UIView
/// 实例化UIView
UIView *InsertView(id superView, CGRect rect, UIColor *backColor);

/// 实例化UIView，带边框
UIView *InsertViewWithBorder(id superView, CGRect rect, UIColor *backColor, CGFloat borderwidth, UIColor *bordercolor);

/// 实例化UIView，带边框和圆角
UIView *InsertViewWithBorderAndCorRadius(id superView, CGRect rect, UIColor *backColor, CGFloat borderwidth, UIColor *bordercolor, CGFloat corRadius);


@end
