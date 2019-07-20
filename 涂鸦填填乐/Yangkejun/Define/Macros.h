//
//  Macros.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

// 输出日志 (格式: [时间] [哪个方法] [哪行] [输出内容])
#ifdef DEBUG
#define NSLog(format, ...)printf("\n[%s] %s [第%d行] 🤨🤨 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

// 日记输出宏
#ifdef DEBUG // 调试状态, 打开LOG功能
#define KJLog(...)NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define KJLog(...)
#endif

/// 适配iPhone X + iOS 11
#define  KJAdjustsScrollViewInsets_Never(__scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([__scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]){\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = __scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)

// 是否为空对象
#define KJObjectIsNil(__object)   ((nil == __object) || [__object isKindOfClass:[NSNull class]])

// 字符串为空
#define KJStringIsEmpty(__string) ((__string.length == 0) || KJObjectIsNil(__string))

// 字符串不为空
#define KJStringIsNotEmpty(__string) (!KJStringIsEmpty(__string))

// 数组为空
#define KJArrayIsEmpty(__array)   ((KJObjectIsNil(__array)) || (__array.count==0))

#define _weakself __weak typeof(self)weakself = self
#pragma mark ********** 快捷获取当前进程的代理对象指针 ************/
#define kAppDelegate  ((AppDelegate *)[UIApplication sharedApplication].delegate)

// IOS版本
#define KJIOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]

/// 机型相关
#define KJ_IS_IPAD   (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
#define KJ_IS_IPHONE (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
#define KJ_IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define is_iPhone ((UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)?YES:NO)

#pragma mark *******    iPhoneX系列   *********/
// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

// tabBar height
#define kTABBAR_HEIGHT (iPhoneX?(49.f+34.f):49.f)

// statusBar height.
#define kSTATUSBAR_HEIGHT (iPhoneX?44.0f:20.f)

// navigationBar height.
#define kNAVIGATION_HEIGHT (44.f)

// (navigationBar + statusBar) height.
#define kSTATUSBAR_NAVIGATION_HEIGHT (iPhoneX?88.0f:64.f)

// 没有tabar 距 底边高度
#define kBOTTOM_SPACE_HEIGHT (iPhoneX?34.0f:0.0f)

#pragma mark *******    屏幕的宽高   *********/
// 屏幕总尺寸
#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height
#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)
#define Handle_width(w)  ((w)*SCREEN_SCALE)
#define Handle_height(h) ((h)*SCREEN_SCALE)
// 等比例缩放系数
#define SCREEN_SCALE  ((SCREEN_WIDTH > 414)?(SCREEN_HEIGHT/375.0): (SCREEN_WIDTH/375.0))
#define Handle(x)    ((x)*SCREEN_SCALE)

#define Cell_Height SCREEN_HEIGHT/14
#define Cell_Space  Cell_Height/5  //(is_iPhone?(Cell_Height/5):(Cell_Height/5))

// 通用控件左右间隔
#define kSpaceToLeftOrRight          Handle(10)
#define KJTopicVerticalSpace         kSpaceToLeftOrRight
#define KJCommentContentLineSpacing  kSpaceToLeftOrRight
#define KJTopicHorizontalSpace       kSpaceToLeftOrRight
// 二级评价
#define KJCommentHorizontalSpace     Handle(11.0f)
#define KJCommentVerticalSpace       Handle(7.0f)
#define KJTopicAvatarWH              Handle(30.0f) // 话题头像宽高
#define KJTopicMoreButtonW           24.0f  // 话题更多按钮宽
#define KJGlobalBottomLineHeight     0.55f  // 线高

//#pragma mark *******    切换主题相关   *********/
//#define ThemeColorString(k)  [[KJSkinThemeManager shareSkinThemeManager] skinColorStringWithKey:k]
//#define ThemeImageString(k)  [[KJSkinThemeManager shareSkinThemeManager] skinImageNameWithKey:k]

#pragma mark *******    颜色   *********/
#define UIColorFromHEXA(hex,a)    [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]
#define UIColorFromRGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]  // rgb颜色+透明度
#define UIColorHexFromRGB(hex)    UIColorFromHEXA(hex,1.0)


#define MainColor(a)          UIColorFromHEXA(0x5AC1A6,a)   // app 主色调
#define BtnUnEnableBgColor    UIColorFromHEXA(0xbbbbbb,1.0) // 按钮不可点击状态
#define BtnBgColor            UIColorFromHEXA(0xFFD308,1.0) // 按钮可点击状态
#define DefaultTitleColor     UIColorFromHEXA(0x343434,1.0) // 字体颜色
#define DefaultBackgroudColor UIColorFromHEXA(0xf9f6f6,1.0) // 视图里面的背景颜色
#define DefaultLineColor      UIColorFromHEXA(0x000000,0.5) // 边框线的颜色
// 填充颜色,获取的是父视图Table背景颜色
#define KJTableFillColor      [UIColor groupTableViewBackgroundColor]


#pragma mark *******    图片资源相关   *********
#define GetImage(imageName)  [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
#define DefaultHeaderImage   GetImage(@"me_no_header")    // 头像占位图
#define DefaultCoverImage    GetImage(@"me_no_cover")     // 封面占位图

#pragma mark *******    系统默认字体设置和自选字体设置   *********/
#define SystemFontSize(fontsize)[UIFont systemFontOfSize:(fontsize)]
#define SystemBoldFontSize(fontsize)[UIFont boldSystemFontOfSize:(fontsize)]
#define CustomFontSize(fontname,fontsize)[UIFont fontWithName:fontname size:fontsize]

#pragma mark ********** 工程相关 ************/
/** 获取APP名称 */
#define APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
/** 程序版本号 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** 获取APP build版本 */
#define APP_BUILD ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

#define kAppName  [KJTools appName]
#define kIDName   @"星云号"
#define kAppIcon  GetImage(@"LOGOstore_1024pt")
#define kAppID    @"1440454006"

#pragma mark *******    语言相关   *********/
#define SetLocationLanauage     @"setLocationLanauage"  //  设置语言
// 判断系统语言
#define CURR_LANG ([[NSLocale preferredLanguages] objectAtIndex:0])
#define LanguageIsEnglish ([CURR_LANG isEqualToString:@"en-US"] || [CURR_LANG isEqualToString:@"en-CA"] || [CURR_LANG isEqualToString:@"en-GB"] || [CURR_LANG isEqualToString:@"en-CN"] || [CURR_LANG isEqualToString:@"en"])   // 是否为英文
#define En                @"en"     // 英文请求头
#define Zh                @"zh-CN"  // 中文请求头

#pragma mark *******    需要存入UserDefaults相关   *********
#define UserDefault     [NSUserDefaults standardUserDefaults]

#pragma mark ********** 通知消息的名字相关 ************/
#define NotificationCenter(name,dict)    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:dict]
#define NotificationModel(name)     [name modelWithJSON:info.userInfo[@"data"]]
#define Register_Tag_Push_Home      @"Register_Tag_Push_Home"          // 从注册位置的选择标签之后跳转到首页
#define Me_changed_info_data        @"Me_changed_info_data"            // 更改了资料
#define Me_changed_info_tag_data    @"Me_changed_info_tag_data"        // 更改了标签资料
#define Check_login_status          @"Check_login_status"              // 检查登陆状态
#define Login_Register_sucess       @"Login_Register_sucess"           // 登陆或者注册成功,  为了开启长连接


#endif /* Macros_h */
