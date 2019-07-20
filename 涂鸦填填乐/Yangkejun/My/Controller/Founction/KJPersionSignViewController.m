//
//  KJPersionSignViewController.m
//  OptimalLive
//
//  Created by 杨科军 on 2017/10/20.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import "KJPersionSignViewController.h"

@interface KJPersionSignViewController ()<UITextViewDelegate>

@property (nonatomic, strong)UITextView  *remarkTextView;//备注

@end

@implementation KJPersionSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.theme_backgroundColor = @"block_bg";
    
    self.navigationItem.title = NSLocalizedString(@"修改个人签名", nil) ;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:nil highImage:nil title:NSLocalizedString(@"保存", nil) titleColor:[UIColor whiteColor] target:self action:@selector(rightBarButtonItem:)];
    [self creatView];
}
-  (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    // 直播间出现键盘的时候不需要页面向上滚动
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = NO;
//    manager.enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;
//    manager.enableAutoToolbar = YES;
}

- (void)setInfro:(NSString *)infro{
    self.remarkTextView.zw_placeHolder = infro;
}

- (void)rightBarButtonItem:(UIButton*)rightBut{
//
//    NSDictionary *dic = @{
//                          @"user_intro" : self.textView.text
//                          };
//    [KJRequestManager sendRequestWithRequestMethodType:KJRequestMethodTypePOST requestAPICode:SaveAccount refreshCache:NO requestParameters:dic success:^(id responseObject) {
//        MBHidden;
//        if (CODE!=0) {
//            [MBProgressHUD showError:responseObject[@"m"]];
//            return ;
//        }
//        [MBProgressHUD showSuccess:NSLocalizedString(@"mine_persion_sucess", nil) ];
//
        if (self.myBlock) {
            self.myBlock(self.remarkTextView.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
//
//    } faild:^(NSError *error) {
//        MBHidden;
//        if (error)
//        {
//            ERROR;
//        }
//    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // 不支持系统表情键盘
    if ([textView isFirstResponder]){
        if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage]){
            [MBProgressHUD showError:NSLocalizedString(@"不支持表情", nil) ];
            return NO;
        }
    }
    NSString *tem = [[text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if (![text isEqualToString:tem]){
        [MBProgressHUD showError:NSLocalizedString(@"mine_persion_sginworng", nil) ];
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 32){
        [MBProgressHUD showError:NSLocalizedString(@"mine_persion_signMax", nil) ];
        textView.text = [textView.text substringToIndex:32];
    }
}
- (void)creatView{
    [self.view addSubview:self.remarkTextView];
    [self.remarkTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).mas_offset(Handle(15));
        make.trailing.mas_equalTo(self.view).mas_offset(-Handle(15));
        make.top.mas_equalTo(self.view).mas_offset(kSTATUSBAR_NAVIGATION_HEIGHT+ Handle(15));
        make.height.mas_equalTo(Handle(200));
    }];
}

- (UITextView *)remarkTextView{
    if (!_remarkTextView){
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
        textView.theme_backgroundColor = @"block_bg";
        textView.font = [UIFont systemFontOfSize:14];
        //文字设置居右、placeHolder会跟随设置
        textView.textAlignment = NSTextAlignmentLeft;
        textView.zw_limitCount = 50;
        textView.zw_labHeight = 12;
        textView.zw_labMargin = 5;
        textView.zw_labFont = [UIFont systemFontOfSize:12];
        textView.zw_placeHolderColor = [UIColor lightGrayColor];
        [KJTools makeCornerRadius:Handle(5) borderColor:MainColor(1) layer:textView.layer borderWidth:1];
        _remarkTextView = textView;
    }
    return _remarkTextView;
}

@end
