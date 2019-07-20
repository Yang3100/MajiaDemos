//
//  KJRulesLineVC.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/10.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJRulesLineVC.h"
#import "ZJ_RulesLineView.h"

@interface KJRulesLineVC ()
@property (nonatomic, strong) ZJ_RulesLineView *lineView;
@end

@implementation KJRulesLineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RulesLine";
    self.lineView = [[ZJ_RulesLineView alloc] initWithFrame:CGRectMake(0, kSTATUSBAR_NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-kSTATUSBAR_NAVIGATION_HEIGHT)];
    [self.view addSubview:_lineView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
