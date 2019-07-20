//
//  KJTools.h
//  MoLiao
//
//  Created by 杨科军 on 2018/7/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//  工具类

#import <Foundation/Foundation.h>

/**
 *  TouchID 状态
 */
typedef NS_ENUM(NSUInteger, TDTouchIDState){
    TDTouchIDStateNotSupport = 0,          // 当前设备不支持TouchID
    TDTouchIDStateSuccess = 1,             // TouchID 验证成功
    TDTouchIDStateFail = 2,                // TouchID 验证失败
    TDTouchIDStateUserCancel = 3,          // TouchID 被用户手动取消
    TDTouchIDStateInputPassword = 4,       // 用户不使用TouchID,选择手动输入密码
    TDTouchIDStateSystemCancel = 5,        // TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)
    TDTouchIDStatePasswordNotSet = 6,      // TouchID 无法启动,因为用户没有设置密码
    TDTouchIDStateTouchIDNotSet = 7,       // TouchID 无法启动,因为用户没有设置TouchID
    TDTouchIDStateTouchIDNotAvailable = 8, // TouchID 无效
    TDTouchIDStateTouchIDLockout = 9,      // TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)
    TDTouchIDStateAppCancel = 10,          // 当前软件被挂起并取消了授权 (如App进入了后台等)
    TDTouchIDStateInvalidContext = 11,     // 当前软件被挂起并取消了授权 (LAContext对象无效)
    TDTouchIDStateVersionNotSupport = 12   // 系统版本不支持TouchID (必须高于iOS 8.0才能使用)
};
typedef void (^StateBlock)(TDTouchIDState state,NSError *error);

@interface KJTools : NSObject

// 请求地址的拼接
+ (NSString *)urlstrSuffix:(NSArray *)key withValue:(NSArray *)value with:(NSString *)suffix;

// 提示框
+ (void)ShowAlertWith:(NSString *)title message:(NSString *)message sureTitle:(NSString*)sureWord andCancel:(NSString*)cancelStr viewControl:(UIViewController *)control andSureBack:(void(^)(void))block andCancelBack:(void(^)(void))canBlock;

// 显示提示框
+ (void)ShowOnlyAlertWith:(NSString*)title message:(NSString*)message andSureTitle:(NSString*)sureTitle viewControl:(UIViewController*)control andSureBack:(void(^)(void))block;

#pragma mark *********************    时间相关   ***********************
// 根据多少秒转为年月日
+ (NSString *)timeIntervalBeforeNowDescription:(NSString*)time;

// 时间戳转时间
+ (NSString *)turnTimeTimestamp:(NSString *)timeStamp withType:(NSString *)type;

// 时间转时间戳
+ (NSInteger)TimestampturnTime:(NSString *)timeStamp withType:(NSString *)type;

// 将时间戳转换为多少分钟前 (按照时间规格转换)
+ (NSString *)turnTimeForTimestamp:(NSString *)timeStamp showDetail:(BOOL)showDetail;

// 将一段时间转换 eg：5分钟转化为00：05：00
+ (NSString *)changMinuteToTime:(NSString *)minute;

// 将一段时间转换为多少小时多少分钟多少秒
+ (NSString *)changMinuteToTimeHDS:(NSString *)minute;

// 比较两个时间差
+ (BOOL)comperTTwoMessage:(NSString*)lastTime andNewTime:(NSString*)newTime;

// 两个时间戳是否相隔5分钟
+ (BOOL)timeIntervalIsSpaceFiveMinutes:(NSString *)lastTime nowTime:(NSString *)nowTime;

// 根据出生日期算详细年龄
+ (NSString*)getAgeFormYear:(NSString*)year;

// 根据出生日期算星座
+ (NSString *)getAstroWithMonth:(NSString*)year;
+ (NSString *)kj_getXingzuo:(NSDate *)in_date;

