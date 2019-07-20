//
//  FMDBMonthModel.h
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataObjectProtocol.h"

@interface FMDBMonthModel : NSObject<GDataObjectProtocol>

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *day;  // 日期
@property (nonatomic, assign) CGFloat expendSum;  // 支出总和
@property (nonatomic, assign) CGFloat incomeSum;  // 收入总和
@property (nonatomic, strong) NSString *remark;  // 备注说明

@end
