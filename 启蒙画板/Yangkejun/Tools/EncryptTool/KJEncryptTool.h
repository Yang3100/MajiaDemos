//
//  KJEncryptTool.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/19.
//  Copyright © 2018年 杨科军. All rights reserved.
//  加密工具

#import <Foundation/Foundation.h>

@interface KJEncryptTool : NSObject

// 6位随机数+10位时间戳（16位数）
+ (NSString*)get16Num;

#pragma mark - RSA非对称加密解密
/** 加密
 *  @param string 需要加密的string
 *  @return 加密后的字符串
 */
+ (NSString *)RSAEncrypt:(NSString *)string;
/** 解密
 *  @param string 加密的字符串
 *  @return 解密后的内容
 */
+ (NSString *)RSADecrypt:(NSString *)string;


#pragma mark - DES加密解密
/** 加密
 *  @param  plainText 加密的字符串
 *  @param  key 密钥
 *  @return 加密后的内容
 */
+ (NSString *)DESEncrypt:(NSString *)plainText key:(NSString *)key;
/** 解密
 *  @param cipherText 加密的字符串
 *  @return 解密后的内容
 */
+ (NSString *)DESDecrypt:(NSString*)cipherText key:(NSString*)key;


#pragma mark - AES加密解密
/** 加密
 *  @param string 需要加密的string
 *  @return 加密后的字符串
 */
+ (NSString *)AES128Encrypt:(NSString *)string;
/** 解密
 *  @param string 加密的字符串
 *  @return 解密后的内容
 */
+ (NSString *)AES128Decrypt:(NSString *)string;



#pragma mark - MD5加密
/** 加密
 *  @param string 需要加密的string
 *  @return 加密后的字符串
 */
+ (NSString *)md5To32bit:(NSString *)string;

@end