#pragma mark *********************    字符串相关   ***********************
// 图片字符串
+ (NSString*)returnPictureStr:(NSString*)imgUrl andW:(NSInteger)wNum andH:(NSInteger)hNum;

// 拼接字符串,去除"-"的数据,如果都为空显示国家
+ (NSString*)kj_judgeCountry:(NSString*)country State:(NSString*)state City:(NSString*)city Region:(NSString*)region;

// 属性文字
+ (NSMutableAttributedString *)getAttributedString:(NSString *)allString withStringAttributedDic:(NSDictionary *)dic withSubString:(NSString *)subString withSubStringAttributeDic:(NSDictionary *)subDic;

+ (NSMutableAttributedString *)changeStrWittContext:(NSString *)context ChangeColorText:(NSString *)ColorStr WithColor:(id)ColorValue WithFont:(id)FontValue;

// 获取字符串大小
+ (CGRect)getStringFrame:(NSString *)str withFont:(NSInteger)fontSize withMaxSize:(CGSize)size;

// 过滤空格后返回的字符
+ (NSString*)filterSpace:(NSString*)string;

// text 宽度
+ (CGFloat)calculateTextWidthWithText:(NSString *)text andFont:(UIFont *)font;

// text 高度
+ (CGFloat)calculateTextHeightWithWidth:(CGFloat)width andText:(NSString *)text andFont:(UIFont *)font;

// text 高度,attribute
+ (CGFloat)calculateTextHeightWithWidth:(CGFloat)width andText:(NSString *)text attributes:(NSDictionary *)attribute;


