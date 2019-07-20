//
//  KJGestureSettingVC.m
//  LZAccount
//
//  Created by 杨科军 on 16/6/2.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJGestureSettingVC.h"

// 10.18
#import "LZGestureViewController.h"
#import "LZGestureTool.h"
#import "KJGestureIntroduceVC.h"

// 10.23
#import "TouchIdUnlock.h"

@interface CMSwitch : UISwitch
@property (nonatomic, strong) NSIndexPath * indexPath;
@end
@implementation CMSwitch
@end


@interface KJGestureSettingVC ()<
UITableViewDataSource,
UITableViewDelegate,LZGestureViewDelegate>
{
    UITableView * _tableView;
    BOOL          _isShowOther;
    CMSwitch * _stateSwitch;
}


@end

@implementation KJGestureSettingVC

- (void)dealloc
{
    if (_tableView) {
        _tableView = nil;
    }
    
    if (_popBackBlock) {
        _popBackBlock = nil;
    }
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _contendView = [UIView new];
        [self.view addSubview:_contendView];
        
        [_contendView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.bottom.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view).offset(kSTATUSBAR_NAVIGATION_HEIGHT);
        }];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"Gestures to set";
    
    [self setupMainView];
}

- (void)setupMainView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = [UIColor clearColor];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    
    [_contendView addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.contendView);
        make.top.mas_equalTo(self.contendView);
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    _isShowOther = [LZGestureTool isGestureEnable];
    
    if (_isShowOther) {
        
        return 4;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
//        
//        return 2;
//    }
    
    if (section == 1&&![[TouchIdUnlock sharedInstance] isTouchIdEnabledOrNotBySystem]) {
        
        return 0;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    switch (indexPath.section)
    {
        case 0:
        {
            CMSwitch * sw = [[CMSwitch alloc] init];
            
            [sw addTarget:self action:@selector(sw:) forControlEvents:UIControlEventValueChanged];
            _stateSwitch = sw;
            cell.accessoryView = sw;
            sw.indexPath = indexPath;
            cell.textLabel.text = @"Unlock password lock";
            sw.on = [LZGestureTool isGestureEnableByUser];
        }break;
            
        case 1:
        {
            CMSwitch * sw = [[CMSwitch alloc] init];
            
            [sw addTarget:self action:@selector(sw:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = sw;
            sw.indexPath = indexPath;
            cell.textLabel.text = @"Use a fingerprint to reset the gesture password";
            sw.on = [LZGestureTool isGestureResetEnableByTouchID];
            
        }break;
        case 2:
        {
            cell.textLabel.text = @"Change password";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        } break;
            
        case 3:
        {
            cell.textLabel.text = @"Forget password";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        } break;
        default:
        {
            cell.textLabel.text = nil;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.accessoryView = nil;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }break;
    }
    
    return cell;
}


#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (![[TouchIdUnlock sharedInstance] isTouchIdEnabledOrNotBySystem] && section == 1) {
        
        return 1.;
    }
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 20.0;
    }
    
    return 1.0;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    if (section == 1 && [[TouchIdUnlock sharedInstance] isTouchIdEnabledOrNotBySystem]) {
        
        return @"When you forget the gesture password, you can use the fingerprint password to reset the gesture password";
    } else if (section == 3) {
        
        if ([[TouchIdUnlock sharedInstance] isTouchIdEnabledOrNotBySystem]) {
            
            return @"If you use a digital password or a fingerprint password, use one of them to reset your gesture password";
        }
        
        return @"If you use a digital password, use a digital password to reset the gesture password";
    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _weakself;
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.5];
    
    // 修改手势密码
    if (indexPath.section == 2) {
        
        LZGestureViewController *gestureVC = [[LZGestureViewController alloc]init];
        [gestureVC showInViewController:self type:(LZGestureTypeUpdate)];
        
        // 忘记手势密码
    } else if (indexPath.section == 3) {
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        if ([[TouchIdUnlock sharedInstance] isTouchIdEnabledOrNotBySystem]&&[LZGestureTool isGestureResetEnableByTouchID]) {
            
            UIAlertAction *touchID = [UIAlertAction actionWithTitle:@"Reset using the fingerprint password" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[TouchIdUnlock sharedInstance] startVerifyTouchID:^{
                        KJGestureIntroduceVC *info = [[KJGestureIntroduceVC alloc]init];
                        [weakself.navigationController pushViewController:info animated:YES];
                }];
            }];
            
            [alert addAction:touchID];
        }
    }
}

#pragma mark - 事件

- (void)sw:(CMSwitch *)sender
{
    if (sender.indexPath.section == 0) {
        
        BOOL isON = sender.isOn;
        
        if ([LZGestureTool isGestureEnableByUser]) {
            
            sender.on = YES;
            LZGestureViewController *gesture = [[LZGestureViewController alloc]init];
            
            gesture.delegate = self;
            [gesture showInViewController:self type:LZGestureTypeVerifying];
        } else {
            
            [LZGestureTool saveGestureEnableByUser:isON];
            
            _isShowOther = isON;
            [_tableView reloadData];
        }
    } else if (sender.indexPath.section == 1){
     
        if ([LZGestureTool isGestureResetEnableByTouchID]) {
            
            sender.on = YES;
        } else {
            
            sender.on = NO;
        }
        
        [[TouchIdUnlock sharedInstance] startVerifyTouchID:^{
                sender.on = !sender.on;
                [LZGestureTool saveGestureResetEnableByTouchID:sender.on];
        }];
    }
}

- (void)gestureViewVerifiedSuccess:(LZGestureViewController *)vc {
    
    [LZGestureTool saveGestureEnableByUser:NO];
    _isShowOther = NO;
    [_tableView reloadData];
    _stateSwitch.on = NO;
}

@end
