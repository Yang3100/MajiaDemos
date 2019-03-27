//
//  KJTencentUploadTools.h
//  MoLiao
//
//  Created by 杨科军 on 2018/8/8.
//  Copyright © 2018年 杨科军. All rights reserved.
//  上传图片到腾讯云

#import <Foundation/Foundation.h>

@interface KJTencentUploadTools : NSObject

// 上传图片
+ (void)uploadFileWithImage:(UIImage *)image uploadSuccess:(void(^)(NSString *resp))success uploadFailed:(void(^)(NSDictionary *dict))failed;

// 上传录音
+ (void)uploadFileRecordFileName:(NSString *)file_name Path:(NSString*)path uploadSuccess:(void(^)(NSString *resp))success uploadFailed:(void(^)(NSDictionary *dict))failed;

@end
