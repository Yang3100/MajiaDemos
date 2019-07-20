//
//  NSObject+KJRandom.h
//  KJDevelopExample
//
//  Created by CoderMikeHe on 17/2/8.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KJRandom)
// 获取 [to from] 之间的数据
+ (NSInteger)kj_randomNumber:(NSInteger)from to:(NSInteger)to;
@end
