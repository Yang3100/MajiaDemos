//
//  KJWordButton.h
//  跟我学英文
//
//  Created by 杨科军 on 2018/12/3.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDuration 1.0

@interface KJWordButton : UIButton

@property(nonatomic,assign)CGPoint fromPosition;
@property(nonatomic,assign)CGPoint toPosition;

- (void)animationShow;
- (void)animationDismiss;

@end
