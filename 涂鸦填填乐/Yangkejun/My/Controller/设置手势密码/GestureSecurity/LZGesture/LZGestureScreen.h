//
//  LZGestureScreen.h
//  LZGestureSecurity
//
//  Created by 杨科军 on 2016/10/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZGestureScreen;
@protocol LZGestureScreenDelegate <NSObject>

- (void)screen:(LZGestureScreen *)screen didSetup:(NSString *)psw;
@end
@interface LZGestureScreen : NSObject

+ (instancetype)shared;
- (void)show;
- (void)dismiss;
@end
