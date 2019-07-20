//
//  KJEncryptTool.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/19.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJEncryptTool.h"
#import <CommonCrypto/CommonCrypto.h>  // 系统加密库
#import <Security/Security.h>
#import "GTMBase64.h"

static NSString *AESIV = @"AES_Pwd__AES_Pwd"; // 偏移量 16位长度的字符串

//md5秘钥 - 加密密钥
static NSString *md5_secret =  @"yangkejun-735n197nxn(N′568GGS%d~~9naei';45vhhafdjkv]32rpks;lg,];:vjo(&**&^)";

static NSString *RSAPublicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPm0kFwUYRwzr/dKsjsjL0pEPgoMOpnLVSEt9UrNEyjN98omr9wN3QkuXJNXxgWSpfIfhTnbiiwX+UtYfODDmXD2EwkFOPriEOYKA3DvZgd8EAk8TLGFWHSqYuZsWo4tty6xATcpWYmsovsejg72fCryDxPs9BL3c/TGC0rZ5JFQIDAQAB";
static NSString *RSAprivateKey = @"MIICeQIBADANBgkqhkiG9w0BAQEFAASCAmMwggJfAgEAAoGBAM+bSQXBRhHDOv90qyOyMvSkQ+Cgw6mctVIS31Ss0TKM33yiav3A3dCS5ck1fGBZKl8h+FOduKLBf5S1h84MOZcPYTCQU4+uIQ5goDcO9mB3wQCTxMsYVYdKpi5mxaji23LrEBNylZiayi+x6ODvZ8KvIPE+z0Evdz9MYLStnkkVAgMBAAECgYEAlfp3sWmj5hclGwE81YfZ2fSFeNSLJZApSYaKwpAqfRtaJJ7tLi5T0GcfC9HQ7YXc32caD8YEacfiFBtkZY1dWB+G0DsQnduEFg1z50q95TZQ6r1e6R3i80JKv/jeojkiOhHPY2VlNbDacy/PuLHdmgf4Ecu+OAk5NcbwI+gGyE0CQQDwhv0TBB7eB0cPnMienJac01oYVBACru6jnVUYKSR4CZpzR5Lx10NBnivM3qF1OZd91SFSxrmAanXd1iNCUjFDAkEA3PYoQRCl8qswasdPoCjSZxdHiBmt0QzgZfGR3Wj8prTeI8f58qxw1nhmvwdK/cLOODCOYiKw20om9/7+tPcqxwJBAKJ/UDKssf3kjMezcIZX3BkPYOrWwApQDMFU5cxw30aJlmMTk973Q2Tta0H5lrMPuZ01hFHcGC79vaulpCSGSukCQQDYiAU0lbr5zpaY3Q6Dtd1SFzcLAZca+JJidFNr9Pk56J6T0+F11VSSZ9TQOLZdbOynlbXCJ5rGmqkLeABkmJ57AkEAyawmfqGfm1615nSiPhhLZVEEN5+moUZcdZvfcnrcgRcWuZkHVlOf1uDEHQO/HUcVfNI2Xx36F4s1CZKGZorqmQ==";

