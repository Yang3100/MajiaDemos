//
//  NSDate+Extension.h
//  YBJY
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 YouBeiJiaYuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDateFormatter+Extension.h"

#define KJ_D_MINUTE	    60
#define KJ_D_HOUR		3600
#define KJ_D_DAY		86400
#define KJ_D_WEEK		604800
#define KJ_D_YEAR		31556926


@interface NSDate (Extension)
/**
 *  是否为今天
 */
- (BOOL)kj_isToday;
/**
 *  是否为昨天
 */
- (BOOL)kj_isYesterday;
/**
 *  是否为今年
 */
- (BOOL)kj_isThisYear;
/**
 *  是否本周
 */
- (BOOL)kj_isThisWeek;

/**
 *  星期几
 */
- (NSString *)kj_weekDay;

/**
 *  是否为在相同的周
 */
- (BOOL)kj_isSameWeekWithAnotherDate: (NSDate *)anotherDate;


/**
 *  通过一个时间 固定的时间字符串 "2016/8/10 14:43:45" 返回时间
 *  @param timestamp 固定的时间字符串 "2016/8/10 14:43:45"
 */
+ (instancetype)kj_dateWithTimestamp:(NSString *)timestamp;

/**
 *  返回固定的 当前时间 2016-8-10 14:43:45
 */
+ (NSString *)kj_currentTimestamp;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)kj_dateWithYMD;

/**
 * 格式化日期描述
 */
- (NSString *)kj_formattedDateDescription;

/** 与当前时间的差距 */
- (NSDateComponents *)kj_deltaWithNow;



//////////// MVC&MVVM的商品的发布时间的描述 ////////////
- (NSString *)kj_string_yyyy_MM_dd;
- (NSString *)kj_string_yyyy_MM_dd:(NSDate *)toDate;
//////////// MVC&MVVM的商品的发布时间的描述 ////////////

@end
