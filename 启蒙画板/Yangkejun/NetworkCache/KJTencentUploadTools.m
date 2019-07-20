//
//  KJTencentUploadTools.m
//  MoLiao
//
//  Created by 杨科军 on 2018/8/8.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJTencentUploadTools.h"

// 腾讯云存储
#import <COSTask.h>
#import <COSClient.h>

@interface KJTencentUploadTools()

@property(nonatomic,copy) NSString *appId;  // 项目ID，即APP ID
@property(nonatomic,copy) NSString *region; // bucket被创建的时候机房区域，比如华东园区：“sh”
@property(nonatomic,copy) NSString *bucket; // 目录所属 bucket 名称
@property(nonatomic,copy) NSString *sign;   // 签名
@property(nonatomic,copy) NSString *dir;    // 目录路径（相对于bucket的路径）
@property(nonatomic,copy) NSString *imageCDN;  //

@end

@implementation KJTencentUploadTools

// 上传图片到腾讯云存储
+ (void)uploadFileWithImage:(UIImage *)image uploadSuccess:(void(^)(NSString  *resp))success uploadFailed:(void(^)(NSDictionary *dict))failed{
    KJTencentUploadTools *tut = [[KJTencentUploadTools alloc] init];
    [tut getSignAndAppIdWithSuccess:^{
        // 在这里开始处理上传操作
        // 先把图片保存到沙盒， 并且记录路径
        NSString *fileName = [tut getFileName];
        [tut saveImage:image withName:fileName];
        NSString *fullPath = [tut getImagePathWithName:fileName];
        COSObjectPutTask *task = [[COSObjectPutTask alloc] init];
//        NSLog(@"------------%@",fullPath);
        task.filePath = fullPath;
        task.fileName = fileName;
        task.bucket = tut.bucket;
        task.attrs = @"customAttribute";
        NSString  *upImgStr = [NSString stringWithFormat:@"%@/%@",[tut getFilePath],fileName];
        task.directory = [tut getFilePath];
        task.insertOnly = YES;
        task.sign = tut.sign;
        COSClient *myClient = [[COSClient alloc] initWithAppId:tut.appId withRegion:tut.region];
        //设置htpps请求
        [myClient openHTTPSrequset:YES];
        myClient.completionHandler = ^(COSTaskRsp *resp, NSDictionary *context) {
            COSObjectUploadTaskRsp *rsp = (COSObjectUploadTaskRsp *)resp;
            if (rsp.retCode >=0) {
                NSString  *imgUrl =[NSString stringWithFormat:@"%@/%@",tut.imageCDN,upImgStr];
                // 上传成功
                if (success) {
                    success(imgUrl);
//                    NSLog(@"xxxxxxxxx:%@",imgUrl);
                }
            }
            else {
//                NSLog(@"上传失败，code:%d  mes:%@",rsp.retCode,rsp.descMsg);
                if (failed) {
                    failed(context);
                }
            }
        };
        [myClient putObject:task];
    } andFailed:^(NSDictionary*dict){
        if (failed) {
            failed(nil);
        }
    }];
}

// 上传录音
+ (void)uploadFileRecordFileName:(NSString *)file_name Path:(NSString*)path uploadSuccess:(void(^)(NSString *resp))success uploadFailed:(void(^)(NSDictionary *dict))failed{
    KJTencentUploadTools *tut = [[KJTencentUploadTools alloc] init];
    [tut getSignAndAppIdWithSuccess:^{
        // 在这里开始处理上传操作
        // 先把图片保存到沙盒， 并且记录路径
        NSString *fileName = file_name;
        NSString *fullPath = path;  // 沙盒路径
        COSObjectPutTask *task = [[COSObjectPutTask alloc] init];
        task.filePath = fullPath;
        task.fileName = fileName;
        task.bucket = tut.bucket;
        task.attrs = @"customAttribute";
        // 存放在云端的路径
        NSString  *upImgStr = [NSString stringWithFormat:@"%@/%@",[tut getRecordFilePath],fileName];
        task.directory = [tut getRecordFilePath];
        task.insertOnly = YES;
        task.sign = tut.sign;
        COSClient *myClient = [[COSClient alloc] initWithAppId:tut.appId withRegion:tut.region];
        //设置htpps请求
        [myClient openHTTPSrequset:YES];
        myClient.completionHandler = ^(COSTaskRsp *resp, NSDictionary *context) {
            COSObjectUploadTaskRsp *rsp = (COSObjectUploadTaskRsp *)resp;
            if (rsp.retCode >=0) {
                NSString  *imgUrl =[NSString stringWithFormat:@"%@/%@",tut.imageCDN,upImgStr];
                // 上传成功
                if (success) {
                    success(imgUrl);
//                    NSLog(@"xxxxxxxxx:%@",imgUrl);
                }
            }
            else {
                //                NSLog(@"上传失败，code:%d  mes:%@",rsp.retCode,rsp.descMsg);
                if (failed) {
                    failed(context);
                }
            }
        };
        [myClient putObject:task];
    } andFailed:^(NSDictionary*dict){
        if (failed) {
            failed(nil);
        }
    }];
}

