//
//  KJHomeModel.h
//  跟我学英文
//
//  Created by 杨科军 on 2018/12/4.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJHomeModel : NSObject
@property(nonatomic,strong) NSString *word_id;
@property(nonatomic,strong) NSString *english;
@property(nonatomic,strong) NSString *chinese;
@property(nonatomic,strong) NSString *is_study;//是否学习过 1是 0否

@end

NS_ASSUME_NONNULL_END
