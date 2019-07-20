//
//  UIFont+KJExtension.h
//  KJDevLibExample
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 Mike_He. All rights reserved.
//
/**
 *  Mike_He 但是苹方字体 iOS9.0+出现  需要做适配
 *  这个分类主要用来 字体...
 (
 "PingFangSC-Ultralight",
 "PingFangSC-Regular",
 "PingFangSC-Semibold",
 "PingFangSC-Thin",
 "PingFangSC-Light",
 "PingFangSC-Medium"
 )
 */

// IOS版本
#define KJ_IOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue])


/// 设置系统的字体大小（YES：粗体 NO：常规）
#define KJFont(__size__,__bold__)((__bold__)?([UIFont boldSystemFontOfSize:__size__]):([UIFont systemFontOfSize:__size__]))

/// 极细体
#define KJUltralightFont(__size__)((KJ_IOSVersion<9.0)?KJFont(__size__ , YES):[UIFont kj_fontForPingFangSC_UltralightFontOfSize:__size__])

/// 纤细体
#define KJThinFont(__size__)      ((KJ_IOSVersion<9.0)?KJFont(__size__ , YES):[UIFont kj_fontForPingFangSC_ThinFontOfSize:__size__])

/// 细体
#define KJLightFont(__size__)     ((KJ_IOSVersion<9.0)?KJFont(__size__ , YES):[UIFont kj_fontForPingFangSC_LightFontOfSize:__size__])

// 中等
#define KJMediumFont(__size__)    ((KJ_IOSVersion<9.0)?KJFont(__size__ , YES):[UIFont kj_fontForPingFangSC_MediumFontOfSize:__size__])

// 常规
#define KJRegularFont(__size__)   ((KJ_IOSVersion<9.0)?KJFont(__size__ , NO):[UIFont kj_fontForPingFangSC_RegularFontOfSize:__size__])

/** 中粗体 */
#define KJSemiboldFont(__size__)  ((KJ_IOSVersion<9.0)?KJFont(__size__ , YES):[UIFont kj_fontForPingFangSC_SemiboldFontOfSize:__size__])



/// 苹方常规字体 10
#define KJRegularFont_10 KJRegularFont(10.0f)
/// 苹方常规字体 11
#define KJRegularFont_11 KJRegularFont(11.0f)
/// 苹方常规字体 12
#define KJRegularFont_12 KJRegularFont(12.0f)
/// 苹方常规字体 13
#define KJRegularFont_13 KJRegularFont(13.0f)
/** 苹方常规字体 14 */
#define KJRegularFont_14 KJRegularFont(14.0f)
/// 苹方常规字体 15
#define KJRegularFont_15 KJRegularFont(15.0f)
/// 苹方常规字体 16
#define KJRegularFont_16 KJRegularFont(16.0f)
/// 苹方常规字体 17
#define KJRegularFont_17 KJRegularFont(17.0f)
/// 苹方常规字体 18
#define KJRegularFont_18 KJRegularFont(18.0f)
/// 苹方常规字体 19
#define KJRegularFont_19 KJRegularFont(19.0f)
/// 苹方常规字体 20
#define KJRegularFont_20 KJRegularFont(20.0f)


#import <UIKit/UIKit.h>

@interface UIFont (KJExtension)

/**
 *  苹方极细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype)kj_fontForPingFangSC_UltralightFontOfSize:(CGFloat)fontSize;

/**
 *  苹方常规体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype)kj_fontForPingFangSC_RegularFontOfSize:(CGFloat)fontSize;

/**
 *  苹方中粗体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype)kj_fontForPingFangSC_SemiboldFontOfSize:(CGFloat)fontSize;

/**
 *  苹方纤细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype)kj_fontForPingFangSC_ThinFontOfSize:(CGFloat)fontSize;

/**
 *  苹方细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype)kj_fontForPingFangSC_LightFontOfSize:(CGFloat)fontSize;

/**
 *  苹方中黑体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype)kj_fontForPingFangSC_MediumFontOfSize:(CGFloat)fontSize;




@end
