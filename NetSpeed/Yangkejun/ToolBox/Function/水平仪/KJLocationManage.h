//
//  KJLocationManage.h
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/10.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CLHeading.h>
#import <CoreMotion/CoreMotion.h>
NS_ASSUME_NONNULL_BEGIN

@interface KJLocationManage : NSObject
+ (instancetype)shared;
- (void)startSensor;
- (void)stopSensor;
- (void)startGyroscope;

@property (nonatomic, copy) void (^didUpdateHeadingBlock)(CLLocationDirection theHeading);
@property (nonatomic, copy) void (^updateDeviceMotionBlock)(CMDeviceMotion *data);
@end

NS_ASSUME_NONNULL_END
