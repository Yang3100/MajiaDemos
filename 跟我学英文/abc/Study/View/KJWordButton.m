//
//  KJWordButton.m
//  跟我学英文
//
//  Created by 杨科军 on 2018/12/3.
//  Copyright © 2018 杨科军. All rights reserved.
//


#import "KJWordButton.h"

@implementation KJWordButton
- (void)animationShow{
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(_toPosition.x, _toPosition.y, self.frame.size.width, self.frame.size.height)];
    [self setLabelConfig:label];
    //缩放
    label.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [keyWindow addSubview:label];
    [UIView animateWithDuration:kDuration animations:^{
        //位移
        CABasicAnimation* position = [CABasicAnimation animationWithKeyPath:@"position"];
        position.fromValue = [NSValue valueWithCGPoint:self.toPosition];
        position.toValue = [NSValue valueWithCGPoint:self.fromPosition];
        position.duration = kDuration;
        position.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        [label.layer addAnimation:position forKey:@"positionAnimation"];
        //缩放
        label.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((kDuration - 0.15) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
        [self setHidden:NO];
    });
}

- (void)animationDismiss{
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    UILabel* label = [[UILabel alloc]initWithFrame:self.frame];
    [self setLabelConfig:label];
    [keyWindow addSubview:label];
    [UIView animateWithDuration:kDuration animations:^{
        //位移
        CABasicAnimation* position = [CABasicAnimation animationWithKeyPath:@"position"];
        position.fromValue = [NSValue valueWithCGPoint:self.fromPosition];
        position.toValue = [NSValue valueWithCGPoint:self.toPosition];
        position.duration = kDuration;
        position.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [label.layer addAnimation:position forKey:@"positionAnimation"];
        //缩放
        label.transform = CGAffineTransformMakeScale(0.1, 0.1);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((kDuration - 0.15) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
    [self setHidden:YES];
}

- (void)setLabelConfig:(UILabel*)label{
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = CGRectGetHeight(label.frame) * 0.5;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.titleLabel.text;
    label.textColor = self.titleLabel.textColor;
    label.font = self.titleLabel.font;
    [label setBackgroundColor:self.backgroundColor];
}

@end
