//
//  LZGestureViewController.h
//  LZGestureSecurity
//
//  Created by 杨科军 on 2016/10/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZGestureViewController;
@protocol LZGestureViewDelegate <NSObject>

@optional
- (void)gestureView:(LZGestureViewController *)vc didSetted:(NSString *)psw ;
- (void)gestureView:(LZGestureViewController *)vc didUpdate:(NSString *)psw ;
- (void)gestureViewVerifiedSuccess:(LZGestureViewController *)vc ;
- (void)gestureViewCanceled:(LZGestureViewController *)vc ;

@end

typedef NS_ENUM(NSInteger, LZGestureType) {
    
    LZGestureTypeSetting = 0,
    LZGestureTypeVerifying,
    LZGestureTypeUpdate,
    LZGestureTypeScreen,
};
@interface LZGestureViewController : UIViewController

@property (nonatomic, assign) id <LZGestureViewDelegate> delegate;
@property (nonatomic, assign) LZGestureType type;

- (void)showInViewController:(UIViewController *)vc type:(LZGestureType)type ;

- (void)dismiss;
@end
