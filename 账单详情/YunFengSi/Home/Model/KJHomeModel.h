//
//  KJHomeModel.h
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJHomeModel : NSObject

/**
 单例类方法
 @return 返回一个共享对象
 */
+ (instancetype)sharedInstance;

// 加载月份表
- (void)loadDataBase:(int)month;

// 读取数据
- (NSArray*)getMonthData:(int)month;

// 删除表
- (void)delTable:(int)month;

// 更新表
- (void)updateTableMonth:(int)month Day:(NSString*)day keyValues:(NSDictionary*)keyValues;

@end

