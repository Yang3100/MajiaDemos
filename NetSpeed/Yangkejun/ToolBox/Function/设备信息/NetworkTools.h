//
//  NetworkTools.h
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/10.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkTools : NSObject
// 获取设备uuid
+ (NSString*)getUUID;
// 设备mac 地址
+ (NSString*)macaddress;
// Version
+ (NSString*)getVersion;

+ (NSDictionary*)getDinfo;

@end

