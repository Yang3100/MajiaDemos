//
//  AITextFiled.h
//  AnimationDemo
//
//  Created by 杨科军 on 2017/11/22.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import "KJTextFiled.h"

@implementation KJTextFiled

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentVerticalAlignment:(UIControlContentVerticalAlignmentCenter)];
        self.layer.cornerRadius  = 8;
        self.backgroundColor     = UIColorFromRGBA(240, 240, 240,1);
        self.font                = [UIFont systemFontOfSize:14];
        UIView *leftView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        leftView.backgroundColor = [UIColor clearColor];
        self.leftView = leftView;
        [self setLeftViewMode:(UITextFieldViewModeAlways)];
    }
    return self;
}
/**
 *  子控件改变的时候调用
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    self.leftView.frame = CGRectMake(0, 0, 10, self.frame.size.height);
}

@end
