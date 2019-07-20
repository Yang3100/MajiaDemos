//
//  LinkedListQueue.h
//  FloodFillDemo
//
//  Created by LZR on 2018/8/31.
//  Copyright © 2018 Run. All rights reserved.
//  栈操作

#import <Foundation/Foundation.h>

#define INVALID_NODE_CONTENT INT_MIN

typedef struct PointNode {
    NSInteger value;
    NSInteger nextNodeOffset;
}PointNode;

@interface LinkedListQueue : NSObject 

- (instancetype)initWithCapacity:(NSInteger)capacity cacheSizeIncrements:(NSInteger)increments multiplier:(NSInteger)multiplier;
// 入栈
- (void)pushWithX: (NSInteger)x y: (NSInteger)y;
// 出栈
- (NSInteger)popWithX: (NSInteger *)x y: (NSInteger *)y;

@end
