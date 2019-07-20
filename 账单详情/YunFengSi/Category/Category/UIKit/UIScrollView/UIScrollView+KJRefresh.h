//
//  UIScrollView+KJRefresh.h
//  KJDevelopExample
//
//  Created by 杨科军 on 2017/6/12.
//  Copyright © 2017年 杨科军. All rights reserved.
//  上下拉刷新

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface UIScrollView (KJRefresh)
/// 添加下拉刷新控件
- (MJRefreshNormalHeader *)kj_addHeaderRefresh:(void(^)(MJRefreshNormalHeader *header))refreshingBlock;
/// 添加上拉加载控件
- (MJRefreshAutoNormalFooter *)kj_addFooterRefresh:(void(^)(MJRefreshAutoNormalFooter *footer))refreshingBlock;
@end
