//
//  KJPhotoChangeManager.h
//  MoLiao
//
//  Created by 杨科军 on 2018/8/8.
//  Copyright © 2018年 杨科军. All rights reserved.
//  访问相册 与 拍照

#import <Foundation/Foundation.h>

@interface KJPhotoChangeManager : NSObject

+ (instancetype)manager;

- (void)showInVC:(UIViewController *)vc Name:(NSString*)name image:(void(^)(UIImage *image))image;

@end
