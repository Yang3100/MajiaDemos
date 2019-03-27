//
//  NSString+KJValid.m
//  KJDevelopExample
//
//  Created by 杨科军 on 2017/6/12.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import "NSString+KJValid.h"

@implementation NSString (KJValid)


/// 检测字符串是否包含中文
+( BOOL)kj_isContainChinese:(NSString *)str{
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}
/// 整形
+ (BOOL)kj_isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
/// 浮点型
+ (BOOL)kj_isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/// 有效的手机号码
+ (BOOL)kj_isValidMobile:(NSString *)str{
    NSString *phoneRegex = @"^1[34578]\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:str];
}
/// 纯数字
+ (BOOL)kj_isPureDigitCharacters:(NSString *)string{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)return NO;
    
    return YES;
}

/// 字符串为字母或者数字
+ (BOOL)kj_isValidCharacterOrNumber:(NSString *)str{
    // 编写正则表达式：只能是数字或英文，或两者都存在
    NSString *regex = @"^[a-z0－9A-Z]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:str];
}






@end