static NSString *base64_encode_data(NSData *data){
    data = [data base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

static NSData *base64_decode(NSString *str){
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

@implementation KJEncryptTool

// 6位随机数+10位时间戳（16位数）
+ (NSString*)get16Num{
    // 获取6位随机数
    int six = arc4random()% 100000;
    NSString *sixStr = [NSString stringWithFormat:@"%06d", six];
    
    // 获取当前时间戳
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    // 截取前10位
    NSString *tenString = [timeString substringToIndex:10];
    
    return [NSString stringWithFormat:@"%@%@",sixStr,tenString];
}

#pragma mark - *************  RSA非对称加密解密  *************
/** 加密
 *  @param string 需要加密的string
 *  @return 加密后的字符串
 */
+ (NSString *)RSAEncrypt:(NSString *)string{
    return [KJEncryptTool encryptString:string publicKey:RSAPublicKey];
}
/** 解密
 *  @param string 加密的字符串
 *  @return 解密后的内容
 */
+ (NSString *)RSADecrypt:(NSString *)string{
    return [KJEncryptTool decryptString:string privateKey:RSAprivateKey];
}

/* START: Encryption with RSA public key */

// 使用公钥字符串加密
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey{
    NSData *data = [self encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] publicKey:pubKey];
    NSString *ret = base64_encode_data(data);
    return ret;
}

+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey{
    if(!data || !pubKey){
        return nil;
    }
    SecKeyRef keyRef = [self addPublicKey:pubKey];
    if(!keyRef){
        return nil;
    }
    return [self encryptData:data withKeyRef:keyRef];
}

+ (SecKeyRef)addPublicKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = base64_decode(key);
    data = [self stripPublicKeyHeader:data];
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PubKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *publicKey = [[NSMutableDictionary alloc] init];
    [publicKey setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKey setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)publicKey);
    
    // Add persistent version of the key to system keychain
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    [publicKey setObject:(__bridge id)kSecAttrKeyClassPublic forKey:(__bridge id)
     kSecAttrKeyClass];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr)&& (status != errSecDuplicateItem)){
        return nil;
    }
    
    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [publicKey setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

+ (NSData *)stripPublicKeyHeader:(NSData *)d_key{
    // Skip ASN.1 public key header
    if (d_key == nil)return(nil);
    
    unsigned long len = [d_key length];
    if (!len)return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx     = 0;
    
    if (c_key[idx++] != 0x30)return(nil);
    
    if (c_key[idx] > 0x80)idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] =
    { 0x30,   0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00 };
    if (memcmp(&c_key[idx], seqiod, 15))return(nil);
    
    idx += 15;
    
    if (c_key[idx++] != 0x03)return(nil);
    
    if (c_key[idx] > 0x80)idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    if (c_key[idx++] != '\0')return(nil);
    
    // Now make a new NSData from this buffer
    return ([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}

+ (NSData *)encryptData:(NSData *)data withKeyRef:(SecKeyRef)keyRef{
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef)* sizeof(uint8_t);
    void *outbuf = malloc(block_size);
    size_t src_block_size = block_size - 11;
    
    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyEncrypt(keyRef,
                               kSecPaddingPKCS1,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0){
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            ret = nil;
            break;
        }else{
            [ret appendBytes:outbuf length:outlen];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}

/* END: Encryption with RSA public key */

#pragma mark - 使用私钥字符串解密

/* START: Decryption with RSA private key */

//使用私钥字符串解密
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey{
    if (!str)return nil;
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [self decryptData:data privateKey:privKey];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey{
    if(!data || !privKey){
        return nil;
    }
    SecKeyRef keyRef = [self addPrivateKey:privKey];
    if(!keyRef){
        return nil;
    }
    return [self decryptData:data withKeyRef:keyRef];
}

+ (SecKeyRef)addPrivateKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN RSA PRIVATE KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END RSA PRIVATE KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = base64_decode(key);
    data = [self stripPrivateKeyHeader:data];
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PrivKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *privateKey = [[NSMutableDictionary alloc] init];
    [privateKey setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [privateKey setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [privateKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)privateKey);
    
    // Add persistent version of the key to system keychain
    [privateKey setObject:data forKey:(__bridge id)kSecValueData];
    [privateKey setObject:(__bridge id)kSecAttrKeyClassPrivate forKey:(__bridge id)
     kSecAttrKeyClass];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)privateKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr)&& (status != errSecDuplicateItem)){
        return nil;
    }
    
    [privateKey removeObjectForKey:(__bridge id)kSecValueData];
    [privateKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [privateKey setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

+ (NSData *)stripPrivateKeyHeader:(NSData *)d_key{
    // Skip ASN.1 private key header
    if (d_key == nil)return(nil);
    
    unsigned long len = [d_key length];
    if (!len)return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx     = 22; //magic byte at offset 22
    
    if (0x04 != c_key[idx++])return nil;
    
    //calculate length of the key
    unsigned int c_len = c_key[idx++];
    int det = c_len & 0x80;
    if (!det){
        c_len = c_len & 0x7f;
    } else {
        int byteCount = c_len & 0x7f;
        if (byteCount + idx > len){
            //rsa length field longer than buffer
            return nil;
        }
        unsigned int accum = 0;
        unsigned char *ptr = &c_key[idx];
        idx += byteCount;
        while (byteCount){
            accum = (accum << 8)+ *ptr;
            ptr++;
            byteCount--;
        }
        c_len = accum;
    }
    
    // Now make a new NSData from this buffer
    return [d_key subdataWithRange:NSMakeRange(idx, c_len)];
}

+ (NSData *)decryptData:(NSData *)data withKeyRef:(SecKeyRef)keyRef{
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef)* sizeof(uint8_t);
    UInt8 *outbuf = malloc(block_size);
    size_t src_block_size = block_size;
    
    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyDecrypt(keyRef,
                               kSecPaddingNone,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0){
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            ret = nil;
            break;
        }else{
            //the actual decrypted data is in the middle, locate it!
            int idxFirstZero = -1;
            int idxNextZero = (int)outlen;
            for ( int i = 0; i < outlen; i++ ){
                if ( outbuf[i] == 0 ){
                    if ( idxFirstZero < 0 ){
                        idxFirstZero = i;
                    } else {
                        idxNextZero = i;
                        break;
                    }
                }
            }
                [ret appendBytes:&outbuf[idxFirstZero+1] length:idxNextZero-idxFirstZero-1];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}

/* END: Decryption with RSA private key */



#pragma mark - *************  DES加密解密  *************

/** 加密
 *  @param  plainText 加密的字符串
 *  @param  key 密钥
 *  @return 加密后的内容
 */
+ (NSString *)DESEncrypt:(NSString *)plainText key:(NSString *)key{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    Byte iv[] = { 0x12, 0x34, 0x56, 0x78,  0x90,  0xAB,  0xCD,  0xEF };
    size_t numBytesEncrypted = 0;
    
    /* 参数解读：
        kCCEncrypt：告知是加密过程。
        kCCAlgorithm3DES：加密算法名称。
        kCCOptionPKCS7Padding|kCCOptionECBMode：对应后端的分组加密模式，这里一定要加上kCCOptionECBMode填充模式，因为我们后端是使用的ECB填充模式。
        初始化向量为空：ECB没有初始化向量。
        kCCKeySize3DES：有效秘钥长度DES和3DES不同。
        */
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,  // kCCEncrypt：告知是加密过程
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode, // ECB填充模式
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          textBytes,
                                          dataLength,
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess){
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }
    return ciphertext;
}
//解密
+ (NSString *)DESDecrypt:(NSString*)cipherText key:(NSString*)key{
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    Byte iv[] = { 0x12, 0x34, 0x56, 0x78,  0x90,  0xAB,  0xCD,  0xEF };
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString *plainText = nil;
    if (cryptStatus == kCCSuccess){
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}


#pragma mark - *************  AES  *************
+ (NSString *)returnAESKey{
    NSString *string = [NSString stringWithFormat:@"%@%@",@"Yang",@"token"];
    string = [string substringToIndex:16];
    return string;
}

+ (NSString *)AES128Encrypt:(NSString *)string{
    NSString *key = [self returnAESKey];
    
    if( ![self validKey:key] ){
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr)encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [AESIV getCString:ivPtr maxLength:sizeof(ivPtr)encoding:NSUTF8StringEncoding];
    
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    unsigned long newSize = 0;
    
    if(diff > 0){
        newSize = dataLength + diff;
        NSLog(@"diff is %d",diff);
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess){
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [GTMBase64 stringByEncodingData:resultData];
    }
    free(buffer);
    return nil;
}

+ (NSString *)AES128Decrypt:(NSString *)string{
    NSString *key = [self returnAESKey];
    
    if( ![self validKey:key] ){
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr)encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [AESIV getCString:ivPtr maxLength:sizeof(ivPtr)encoding:NSUTF8StringEncoding];
    
    NSData *data = [GTMBase64 decodeData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess){
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        NSString *decoded=[[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        return [self processDecodedString:decoded];
    }
    
    free(buffer);
    return nil;
}

+ (BOOL)validKey:(NSString*)key{
    if(key==nil || key.length != 16 ){
        return NO;
    }
    return YES;
}

+ (NSString *)processDecodedString:(NSString *)decoded{
    if( decoded==nil || decoded.length==0 ){
        return nil;
    }
    const char *tmpStr=[decoded UTF8String];
    int i=0;
    
    while(tmpStr[i]!='\0' ){
        i++;
    }
    NSString *final=[[NSString alloc]initWithBytes:tmpStr length:i encoding:NSUTF8StringEncoding];
    return final;
    
}

#pragma mark - MD5加密
+ (NSString *)md5To32bit:(NSString *)string{
    return [self md5:[NSString stringWithFormat:@"%@%@", md5_secret, string]];
}

+ (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [result appendFormat:@"%02X", digest[i]];
    }
    return result;
}


@end

