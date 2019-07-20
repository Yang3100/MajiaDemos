//
//  KJHomeModel.m
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/18.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJHomeModel.h"
#import "FMDBMonthModel.h"

@interface KJHomeModel ()

@end

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

- (NSString*)getPath:(int)month{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *name = [NSString stringWithFormat:@"%@.sqlite",[NSString stringWithFormat:@"%d",month]];
    return [path stringByAppendingPathComponent:name];
}

//// 加载月份表
//- (void)loadDataBase:(int)month{
//    GDataBase *database = [GDataBase databaseWithPath:[self getPath:month] isBase64Encode:YES];
//    // 判断表是否存在,不存在则新建添加数据
//    if (month==8||month==10) {
//        for (NSInteger i = 0; i<31; i++) {
//            FMDBMonthModel * model = [[FMDBMonthModel alloc] init];
//            model.ID = [NSString stringWithFormat:@"%ld",i];
//            model.day = [NSString stringWithFormat:@"%ld号",i+1];
//            model.expendSum = [@(arc4random()%100) floatValue];
//            model.incomeSum = [@(arc4random()%10) floatValue];
//            model.remark = [NSString stringWithFormat:@"%ld号的备注",i+1];
//            [database addObject:model];
//        }
//    }
//    else if (month==9||month==11) {
//        for (NSInteger i = 0; i<30; i++) {
//            FMDBMonthModel * model = [[FMDBMonthModel alloc] init];
//            model.ID = [NSString stringWithFormat:@"%ld",i];
//            model.day = [NSString stringWithFormat:@"%ld号",i+1];
//            model.expendSum = [@(arc4random()%100) floatValue];
//            model.incomeSum = [@(arc4random()%10) floatValue];
//            model.remark = [NSString stringWithFormat:@"%ld号的备注",i+1];
//            [database addObject:model];
//        }
//    }
//}
//
//// 读取数据
//- (NSArray*)getMonthData:(int)month{
//    GDataBase *database = [GDataBase databaseWithPath:[self getPath:month] isBase64Encode:YES];
//    NSArray *all = [database getAllObjectsWithClass:[FMDBMonthModel class]];
////    NSString *jsons = [all yy_modelDescription];
//    NSLog(@"alldata__ %@",all);
//    return all;
//}
//
//// 删除表
//- (void)delTable:(int)month{
//    GDataBase *database = [GDataBase databaseWithPath:[self getPath:month] isBase64Encode:YES];
//    BOOL c = [database removeTableWithClass:[FMDBMonthModel class]];
//    if (c) {
//        NSLog(@"del scuess");
//    }else{
//        NSLog(@"del error");
//    }
//}
//
//// 更新表
//- (void)updateTableMonth:(int)month Day:(NSString*)day keyValues:(NSDictionary*)keyValues{
////    GDataBase *database = [GDataBase databaseWithPath:[self getPath:8] isBase64Encode:YES];
////    [database updateObjectClazz:[FMDBMonthModel class] keyValues:keyValues cond:@"dataID = %@",day,nil];
////    BOOL isSucess = [database updateObjectClass:[FMDBMonthModel class] keyValues:@{@"remark":@"我被修改了"} cond:@"dataIndex = %ld",12,nil];
////    BOOL c = [database updateObjectClass:[FMDBMonthModel class] keyValues:@{@"remark":@"12345"} cond:@"dataIndex = %ld",12,nil];
//    FMDatabase *db = [FMDatabase databaseWithPath:[self getPath:8]];
//    if ([db open]) {
//        NSString *sql = @"UPDATE FMDBMonthModel SET dataID = ? WHERE remark = ?";
//        BOOL res = [db executeUpdate:sql, @"1", @"修改数据"];
//        if (res) {
//            NSLog(@"数据修改成功");
//        } else {
//            NSLog(@"数据修改失败");
//        }
//        [db close];
//    }
//    [self queryData];
//}

#pragma mark - 建表
// 加载月份表
- (void)loadDataBase:(int)month{
    NSString *path = [self getPath:month];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path] == NO) {
        // create it
        FMDatabase *db = [FMDatabase databaseWithPath:path];
        if ([db open]) {
            NSString *sql = @"CREATE TABLE IF NOT EXISTS FMDBMonthModel (id integer PRIMARY KEY AUTOINCREMENT,'day' VARCHAR(30), 'expendSum' VARCHAR(30), 'incomeSum' VARCHAR(30), 'remark' VARCHAR(30));";
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                NSLog(@"error when creating %d.db table",month);
            } else {
                NSLog(@"success to creating %d.db table",month);
            }
            [db close];
        } else {
            NSLog(@"error when open db");
        }
    }
    [self insert:month];
}