#pragma mark *********************    动画相关   ***********************
// 抖动动画
+ (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur;

// 让视图旋转, isRight:顺时针, time:转一圈的时间, TransCount:旋转次数(0:表示一直转)
+ (void)viewAnimationRotate:(UIView*)view isRight:(BOOL)Right speed:(CGFloat)time TransCount:(int)num;
// 移动  Duration:移动持续时间, TransCount:重复次数(0:表示一直转)
+ (void)viewAnimationMove:(UIView*)myView MoveX:(CGFloat)x MoveY:(CGFloat)y Duration:(CGFloat)duration TransCount:(int)num;
// 缩放  Multiple:倍数 Duration:移动持续时间, TransCount:重复次数(0:表示一直转)
+ (CABasicAnimation*)viewAnimationZoom:(UIView *)view Multiple:(CGFloat)multiple Duration:(CGFloat)duration TransCount:(int)num isGroup:(BOOL)group starSize:(CGFloat)size starTime:(CGFloat)time;
// 渐隐  Alpha:隐藏系数 Duration:移动持续时间, TransCount:重复次数(0:表示一直转)
+ (void)viewAnimationOpacity:(UIView*)myView Alpha:(CGFloat)kj_a Duration:(CGFloat)duration TransCount:(int)num isFlash:(BOOL)flash;

// 同一个view实现多种动画
+ (void)viewAnimationMore:(UIView*)view Animations:(NSArray<CABasicAnimation*>*)array Duration:(CGFloat)duration TransCount:(int)num;
//创建一个播放gif的ImageView
+ (CGFloat)hj_imageViewWithGIF:(NSString*)gifStr view:(id)superView cycle:(NSInteger)cle;

#pragma mark *********************    验证信息相关   ***********************
// 利用NSPredicate(谓词)功能做筛选工作
// 验证手机号码是否有效
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

// 验证邮箱格式是否正确
+ (BOOL)isValidateEmail:(NSString *)email;

// 验证身份证是否是真实的
+ (BOOL)isValidateIDCardNumber:(NSString *)value;

// 检测输入内容是否为数字
+ (BOOL)validateNumber:(NSString*)number;

// 验证是否是数字
+ (BOOL)isNumber:(NSString *)string;

// 验证字符串中是否有特殊字符
+ (BOOL)checkSpecialCharacter:(NSString *)string;

#pragma mark *********************    沙盒相关   ***********************
// 获取沙盒地址数组
+ (NSArray *)applicationDocumentsDirectory;

// 获取沙盒地址Library的目录路径
+ (NSString *)applicationDocumentsDirectoryWithLibrary;

// 获取沙盒地址Documents的目录路径
+ (NSString *)applicationDocumentsDirectoryWithDocuments;

// 获取沙盒Preference的文件目录。
+ (NSString *)applicationPreferencePanesDirectoryWithPreference;

// 获取沙盒Caches的文件目录。
+ (NSString *)applicationPreferencePanesDirectoryWithCaches;

// 返回path路径下文件的文件大小。
+ (double)sizeWithFilePath:(NSString *)path;

// 删除path路径下的文件。
+ (void)clearCachesWithFilePath:(NSString *)path;

// 删除文件夹下所有文件
+ (void)clearSubfilesWithFilePath:(NSString *)path;

// 保存图片到沙盒
+ (void)saveImage:(UIImage *)tempImage withName:(NSString *)imageName;

// 根据图片名从获取图片沙盒路径
+ (NSString *)getImagePathWithName:(NSString *)name;

#pragma mark *********************    系统设置相关   ***********************
// 是否有麦克风权限  0:没有询问是否开启麦克风, 1:未授权，家长限制, 2:玩家未授权 3:玩家授权
+ (int)getStatusAudio;

// 跳转到设置中心
+ (void)pushToIphoneSetCenter;

// 复制到剪切板
+ (void)generalPasteboard:(NSString *)location;

// 获取手机型号
+ (NSString*)deviceVersion;

// 获取是否为ipad
+ (BOOL)isIpad;

// 启动TouchID进行验证,   desc  Touch显示的描述,block 回调状态的block
+ (void)kj_showTouchIDWithDescribe:(NSString *)desc BlockState:(StateBlock)block;
/**
 *  直接拨打电话
 *
 *  @param phoneNum 电话号码
 */
+ (void)directPhoneCallWithPhoneNum:(NSString *)phoneNum;

/**
 *  弹出对话框并询问是否拨打电话
 *
 *  @param phoneNum 电话号码
 *  @param view     contentView
 */
+ (void)phoneCallWithPhoneNum:(NSString *)phoneNum contentView:(UIView *)view;

/**
 *  跳到app的评论页
 *
 *  @param appId APP的id号
 */
+ (void)jumpToAppReviewPageWithAppId:(NSString *)appId;

/**
 *  发邮件
 *
 *  @param address 邮件地址
 */
+ (void)sendEmailToAddress:(NSString *)address;

/**
 *  app版本号
 *
 *  @return app版本号
 */
+ (NSString *)appVersion;

/**
 *  获取启动页图片
 *
 *  @return 启动页图片
 */
+ (UIImage *)launchImage;

// 获取手机UUID
+ (NSString*)getDeviceID;

// 获取当前设备可用内存(单位：MB）
+ (float)availableMemory;

// 获取总内存大小
+ (float)getTotalMemorySize;

// 获取当前设备可用存储(单位：MB）
+ (float)getAvailableDiskSize;

#pragma mark *********************    视图控制器相关   ***********************
// 设置边框
+ (void)makeCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor layer:(CALayer *)layer borderWidth:(CGFloat)borderWidth;

// 将视图旋转多少度
+ (UIView*)makeRotation:(UIView *)view Degrees:(CGFloat)degrees;

// 判断当前控制器是什么方式进入  0:prsent方式进入 1:push方式进入
+ (int)kj_judgeCurrentVCIsPushOrPrsent:(UIViewController*)vc;

// 获取当前视图所在的控制器
+ (UIViewController*)getcurrentVC:(UIView*)view;

// 获取当前视图的presentedViewController
+ (UIViewController *)currentViewController;

// dismiss回到指定视图控制器 - class为目标页面的类
+ (void)dismissViewControllerClass:(Class)class;

// pop回指定视图控制器
+ (void)popViewControllerClass:(Class)class;


#pragma mark *********************    数字相关   ***********************
// 2个数相除去最大可能数
+ (int)getMayIntege:(NSInteger)divisor dividend:(NSInteger)div;
// 替换万位一下数字
+ (NSString*)ChangeNumStr:(NSString*)number;
// 获取一个随机整数，范围在[from,to]，包括from，包括to
+ (int)getRandomNumber:(int)from to:(int)to;
// 使用NSScanner条件判断利器,得到字符串当中的数字
+ (NSArray*)getNumberInString:(NSString*)str;



#pragma mark *********************    图片Image相关   ***********************
// 根据颜色得到一张尺寸为Rect的图片
+ (UIImage*)getImageFromColor:(UIColor*)color Rect:(CGRect)rect;

// 根据图片url获取图片尺寸
+ (CGSize)getImageSizeWithURL:(NSString*)urlString;

// 图片 Kb 压缩
+ (UIImage *)zipImageWithImage:(UIImage *)image withMaxSize:(NSInteger)kBit;

// 等比例压缩图片
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

// 处理二维码模糊的问题
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

// 浏览大图, currentImageview 当前图片视图,    alpha 背景透明度
+ (void)scanBigImageWithImageView:(UIImageView *)currentImageview alpha:(CGFloat)alpha;

// 字符串转图片
+ (UIImage *)Base64StrToUIImage:(NSString *)str;

// jpg,png图片转字符串
+ (NSString *)kj_imageToBase64Str:(UIImage *)image;

// 判断图片格式类型
+ (NSString *)contentTypeForImageData:(NSData *)data;

// 播放图片
+ (void)startImages:(UIImageView*)imageView ImageName:(NSString*)name Num:(int)num Time:(CGFloat)time;

// 停止播放
+ (void)endImages:(UIImageView*)imageView;

// 停止上一个动画播放
+ (void)endImages;

// 获取上一个动画试图
+ (UIImageView*)getEndImages;

// 使用了贝塞尔曲线"切割"个这个图片, 给UIImageView 添加了的圆角
+ (UIImageView*)bezierPathDrawCircleImageView:(UIImageView*)imageView Image:(UIImage*)image Diameter:(CGFloat)diameter;


#pragma mark *********************    数组,字典,json相关   ***********************
// 删除数组当中的相同元素
+ (NSArray*)kj_delArrayEquelObj:(NSArray*)array;

// 对比两个数组删除相同元素并合并
+ (NSArray*)kj_mergeArrayDelEqualObj:(NSArray*)arr1 OtherArray:(NSArray*)arr2;

// json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)json;

// 字典转json字符串方法
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

// 读取plist和json文件数据
+ (NSArray*)getPlistOrJsonFile:(NSString*)fileName Type:(NSString*)type;


#pragma mark *********************    其他相关   ***********************
// 获取软件版本号
+ (NSString*)GetApp_Version;

// NSClassFromString来对不确定的类进行初始化
+ (id)kj_initNotSureClassWithName:(NSString*)class_name;

// 存储试图或者控制器
+ (id)storageid:(id)str;

// MD5加密
+ (NSString*)md5To32bit:(NSString *)str;


#pragma mark *********************    算法相关   ***********************
// 查找数据
+ (NSInteger)searchData:(NSArray *)source target:(id)target;

// 二分查找 - 数据需是排好序的, 未找到返回-1
+ (NSInteger)binarySearchTarget:(NSInteger)target inArray:(NSArray *)arr;

// 冒泡排序
+ (NSArray *)BubbleSortOC:(NSArray *)array;

// 插入排序
+ (NSArray *)InsertSortOC:(NSArray *)array;

// 选择排序
+ (NSArray *)SelectionSortOC:(NSArray *)array;

// 求最大公约数
+ (int)maxCommonDivisorNum:(int)a Num2:(int)b;

// 判断质数
+ (BOOL)isPrimeFromNum:(int)num;

@end
