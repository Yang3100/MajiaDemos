//
//  NSObject+KJRandom.m
//  KJDevelopExample
//
//  Created by CoderMikeHe on 17/2/8.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import "NSObject+KJRandom.h"

@implementation NSObject (KJRandom)

+ (NSInteger)kj_randomNumber:(NSInteger)from to:(NSInteger)to{
    return (NSInteger)(from + (arc4random()% (to - from + 1)));
}
@end
