//
//  KJLocationManage.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/10.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJLocationManage.h"

@interface KJLocationManage ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation KJLocationManage
+ (instancetype)shared
{
    return [[self alloc]init];
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)startSensor
{
    _manager = [[CLLocationManager alloc]init];
    _manager.delegate = self;
    
    if ([CLLocationManager headingAvailable]) {
        _manager.headingFilter = 5;
        [_manager startUpdatingHeading];
    }
}
- (void)startGyroscope
{
    _motionManager = [[CMMotionManager alloc]init];
    
    if (_motionManager.deviceMotionAvailable) {
        _motionManager.deviceMotionUpdateInterval = 0.1f;
        __weak typeof(self)mySelf = self;
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                            withHandler:^(CMDeviceMotion *data, NSError *error) {
                                                
                                                if (mySelf.updateDeviceMotionBlock) {
                                                    mySelf.updateDeviceMotionBlock(data);
                                                }
                                                
                                            }];
        
    }
}

- (void)stopSensor
{
    [_manager stopUpdatingHeading];
    _manager = nil;
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if (newHeading.headingAccuracy < 0)
        return;
    
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
    if (_didUpdateHeadingBlock) {
        _didUpdateHeadingBlock(theHeading);
    }
}


@end
