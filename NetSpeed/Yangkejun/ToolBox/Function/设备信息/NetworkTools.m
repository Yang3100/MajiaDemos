//
//  NetworkTools.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/10.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "NetworkTools.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/stat.h> //真机必须导入这个头文件
#import <mach/mach.h>
#include <sys/mount.h>
#import <sys/utsname.h>
//#import <sys/sysctl.h>
//#include <sys/param.h>
//#include <ifaddrs.h>
//#include <sys/socket.h>

/*
 * Top-level identifiers
 */
#define CTL_NET     4       /* network, see socket.h */
#define AF_ROUTE    17      /* Internal Routing Protocol */
#define AF_LINK     18      /* Link layer interface */
#define NET_RT_IFLIST2      6   /* interface list with addresses */
#define NET_RT_IFLIST       3   /* survey interface list */

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

//获取屏幕宽度
#define screenWide [UIScreen mainScreen].bounds.size.width
//获取屏幕高度
#define screenHeight [UIScreen mainScreen].bounds.size.height

@implementation NetworkTools
+ (NSDictionary *)getDinfo {
    NSString *mac = [self macaddress];
    NSString *udid = [self getUUID];
    NSString *ip = [self ipAddressIsV4:YES];
    NSString *device_info =  [self getDeviceInfo];
    NSString *prison_break = [self jailbroken] ? @"已越狱":@"未越狱";
    //[NSString stringWithFormat:@"%i",[self jailbroken]];
    NSString *rw = [NSString stringWithFormat:@"%.f",screenWide];
    NSString *rh = [NSString stringWithFormat:@"%.f",screenHeight];
    NSString *mobile = [self chinaMobileModel];
    NSString *device_name = [self deviceName];
    NSString *system_version = [self getSystemVersion];
//    NSString *cv = [NSString stringWithFormat:@"%ld",[self version]];
    NSString *network_state = [self getNetWorkStates];
    NSString *battery_percent = [self currentBatteryPercent];
    NSString *signal_strength =  [NSString stringWithFormat:@"%d",[self getSignalStrength]];
    NSString *availableMemory = [NSString stringWithFormat:@"%.2fMB",[self availableMemory]];
//    NSString *totalMemorySize = [NSString stringWithFormat:@"%f",[self getTotalMemorySize]];
    NSString *availableDiskSize = [NSString stringWithFormat:@"%.2fGB",[self getAvailableDiskSize]/1024.0];
    NSDictionary *dinfo = @{
                            @"system_version":system_version,
                            @"udid":udid,
                            @"ip":ip,
                            @"device_info":device_info,
                            @"prison_break":prison_break,
                            @"rw":rw,
                            @"rh":rh,
                            @"mobile":mobile,
                            @"decice_name":device_name,
                            @"mac":mac,
                            @"network_state":network_state,
                            @"battery_percent":battery_percent,
                            @"signal_strength":signal_strength,
                            @"available_memory":availableMemory,
                            //@"total_memory":totalMemorySize,
                            @"available_disk":availableDiskSize,
                            };
    return dinfo;
}

// 设备信息 产品名称
+ (NSString *)getDeviceInfo {
    UIDevice *device = [[UIDevice alloc] init];
    NSString *name = device.name;       //获取设备所有者的名称
//    NSString *type = device.localizedModel; //获取本地化版本
//    NSString *systemName = device.systemName;   //获取当前运行的系统
//    NSString *systemVersion = device.systemVersion;//获取当前系统的版本
//    NSLog(@"-----name : %@,model : %@,type : %@,systemName :%@,systemVersion %@",name,model,type,systemName,systemVersion);
    return name;
}

// 获取设备uuid
+ (NSString*)getUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    return result;
}


// 设备mac 地址
+ (NSString *)macaddress{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    NSLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
}

// Version
+ (NSString *)getVersion {
    NSString *string = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:string];
    NSString *version = [dic objectForKey:@"CFBundleVersion"];
    return version;
    
}
///SIM卡所属的运营商（公司）
+(NSString *)serviceCompany{
    NSArray *infoArray = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    for (id info in infoArray){
        if ([info isKindOfClass:NSClassFromString(@"UIStatusBarServiceItemView")])
        {
            NSString *serviceString = [info valueForKeyPath:@"serviceString"];
            NSLog(@"公司为：%@",serviceString);
            return serviceString;
        }
    }
    return @"";
}

#pragma mark - 内部方法
+ (NSString *)currentBatteryPercent{
    NSArray *infoArray = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    for (id info in infoArray){
        if ([info isKindOfClass:NSClassFromString(@"UIStatusBarBatteryPercentItemView")]){
            NSString *percentString = [info valueForKeyPath:@"percentString"];
            return percentString;
        }
    }
    return @"";
}

