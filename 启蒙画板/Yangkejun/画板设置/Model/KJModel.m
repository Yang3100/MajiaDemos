//
//  KJModel.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/24.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJModel.h"

@implementation KJModel

static KJModel *kjLanguageChatVC = nil;
/** 单例类方法 */
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kjLanguageChatVC = [[self allocWithZone:NULL] init];
    });
    return kjLanguageChatVC;
}

- (void)retColor:(NSInteger)index{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"draw_color"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)retLineWitd:(NSInteger)index{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"draw_line"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)retTime:(CGFloat)time{
    [[NSUserDefaults standardUserDefaults] setFloat:time forKey:@"draw_time"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
