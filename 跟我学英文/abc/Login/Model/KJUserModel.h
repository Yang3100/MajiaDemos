//
//  KJUserModel.h
//  跟我学英文
//
//  Created by 杨科军 on 2018/12/4.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJUserModel : NSObject

// 单例
+ (instancetype)initUserModelManager;

@property(nonatomic,strong) NSString *userid;
@property(nonatomic,strong) NSString *nickname;
@property(nonatomic,strong) NSString *signature;
@property(nonatomic,strong) NSString *face;
@property(nonatomic,strong) NSString *phone;

@end

NS_ASSUME_NONNULL_END