//  判断当前网络连接状态
+ (NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            NSLog(@"netType:%d",netType);
            switch (netType) {
                case 0:
                                        state = @"无网络"; // 5
//                    state = @"5";
                    //无网模式
                    break;
                case 1:
                                        state = @"2G"; // 1
//                    state = @"1";
                    break;
                case 2:
                                        state = @"3G"; // 2
//                    state = @"3";
                    break;
                case 3:
                                        state = @"4G"; //3
//                    state = @"4";
                    break;
                case 5:
                                        state = @"WIFI"; //5
//                    state = @"5";
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}


+ (NSString *)getSystemVersion {
    UIDevice *device = [[UIDevice alloc] init];
    NSString *systemVersion = device.systemVersion;
    return systemVersion;
}


// ip 地址
+ (NSString *)ipAddressIsV4:(BOOL)v4{
    NSArray *searchArray = v4 ?
    @[ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self addressInfo];
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop){
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

// 是否越狱
+ (BOOL)jailbroken{
#if !TARGET_IPHONE_SIMULATOR
    
    //Apps and System check list
    BOOL isDirectory;
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Cyd", @"ia.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"bla", @"ckra1n.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Fake", @"Carrier.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Ic", @"y.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Inte", @"lliScreen.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"MxT", @"ube.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Roc", @"kApp.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"SBSet", @"ttings.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Wint", @"erBoard.a", @"pp"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/a", @"pt/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/c", @"ydia/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/mobile", @"Library/SBSettings", @"Themes/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/t", @"mp/cyd", @"ia.log"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/s", @"tash/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/b",@"in", @"s", @"shd"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/sb",@"in", @"s", @"shd"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/sftp-", @"server"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@",@"/Syste",@"tem/Lib",@"rary/Lau",@"nchDae",@"mons/com.ike",@"y.bbot.plist"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@%@",@"/Sy",@"stem/Lib",@"rary/Laun",@"chDae",@"mons/com.saur",@"ik.Cy",@"@dia.Star",@"tup.plist"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/Libr",@"ary/Mo",@"bileSubstra",@"te/MobileSubs",@"trate.dylib"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/va",@"r/c",@"ach",@"e/a",@"pt/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"ib",@"/apt/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"ib/c",@"ydia/"] isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"/va",@"r/l",@"og/s",@"yslog"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/bi",@"n/b",@"ash"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/b",@"in/",@"sh"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/et",@"c/a",@"pt/"]isDirectory:&isDirectory]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"/etc/s",@"sh/s",@"shd_config"]]
        || [defaultManager fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"/us",@"r/li",@"bexe",@"c/ssh-k",@"eysign"]]){
        return YES;
    }
    
    // SandBox Integrity Check
    int pid = fork(); //返回值：子进程返回0，父进程中返回子进程ID，出错则返回-1
    if(!pid){
        exit(0);
    }
    if(pid>=0){
        return YES;
    }
    
    //Symbolic link verification
    struct stat s;
    if(lstat("/Applications", &s) || lstat("/var/stash/Library/Ringtones", &s) || lstat("/var/stash/Library/Wallpaper", &s)
       || lstat("/var/stash/usr/include", &s) || lstat("/var/stash/usr/libexec", &s)  || lstat("/var/stash/usr/share", &s)
       || lstat("/var/stash/usr/arm-apple-darwin9", &s)){
        if(s.st_mode & S_IFLNK){
            return YES;
        }
    }
    
    //Try to write file in private
    NSError *error;
    [[NSString stringWithFormat:@"Jailbreak test string"] writeToFile:@"/private/test_jb.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if(nil==error){
        //Writed
        return YES;
    } else {
        [defaultManager removeItemAtPath:@"/private/test_jb.txt" error:nil];
    }
    
#endif
    return NO;
}


+ (NSDictionary *)addressInfo{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                char addrBuf[INET6_ADDRSTRLEN];
                if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

// 运营商
+ (NSString *)chinaMobileModel{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil) {
                return @"不识别";
//        return @"0";
    }
    
    NSString *code = [carrier mobileNetworkCode];
    if (code == nil) {
                return @"不识别";
//        return @"0";
    }
    
    if ([code isEqualToString:@"00"] || [code isEqualToString:@"02"] || [code isEqualToString:@"07"]){
                return @"移动";
//        return @"1";
    }else if ([code isEqualToString:@"01"] || [code isEqualToString:@"06"]){
                return @"联通";
//        return @"2";
    }else if ([code isEqualToString:@"03"] || [code isEqualToString:@"05"]){
                return @"电信";
//        return @"3";
    }else if ([code isEqualToString:@"20"]){
        return @"铁通";
    }
    return @"不识别";
}

+ (NSString *)deviceModel{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *deviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);
    return deviceModel;
}


// 机型信息
+ (NSString *)deviceName{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    else if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    else if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    else if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    else if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    else if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    else if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    else if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    else if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    else if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    else if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    else if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    else if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    else if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    else if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    else if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    else if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    else if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    else if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    else if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    else if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    else if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    else if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    else if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhoneX";
    else if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhoneX";
    else if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    else if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    else if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    else if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    else if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    else if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    else if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    else if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    else if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    else if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    else if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    else if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    else if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    else if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    else if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    else if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    else if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    else if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    else if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    else if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    else if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    else if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    else if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    else if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    else if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    else if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    else if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    else if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    else if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    else if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    else if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    else if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    else if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    else if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    else if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    else if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    else if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    else if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    else if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    else if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    else if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    else if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    else return deviceModel;
}

+ (int )getSignalStrength{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    UIView *dataNetworkItemView = nil;
    
    for (UIView * subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    int signalStrength = [[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] intValue];
    
//    NSLog(@"signal %d", signalStrength);
    return signalStrength;
}
// 获取当前设备可用内存(单位：MB）
+ (float)availableMemory{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

// 获取总内存大小
+ (float)getTotalMemorySize{
    return [NSProcessInfo processInfo].physicalMemory / 1024.0 / 1024.0;
}

// 获取当前设备可用存储(单位：MB）
+ (float)getAvailableDiskSize{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0){
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace / 1024.0 / 1024.0;
}


@end
