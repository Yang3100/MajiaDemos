//
//  FBKVOController+KJExtension.m
//  KJDevelopExample
//
//  Created by 杨科军 on 2017/6/16.
//  Copyright © 2017年 杨科军. All rights reserved.
//  FBKVOController

#import "FBKVOController+KJExtension.h"

@implementation FBKVOController (KJExtension)
- (void)kj_observe:(id)object keyPath:(NSString *)keyPath block:(FBKVONotificationBlock)block{
    [self observe:object keyPath:keyPath options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:block];
}

- (void)kj_observe:(id)object keyPath:(NSString *)keyPath action:(SEL)action{
    [self observe:object keyPath:keyPath options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew action:action];
}
@end
