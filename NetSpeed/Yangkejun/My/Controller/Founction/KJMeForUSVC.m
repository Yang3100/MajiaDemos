//
//  KJMeForUSVC.m
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/19.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJMeForUSVC.h"

@interface KJMeForUSVC ()

@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *appVersion;

@end

@implementation KJMeForUSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"For Us";
    
    self.appName.text = @"NetSpeed";
    self.appVersion.text = [NSString stringWithFormat:@"Versions: %@",[KJTools appVersion]];
}

@end
