//
//  KJChangeUserInfoVC.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/25.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJChangeNameVC.h"

@interface KJChangeNameVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView       *bgView;
@property (nonatomic, strong) UITextField  *nickNameText;
@property (nonatomic, strong) UILabel *descLab;

@end


@implementation KJChangeNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.theme_backgroundColor = @"block_bg";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:nil highImage:nil title:@"保存" titleColor:[UIColor whiteColor] target:self action:@selector(rightBarButtonItem:)];
    // 创建UI
    [self createView];
    
    if (HNChangeUserInfoVCTypeNick == self.vcType){
        self.navigationItem.title = @"昵称";
        self.nickNameText.placeholder = @"请输入您的昵称";
        self.nickNameText.text = self.string;
        self.descLab.text = [NSString stringWithFormat:@"%ld/13",self.string.length];
    }
}

-  (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    // 直播间出现键盘的时候不需要页面向上滚动
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    manager.enableAutoToolbar = NO;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.enableAutoToolbar = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载数据
- (void)loadDataWithNickName:(NSString *)nickname{
//    NSDictionary *dic = @{@"user_nickname":nickname};
//
//    MBShow;
//    [HNRequestManager sendRequestWithRequestMethodType:HNRequestMethodTypePOST requestAPICode:SaveAccount refreshCache:NO requestParameters:dic success:^(id responseObject) {
//        MBHidden;
//        if (CODE!=0) {
//            [MBProgressHUD showError:responseObject[@"m"]];
//            return ;
//        }
//        [MBProgressHUD showSuccess:NSLocalizedString(@"mine_persion_sucess", nil) ];
//
        if (self.myBlock) {
            self.myBlock(nickname);
        }
        [self.navigationController popViewControllerAnimated:YES];
//
//
//    } faild:^(NSError *error) {
//        MBHidden;
//        if (error)
//        {
//            ERROR;
//        }
//    }];
}

- (void)loadDataWithIntro:(NSString *)intro{
//    NSDictionary *dic = @{
//                          @"user_intro" : intro
//                          };
//
//    MBShow;
//    [HNRequestManager sendRequestWithRequestMethodType:HNRequestMethodTypePOST requestAPICode:SaveAccount refreshCache:NO requestParameters:dic success:^(id responseObject) {
//        MBHidden;
//        if (CODE!=0) {
//            [MBProgressHUD showError:responseObject[@"m"]];
//            return ;
//        }
//        [MBProgressHUD showSuccess:NSLocalizedString(@"mine_persion_sucess", nil) ];
//
//        if (self.myBlock) {
//            self.myBlock(intro);
//        }
//
//        [self.navigationController popViewControllerAnimated:YES];
//
//    } faild:^(NSError *error) {
//        MBHidden;
//        if (error)
//        {
//            ERROR;
//        }
//    }];
}

#pragma mark - privateMetho
// 保存按钮
- (void)rightBarButtonItem:(UIBarButtonItem *)btn{
    [self.nickNameText resignFirstResponder];
    
    if (self.vcType == HNChangeUserInfoVCTypeNick){
        // 过滤字符串首尾的空格
        NSString *nickName = _nickNameText.text;
        nickName = [nickName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (nickName.length == 0){
            [MBProgressHUD showError:NSLocalizedString(@"mine_persion_noNick", nil) ];
            return;
        }
        [self loadDataWithNickName:self.nickNameText.text];
    }
    else{
        [self loadDataWithIntro:self.nickNameText.text];
    }
}

- (void)setString:(NSString *)string{
    _string = string;
    
    self.nickNameText.text = string;
}

#pragma mark ---- UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.vcType == HNChangeUserInfoVCTypeNick){
        // 不支持系统表情键盘
        if ([textField isFirstResponder]){
            if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]){
                [MBProgressHUD showError:NSLocalizedString(@"mine_persion_noemjio", nil) ];
                return NO;
            }
        }
        NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
        if (![string isEqualToString:tem])
        {
            [MBProgressHUD showError:NSLocalizedString(@"mine_persion_nickworng", nil) ];
            return NO;
        }
    }
    
    return YES;
}

- (void)textFieldChange:(UITextField *)textField{
    if (self.vcType == HNChangeUserInfoVCTypeNick){
        NSString *text = textField.text;
        
        if (textField.text.length > 13){
            [MBProgressHUD showError:NSLocalizedString(@"mine_persion_maxNick", nil)];
            textField.text = [textField.text substringToIndex:13];
            NSInteger  length = [textField.text length];
            _descLab.text =[NSString stringWithFormat:@"%ld/13",length];
        }else{
            NSInteger  length = [textField.text length];
            _descLab.text =[NSString stringWithFormat:@"%ld/13",length];
        }
    }
    else{
        if (textField.text.length > 32){
            [MBProgressHUD showError:NSLocalizedString(@"mine_persion_signMax", nil) ];
            textField.text = [textField.text substringToIndex:32];
        }
    }
}

#pragma mark - setUI

- (void)createView{
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.nickNameText];
    [self.view addSubview:self.descLab];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(Handle(34) + kSTATUSBAR_NAVIGATION_HEIGHT);
        make.height.mas_equalTo(Handle_height(30));
        make.leading.mas_equalTo(self.view).mas_offset(Handle(15));
        make.width.mas_equalTo(SCREEN_WIDTH-Handle(30));
    }];
    [self.nickNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView);
        make.left.mas_offset(Handle(15));
        make.right.mas_offset(-Handle(15));
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(Handle(10));
        make.trailing.mas_offset(-Handle(10));
    }];
}

#pragma mark ---- 懒加载
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColorFromHEXA(0xF6F6F6, 1);
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = Handle(15);
        _bgView.layer.borderWidth = Handle(1);
        _bgView.layer.borderColor = DefaultLineColor.CGColor;
    }
    return _bgView;
}

- (UITextField *)nickNameText{
    if (!_nickNameText) {
        _nickNameText = [[UITextField alloc] init];
        [_nickNameText addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        _nickNameText.text = self.string;
        _nickNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nickNameText.textColor = MainColor(1);
        _nickNameText.font = SystemFontSize(15);
    }
    return _nickNameText;
}

- (UILabel *)descLab{
    if(!_descLab){
        _descLab = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", SystemFontSize(12), [UIColor grayColor]);
    }
    return _descLab;
}

@end
