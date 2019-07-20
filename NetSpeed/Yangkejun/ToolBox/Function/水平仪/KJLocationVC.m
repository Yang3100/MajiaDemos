//
//  KJLocationVC.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/10.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJLocationVC.h"
#import "KJLocationManage.h"

@interface KJLocationVC ()

@property (nonatomic, strong) UIImageView *levelImg;
@property (nonatomic, strong) KJLocationManage *manager;
@property (nonatomic, assign) CGPoint point;

@property (nonatomic, strong) UILabel *labelX;
@property (nonatomic, strong) UILabel *labelY;

@end

@implementation KJLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Lication";
    self.view.backgroundColor = [UIColor blackColor];
    
    _point = CGPointMake(self.view.center.x, self.view.center.y-50);
    
    UIImageView *backImg =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spy-bg"]];
    backImg.center = _point;
    [self.view addSubview:backImg];
    
    _levelImg =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spy"]];
    _levelImg.center = _point;
    [self.view addSubview:_levelImg];
    
    _labelX = [[UILabel alloc] initWithFrame:CGRectMake(0, backImg.frame.origin.y + backImg.frame.size.height+30, [UIScreen mainScreen].bounds.size.width/2, 30)];
    _labelX.font = [UIFont systemFontOfSize:16];
    _labelX.textAlignment = NSTextAlignmentCenter;
    _labelX.textColor = [UIColor whiteColor];
    [self.view addSubview:_labelX];
    
    _labelY = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, backImg.frame.origin.y + backImg.frame.size.height+30, [UIScreen mainScreen].bounds.size.width/2, 30)];
    _labelY.font = [UIFont systemFontOfSize:16];
    _labelY.textAlignment = NSTextAlignmentCenter;
    _labelY.textColor = [UIColor whiteColor];
    [self.view addSubview:_labelY];
    
    [self startSensor];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_manager stopSensor];
}

/**
 *  启动传感器
 */
- (void)startSensor{
    __weak typeof(self)mySelf = self;
    _manager = [KJLocationManage shared];
    _manager.updateDeviceMotionBlock = ^(CMDeviceMotion *data){
        
        mySelf.levelImg.center = CGPointMake(mySelf.point.x + data.gravity.x*100, mySelf.point.y + data.gravity.y*100);
        mySelf.labelX.text = [NSString stringWithFormat:@"X: %.2f",data.gravity.x*100];
        mySelf.labelY.text = [NSString stringWithFormat:@"Y: %.2f",data.gravity.y*100];
    };
    [_manager startSensor];
    [_manager startGyroscope];
}

@end
