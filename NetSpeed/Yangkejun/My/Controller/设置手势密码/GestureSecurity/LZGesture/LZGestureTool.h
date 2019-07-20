//
//  LZGestureTool.h
//  LZGestureSecurity
//
//  Created by 杨科军 on 2016/10/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZGestureTool : NSObject

// 用户是否开启手势解锁
+ (void)saveGestureEnableByUser:(BOOL)isEnable;
+ (BOOL)isGestureEnableByUser;

// 保存 读取用户设置的密码
+ (void)saveGesturePsw:(NSString *)psw;
+ (NSString *)getGesturePsw;
+ (void)deleteGesturePsw;
+ (BOOL)isGesturePswEqualToSaved:(NSString *)psw;

+ (BOOL)isGestureEnable;
+ (BOOL)isGesturePswSavedByUser;

+ (void)saveGestureResetEnableByTouchID:(BOOL)enable;
+ (BOOL)isGestureResetEnableByTouchID;
@end
