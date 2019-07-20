//
//  KJTools.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJTools.h"
#import "sys/utsname.h"  // 机型相关

#import <CommonCrypto/CommonDigest.h> // 加密相关

// 指纹支付相关
#import <LocalAuthentication/LocalAuthentication.h>
#import <AVFoundation/AVFoundation.h>

//md5秘钥-加密密钥
#define Tool_EncryptionKey @"yangkejun-735n197nxn(N′568GGS%d~~9naei';45vhhafdjkv]32rpks;lg,];:vjo(&**&^)"

// 头文件中需要定义 PI
#define PI 3.14159265358979323846264338327950288

//颜色相关
#define UIColorFromHEXA(hex,a)[UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]
//文字大小
#define SystemFontSize(fontsize)[UIFont systemFontOfSize:(fontsize)]

@interface KJTools()

@end



@implementation KJTools

//原始尺寸
static CGRect tool_oldframe;
+ (void)ShowAlertWith:(NSString *)title message:(NSString *)message sureTitle:(NSString*)sureWord andCancel:(NSString*)cancelStr viewControl:(UIViewController *)control andSureBack:(void(^)(void))block andCancelBack:(void(^)(void))canBlock{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:sureWord style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        block();
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        canBlock();
    }];
    
    if ([[[UIDevice currentDevice] systemVersion]integerValue] >=9.0){
        //        [sure setValue:AssistColor forKey:@"titleTextColor"];
        [cancel setValue:UIColorFromHEXA(0x333333,1.0)forKey:@"titleTextColor"];
        [sure setValue:MainColor(1) forKey:@"titleTextColor"];
    }
    
    [ac addAction:sure];
    [ac addAction:cancel];
    [control presentViewController:ac animated:YES completion:^{
    }];
}
#pragma mark-----提示框 确定和取消
+ (void)ShowOnlyAlertWith:(NSString*)title message:(NSString*)message andSureTitle:(NSString*)sureTitle viewControl:(UIViewController*)control andSureBack:(void(^)(void))block{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        block();
    }];
    if ([[[UIDevice currentDevice] systemVersion]integerValue] >=9.0){
        [sure setValue:UIColorFromHEXA(0x333333,1.0)forKey:@"titleTextColor"];
        [sure setValue:MainColor(1) forKey:@"titleTextColor"];
    }
    [ac addAction:sure];
    [control presentViewController:ac animated:YES completion:^{
    }];
    
}

// 抖动动画
+ (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = dur;
    //animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

// 请求地址的拼接
+ (NSString *)urlstrSuffix:(NSArray *)key withValue:(NSArray *)value with:(NSString *)suffix{
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@?",suffix];
    for (int i = 0; i < key.count; i ++){
        if (i == key.count-1){
            [url appendFormat:@"%@=%@",key[i],value[i]];
        }else{
            [url appendFormat:@"%@=%@&",key[i],value[i]];
        }
    }
    if ([self IsChinese:[NSString stringWithFormat:@"aa!@#$%@%@)",@"^&*(",url]]){  //当有中文的时候记得进行UTF8转码
        NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        NSString *str = url;
        str = [str stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        return str;
    }
    return url;
}

//判断是否有中文
+ (BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

// 属性文字
+ (NSMutableAttributedString *)getAttributedString:(NSString *)allString withStringAttributedDic:(NSDictionary *)dic withSubString:(NSString *)subString withSubStringAttributeDic:(NSDictionary *)subDic{
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc]initWithString:allString attributes:dic];
    NSRange range = [allString rangeOfString:subString];
    [resultString addAttributes:subDic range:range];
    return resultString;
}

+ (NSMutableAttributedString *)changeStrWittContext:(NSString *)context ChangeColorText:(NSString *)ColorStr WithColor:(id)ColorValue WithFont:(id)FontValue {
    if (context == nil || ColorStr == nil){
        return nil;
    }
    NSMutableAttributedString* inputStr = [[NSMutableAttributedString alloc]initWithString:context];
    NSRange ColorRange = NSMakeRange([[inputStr string]rangeOfString:ColorStr options:NSBackwardsSearch].location, [[inputStr string]rangeOfString:ColorStr].length);
    
    [inputStr addAttributes:@{NSForegroundColorAttributeName:ColorValue,NSFontAttributeName:FontValue} range:ColorRange];
    return inputStr;
    
}
//获取字符串大小
+ (CGRect)getStringFrame:(NSString *)str withFont:(NSInteger)fontSize withMaxSize:(CGSize)size{
    CGRect rect = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SystemFontSize(fontSize)} context:nil];
    return rect;
}

+ (NSString *)timeIntervalBeforeNowDescription:(NSString*)time{
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    //格式化日期字符串,只保留年、月、日信息
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:time.longLongValue];
    //    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:time.longLongValue];
    NSString *startTime = [dateFormatter stringFromDate:startDate];
    //    NSString *endTime = [dateFormatter stringFromDate:endDate];
    
    return [NSString stringWithFormat:@"%@",startTime];
}


// 时间戳转时间
+ (NSString *)turnTimeTimestamp:(NSString *)timeStamp withType:(NSString *)type{
    NSTimeInterval time=[timeStamp doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:type];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}
// 时间转时间戳
+ (NSInteger)TimestampturnTime:(NSString *)timeStamp withType:(NSString *)type{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //指定时间显示样式: HH表示24小时制 hh表示12小时制
    [formatter setDateFormat:type];
    NSString *lastTime = timeStamp;
    NSDate *lastDate = [formatter dateFromString:lastTime];
    //以 1970/01/01 GMT为基准，得到lastDate的时间戳
    long firstStamp = [lastDate timeIntervalSince1970];
    return firstStamp;
}

// 将时间戳转换为多少分钟前
+ (NSString *)turnTimeForTimestamp:(NSString *)timeStamp showDetail:(BOOL)showDetail{
    /*
     *、1、当天内，显示四个时段的时间，时段包括凌晨、上午、下午、晚上、凌晨。格式如下午16：30.
     * 1）凌晨定义：00：00--05：00
     * 2）上午定义：05：01--12：00
     * 3）下午定义：12：01--06：00
     * 4）晚上定义：06：01--23：59
     * 2、昨天的则显示昨天。
     * 3、昨天以前的则显示年/月/日，如2017/5/11。
     */
    // 今天的时间
    NSDate * nowDate = [NSDate date];
    NSDate * msgDate = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]];
    NSString *result = nil;
    NSCalendarUnit components = (NSCalendarUnit)(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour | NSCalendarUnitMinute);
    NSDateComponents *nowDateComponents = [[NSCalendar currentCalendar] components:components fromDate:nowDate];
    NSDateComponents *msgDateComponents = [[NSCalendar currentCalendar] components:components fromDate:msgDate];
    
    NSInteger hour = msgDateComponents.hour;
    
    result = [self getPeriodOfTime:hour withMinute:msgDateComponents.minute];
    if (hour > 12){
        hour = hour - 12;
    }
    if(nowDateComponents.day == msgDateComponents.day){ // 同一天,显示时间
        result = [[NSString alloc] initWithFormat:@"%@ %ld:%02d",result,(long)hour,(int)msgDateComponents.minute];
    }
    else if(nowDateComponents.day == (msgDateComponents.day+1)){ //昨天
        result = showDetail ?  [[NSString alloc] initWithFormat:@"%@%@ %ld:%02d",NSLocalizedString(@"time_yesterday", nil),result,(long)hour,(int)msgDateComponents.minute] : NSLocalizedString(@"time_yesterday", nil);
    }
    else { //显示日期
        NSString *day = [NSString stringWithFormat:@"%ld.%zd.%zd", (long)msgDateComponents.year, msgDateComponents.month, msgDateComponents.day];
        result = showDetail ? [day stringByAppendingFormat:@"%@ %ld:%02d",result,(long)hour,(int)msgDateComponents.minute]:day;
    }
    return result;
}

