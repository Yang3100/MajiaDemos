//
//  KJShowcaseModel.h
//  涂鸦填填乐
//
//  Created by 杨科军 on 2018/10/26.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJShowcaseModel : NSObject

/**
 单例类方法
 @return 返回一个共享对象
 */
+ (instancetype)sharedInstance;

// 保存图片
- (void)saveImage:(UIImage*)image OldName:(NSString*)oldName;

// 删除图片
- (void)delImageName:(NSString*)imageName;

// 获取所有图片路径
- (NSArray*)getAllImages;

@end

