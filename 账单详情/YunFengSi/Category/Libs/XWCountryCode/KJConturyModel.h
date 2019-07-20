//
//  KJConturyModel.h
//  HawkeyeLive
//
//  Created by 杨科军 on 2018/5/25.
//  Copyright © 2018年 HN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJConturyModel : NSObject

@property(nonatomic,strong) NSString *AnContury;  // 中文名字
@property(nonatomic,strong) NSString *EnContury;  // 英文名字
@property(nonatomic,strong) NSString *conturyID;  // 国家对应的id
@property(nonatomic,strong) NSString *FristName;  // 首字母
@property(nonatomic,assign) NSInteger tag;        // 对应的标签
@property(nonatomic,strong) NSString *currentLanguage; // 当前语言

@end
