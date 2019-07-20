//
//  FBKVOController+KJExtension.h
//  KJDevelopExample
//
//  Created by 杨科军 on 2017/6/16.
//  Copyright © 2017年 杨科军. All rights reserved.
//  FBKVOController

#import <KVOController/KVOController.h>

@interface FBKVOController (KJExtension)

- (void)kj_observe:(nullable id)object keyPath:(NSString *_Nullable)keyPath block:(FBKVONotificationBlock _Nullable )block;

- (void)kj_observe:(nullable id)object keyPath:(NSString *_Nullable)keyPath action:(SEL _Nullable )action;

@end
