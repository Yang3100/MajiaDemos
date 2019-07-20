//
//  KJWaterfallModel.h
//  MHDevelopExample
//
//  Created by lx on 2018/6/11.
//  Copyright © 2018年 杨科军. All rights reserved.
//

@interface KJWaterfall : NSObject

/// title
@property (nonatomic , readwrite , copy) NSString *title;
/// imageUrl
@property (nonatomic , readwrite , copy) NSString *imageUrl;
/// 宽
@property (nonatomic , readwrite , assign) CGFloat width;
/// 高
@property (nonatomic , readwrite , assign) CGFloat height;
@end
