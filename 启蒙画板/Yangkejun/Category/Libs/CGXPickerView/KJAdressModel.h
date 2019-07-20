//
//  KJAdressModel.h
//  HawkeyeLive
//
//  Created by 杨科军 on 2018/6/5.
//  Copyright © 2018年 HN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJAdressModel : NSObject

@property(nonatomic,strong) NSString *currentLangue;

@property(nonatomic,strong) NSArray *AnState;
@property(nonatomic,strong) NSArray *EnState;
@property(nonatomic,strong) NSArray *stateID;
@property(nonatomic,strong) NSArray *AnCity;
@property(nonatomic,strong) NSArray *EnCity;
@property(nonatomic,strong) NSArray *cityID;
@property(nonatomic,strong) NSArray *AnRegion;
@property(nonatomic,strong) NSArray *EnRegion;
@property(nonatomic,strong) NSArray *regionID;

@end
