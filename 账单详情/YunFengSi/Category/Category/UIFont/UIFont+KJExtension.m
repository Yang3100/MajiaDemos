//
//  UIFont+KJExtension.m
//  KJDevLibExample
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 Mike_He. All rights reserved.
//

/**
 * 
 (
 "PingFangSC-Ultralight",
 "PingFangSC-Regular",
 "PingFangSC-Semibold",
 "PingFangSC-Thin",
 "PingFangSC-Light",
 "PingFangSC-Medium"
 )
 */
/**
 *  极细体
 */
static NSString *const KJPingFangSC_Ultralight = @"PingFangSC-Ultralight";
/**
 *  常规体
 */
static NSString *const KJPingFangSC_Regular = @"PingFangSC-Regular";
/**
 *  中粗体
 */
static NSString *const KJPingFangSC_Semibold = @"PingFangSC-Semibold";
/**
 *  纤细体
 */
static NSString *const KJPingFangSC_Thin = @"PingFangSC-Thin";
/**
 *  细体
 */
static NSString *const KJPingFangSC_Light = @"PingFangSC-Light";
/**
 *  中黑体
 */
static NSString *const KJPingFangSC_Medium = @"PingFangSC-Medium";


#import "UIFont+KJExtension.h"

@implementation UIFont (KJExtension)
/**
 *  苹方极细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype)kj_fontForPingFangSC_UltralightFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:KJPingFangSC_Ultralight size:fontSize];
}

/**
 *  苹方常规体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype)kj_fontForPingFangSC_RegularFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:KJPingFangSC_Regular size:fontSize];
}

/**
 *  苹方中粗体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype)kj_fontForPingFangSC_SemiboldFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:KJPingFangSC_Semibold size:fontSize];
}

/**
 *  苹方纤细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype)kj_fontForPingFangSC_ThinFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:KJPingFangSC_Thin size:fontSize];
}

/**
 *  苹方细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype)kj_fontForPingFangSC_LightFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:KJPingFangSC_Light size:fontSize];
}

/**
 *  苹方中黑体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype)kj_fontForPingFangSC_MediumFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:KJPingFangSC_Medium size:fontSize];
}


@end
