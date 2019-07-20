//
//  KJWordsCheckButton.h
//  跟我学英文
//
//  Created by 杨科军 on 2018/12/3.
//  Copyright © 2018 杨科军. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void (^EndEditBlock) (NSString* text);

typedef NS_ENUM(NSInteger,KJBtnType){
    KJBtnTypeNomal,   // 正常显示
    KJBtnTypeRight,   // 回答正确
    KJBtnTypeEorror   // 回答错误
};

@interface KJWordsCheckButton : UIButton

@property(nonatomic,copy)EndEditBlock endEditBlock;
@property(nonatomic,assign)KJBtnType btnType;
@property(nonatomic,strong)NSString *content; // 字母
@property(nonatomic,strong)NSString *answer;  // 正确答案

@end
