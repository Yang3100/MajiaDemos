//
//  InitializationUIMethod.m
//  BaseProject
//
//  Created by ZhouChong on 2017/2/24.
//  Copyright © 2017年 HN. All rights reserved.
//

#import "InitializationUIMethod.h"

@implementation InitializationUIMethod

#pragma mark - UILabel
UILabel *InsertLabel(id superView, CGRect cRect, NSTextAlignment align, NSString *contentStr, UIFont *textFont, UIColor *textColor){
    return InsertLabelWithShadow(superView, cRect, align, contentStr, textFont, textColor, NO, nil, CGSizeMake(0.0, 0.0));
}

UILabel *InsertLabelWithShadow(id superView, CGRect cRect, NSTextAlignment align, NSString *contentStr, UIFont *textFont, UIColor *textColor, BOOL shadow, UIColor *shadowColor, CGSize shadowOffset){
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:cRect];
    tempLabel.backgroundColor = [UIColor clearColor];
    tempLabel.textAlignment = align;
    tempLabel.textColor = textColor;
    tempLabel.font = textFont;
    tempLabel.text = contentStr;
    [tempLabel setNumberOfLines:1];
    
    if (superView){
        [superView addSubview:tempLabel];
    }
    
    if (shadow){
        if (shadowColor){
            tempLabel.shadowColor = shadowColor;
        }
        tempLabel.shadowOffset = shadowOffset;
    }
    
    return tempLabel;
}

#pragma mark - UIScrollView
UIScrollView *InsertScrollView(UIView *superView, CGRect rect, int tag,id<UIScrollViewDelegate> delegate){
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.tag = tag;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = delegate;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    if (superView){
        [superView addSubview:scrollView];
    }
    
    return scrollView;
}

#pragma mark - UIButton
UIButton *InsertButtonRoundedRect(id superView,  CGRect rc, int tag, NSString *title, id target, SEL action){
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = rc;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTag:tag];
    
    if (superView){
        [superView addSubview:btn];
    }
    
    return btn;
}

UIButton *InsertImageButton(id superView, CGRect rc, int tag, UIImage *img, UIImage *imgH, id target, SEL action){
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rc;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:tag];
    
    if (nil != img){
        [btn setBackgroundImage:img forState:UIControlStateNormal];
    }
    
    if (nil != imgH){
        [btn setBackgroundImage:imgH forState:UIControlStateHighlighted];
    }
    
    if (superView){
        [superView addSubview:btn];
    }
    
    return btn;
}

UIButton *InsertTitleAndImageButton(id superView, CGRect rc, int tag, NSString *title, UIEdgeInsets edgeInsets, UIFont *font, UIColor *color, UIColor *colorH, UIImage *img, UIImage *imgH, id target, SEL action){
    UIButton *btn = InsertImageButton(superView, rc, tag, img, imgH, target, action);
    
    if (nil != font){
        btn.titleLabel.font = font;
    }
    if (nil != color){
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (nil != colorH){
        [btn setTitleColor:colorH forState:UIControlStateHighlighted];
    }
    
    if (nil != title){
        [btn setTitle:title forState:UIControlStateNormal];
        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    }
    
    btn.titleEdgeInsets = edgeInsets;
    
    return btn;
}

UIButton *InsertImageButtonWithSelectedImage(id superView, CGRect rc, int tag, UIImage *img, UIImage *imgH, UIImage *imgSelected, BOOL selected, id target, SEL action){
    UIButton *btn = InsertImageButton(superView, rc, tag, img, imgH, target, action);
    [btn setBackgroundImage:imgSelected forState:UIControlStateSelected];
    btn.selected = selected;
    [superView bringSubviewToFront:btn];
    [superView setUserInteractionEnabled:YES];
    return btn;
}

UIButton *InsertImageButtonWithSelectedImageAndTitle(id superView, CGRect rc, int tag, UIImage *img, UIImage *imgH, UIImage *imgSelected, BOOL selected, NSString *title, UIEdgeInsets edgeInsets, UIFont *font, UIColor *color, id target, SEL action){
    UIButton *btn = InsertImageButtonWithSelectedImage(superView, rc, tag, img, imgH, imgSelected, selected, target, action);
    
    if (nil != font){
        btn.titleLabel.font = font;
    }
    if (nil != color){
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    
    if (nil != title){
        [btn setTitle:title forState:UIControlStateNormal];
    }
    btn.titleEdgeInsets = edgeInsets;
    
    return btn;
}

#pragma mark - UIWebView
UIWebView *InsertWebView(id superView,CGRect cRect, id<UIWebViewDelegate>delegate, int tag){
    UIWebView *tempWebView = [[UIWebView alloc] initWithFrame:cRect];
    tempWebView.tag = tag;
    [tempWebView setOpaque:NO];
    tempWebView.backgroundColor = [UIColor clearColor];
    tempWebView.delegate = delegate;
    tempWebView.scalesPageToFit = NO;
    tempWebView.scrollView.scrollEnabled = NO;
    
    if (superView){
        [superView addSubview:tempWebView];
    }
    
    return tempWebView;
}

void WebSimpleLoadRequest(UIWebView *web, NSString *strURL){
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:strURL]] ;
    
    [web loadRequest:request];
}

void WebSimpleLoadRequestWithCookie(UIWebView *web, NSString *strURL, NSString *cookies){
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
    [request addValue:cookies forHTTPHeaderField:@"Cookie"];
    [web loadRequest:request];
}