+ (NSString *)getPeriodOfTime:(NSInteger)time withMinute:(NSInteger)minute{
    NSInteger totalMin = time *60 + minute;
    NSString *showPeriodOfTime = @"";
    if (totalMin > 0 && totalMin <= 5 * 60){
        showPeriodOfTime = NSLocalizedString(@"time_morning", nil);
    }
    else if (totalMin > 5 * 60 && totalMin < 12 * 60){
        showPeriodOfTime = NSLocalizedString(@"time_morning", nil);
    }
    else if (totalMin >= 12 * 60 && totalMin <= 18 * 60){
        showPeriodOfTime = NSLocalizedString(@"time_afternoon", nil);
    }
    else if ((totalMin > 18 * 60 && totalMin <= (23 * 60 + 59))|| totalMin == 0){
        showPeriodOfTime = NSLocalizedString(@"time_evening", nil);
    }
    return showPeriodOfTime;
}
// 比较两个时间差
+ (BOOL)comperTTwoMessage:(NSString*)lastTime andNewTime:(NSString*)newTime{
    long  number = 0;
    number = [newTime doubleValue] - [lastTime doubleValue];
    if (number>300.0){
        return NO;
    }else{
        return YES;
    }
    
}

// 将一段时间转换 eg：5分钟转化为00：05：00
+ (NSString *)changMinuteToTime:(NSString *)minute{
    NSInteger time = [minute integerValue];
    if(time < 60){
        return [NSString stringWithFormat:@"00:00:%02ld",(long)time];
    }
    else{
        int seconds = time % 60;
        int minutes = (time / 60)% 60;
        long hours = time / 3600;
        return [NSString stringWithFormat:@"%02zd:%02d:%02d",hours, minutes, seconds];
    }
}

// 将一段时间转换为多少小时多少分钟多少秒
+ (NSString *)changMinuteToTimeHDS:(NSString *)minute{
    NSInteger time = [minute integerValue];
    if(time < 60){
        return [NSString stringWithFormat:@"%2ld%@",(long)time,NSLocalizedString(@"time_seconds", nil)];
    }
    else if (time>=60&&time<3600){
        return [NSString stringWithFormat:@"%2ld%@%2zd%@",time/60,NSLocalizedString(@"time_minute", nil),time%60,NSLocalizedString(@"time_seconds", nil)];
    }
    else{
        return [NSString stringWithFormat:@"%2ld%@%2zd%@",time/3600,NSLocalizedString(@"time_hour", nil),time/60,NSLocalizedString(@"time_minute", nil)];
    }
}

//// 检测系统是否安装了QQ,微信,微博
//+ (BOOL)isSupportWX {
//    return [WXApi isWXAppSupportApi] && [WXApi isWXAppInstalled];
//}
//
//+ (BOOL)isSupportQQ {
//    return [QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi];
//}
//
//+ (BOOL)isSupportSina {
//    return [WeiboSDK isCanSSOInWeiboApp] && [WeiboSDK isWeiboAppInstalled] && [WeiboSDK isCanShareInWeiboAPP];
//}

// 获取软件版本号
+ (NSString*)GetApp_Version{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}
// 过滤空格
+ (NSString*)filterSpace:(NSString*)string{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSLog(@"urlStr = %@",string);
    //过滤中间空格
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"urlStr = %@",string);
    return string;
}
// 验证手机号码是否有效
+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    if (mobileNum.length != 11){
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    // 使用谓词筛选功能,选出需求的数据
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else{
        return NO;
    }
}

// 验证邮箱格式是否正确
+ (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// 判断身份证是否是真实的
+ (BOOL)isValidateIDCardNumber:(NSString *)value{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    
    if (!value){
        return NO;
    }else {
        length = value.length;
        if (length != 15 && length != 18){
            return NO;
        }
    }
    
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    
    for (NSString *areaCode in areasArray){
        if ([areaCode isEqualToString:valueStart2]){
            areaFlag = YES;
            break;
        }
    }
    
    if (!areaFlag){
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    NSInteger year = 0;
    
    switch (length){
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
                if (year %4 ==0 || (year %100 ==0 && year %4 ==0)){
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
                numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0){
                return YES;
            }else {
                return NO;
            }
            case 18:
                year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)){
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
                    }else {
                        regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
                    }
                numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0){
                        int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue)*7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue)*9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value  substringWithRange:NSMakeRange(12,1)].intValue)*10 + ([value  substringWithRange:NSMakeRange(3,1)].intValue + [value  substringWithRange:NSMakeRange(13,1)].intValue)*5 + ([value  substringWithRange:NSMakeRange(4,1)].intValue + [value  substringWithRange:NSMakeRange(14,1)].intValue)*8 + ([value  substringWithRange:NSMakeRange(5,1)].intValue + [value  substringWithRange:NSMakeRange(15,1)].intValue)*4 + ([value  substringWithRange:NSMakeRange(6,1)].intValue + [value  substringWithRange:NSMakeRange(16,1)].intValue)*2 + [value  substringWithRange:NSMakeRange(7,1)].intValue *1 + [value  substringWithRange:NSMakeRange(8,1)].intValue *6 + [value  substringWithRange:NSMakeRange(9,1)].intValue *3;
                        int Y = S %11;
                        NSString *M =@"F";
                        NSString *JYM =@"10X98765432";
                        M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                        if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]){
                                return YES;// 检测ID的校验位
                            }else {
                    return NO;
                }
            }else {
                return NO;
            }
            default:
            return NO;
        }
}

// 图片 Kb 压缩
+ (UIImage *)zipImageWithImage:(UIImage *)image withMaxSize:(NSInteger)kBit{
    NSLog(@"开始时间");
    if (!image){
        return nil;
    }
    CGFloat maxFileSize = kBit*1024;
    CGFloat compression = 0.9f;
    //    compression = 0.7;
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    int i = 0;
    while ([compressedData length] > maxFileSize){
        compression *= compression;
        compressedData = UIImageJPEGRepresentation([[self class] compressImage:image newWidth:image.size.width*compression], compression);
        i++;
    }
    NSLog(@"循环处理次数 === %d",i);
    UIImage  *backImg = [UIImage imageWithData:compressedData];
    return backImg;
}
+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth{
    if (!image)return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    @autoreleasepool {
        if (widthScale > heightScale){
            [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
        }
        else {
            [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
        }
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
}
// 检测输入内容是否为数字
+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length){
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0){
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

#pragma mark -----------------------------  项目相关 ---------------------

// 等比例压缩图片
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size)== NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight)* 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth)* 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