#pragma mark - 插入数据
//插入数据
-(void)insert:(int)month{
    NSString *dbPath = [self getPath:month];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        if (month==8||month==10) {
            for (int i=0; i<31; i++) {
                NSString *sql = @"INSERT INTO FMDBMonthModel (day, expendSum, incomeSum, remark) VALUES (?, ?, ?, ?);";
                NSString *day = [NSString stringWithFormat:@"%d号",i+1];
                NSString *remark = [NSString stringWithFormat:@"%d号的备注",i+1];
                [db executeUpdate:sql, day, 0.0, 0.0, remark];
            }
            [db close];
        }else if (month==11||month==9){
            for (int i=0; i<30; i++) {
                NSString *sql = @"INSERT INTO FMDBMonthModel (day, expendSum, incomeSum, remark) VALUES (?, ?, ?, ?);";
                NSString *day = [NSString stringWithFormat:@"%d号",i+1];
                NSString *remark = [NSString stringWithFormat:@"%d号的备注",i+1];
                [db executeUpdate:sql, day, 0.0, 0.0, remark];
            }
            [db close];
        }
    }
}

#pragma mark - 读取数据
- (NSArray*)getMonthData:(int)month{
    // 查询数据
    NSMutableArray *dataArr = [NSMutableArray array];
    [dataArr removeAllObjects];
    NSString *dbPath = [self getPath:month];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        // 1.执行查询语句
        FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM FMDBMonthModel"];
        // 2.遍历结果
        while ([resultSet next]) {
            FMDBMonthModel *model = [[FMDBMonthModel alloc]init];
            model.ID = [resultSet stringForColumn:@"id"];
            model.day = [resultSet stringForColumn:@"day"];
            model.expendSum = [resultSet doubleForColumn:@"expendSum"];
            model.incomeSum = [resultSet doubleForColumn:@"incomeSum"];
            model.remark = [resultSet stringForColumn:@"remark"];
            [dataArr addObject:model];
            //            NSLog(@"user id = %d, day = %@, expendSum = %f, incomeSum = %f, remark = %@", userId, day,expendSum,incomeSum,remark);
        }
        [db close];
    }
    return dataArr;
}

// 删除表
- (void)delTable:(int)month{
    
}

#pragma mark - 更新数据
- (void)updateTableMonth:(int)month Day:(NSString*)day keyValues:(NSDictionary*)keyValues{
    NSString *dbPath = [self getPath:month];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    CGFloat expendSum = [[keyValues valueForKey:@"expendSum"] floatValue];
    CGFloat incomeSum = [[keyValues valueForKey:@"incomeSum"] floatValue];
    NSString *remark = [NSString stringWithFormat:@"%@",[keyValues valueForKey:@"remark"] ];
    if (expendSum>0) {
        if ([db open]) {
            NSString *sql = @"UPDATE FMDBMonthModel SET expendSum = ? WHERE day = ?";
            [db executeUpdate:sql,[NSString stringWithFormat:@"%f",expendSum],day];
            [db close];
        }
    }
    if (incomeSum>0){
        if ([db open]) {
            NSString *sql = @"UPDATE FMDBMonthModel SET incomeSum = ? WHERE day = ?";
            [db executeUpdate:sql, [NSString stringWithFormat:@"%f",incomeSum],day];
            [db close];
        }
    }
    if (![remark isEqualToString:@""]||remark!=nil){
        if ([db open]) {
            NSString *sql = @"UPDATE FMDBMonthModel SET remark = ? WHERE day = ?";
            [db executeUpdate:sql, remark,day];
            [db close];
        }
    }
}

- (BOOL)isTableOK:(NSString *)tableName{
    // 获得Documents目录路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    // 文件路径
    NSString *namePath = [NSString stringWithFormat:@"%@.db",tableName];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:namePath];
    // 实例化FMDataBase对象
    FMDatabase *_db = [FMDatabase databaseWithPath:filePath];
    
    FMResultSet *rs = [_db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", @"FMDBMonthModel"];
    while ([rs next]){
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@"isTableOK %ld", (long)count);
        if (0 == count){
            return NO;
        }
        else{
            return YES;
        }
    }
    return NO;
}

@end

