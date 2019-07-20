//
//  KJHistoryModel.h
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/9.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJHistoryModel : NSObject

@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *ip;
@property(nonatomic,strong) NSString *max;
@property(nonatomic,strong) NSString *min;
@property(nonatomic,strong) NSString *bandwith;

@end

NS_ASSUME_NONNULL_END