// 两个时间戳是否相隔5分钟
+ (BOOL)timeIntervalIsSpaceFiveMinutes:(NSString *)lastTime nowTime:(NSString *)nowTime{
    NSTimeInterval startTime = [lastTime doubleValue];
    NSTimeInterval endTime = [nowTime doubleValue];
    
    //这个是相隔的秒数
    NSTimeInterval timeInterval = endTime - startTime;
    
    //相距5分钟显示时间Label
    if (fabs (timeInterval)> 300){
        return YES;
    }
    else{
        return NO;
    }
}
+ (BOOL)isNumber:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

// 得到字符串当中的数字
+ (NSArray*)getNumberInString:(NSString*)str{
    NSMutableArray *arr = [NSMutableArray array];
    //NSScanner条件判断利器
    NSScanner *scanner = [NSScanner scannerWithString:str];
    
    NSCharacterSet *numSet = [NSCharacterSet decimalDigitCharacterSet];
    while([scanner isAtEnd]==NO){
        if([scanner scanCharactersFromSet:numSet intoString:NULL]){ // 读取下一行
            int num;
            if([scanner scanInt:&num]){
                NSLog(@"num:%d",num);
                [arr addObject:@(num)];
            }
        }
    }
    return arr;
}

//   替换万位一下数字
+(NSString*)ChangeNumStr:(NSString*)number{
    NSString     *string = nil;
    if ([number isKindOfClass:[NSNull class]]||number==nil||[number isEqualToString:@""]){
        string =@"0.00";
        return string;
    }

    if ([number rangeOfString:@"."].location!=NSNotFound){
        // 有小数点数据
        CGFloat    num = [number floatValue];
        NSString  *changeNum=  [NSString stringWithFormat:@"%.2f",num];
        if (num/10000<1){
            string = [NSString stringWithFormat:@"%@",changeNum];
        }else{
            float  result =  num/10000.0;
            if (result>=1000){
                string = [NSString stringWithFormat:@"999+%@",NSLocalizedString(@"number_wan", nil)];
                //                @"999+万";
            }else{
                NSString   *hash = [self notRounding:result afterPoint:2];
                string = [NSString  stringWithFormat:@"%@%@",hash,NSLocalizedString(@"number_wan", nil)];
            }
        }
    }else{
        NSInteger  num= [number integerValue];
        NSString  *lastNum=  [NSString stringWithFormat:@"%ld",(long)num];
        if (num/10000<1){
            string = [NSString stringWithFormat:@"%@",lastNum];
        }else{
            float  result =  num/10000.0;
            if (result>=1000){
                string = [NSString stringWithFormat:@"999+%@",NSLocalizedString(@"number_wan", nil)];
                //                @"999+万";;
            }else{
                NSString   *hash = [self notRounding:result afterPoint:2];
                string = [NSString  stringWithFormat:@"%@%@",hash,NSLocalizedString(@"number_wan", nil)];
            }
        }
    }
    //    CGFloat    num = [number floatValue];
    //    NSString  *lastNum=  [NSString stringWithFormat:@"%.2f",num];
    //    if ([lastNum hasPrefix:@"."]){
    //        if (num/10000<1){
    //            string = [NSString stringWithFormat:@"%@",lastNum];
    //        }else{
    //            float  result =  num/10000.0;
    //            NSString   *hash = [self notRounding:result afterPoint:2];
    //            string = [NSString  stringWithFormat:@"%@万",hash];
    //        }
    //
    //    }else{
    //
    //        if (num/10000<1){
    //            string = [NSString stringWithFormat:@"%@",lastNum];
    //        }else{
    //            float  result =  num/10000.0;
    //            NSString   *hash = [self notRounding:result afterPoint:2];
    //            string = [NSString  stringWithFormat:@"%@万",hash];
    //        }
    //    }
    return string;
}


// 获取当前视图所在的控制器
+ (UIViewController*)getcurrentVC:(UIView*)view;{
    for (UIView* next = [view superview]; next; next = next.superview){
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]){
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

// 获取当前视图presentedViewController
+ (UIViewController *)currentViewController{
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController){
        vc = vc.presentedViewController;
        if ([vc isKindOfClass:[UINavigationController class]]){
            vc = [(UINavigationController *)vc visibleViewController];
        }
        else if ([vc isKindOfClass:[UITabBarController class]]){
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    return vc;
}

//class为目标页面的类
+ (void)dismissViewControllerClass:(Class)class{
    UIViewController *vc = [self currentViewController];
    while (![vc isKindOfClass:class] && vc != nil){
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}

+ (void)popViewControllerClass:(Class)class{
    for (UIViewController *controller in [self currentViewController].navigationController.viewControllers){
        if ([controller isKindOfClass:class]){
            [[self currentViewController].navigationController popToViewController:controller animated:YES];
        }
    }
}

+ (NSString *)notRounding:(float)price afterPoint:(int)position{
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal;
    
    NSDecimalNumber *roundedOunces;
    
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
    
}

// json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)json{
    if (json == nil){
        return nil;
    }
    if ([json isKindOfClass:[NSData class]]){
        return nil;
    }
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// 字典转json字符串方法
+ (NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData){
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

//// 根据用户等级返回背景图片名称
//+ (UIImage *)returnBackgroundImageNameWithLevel:(NSString *)level{
//    if ([level integerValue] <= 10){
//        return [UIImage imageWithCustomColor:UIColorFromHEXA(0x42a5f5, 1.0)];
//    }
//    else if ([level integerValue] > 10 && [level integerValue] <= 20){
//        return [UIImage imageWithCustomColor:UIColorFromHEXA(0x11d680, 1.0)];
//    }
//    else if ([level integerValue] > 20 && [level integerValue] <= 30){
//        return [UIImage imageWithCustomColor:UIColorFromHEXA(0xf87a67, 1.0)];
//    }
//    else if ([level integerValue] > 30 && [level integerValue] <= 40){
//        return [UIImage imageWithCustomColor:UIColorFromHEXA(0xec51a8, 1.0)];
//    }
//    else if ([level integerValue] > 40 && [level integerValue] <= 50){
//        return [UIImage imageWithCustomColor:UIColorFromHEXA(0xf35164, 1.0)];
//    }
//    else if ([level integerValue] > 50 && [level integerValue] <= 60){
//        return [UIImage imageWithCustomColor:UIColorFromHEXA(0xc64ad9, 1.0)];
//    }
//    else if ([level integerValue] > 60 && [level integerValue] <= 70){
//        return [UIImage imageWithCustomColor:UIColorFromHEXA(0x81cb21, 1.0)];
//    }
//    else if ([level integerValue] > 70 && [level integerValue] <= 80){
//        return [UIImage imageWithCustomColor:UIColorFromHEXA(0x63dfde, 1.0)];
//    }
//    else if ([level integerValue] > 80 && [level integerValue] <= 90){
//        return [UIImage imageWithCustomColor:UIColorFromHEXA(0xea7320, 1.0)];
//    }
//    else{
//        return [UIImage imageWithCustomColor:UIColorFromHEXA(0xfd596b, 1.0)];
//    }
//}

//// 大礼物动画名称数组
//+ (NSArray *)BigGiftNameArray{
//    NSString *docsDir = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//
//    NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:docsDir];
//
//    NSString *fileName;
//    NSMutableArray *array = [NSMutableArray array];
//    while (fileName = [dirEnum nextObject]){
//        [array addObject:fileName];
//    }
//
//    return array;
//}
//
//// 获取大礼物动画图片数组
//+ (NSMutableArray *)getBigGiftPictureArray:(NSString *)key {
//    NSString *fullpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:key];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:fullpath];
//
//    NSString *fileName;
//    NSMutableArray *array = [NSMutableArray array];
//    while (fileName = [dirEnum nextObject]){
//        [array addObject:fileName];
//    }
//
//    // 数组排序
//    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
//    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
//    NSComparator sort = ^(NSString *obj1,NSString *obj2){
//        NSRange range = NSMakeRange(0,obj1.length);
//        return [obj1 compare:obj2 options:comparisonOptions range:range];
//    };
//    NSArray *resultArray2 = [array sortedArrayUsingComparator:sort];
//
//    // 数据组装
//    NSMutableArray *images = [NSMutableArray array];
//    for (NSString *name in resultArray2){
//        NSString *path =  [fullpath stringByAppendingPathComponent:name];
//        UIImage * image = [UIImage imageWithContentsOfFile:path];
//        if (image != nil){
//            [images addObject:image];
//        }
//    }
//
//    return images;
//}


+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent)* scale;
    size_t height = CGRectGetHeight(extent)* scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
    
}

// 获取沙盒地址Library的目录路径
+ (NSArray *)applicationDocumentsDirectory{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
}

// 获取沙盒地址Library的目录路径
+ (NSString *)applicationDocumentsDirectoryWithLibrary{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
}

// 获取沙盒地址Documents的目录路径
+ (NSString *)applicationDocumentsDirectoryWithDocuments{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
}
/**
 *  获取沙盒Preference的文件目录。
 */
+ (NSString *)applicationPreferencePanesDirectoryWithPreference{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES)lastObject];
}

