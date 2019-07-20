//
//  KJTouchIDVC.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJTouchIDVC.h"
#import "TouchIdUnlock.h"

@interface KJTouchIDVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation KJTouchIDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置 TouchID";
    self.view.theme_backgroundColor = @"block_bg";
    
    [self setupUI];
}

- (void)setupUI {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.separatorColor = [UIColor clearColor];
    _tableView.theme_backgroundColor = @"block_bg";
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"touchIDCell"];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"touchIDCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    cell.theme_backgroundColor = @"block_table_bg";
    
    UISwitch * sw = [[UISwitch alloc] init];
    
    [sw addTarget:self action:@selector(sw:) forControlEvents:UIControlEventValueChanged];
    
    cell.textLabel.text = @"开启TouchID";
    cell.textLabel.theme_textColor = @"text_h1";
    cell.accessoryView = sw;
    
    sw.on = [[TouchIdUnlock sharedInstance] isTouchIdEnabledOrNotByUser];
    
    return cell;
}

- (void)sw:(UISwitch *)sw {
    if (sw.on == NO) {sw.on = YES;
        if ([[TouchIdUnlock sharedInstance] canVerifyTouchID]) {    
            [[TouchIdUnlock sharedInstance] startVerifyTouchID:^{
                [[TouchIdUnlock sharedInstance] save_TouchIdEnabledOrNotByUser_InUserDefaults:NO];
                sw.on = NO;
            }];
        }
    } else {
        [[TouchIdUnlock sharedInstance] save_TouchIdEnabledOrNotByUser_InUserDefaults:YES];
//        if ([[TouchIdUnlock sharedInstance] isTouchIdEnabledOrNotBySystem]) {
//            
//            
//        } else {
//            
//            [SVProgressHUD showErrorWithStatus:@"Touch ID 不可用"];
//            [self performSelector:@selector(switchOff:) withObject:sw afterDelay:1];
//        }
    }
}

- (void)switchOff:(UISwitch *)sw {
    
    sw.on = NO;
}

- (void)dealloc {
    
    NSLog(@"dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
