//
//  KJCompassVC.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/11.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJCompassVC.h"
#import "KJCompassView.h" // 指南针

@interface KJCompassVC ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property(nonatomic,strong) KJCompassView *compassView;// 指南针
@end

@implementation KJCompassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.title = @"Compass";
    
    [self.backView addSubview:self.compassView];
}

- (KJCompassView*)compassView{
    if (!_compassView) {
        CGRect fram = CGRectMake(self.backView.frame.origin.x, 0, self.backView.frame.size.width, self.backView.frame.size.width);
        KJCompassView *compassView = [KJCompassView sharedWithRect:fram radius:(self.backView.bounds.size.width)/2];
        compassView.alpha = 1;
        compassView.textColor = [UIColor whiteColor];
        compassView.calibrationColor = [UIColor whiteColor];
        compassView.horizontalColor = [UIColor redColor];
        _compassView = compassView;
    }
    return _compassView;
}
@end