/**
 *  获取沙盒Caches的文件目录。
 */
+ (NSString *)applicationPreferencePanesDirectoryWithCaches{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
}
// 按路径清除文件
+ (void)clearCachesWithFilePath:(NSString *)path{
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:path error:nil];
    
    
}
//清除文件夹下所有文件
+ (void)clearSubfilesWithFilePath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *allPaths = [manager subpathsAtPath:path];
    for (NSString *str in allPaths){
        [manager removeItemAtPath:[path stringByAppendingPathComponent:str] error:nil];
    }
}


+ (double)sizeWithFilePath:(NSString *)path{
    // 1.获得文件夹管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [mgr fileExistsAtPath:path isDirectory:&dir];
    if (!exits)return 0;
    
    // 3.判断是否为文件夹
    if (dir){ // 文件夹, 遍历文件夹里面的所有文件
        // 这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径)
        NSArray *subpaths = [mgr subpathsAtPath:path];
        int totalSize = 0;
        for (NSString *subpath in subpaths){
            NSString *fullsubpath = [path stringByAppendingPathComponent:subpath];
                BOOL dir = NO;
            [mgr fileExistsAtPath:fullsubpath isDirectory:&dir];
            if (!dir){ // 子路径是个文件
                NSDictionary *attrs = [mgr attributesOfItemAtPath:fullsubpath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        return totalSize / (1024 * 1024.0);
    } else { // 文件
        NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
        return [attrs[NSFileSize] intValue] / (1024 * 1024.0);
    }
}


// 保存图片到沙盒
+ (void)saveImage:(UIImage *)tempImage withName:(NSString *)imageName{
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [self applicationDocumentsDirectoryWithDocuments];//[paths objectAtIndex:0];
    
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
}

// 根据图片名从获取图片路径
+ (NSString *)getImagePathWithName:(NSString *)name{
    NSString *documentsFile = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString* fullPathToFile = [documentsFile stringByAppendingPathComponent:name];
    
    return fullPathToFile;
}

// 判断机型
+ (NSString*)deviceVersion{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])   return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])   return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])   return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])   return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])   return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])   return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])   return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])   return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])   return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])   return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])   return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])   return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])   return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])   return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])   return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])   return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone9,1"] || [deviceString isEqualToString:@"iPhone9,3"])   return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"] || [deviceString isEqualToString:@"iPhone9,4"])   return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"] || [deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"] || [deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"] || [deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    
    return deviceString;
}
+ (BOOL)isIpad{
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPhone"]){
        return NO;
    }
    else if([deviceType isEqualToString:@"iPod touch"]){
        return NO;
    }
    else if([deviceType isEqualToString:@"iPad"]){
        return YES;
    }
    return NO;
}

// 根据出生日期算详细年龄
+ (NSString*)getAgeFormYear:(NSString*)year{
    if (year ==nil || [year isEqualToString:@"出生日期" ]){
        return @"未设置";
    }
    NSString *ago = [NSString stringWithFormat:@"0%@", NSLocalizedString(@"time_age", nil)];
    //    @"0岁";
    NSCalendar *calendar = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    
    NSDate *nowDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSString *birthdayStr=[year substringWithRange:NSMakeRange(0,10)];
    NSDate *birthDay = [dateFormatter dateFromString:birthdayStr];
    
    //用来得到详细的时差
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *date = [calendar components:unitFlags fromDate:birthDay toDate:nowDate options:0];
    ago = [NSString stringWithFormat:@"%ld%@",(long)[date year],NSLocalizedString(@"time_age", nil)];
    
    return ago;
}

+ (NSString *)getAstroWithMonth:(NSString*)year{
    if (year ==nil || [year isEqualToString:@"出生日期" ]){
        return @"未设置";
    }
    NSString *birthdayStr=[year substringWithRange:NSMakeRange(0,10)];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    NSDate *birthdayDate = [dateFormatter dateFromString:birthdayStr];
    return [self kj_getXingzuo:birthdayDate];
}

