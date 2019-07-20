//
//  KJFilterTools.h
//  FilterPhotos
//
//  Created by 杨科军 on 2018/11/14.
//  Copyright © 2018 杨科军. All rights reserved.
//  滤镜工具

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KJFilterTools : NSObject

- (UIImage *)createImageWithImage:(UIImage *)inImage colorMatrix:(const float *)f;

@end

