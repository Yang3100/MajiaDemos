//
//  ZJ_RulesLineMovingView.h
//  ceshi
//
//  Created by shao_Mac on 2018/5/4.
//  Copyright © 2018年 shao_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SlideHeight 60

@protocol ValueChangeDelegate <NSObject>

- (void)valueChange;

@end

@interface ZJ_RulesLineMovingView : UIView

@property (nonatomic, weak) id<ValueChangeDelegate> delegate;

@end