+ (NSString *)kj_getXingzuo:(NSDate *)in_date{
    //计算星座
    NSString *retStr=@"";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int i_month=0;
    NSString *theMonth = [dateFormat stringFromDate:in_date];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]){
        i_month = [[theMonth substringFromIndex:1] intValue];
    }else{
        i_month = [theMonth intValue];
    }
    
    [dateFormat setDateFormat:@"dd"];
    int i_day=0;
    NSString *theDay = [dateFormat stringFromDate:in_date];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]){
        i_day = [[theDay substringFromIndex:1] intValue];
    }else{
        i_day = [theDay intValue];
    }
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    
    switch (i_month){
        case 1:
            if(i_day>=20 && i_day<=31){
                retStr = [NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Aquarius", nil)];
            }
            if(i_day>=1 && i_day<=19){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Capricorn", nil)];
                //@"摩羯座";
            }
            break;
        case 2:
            if(i_day>=1 && i_day<=18){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Aquarius", nil)];
                //@"水瓶座";
            }
            if(i_day>=19 && i_day<=31){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Pisces", nil)];
                //@"双鱼座";
            }
            break;
        case 3:
            if(i_day>=1 && i_day<=20){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Pisces", nil)];
                //@"双鱼座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Aries", nil)];
                //@"白羊座";
            }
            break;
        case 4:
            if(i_day>=1 && i_day<=19){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Aries", nil)];
                //@"白羊座";
            }
            if(i_day>=20 && i_day<=31){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Taurus", nil)];
                //@"金牛座";
            }
            break;
        case 5:
            if(i_day>=1 && i_day<=20){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Taurus", nil)];
                //@"金牛座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Gemini", nil)];
                //@"双子座";
            }
            break;
        case 6:
            if(i_day>=1 && i_day<=21){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Gemini", nil)];
                //@"双子座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Cancer", nil)];
                //@"巨蟹座";
            }
            break;
        case 7:
            if(i_day>=1 && i_day<=22){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Cancer", nil)];
                //@"巨蟹座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Leo", nil)];
                //@"狮子座";
            }
            break;
        case 8:
            if(i_day>=1 && i_day<=22){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Leo", nil)];
                //@"狮子座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Virgo", nil)];
                //@"处女座";
            }
            break;
        case 9:
            if(i_day>=1 && i_day<=22){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Virgo", nil)];//@"处女座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Libra", nil)];//@"天秤座";
            }
            break;
        case 10:
            if(i_day>=1 && i_day<=23){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Libra", nil)];//@"天秤座";
            }
            if(i_day>=24 && i_day<=31){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Scorpio", nil)];//@"天蝎座";
            }
            break;
        case 11:
            if(i_day>=1 && i_day<=21){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Scorpio", nil)];//@"天蝎座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Sagittarius", nil)];//@"射手座";
            }
            break;
        case 12:
            if(i_day>=1 && i_day<=21){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Sagittarius", nil)];//@"射手座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=[NSString stringWithFormat:@"%@",NSLocalizedString(@"tool_constellation_Capricorn", nil)];//@"摩羯座";
            }
            break;
    }
    return retStr;
}

// 拼接字符串,去除"-"的数据,如果都为空显示国家
+ (NSString*)kj_judgeCountry:(NSString*)country State:(NSString*)state City:(NSString*)city Region:(NSString*)region{
    NSString *str=@"";
    if (![state isEqualToString:@""]&&![state isEqualToString:@"-"]){
        str = state;
    }
    if (![str isEqualToString:@""]){
        str = [NSString stringWithFormat:@"%@-",str];
    }
    
    if (![city isEqualToString:@""]&&![city isEqualToString:@"-"]){
        str = [NSString stringWithFormat:@"%@%@",str,city];
    }
    
    if (![region isEqualToString:@""]&&![region isEqualToString:@"-"]){
        str = [NSString stringWithFormat:@"%@-%@",str,region];
    }
    
    if ([str isEqualToString:@""]){
        str = country;
    }
    
    return str;
}

// 图片字符串
+ (NSString*)returnPictureStr:(NSString*)imgUrl andW:(NSInteger)wNum andH:(NSInteger)hNum{
    NSString  *string =nil;
    if ([imgUrl hasPrefix:@"http"]||[imgUrl hasPrefix:@"https"]){
        string = [NSString  stringWithFormat:@"%@?imageView2/w/%ld/h/%ld",imgUrl,wNum,hNum];
    }else{
        return nil;
    }
    return string;
    
}

// 读取plist和json文件数据
+ (NSArray*)getPlistOrJsonFile:(NSString*)fileName Type:(NSString*)type{
    NSMutableArray *arrData = [NSMutableArray array];
    if ([type isEqualToString:@"plist"]){ //[fileName hasSuffix:@".plist"]
        NSString *_fileName = [fileName stringByReplacingOccurrencesOfString:@".plist" withString:@""];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:_fileName ofType:@"plist"];
        arrData = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    else if ([type isEqualToString:@"json"]){
        NSString *_fileName = [fileName stringByReplacingOccurrencesOfString:@".plist" withString:@""];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:_fileName ofType:@"json"];
        NSData *JSONData = [NSData dataWithContentsOfFile:filePath];
        arrData = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    }
    return arrData;
}


// 根据图片url获取图片尺寸
+ (CGSize)getImageSizeWithURL:(NSString*)urlString{
    NSURL *URL = [NSURL URLWithString:urlString];
    if(URL == nil)return CGSizeZero; // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"]){
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size)){                    // 如果获取文件头信息失败,发送异步请求请求原图
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image){
            size = image.size;
        }
    }
    return size;
}
//  获取PNG图片的大小
+ (CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8){
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24)+ (w2 << 16)+ (w3 << 8)+ w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24)+ (h2 << 16)+ (h3 << 8)+ h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
+ (CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4){
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
+ (CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58){
        return CGSizeZero;
    }
    
    if ([data length] < 210){// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8)+ w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8)+ h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb){
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb){// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8)+ w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8)+ h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8)+ w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8)+ h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

//text 高度
+ (CGFloat)calculateTextHeightWithWidth:(CGFloat)width andText:(NSString *)text andFont:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return rect.size.height;
}

+ (CGFloat)calculateTextHeightWithWidth:(CGFloat)width andText:(NSString *)text attributes:(NSDictionary *)attribute{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return rect.size.height;
}

//text 宽度
+ (CGFloat)calculateTextWidthWithText:(NSString *)text andFont:(UIFont *)font{
    if (!text || !font){
        return 0.0f;
    }
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return rect.size.width + 2;
}

+ (int)getMayIntege:(NSInteger)divisor dividend:(NSInteger)div{
    int MayIntege=0;
    if (divisor%div >0){
        MayIntege++;
    }
    if (divisor/div >0){
        MayIntege+=divisor/div;
    }
    return MayIntege;
}

// 获取一个随机整数，范围在[from,to]，包括from，包括to
+ (int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + arc4random()% (to-from + 1));
}

/**
 *  浏览大图
 *
 *  @param currentImageview 当前图片
 *  @param alpha            背景透明度
 */
