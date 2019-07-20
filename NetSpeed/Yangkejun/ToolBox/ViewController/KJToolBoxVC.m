//
//  KJToolBoxVC.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/10.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJToolBoxVC.h"

#import "KJNoiseVC.h" // 测噪音
#import "KJFoldClockVC.h" // 时钟
#import "KJLocationVC.h" // 水平仪
#import "KJRulesLineVC.h" // 直尺
#import "KJEquipmentVC.h" // 设备信息
#import "KJCompassVC.h" // 指南针

@interface KJToolBoxVC ()

@end

@implementation KJToolBoxVC
#pragma mark - Status bar
- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // hide sys navBar
    self.fd_prefersNavigationBarHidden = YES;
    /// Create NavBar;
    UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, kSTATUSBAR_HEIGHT-20, kScreenW, self.navigationController.navigationBar.height+20)];
    navBar.backgroundColor = MainColor(1.f);
    [self.view addSubview:navBar];
    
    UILabel *tit = InsertLabel(navBar, CGRectZero, NSTextAlignmentCenter, @"Tool - Box", [UIFont fontWithName:@"Futura" size:24], [UIColor whiteColor]);
    [tit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(navBar.mas_bottom).mas_offset(-Handle(10));
        make.centerX.mas_equalTo(self.view);
    }];
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView *bg = InsertImageView(self.view, CGRectZero, DefaultBGImage);
    bg.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    bg.alpha = 0.6;
    [self.view sendSubviewToBack:bg];
}
- (IBAction)ClickButton:(UIButton *)sender {
    KJBaseViewController *vc;
    switch (sender.tag) {
        case 520:{
            vc = [[KJNoiseVC alloc]init];
            }
            break;
        case 521:{
            vc = [[KJFoldClockVC alloc] init];
        }
            break;
        case 522:{
            vc = [[KJLocationVC alloc] init];
        }
            break;
        case 523:{
            vc = [[KJRulesLineVC alloc] init];
        }
            break;
        case 524:{
            vc = [[KJEquipmentVC alloc] init];
        }
            break;
        case 525:{
            vc = [[KJCompassVC alloc] init];
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end
