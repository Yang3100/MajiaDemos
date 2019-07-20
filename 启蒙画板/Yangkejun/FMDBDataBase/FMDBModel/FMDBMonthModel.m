//
//  FMDBMonthModel.m
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "FMDBMonthModel.h"

@implementation FMDBMonthModel

GDATABASE_IMPLEMENTATION_INJECT(FMDBMonthModel)

- (NSArray<NSString *> *)g_GetCustomPrimarykey
{
    return @[@"ID"];
}


+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{
             @"ID" :@"id",
             };
}


@end