+(void)scanBigImageWithImageView:(UIImageView *)currentImageview alpha:(CGFloat)alpha {
    //  当前imageview的图片
    UIImage *image = currentImageview.image;
    if (image == nil){
        return;
    }
    //  当前视图
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //  背景
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //  当前imageview的原始尺寸->将像素currentImageview.bounds由currentImageview.bounds所在视图转换到目标视图window中，返回在目标视图window中的像素值
    tool_oldframe = [currentImageview convertRect:currentImageview.bounds toView:window];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:alpha]];
    
    //  此时视图不会显示
    [backgroundView setAlpha:0];
    //  将所展示的imageView重新绘制在Window中
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:tool_oldframe];
    [imageView setImage:image];
    imageView.contentMode =UIViewContentModeScaleAspectFit;
    [imageView setTag:1024];
    [backgroundView addSubview:imageView];
    //  将原始视图添加到背景视图中
    [window addSubview:backgroundView];
    
    //  添加点击事件同样是类方法 -> 作用是再次点击回到初始大小
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
    [backgroundView addGestureRecognizer:tapGestureRecognizer];
    
    //  动画放大所展示的ImageView
    [UIView animateWithDuration:0.4 animations:^{
        CGFloat y,width,height;
        y = ([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width)* 0.5;
        //宽度为屏幕宽度
        width = [UIScreen mainScreen].bounds.size.width;
        //高度 根据图片宽高比设置
        height = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
        [imageView setFrame:CGRectMake(0, y, width, height)];
        //重要！ 将视图显示出来
        [backgroundView setAlpha:1];
    } completion:^(BOOL finished){
    }];
    
}

/**
 *  恢复imageView原始尺寸
 *
 *  @param tap 点击事件
 */
+(void)hideImageView:(UITapGestureRecognizer *)tap{
    
    UIView *backgroundView = tap.view;
    //  原始imageview
    UIImageView *imageView = [tap.view viewWithTag:1024];
    //  恢复
    [UIView animateWithDuration:0.4 animations:^{
        [imageView setFrame:tool_oldframe];
        [backgroundView setAlpha:0];
    } completion:^(BOOL finished){
        //完成后操作->将背景视图删掉
        [backgroundView removeFromSuperview];
    }];
}

// 指纹验证
+ (void)kj_showTouchIDWithDescribe:(NSString *)desc BlockState:(StateBlock)block{
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"系统版本不支持TouchID (必须高于iOS 8.0才能使用)");
            block(TDTouchIDStateVersionNotSupport,nil);
        });
        return;
    }
    LAContext *context = [[LAContext alloc]init];
    context.localizedFallbackTitle = desc;
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:desc == nil ? @"通过Home键验证已有指纹":desc reply:^(BOOL success, NSError * _Nullable error){
            if (success){
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"TouchID 验证成功");
                    block(TDTouchIDStateSuccess,error);
                });
            }else if(error){
                switch (error.code){
                    case LAErrorAuthenticationFailed:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 验证失败");
                            block(TDTouchIDStateFail,error);
                        });
                        break;
                    }
                    case LAErrorUserCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 被用户手动取消");
                            block(TDTouchIDStateUserCancel,error);
                        });
                    }
                        break;
                    case LAErrorUserFallback:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"用户不使用TouchID,选择手动输入密码");
                            block(TDTouchIDStateInputPassword,error);
                        });
                    }
                        break;
                    case LAErrorSystemCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
                            block(TDTouchIDStateSystemCancel,error);
                        });
                    }
                        break;
                    case LAErrorPasscodeNotSet:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 无法启动,因为用户没有设置密码");
                            block(TDTouchIDStatePasswordNotSet,error);
                        });
                    }
                        break;
                    case LAErrorTouchIDNotEnrolled:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 无法启动,因为用户没有设置TouchID");
                            block(TDTouchIDStateTouchIDNotSet,error);
                        });
                    }
                        break;
                    case LAErrorTouchIDNotAvailable:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 无效");
                            block(TDTouchIDStateTouchIDNotAvailable,error);
                        });
                    }
                        break;
                    case LAErrorTouchIDLockout:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
                            block(TDTouchIDStateTouchIDLockout,error);
                        });
                    }
                        break;
                    case LAErrorAppCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                            block(TDTouchIDStateAppCancel,error);
                        });
                    }
                        break;
                    case LAErrorInvalidContext:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                            block(TDTouchIDStateInvalidContext,error);
                        });
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"当前设备不支持TouchID");
            block(TDTouchIDStateNotSupport,error);
        });
    }
}

// 旋转动画
+ (void)viewAnimationRotate:(UIView*)view isRight:(BOOL)Right speed:(CGFloat)time TransCount:(int)num{
        CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        if (Right){
            animation.fromValue = [NSNumber numberWithFloat:0.f];
            animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
        }else{
            animation.fromValue =[NSNumber numberWithFloat: M_PI *2];
            animation.toValue =  [NSNumber numberWithFloat:0.f];
        }
        animation.duration = time ? time : 5.0f; // 默认5秒
        animation.autoreverses = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.beginTime = CACurrentMediaTime()+ 0.1; // 0.1秒后执行
        animation.repeatCount = num == 0 ? MAXFLOAT : num; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        [view.layer addAnimation:animation forKey:@"rotate-layer"];
}

// 移动动画
+ (void)viewAnimationMove:(UIView*)myView MoveX:(CGFloat)x MoveY:(CGFloat)y Duration:(CGFloat)duration TransCount:(int)num{
    //1.移动动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = duration;
    animation.repeatCount = num == 0 ? CGFLOAT_MAX : num;  // 重复次数
    //        animation.autoreverses      = YES; // 动画结束时是否执行逆动画
    animation.beginTime = CACurrentMediaTime()+ .1;// 1秒后执行
    animation.fromValue = [NSValue valueWithCGPoint:myView.layer.position]; // 起始帧
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(x, y)]; // 终了帧
    
    // 视图添加动画
    [myView.layer addAnimation:animation forKey:@"move-layer"];
}

// 缩放  Duration:移动持续时间, TransCount:重复次数(0:表示一直转)
+ (CABasicAnimation*)viewAnimationZoom:(UIView *)view Multiple:(CGFloat)multiple Duration:(CGFloat)duration TransCount:(int)num isGroup:(BOOL)group starSize:(CGFloat)size starTime:(CGFloat)time{
    //3.缩放动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = duration;
    animation.repeatCount = num == 0 ? CGFLOAT_MAX : num;  // 重复次数
   // animation.autoreverses      = YES; // 动画结束时是否执行逆动画
    animation.fromValue = [NSNumber numberWithFloat:size]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:multiple]; // 结束时的倍率
    if (group){
        animation.beginTime = time;
        return animation;
    }
    [view.layer addAnimation:animation forKey:@"scale-layer"];
    return nil;
}

// 渐隐  isAlpha:是否为隐藏, Alpha:隐藏系数 Duration:移动持续时间, TransCount:重复次数(0:表示一直转)
+ (void)viewAnimationOpacity:(UIView*)myView Alpha:(CGFloat)kj_a Duration:(CGFloat)duration TransCount:(int)num isFlash:(BOOL)flash{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = duration;
    animation.repeatCount = num == 0 ? CGFLOAT_MAX : num;  // 重复次数
    if (flash){
       animation.autoreverses = YES; // 动画结束时是否执行逆动画
    }
    animation.toValue = [NSNumber numberWithFloat:kj_a]; // 结束时的倍率
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    [myView.layer addAnimation:animation forKey:@"op"];
}

