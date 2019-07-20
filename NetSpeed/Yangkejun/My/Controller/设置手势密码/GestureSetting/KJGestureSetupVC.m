//
//  LZGestureSetupViewController.m
//  LZAccount
//
//  Created by 杨科军 on 16/6/2.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJGestureSetupVC.h"

#import "KJGestureSettingVC.h"
#import "KJGestureIntroduceVC.h"


// 10.18
#import "LZGestureTool.h"

static NSString *cellReuseIdentifier = @"com.cellReuseIdentifier";

@interface KJGestureSetupVC ()<
UITableViewDataSource,
UITableViewDelegate>
{
    UITableView * _tableView;
}

@end

@implementation KJGestureSetupVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Set gesture password";
    
    [self setupMainView];
}


- (void)setupMainView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = [UIColor clearColor];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseIdentifier];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(kSTATUSBAR_NAVIGATION_HEIGHT);
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if (![cell.contentView viewWithTag:147258])
    {
        float screenW = [UIScreen mainScreen].bounds.size.width;
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(screenW-90, 0, 60, cell.bounds.size.height)];
        lb.text = nil;
        lb.textColor = [UIColor blueColor];
        lb.textAlignment = NSTextAlignmentRight;
        
        lb.tag = 147258;//请勿更改这个。
        
        lb.hidden = YES;
        [cell.contentView addSubview: lb];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString * textLock = @"Gestures to lock";
    
    cell.textLabel.text = textLock; //手势这行单元格
    
    
    if ([LZGestureTool isGestureEnable])
    {
        UILabel * lb = (UILabel *)[cell.contentView viewWithTag:147258];
        lb.text = @"Open";//开启了手势锁屏
        lb.textColor = [UIColor blueColor];
        
        lb.hidden = NO;
    }
    else if (![LZGestureTool isGesturePswSavedByUser])
    {
        UILabel * lb = (UILabel *)[cell.contentView viewWithTag:147258];
        lb.text = @"Not set";//还没有设置手势密码
        lb.textColor = [UIColor grayColor];
        
        lb.hidden = NO;
    }
    else if (![LZGestureTool isGestureEnableByUser])
    {
        UILabel * lb = (UILabel *)[cell.contentView viewWithTag:147258];
        lb.text = @"Close";//关闭了手势
        lb.textColor = [UIColor grayColor];
        
        lb.hidden = NO;
    }
    
    return cell;
}


#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BOOL isHasGestureSavedInNSUserDefaults = [LZGestureTool isGesturePswSavedByUser];
    
    if (isHasGestureSavedInNSUserDefaults)
    {
        
        KJGestureSettingVC * gsVC = [[KJGestureSettingVC alloc]init];
        __weak UITableView * ___tableView = _tableView;
        
        gsVC.popBackBlock = ^{
            [___tableView reloadData];
        };
        
        gsVC.title = @"Gestures to set";
        
        [self.navigationController pushViewController:gsVC animated:YES];
    }
    else
    {
        /**
         手势密码介绍页面
         */
        KJGestureIntroduceVC *giVC = [[KJGestureIntroduceVC alloc]init];
        giVC.title = @"Gesture password lock";
        [self.navigationController pushViewController:giVC animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    return @"Gesture password as the main password protection verification method, after setting please properly keep!";
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return UITableViewAutomaticDimension;
}

@end
