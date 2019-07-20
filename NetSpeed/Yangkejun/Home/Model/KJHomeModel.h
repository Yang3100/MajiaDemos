//
//  KJShowcaseModel.h
//  涂鸦填填乐
//
//  Created by 杨科军 on 2018/10/26.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJHomeModel : NSObject

/**
 单例类方法
 @return 返回一个共享对象
 */
+ (instancetype)sharedInstance;

//// 保存图片
//- (void)saveImage:(UIImage*)image OldName:(NSString*)oldName;
//
//// 删除图片
//- (void)delImageName:(NSString*)imageName;

- (void)saveHistoryName:(NSString*)name Address:(NSString*)address IP:(NSString*)ip Max:(NSString*)max Min:(NSString*)min
               Bandwith:(NSString *)bandwith;

- (void)delHistoryForTime:(NSString*)time;

// 获取所有数据
- (NSArray*)getAllDatas;

@end