// 同一个view实现多种动画
+ (void)viewAnimationMore:(UIView*)view Animations:(NSArray<CABasicAnimation*>*)array Duration:(CGFloat)duration TransCount:(int)num{
    /* 动画组 */
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duration;
    group.repeatCount = num == 0 ? CGFLOAT_MAX : num;  // 重复次数
//    group.autoreverses      = YES; // 动画结束时是否执行逆动画
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.animations = array;
    [view.layer addAnimation:group forKey:@"move-rotate-layer"];
}
+ (CGFloat)hj_imageViewWithGIF:(NSString*)gifStr view:(UIImageView*)imageView cycle:(NSInteger)cle{
    NSMutableArray* gifImages=[NSMutableArray array];
    NSString *path=[[NSBundle mainBundle]pathForResource:gifStr ofType:@"gif"];
    NSData*date=[NSData dataWithContentsOfFile:path];
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)date, NULL);
    CGFloat animationTime = 0.f;
    if (src){
        size_t l = CGImageSourceGetCount(src);
        gifImages = [NSMutableArray arrayWithCapacity:l];
        for (size_t i = 0; i < l; i++){
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
            NSDictionary *properties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, i, NULL));
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            animationTime += [delayTime floatValue];
            if (img){
                [gifImages addObject:[UIImage imageWithCGImage:img]];
                CGImageRelease(img);
            }
        }
        CFRelease(src);
    }
    CGFloat time=(1.0f/10.0f)*gifImages.count;
    imageView.animationImages = gifImages;
    imageView.animationDuration =time;
    imageView.animationRepeatCount = cle;
    [imageView startAnimating];
    return time;
}

+ (int)getStatusAudio{
    // 是否有麦克风权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
//    switch (authStatus){
//        case AVAuthorizationStatusNotDetermined:
//            //没有询问是否开启麦克风
//
//        case AVAuthorizationStatusRestricted:
//            //未授权，家长限制
//
//        case AVAuthorizationStatusDenied:
//            //玩家未授权
//
//            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted){
//
//            }];
//        case AVAuthorizationStatusAuthorized:
//            //玩家授权
//
//            break;
//        default:
//            break;
//    }
    return authStatus;
}
// 删除数组当中的相同元素
+ (NSArray*)kj_delArrayEquelObj:(NSArray*)array{
    NSMutableArray *listAry = [[NSMutableArray alloc]init];
    for (NSString *str in array){
        if (![listAry containsObject:str]){
            [listAry addObject:str];
        }
    }
    //    NSLog(@"%@",listAry);
    return listAry;
}

// 对比两个数组删除相同元素并合并
+ (NSArray*)kj_mergeArrayDelEqualObj:(NSArray*)arr1 OtherArray:(NSArray*)arr2{
    // 谓词（NSPredicate）使用
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",arr1];
    NSArray *filter = [arr2 filteredArrayUsingPredicate:filterPredicate];
    //    NSLog(@"%@",filter);
    NSMutableArray *newArray = [NSMutableArray array];
    [newArray addObjectsFromArray:arr1];
    [newArray addObjectsFromArray:filter];
    return newArray;
}
// 检测字符串中是否有特殊字符
+ (BOOL)checkSpecialCharacter:(NSString *)string{
    NSString *regex = @".*[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？].*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

// 将视图旋转
+ (UIView*)makeRotation:(UIView *)view Degrees:(CGFloat)degrees{
    CGFloat k = 180/degrees;
    view.transform = CGAffineTransformMakeRotation(M_PI/k);
    return view;
}

// 判断当前页面是push方式进入还是present方式进入
+ (int)kj_judgeCurrentVCIsPushOrPrsent:(UIViewController*)vc{
    NSArray *viewcontrollers = vc.navigationController.viewControllers;
    if (viewcontrollers.count>1){
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==vc){
            //push方式
            return 1;
        }
    }
    return 0;//present方式
}

// 跳转到设置中心
+ (void)pushToIphoneSetCenter{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    UIApplication *application = [UIApplication sharedApplication];
    if ([application canOpenURL:url]){
        //如果这个要打开的URL有效，并且在应用中配置它布尔值为YES时才可以打开，否则打不开
        //        NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @YES};
        [application openURL:url options:@{} completionHandler:^(BOOL success){
            }];
    }
}

/**
 *  复制到剪切板
 */
+ (void)generalPasteboard:(NSString *)location{
    [UIPasteboard generalPasteboard].string = location;
}

// NSClassFromString来对不确定的类进行初始化
+ (id)kj_initNotSureClassWithName:(NSString*)class_name{
    /**
     *  NSClassFromString是一个很有用的东西,用此函数进行动态加载尝试,如果返回nil, 则不能加载此类的实例
     */
    id myObj = [[NSClassFromString(class_name)alloc] init];
    return myObj;
}

//字符串转图片
+ (UIImage *)Base64StrToUIImage:(NSString *)str{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

// jpg,png图片转字符串
+ (NSString *)kj_imageToBase64Str:(UIImage *)image{
    NSData *data;
    if (UIImagePNGRepresentation(image)== nil){
        data = UIImageJPEGRepresentation(image, 1.0f);
    }
    else {
        data = UIImagePNGRepresentation(image);
    }
    
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

// 判断图片格式类型
+ (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c){
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12){
                return nil;
            }
                NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]){
                return @"webp";
            }
            return @"未判断出来";
    }
    return @"未判断出来";
}

+ (void)makeCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor layer:(CALayer *)layer borderWidth:(CGFloat)borderWidth{
    layer.cornerRadius = radius;
    layer.masksToBounds = YES;
    layer.borderColor = borderColor.CGColor;
    layer.borderWidth = borderWidth;
}

+ (void)directPhoneCallWithPhoneNum:(NSString *)phoneNum {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel:" stringByAppendingString:phoneNum]]options:@{} completionHandler:nil];
}

+ (void)phoneCallWithPhoneNum:(NSString *)phoneNum contentView:(UIView *)view {
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[@"tel:" stringByAppendingString:phoneNum]]]];
    [view addSubview:callWebview];
}

+ (void)jumpToAppReviewPageWithAppId:(NSString *)appId {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=" stringByAppendingString:appId]]options:@{} completionHandler:nil];
}

+ (void)sendEmailToAddress:(NSString *)address {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"mailto://" stringByAppendingString:address]]options:@{} completionHandler:nil];
}

+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

// 获取手机UUID
+ (NSString*)getDeviceID{
   return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (UIImage *)launchImage {
    UIImage               *lauchImage      = nil;
    NSString              *viewOrientation = nil;
    CGSize                 viewSize        = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation     = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
        viewOrientation = @"Landscape";
    } else {
        viewOrientation = @"Portrait";
    }
    
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary){
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize)&& [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]){
            lauchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    
    return lauchImage;
}