#pragma mark -UITableView
UITableView *InsertTableView(id superView, CGRect rect, id<UITableViewDataSource> dataSoure, id<UITableViewDelegate> delegate, UITableViewStyle style, UITableViewCellSeparatorStyle cellStyle){
    UITableView *tabView = [[UITableView alloc] initWithFrame:rect style:style];
    tabView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (dataSoure){
        tabView.dataSource = dataSoure;
    }
    if (delegate){
        tabView.delegate = delegate;
    }
    
    tabView.separatorStyle = cellStyle;
    tabView.backgroundView = nil;
    
    if (superView){
        [superView addSubview:tabView];
    }
    
    return tabView;
}

#pragma mark - UITextField
UITextField *InsertTextField(id superView, id delegate, CGRect rc, NSString *placeholder, UIFont *font, NSTextAlignment textAlignment, UIControlContentVerticalAlignment contentVerticalAlignment){
    return InsertTextFieldWithTextColor(superView, delegate, rc, placeholder, font, textAlignment, contentVerticalAlignment, nil);
}

UITextField *InsertTextFieldWithTextColor(id superView, id delegate, CGRect rc, NSString *placeholder, UIFont *font, NSTextAlignment textAlignment, UIControlContentVerticalAlignment contentVerticalAlignment, UIColor *textFieldColor){
    return InsertTextFieldWithBorderAndCorRadius(superView, delegate, rc, placeholder, font, textAlignment, contentVerticalAlignment, 0.0, nil, textFieldColor, 0.0);
}

UITextField *InsertTextFieldWithBorderAndCorRadius(id superView, id delegate, CGRect rc, NSString *placeholder, UIFont *font, NSTextAlignment textAlignment, UIControlContentVerticalAlignment contentVerticalAlignment, float borderwidth, UIColor *bordercolor, UIColor *textFieldColor, float cornerRadius){
    UITextField *myTextField = [[UITextField alloc] initWithFrame:rc];
    myTextField.delegate = delegate;
    myTextField.placeholder = placeholder;
    myTextField.font = font;
    myTextField.textAlignment = textAlignment;
    myTextField.contentVerticalAlignment = contentVerticalAlignment;
    myTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    myTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if (!textFieldColor) {
        myTextField.textColor = [UIColor whiteColor];
    }
    else{
        myTextField.textColor = textFieldColor;
    }
    
    if (bordercolor && 0.0 != borderwidth){
        myTextField.layer.borderWidth = borderwidth;
        myTextField.layer.borderColor = bordercolor.CGColor;
    }
    
    if (0.0 != cornerRadius) {
        myTextField.layer.cornerRadius = cornerRadius;
    }
    
    if (superView){
        [superView addSubview:myTextField];
    }
    
    return myTextField;
}

#pragma mark -UITextView
UITextView *InsertTextView(id superView, id delegate, CGRect rc, UIFont *font, NSTextAlignment textAlignment){
    return InsertTextViewWithTextColor(superView, delegate, rc, font, textAlignment, nil);
}

UITextView *InsertTextViewWithTextColor(id superView, id delegate, CGRect rc, UIFont *font, NSTextAlignment textAlignment, UIColor *textcolor){
    return InsertTextViewWithBorderAndCorRadius(superView, delegate, rc, font, textAlignment, 0.0, nil, textcolor, 0.0);
}

UITextView *InsertTextViewWithBorderAndCorRadius(id superView, id delegate, CGRect rc, UIFont *font, NSTextAlignment textAlignment, float borderwidth, UIColor *bordercolor, UIColor *textcolor, float cornerRadius){
    UITextView *textview = [[UITextView alloc] initWithFrame:rc];
    textview.delegate = delegate;
    textview.font = font;
    textview.textAlignment = textAlignment;
    textview.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textview.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if (!textcolor){
        textview.textColor = [UIColor whiteColor];
    }
    else{
        textview.textColor = textcolor;
    }
    
    if (bordercolor && 0.0 != borderwidth){
        textview.layer.borderWidth = borderwidth;
        textview.layer.borderColor = bordercolor.CGColor;
    }
    
    if (0.0 != cornerRadius){
        textview.layer.cornerRadius = cornerRadius;
    }
    
    if (superView){
        [superView addSubview:textview];
    }
    
    return textview;
}

#pragma mark - UIImageView
UIImageView *InsertImageView(id superView, CGRect rect, UIImage *image){
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    
    if (image){
        [imageView setImage:image];
    }
    
    imageView.userInteractionEnabled = YES;
    
    if (superView){
        [superView addSubview:imageView];
    }
    
    return imageView;
}

#pragma mark - UIView
UIView *InsertView(id superView, CGRect rect, UIColor *backColor){
    return InsertViewWithBorder(superView, rect, backColor, 0.0, nil);
}

UIView *InsertViewWithBorder(id superView, CGRect rect, UIColor *backColor, CGFloat borderwidth, UIColor *bordercolor){
    return InsertViewWithBorderAndCorRadius(superView, rect, backColor, borderwidth, bordercolor, 0.0);
}

UIView *InsertViewWithBorderAndCorRadius(id superView, CGRect rect, UIColor *backColor, CGFloat borderwidth, UIColor *bordercolor, CGFloat corRadius){
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    
    if (superView){
        [superView addSubview:view];
    }
    
    if (bordercolor && 0.0 != borderwidth){
        view.layer.borderWidth = borderwidth;
        view.layer.borderColor = bordercolor.CGColor;
    }
    
    if (0.0 != corRadius){
        view.layer.cornerRadius = corRadius;
    }
    
    return view;
}


@end
