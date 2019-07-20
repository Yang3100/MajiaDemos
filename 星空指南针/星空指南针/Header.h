//
//  Header.h
//  星空指南针
//
//  Created by 杨科军 on 2018/10/21.
//  Copyright © 2018 杨科军. All rights reserved.
//

#ifndef Header_h
#define Header_h
/**
 * 完美解决Xcode NSLog打印不全的宏 亲测目前支持到8.2bate版
 */
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#define _weakself __weak typeof(self) weakself = self
#pragma mark ********** 快捷获取当前进程的代理对象指针 ************/
#define kAppDelegate  ((AppDelegate *)[UIApplication sharedApplication].delegate)

#pragma mark *******    屏幕的宽高   *********/
#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)
#define KStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
// 等比例缩放系数
#define KEY_WINDOW    ([UIApplication sharedApplication].keyWindow)
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_SCALE  ((SCREEN_WIDTH > 414) ? (SCREEN_HEIGHT/375.0) : (SCREEN_WIDTH/375.0))
#define Handle(x)        ((x)*SCREEN_SCALE)
#define Handle_width(w)  ((w)*SCREEN_SCALE)
#define Handle_height(h) ((h)*SCREEN_SCALE)
#define KJSIZEX(x) ((SCREEN_WIDTH/750)*(x))
#define KJSIZEY(y) ((SCREEN_HEIGHT/1334)*(y))
#define SCREEN_MAX_LENGTH   (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH   (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

/**
 iPhoneX适配
 */
#define iPhoneX ([UIScreen instanceMethodForSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(1125,2436),[[UIScreen mainScreen] currentMode].size):NO)

#define kTABBAR_HEIGHT (iPhoneX?(49.f+34.f):49.f)

/**
 Return the statusBar height.
 */
#define kSTATUSBAR_HEIGHT (iPhoneX?44.0f:20.f)

#define LiveRemandViewY   (iPhoneX?44.0f:0.f)

/**
 Return the navigationBar height.
 */
#define kNAVIGATION_HEIGHT (44.f)

/**
 Return the (navigationBar + statusBar) height.
 */
#define kSTATUSBAR_NAVIGATION_HEIGHT (iPhoneX?88.0f:64.f)

/**
 Return 没有tabar 距 底边高度
 */
#define BOTTOM_SPACE_HEIGHT (iPhoneX?34.0f:0.0f)

// 通用控件左右间隔
#define kSpaceToLeftOrRight Handle(10)

// 底部条高度
#define kBottomViewHeight 48

// 导航条高度
#define  kNavigationHeight 64

#define ChatToolsHeight  50+BOTTOM_SPACE_HEIGHT         // 聊天工具框高度
#define EmojiKeyboard_Height 200+BOTTOM_SPACE_HEIGHT    // 表情键盘的高度
#define LiveChatToolsHeight 49          // 直播间聊天工具栏高度
#define Live_EmojiKeyboard_Height  200  // 直播间表情键盘高度

#define  DeviceIsIPhoneX   [[HNTools deviceVersion] isEqualToString:@"iPhone X"]?1:0

#pragma mark *******    语言相关   *********/
#define SetLocationLanauage     @"setLocationLanauage"  //  设置语言
// 判断系统语言
#define CURR_LANG ([[NSLocale preferredLanguages] objectAtIndex:0])
#define LanguageIsEnglish ([CURR_LANG isEqualToString:@"en-US"] || [CURR_LANG isEqualToString:@"en-CA"] || [CURR_LANG isEqualToString:@"en-GB"] || [CURR_LANG isEqualToString:@"en-CN"] || [CURR_LANG isEqualToString:@"en"])   // 是否为英文
#define En                @"en"     // 英文请求头
#define Zh                @"zh-CN"  // 中文请求头

#pragma mark *******    国际化语言相关   *********/
#define Man             NSLocalizedString(@"男", nil)   // 男
#define Woman           NSLocalizedString(@"女", nil) // nv
#define Choose_camera   NSLocalizedString(@"立即拍照", nil)  // 立即拍照
#define Choose_photo    NSLocalizedString(@"选择照片", nil)  // 选择照片
#define Choose_cancel   NSLocalizedString(@"取消", nil)  // 取消
#define Choose_sure     NSLocalizedString(@"确认", nil)  // 确定
#define UPLOAD_SAVE     NSLocalizedString(@"保存", nil) // 保存
#define SAVE_SCUESS     NSLocalizedString(@"保存成功", nil) // 保存成功
#define SAVE_FAILED     NSLocalizedString(@"保存失败",nil) // 保存失败
#define UPLOAD_SCUESS   NSLocalizedString(@"上传成功",nil) // 上传成功
#define UPLOAD_FAILED   NSLocalizedString(@"上传失败",nil) // 上传失败


#pragma mark *******    颜色   *********/
#define UIColorFromHEXA(hex,a) [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]
#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define UIColorHexFromRGB(hex) UIColorFromHEXA(hex,1.0)

#define MainColor             UIColorFromHEXA(0x000000,1.0)  // app 主色调
#define BtnUnEnableBgColor    UIColorFromHEXA(0xbbbbbb,1.0)  // 按钮不可点击状态
#define BtnBgColor            UIColorFromHEXA(0xFFD308,1.0)  // 按钮可点击状态
#define DefaultTitleColor     UIColorFromHEXA(0x343434,1.0)  // 字体颜色
#define DefaultBackgroudColor     UIColorFromHEXA(0xEEEEEE,1.0)  // 视图里面的背景颜色
#define DefaultLineColor      UIColorFromHEXA(0x000000,1.0)  // 边框线的颜色
#define KJTableFillColor [UIColor groupTableViewBackgroundColor]  // 填充颜色,获取的是父视图Table背景颜色

#pragma mark *******    系统默认字体设置和自选字体设置   *********/
#define SystemFontSize(fontsize) [UIFont systemFontOfSize:(fontsize)]
#define SystemBoldFontSize(fontsize) [UIFont boldSystemFontOfSize:(fontsize)]
#define CustomFontSize(fontname,fontsize) [UIFont fontWithName:fontname size:fontsize]


#pragma mark *******    需要存入UserDefaults相关   *********
#define UserDefault [NSUserDefaults standardUserDefaults]

#define kUserID      [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]
#define kTOKEN       [[NSUserDefaults standardUserDefaults]objectForKey:@"token"]
#define KJTOKENEXPIRES  [[NSUserDefaults standardUserDefaults]objectForKey:@"token_expires"]
#define KJTOKENKEY   [[NSUserDefaults standardUserDefaults]objectForKey:@"token_key"]
#define kUDID        [[NSUserDefaults standardUserDefaults]objectForKey:@"UDID"]  // 手机uuid
#define kAPPVERSION  [[NSUserDefaults standardUserDefaults]objectForKey:@"appVersion"]  // app版本

#pragma mark *******    图片资源相关   *********
#define GetImage(imageName)    [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

#define  DefaultHeaderImage    GetImage(@"me_no_header")     // 头像占位图
#define  KJMeNoCoverImage      GetImage(@"me_no_cover")      // 我的封面占位图
#define  KJMeNoDrawRecordImage      GetImage(@"me_no_cover")      // 我的抽奖记录头像占位图
#define  DefaultChatBGImage    GetImage(@"LTBG")             // 默认聊天背景图

#pragma mark ********** 工程相关 ************/
/** 获取APP名称 */
#define APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
/** 程序版本号 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** 获取APP build版本 */
#define APP_BUILD ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

#define kAppName  @"iPace"
#define kIDName   @"星云号"
#define kAppIcon  GetImage(@"yy")


#endif /* Header_h */
