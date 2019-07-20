//
//  KJModel.h
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/24.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJModel : NSObject

/**
 单例类方法
 @return 返回一个共享对象
 */
+ (instancetype)sharedInstance;

- (void)retColor:(NSInteger)index;

- (void)retLineWitd:(NSInteger)index;

- (void)retTime:(CGFloat)time;

@end
