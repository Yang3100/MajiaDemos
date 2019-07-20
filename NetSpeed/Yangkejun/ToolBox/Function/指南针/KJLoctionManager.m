//
//  KJLoctionManager.h
//  MoLiao
//
//  Created by 杨科军 on 2018/7/20.
//  Copyright © 2018年 杨科军. All rights reserved.
//  

#import "KJLoctionManager.h"

@interface KJLoctionManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation KJLoctionManager

+ (instancetype)shared{
    return [[self alloc]init];
}

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)startSensor{
    _manager = [[CLLocationManager alloc]init];
    _manager.delegate = self;
    
    if ([CLLocationManager headingAvailable]) {
        _manager.headingFilter = 5;
        [_manager startUpdatingHeading];
    }
}

- (void)startGyroscope{
    _motionManager = [[CMMotionManager alloc]init];
    if (_motionManager.deviceMotionAvailable) {
        _motionManager.deviceMotionUpdateInterval = 0.01f;
        __weak typeof(self)mySelf = self;
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *data, NSError *error) {
             if (mySelf.updateDeviceMotionBlock) {
                 mySelf.updateDeviceMotionBlock(data);
             }
        }];
    }
}

- (void)stopSensor{
    [_manager stopUpdatingHeading];
    _manager = nil;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    if (newHeading.headingAccuracy < 0) return;
    
    CLLocationDirection theHeading = ((newHeading.trueHeading > 0) ? newHeading.trueHeading : newHeading.magneticHeading);
    if (_didUpdateHeadingBlock) {
        _didUpdateHeadingBlock(theHeading);
    }
}


@end
