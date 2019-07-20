//
//  KJMeSkinThemeVC.m
//  专属橱窗
//
//  Created by 杨科军 on 2018/10/25.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJMeSkinThemeVC.h"

@interface KJMeSkinThemeVC ()

@property (weak, nonatomic) IBOutlet UILabel *setTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *whiteButton;
@property (weak, nonatomic) IBOutlet UIButton *blackButton;

@end

@implementation KJMeSkinThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置主题";
    self.view.theme_backgroundColor = @"block_bg";
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.setTitleLabel.theme_backgroundColor = @"block_bg";
    self.setTitleLabel.theme_textColor = @"text_h1";
}

- (IBAction)buttonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 520:{
            [[SDThemeManager sharedInstance] changeTheme:@"KJTheme-White"];
        }
            break;
        case 521:{
            [[SDThemeManager sharedInstance] changeTheme:@"KJTheme-Black"];
        }
            break;
        default:
            break;
    }
}

@end
