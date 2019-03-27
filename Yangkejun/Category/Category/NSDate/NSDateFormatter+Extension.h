//
//  NSDateFormatter+Extension.h
//  YBJY
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 YouBeiJiaYuan. All rights reserved.
//  主要针对的是  童讯家长  的在线聊天的业务员逻辑

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Extension)
+ (instancetype)kj_dateFormatter;

+ (instancetype)kj_dateFormatterWithFormat:(NSString *)dateFormat;

+ (instancetype)kj_defaultDateFormatter;/*yyyy/MM/dd HH:mm:ss*/
@end