// 创建音频文件目录
- (NSString *)getRecordFilePath{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *lastStr = [NSString stringWithFormat:@"audio/%@",dateStr];
    return lastStr;
}

// 获取上传签名
- (void)getSignAndAppIdWithSuccess:(void(^)(void))success andFailed:(void(^)(NSDictionary *dict))field {
    NSURL *nsurl = [NSURL URLWithString:UpImgForOSSUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    //如果想要设置网络超时的时间的话，可以使用下面的方法：
    //NSMutableURLRequest *mutableRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //设置请求类型
    request.HTTPMethod = @"POST";
    
    //    //将需要的信息放入请求头 随便定义了几个
    //    [request setValue:@"xxx" forHTTPHeaderField:@"Authorization"];//token
    //    [request setValue:@"xxx" forHTTPHeaderField:@"Gis-Lng"];//坐标 lng
    //    [request setValue:@"xxx" forHTTPHeaderField:@"Gis-Lat"];//坐标 lat
    //    [request setValue:@"xxx" forHTTPHeaderField:@"Version"];//版本
    //    NSLog(@"POST-Header:%@",request.allHTTPHeaderFields);
    //    //把参数放到请求体内
    //    NSString *postStr = [self parseParams:parameters];
    //    request.HTTPBody = [postStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) { //请求失败
            //            ERROR;
            if (field) {
                field(error);
            }
        } else {  //请求成功
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([responseObject[@"c"] integerValue]!=0) {
                [MBProgressHUD showError:@"获取上传签名失败"];
                if (field) {
                    field(nil);
                }
            }
            // 获取出来的数据要进行解密
            NSDictionary *data = responseObject[@"d"][@"config"];
            self.sign = data[@"sign"];
            self.appId = data[@"appId"];
            self.bucket = data[@"bucket"];
            self.region = data[@"region"];
            self.imageCDN = data[@"image_cdn"];
            if (success) {
                success();
            }
        }
    }];
    [dataTask resume];  //开始请求
}
//重新封装参数 加入app相关信息
- (NSString *)parseParams:(NSDictionary *)params{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:params];
    [parameters setValue:@"ios" forKey:@"client"];
    [parameters setValue:@"请替换版本号" forKey:@"auth_version"];
    NSString* phoneModel = @"获取手机型号" ;
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];//ios系统版本号
    NSString *system = [NSString stringWithFormat:@"%@(%@)",phoneModel, phoneVersion];
    [parameters setValue:system forKey:@"system"];
    NSDate *date = [NSDate date];
    NSTimeInterval timeinterval = [date timeIntervalSince1970];
    [parameters setObject:[NSString stringWithFormat:@"%.0lf",timeinterval] forKey:@"auth_timestamp"];//请求时间戳
    NSString *devicetoken = @"请替换DeviceToken";
    [parameters setValue:devicetoken forKey:@"uuid"];
//    NSLog(@"请求参数:%@",parameters);
    
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    //实例化一个key枚举器用来存放dictionary的key
    
    //加密处理 将所有参数加密后结果当做参数传递
    //parameters = @{@"i":@"加密结果 抽空加入"};
    
    NSEnumerator *keyEnum = [parameters keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&", key, [params valueForKey:key]];
        [result appendString:keyValueFormat];
    }
    return result;
}

#pragma mark - 将图片储存到沙盒相关
// 保存图片到沙盒
- (void)saveImage:(UIImage *)tempImage withName:(NSString *)imageName{
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [self applicationDocumentsDirectoryWithDocuments];//[paths objectAtIndex:0];
    
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
}
// 获取沙盒地址Documents的目录路径
- (NSString *)applicationDocumentsDirectoryWithDocuments{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}
// 根据图片名从获取图片路径
- (NSString *)getImagePathWithName:(NSString *)name{
    NSString *documentsFile = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* fullPathToFile = [documentsFile stringByAppendingPathComponent:name];
    
    return fullPathToFile;
}
// 创建一个文件名
- (NSString *)getFileName{
    int x = arc4random() % 1000;//（0-1000随机数）
    NSDate *date = [NSDate date];
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSString *xStr = [NSString stringWithFormat:@"%@%d",date2,x];
    // 加密
    xStr = [KJTools md5To32bit:xStr];
    return xStr;
}

// 创建文件目录
- (NSString *)getFilePath{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *lastStr = [NSString stringWithFormat:@"image/%@",dateStr];
    return lastStr;
}
// 解析json
- (NSDictionary *)dictionaryWitKJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
//        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


@end

