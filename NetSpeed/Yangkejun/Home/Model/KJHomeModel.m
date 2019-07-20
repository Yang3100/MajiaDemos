//
//  KJShowcaseModel.m
//  涂鸦填填乐
//
//  Created by 杨科军 on 2018/10/26.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJHomeModel.h"
#import "KJHistoryModel.h"

@implementation KJHomeModel

static KJHomeModel *homeModelSharedInstance = nil;
/** 单例类方法 */
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeModelSharedInstance = [[self allocWithZone:NULL] init];
    });
    return homeModelSharedInstance;
}

- (instancetype)init{
    if (self==[super init]) {
        [self judgeIsTable];
    }
    return self;
}

- (void)judgeIsTable{
    // 判断是不是第一次启动app
    if (![UserDefault boolForKey:@"is_frist_creat_table"]){  // 第一次启动
        // 建立数据表
        BOOL sucess = [self creatSqliteTable];
        if (sucess) {        
            [UserDefault setBool:YES forKey:@"is_frist_creat_table"];
            [UserDefault synchronize];
        }
    }
}

//// 保存图片
//- (void)saveImage:(UIImage*)image OldName:(NSString*)oldName{
//    // 判断oldName是否为空,为空则为新增,反之修改
//    NSString *timeName = [self getImageNameForCurrentDate];
//    if ([oldName isEqualToString:@""]||oldName==nil) {
//        [self insert:timeName];
//    }else{
//        [self updateTableOldName:oldName NewName:timeName];
//        [self delImageFromSandbox:oldName];
//    }
//    [self saveImageToSandbox:image Name:timeName];
//}

//// 删除图片
//- (void)delImageName:(NSString*)imageName{
//    [self delTableOneDataForImageName:imageName];
//    [self delImageFromSandbox:imageName];
//}

//#pragma mark - 沙盒相关
//// 将图片保存至沙盒
//- (void)saveImageToSandbox:(UIImage*)image Name:(NSString*)imageName{
//    // 保存到沙盒
//    [KJTools saveImage:image withName:imageName];
//}

//- (void)delImageFromSandbox:(NSString*)imageName{
//    // 先返回图片所在的沙盒路径,先删除以前的那张
//    [KJTools clearCachesWithFilePath:[KJTools getImagePathWithName:imageName]];
//}

- (void)saveHistoryName:(NSString*)name Address:(NSString*)address IP:(NSString*)ip Max:(NSString*)max Min:(NSString*)min Bandwith:(NSString *)bandwith{
    [self insertName:name Address:address IP:ip Max:max Min:min Bandwith:bandwith];
}

- (void)delHistoryForTime:(NSString*)time{
    [self delTableOneDataForTime:time];
}

#pragma mark - 数据库相关
// 获取所有图片路径
- (NSArray*)getAllDatas{
    NSArray *arr = [self getMonthData];
    // 数组倒叙排列
    return [[arr reverseObjectEnumerator] allObjects];
}

- (NSString*)getPath{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [path stringByAppendingPathComponent:@"history.sqlite"];
}

// 建表
- (BOOL)creatSqliteTable{
    BOOL isSuccess = NO;
    NSString *path_string = [self getPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path_string] == NO) {
        // create it
        FMDatabase *db = [FMDatabase databaseWithPath:path_string];
        if ([db open]) {
            NSString *sql = @"CREATE TABLE IF NOT EXISTS SaveHistoryTable (id integer PRIMARY KEY AUTOINCREMENT,'time' VARCHAR(30),'name' VARCHAR(30),'address' VARCHAR(30),'ip' VARCHAR(30),'max' VARCHAR(30),'min' VARCHAR(30),'bandwith' VARCHAR(30));";
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                NSLog(@"error");
            } else {
                NSLog(@"success");
                isSuccess = YES;
            }
            [db close];
        } else {
            NSLog(@"error when open db");
        }
    }
    return isSuccess;
}

//插入数据
-(void)insertName:(NSString*)name Address:(NSString*)address IP:(NSString*)ip Max:(NSString*)max Min:(NSString*)min
         Bandwith:(NSString *)bandwith{
    NSString *time = [self getCurrentDateTime];
    NSString *dbPath = [self getPath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSString *sql = @"INSERT INTO SaveHistoryTable (time,name,address,ip,max,min,bandwith) VALUES (?,?,?,?,?,?,?);";
        [db executeUpdate:sql, time,name,address,ip,max,min,bandwith];
        [db close];
    }
}

// 查询数据
- (NSArray*)getMonthData{
    NSMutableArray *dataArr = [NSMutableArray array];
    [dataArr removeAllObjects];
    NSString *dbPath = [self getPath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        // 1.执行查询语句
        FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM SaveHistoryTable"];
        // 2.遍历结果
        while ([resultSet next]) {
            KJHistoryModel *model = [[KJHistoryModel alloc] init];
            model.time = [resultSet stringForColumn:@"time"];
            model.name = [resultSet stringForColumn:@"name"];
            model.address = [resultSet stringForColumn:@"address"];
            model.ip = [resultSet stringForColumn:@"ip"];
            model.max = [resultSet stringForColumn:@"max"];
            model.min = [resultSet stringForColumn:@"min"];
            model.bandwith = [resultSet stringForColumn:@"bandwith"];
            [dataArr addObject:model];
        }
        [db close];
    }
    return dataArr;
}
//// 更新数据
//- (void)updateTableOldName:(NSString*)oldName NewName:(NSString*)newName{
//    NSString *dbPath = [self getPath];
//    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
//    if ([db open]) {
//        NSString *sql = @"UPDATE SaveHistoryTable SET imageName = ? WHERE imageName = ?";
//        [db executeUpdate:sql,newName,oldName];
//        [db close];
//    }
//}

// 删除指定行
- (void)delTableOneDataForTime:(NSString*)time{
    NSString *dbPath = [self getPath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSString *sql = @"DELETE FROM SaveHistoryTable WHERE time = ?";
        [db executeUpdate:sql,time];
        [db close];
    }
}

// 根据当前时间生成图片名字
- (NSString*)getCurrentDateTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    // 将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

@end