// 根据颜色得到一张尺寸为Rect的图片
+ (UIImage*)getImageFromColor:(UIColor*)color Rect:(CGRect)rect{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 播放图片
UIImageView *needleAnimation = nil; //记录上一帧动画素材
+ (void)startImages:(UIImageView*)imageView ImageName:(NSString*)name Num:(int)num Time:(CGFloat)time{
  
    //创建一个数组，数组中按顺序添加要播放的图片（图片为静态的图片）
    NSMutableArray *imgArray = @[].mutableCopy;
    for (int i=1; i<=num; i++){
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d",name,i]];
        [imgArray addObject:image];
    }
    //把存有UIImage的数组赋给动画图片数组
    imageView.animationImages = imgArray;
    //设置执行一次完整动画的时长
    imageView.animationDuration =time;
    //动画重复次数 （0为重复播放）
    imageView.animationRepeatCount = 10;
    //开始播放动画
    [imageView startAnimating];
    needleAnimation=imageView;
}

// 停止播放
+ (void)endImages:(UIImageView*)imageView{
    [imageView stopAnimating];
    imageView.animationImages = nil;
}
// 停止上一个动画播放
+ (void)endImages{
    if (needleAnimation.animationImages){
        [needleAnimation stopAnimating];
        needleAnimation.animationImages = nil;
    }
}
// 获取上一个动画试图
+ (UIImageView*)getEndImages{
    return needleAnimation;
}
id controller;
+ (id)storageid:(id)str{
    if (str){
        controller =str;
    }
    return controller;
}


// 使用了贝塞尔曲线"切割"个这个图片, 给UIImageView 添加了的圆角
+ (UIImageView*)bezierPathDrawCircleImageView:(UIImageView*)imageView Image:(UIImage*)image Diameter:(CGFloat)diameter{
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:diameter] addClip];
    [image drawInRect:imageView.bounds];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageView;
}

+ (NSInteger)searchData:(NSArray *)source target:(id)target{
    //Where is "Beth"?
    unsigned index = (unsigned)CFArrayBSearchValues((CFArrayRef)source, CFRangeMake(0, CFArrayGetCount((CFArrayRef)source)), (CFStringRef)target, (CFComparatorFunction)CFStringCompare, NULL);
    if (index < [source count] && [target isEqualToString:source[index]]){
        return index;
    } else {
        return -1;
    }
}

/** 二分查找
 当数据量很大适宜采用该方法。
 采用二分法查找时，数据需是排好序的。
 基本思想：假设数据是按升序排序的，对于给定值x，从序列的中间位置开始比较，如果当前位置值等于x，则查找成功；若x小于当前位置值，则在数列的前半段 中查找；若x大于当前位置值则在数列的后半段中继续查找，直到找到为止。
 */
+ (NSInteger)binarySearchTarget:(NSInteger)target inArray:(NSArray *)arr{
    if (arr.count < 1){
        //数组无元素,返回-1;
        return -1;
    }
    // 定义三个变量 第一个值下标、中间值下标、最后一个值下标
    NSInteger start = 0;
    NSInteger end = arr.count - 1;
    NSInteger mind = 0;
    // 进行循环 // 数组中第一个对象和最后一个对象之前还有其他对象则进行循环
    while (start < end - 1){
        //会有一些朋友看到有些人是( start + end )/ 2这样写的,但是这样写有一点不好,就是start+end会出现整数溢出的情况,如果存在溢出,你再除以2也是没有用的,所以不能这么写
        mind = start + (end - start)/ 2;
        // 如果中间值大于目标值
        if ([arr[mind] integerValue]> target){
            end = mind; // 中间值做为最后一个值，在前半段再进行相同的搜索
        }else{
            start = mind;
        }
    }
    // 如果第一个值和目标值相等则获取第一个值的下标
    if ([arr[start] integerValue] == target){
        return start;
    }
    // 如果最后一个值和目标值想等则获取最后一个下标
    if ([arr[end] integerValue] == target){
        return end;
    }
    return -1;
}



/** 冒泡排序
 1. 首先将所有待排序的数字放入工作列表中。
 2. 从列表的第一个数字到倒数第二个数字，逐个检查：若某一位上的数字大于他的下一位，则将它与它的下一位交换。
 3. 重复2号步骤(倒数的数字加1。例如：第一次到倒数第二个数字，第二次到倒数第三个数字，依此类推...)，直至再也不能交换。
 */
+ (NSArray *)BubbleSortOC:(NSArray *)array{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    id temp;
    int i, j;
    NSInteger count = [arr count];
    for (i=0; i < count - 1; ++i){
        for (j=0; j < count - i - 1; ++j){
            if (arr[j] > arr[j+1]){    // 升序排列
                temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
    return arr;
}

/** 插入排序
 1. 从第一个元素开始，认为该元素已经是排好序的。
 2. 取下一个元素，在已经排好序的元素序列中从后向前扫描。
 3. 如果已经排好序的序列中元素大于新元素，则将该元素往右移动一个位置。
 4. 重复步骤3，直到已排好序的元素小于或等于新元素。
 5. 在当前位置插入新元素。
 6. 重复步骤2。
 */
+ (NSArray *)InsertSortOC:(NSArray *)array{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    id temp;
    int i, j;
    NSInteger count = [arr count];
    for (i=1; i < count; ++i){
        temp = arr[i];
        for (j=i; j > 0 && temp < arr[j-1]; --j){
            arr[j] = arr[j-1];
        }
        arr[j] = temp; // j是循环结束后的值
    }
    return arr;
}

/** 选择排序
 1. 设数组内存放了n个待排数字，数组下标从1开始，到n结束。
 2. i=1
 3. 从数组的第i个元素开始到第n个元素，寻找最小的元素。（具体过程为:先设arr[i]为最小，逐一比较，若遇到比之小的则交换）
 4. 将上一步找到的最小元素和第i位元素交换。
 5. 如果i=n－1算法结束，否则回到第3步
 */
+ (NSArray *)SelectionSortOC:(NSArray *)array{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    id temp;
    int min, i, j;
    NSInteger count = [arr count];
    for (i=0; i < count; ++i){
        min = i;
        for (j = i+1; j < count; ++j){
            if (arr[min] > arr[j]){
                min = j;
            }
        }
        if (min != i){
            temp = arr[min];
            arr[min] = arr[i];
            arr[i] = temp;
        }
    }
    return arr;
}

// 求最大公约数
+ (int)maxCommonDivisorNum:(int)a Num2:(int)b{
//    // 1.直接遍历法
//    int max = 0;
//    for (int i = 1; i <=b; i++){
//        if (a % i == 0 && b % i == 0){
//            max = i;
//        }
//    }
//    return max;
    
    if (a<b){ // 交换位置
        a = a + b;
        b = a - b;
        a = a - b;
    }
    
    // 2.辗转相除法
    int tmp;
    while(a % b > 0){
        tmp = a % b;
        a = b;
        b = tmp;
    }
    return b;
}

// 判断质数
+ (BOOL)isPrimeFromNum:(int)num{
    for(int i = 2; i <= sqrt(num); i++){
        if(num % i == 0){
            return NO;
        }
    }
    return YES;
}

// MD5加密
+ (NSString *)md5To32bit:(NSString *)str{
    return [self md5:[NSString stringWithFormat:@"%@%@", Tool_EncryptionKey, str]];
}

+ (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    return result;
}

@end






