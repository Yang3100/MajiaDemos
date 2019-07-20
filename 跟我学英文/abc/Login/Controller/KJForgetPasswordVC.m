//
//  KJForgetPasswordVC.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/19.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJForgetPasswordVC.h"
//#import "UITextField+banCopy.h"

@interface KJForgetPasswordVC ()

@property(nonatomic,strong) UILabel *iphoneLabel;
@property(nonatomic,strong) UITextField *iphoneText;   // 手机号
@property(nonatomic,strong) UILabel *codeLabel;
@property(nonatomic,strong) UITextField *codeText;     // 验证码
@property(nonatomic,strong) UILabel *passwordLabel;
@property(nonatomic,strong) UITextField *passwordText; // 密码
@property(nonatomic,strong) UIButton *eyeBtn;          // 密码是否为明文
@property(nonatomic,strong) UIButton *getCodeBut;      // 获取验证码
@property(nonatomic,strong) UIButton *nextButton;      // 下一步

@property(nonatomic,strong) UIView *line1;
@property(nonatomic,strong) UIView *line2;
@property(nonatomic,strong) UIView *line3;

@property(nonatomic, assign) int         time;//60s倒计时
@property(nonatomic, strong) NSTimer     *timer;


@end

@implementation KJForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
    
    self.navigationItem.title = @"忘记密码";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    button.size = button.currentBackgroundImage.size;
    [button sizeToFit];
    [button addTarget:self action:@selector(leftBarButtonItem) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];;
}

- (void)leftBarButtonItem{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getPhoneCode{
//    [MBProgressHUD showSuccess:@"获取验证码"];
//    [KJNetManager verificationCode:3 Phone:self.iphoneNum retry:^(id responseObj, NSError *error) {
//        if (CODE==0) {
//            [MBProgressHUD showError:responseObj[@"m"]];
//        }
//        else if (CODE==10013) {
//            [MBProgressHUD showError:responseObj[@"m"]];
//        }
//        else if (CODE==10015) {
//            [MBProgressHUD showError:@"60秒内不可重复申请"];
//        }
//        else if (CODE==22) {
//            [MBProgressHUD showError:responseObj[@"m"]];
//        }
//    }];
    [self setButtonTitleCountDown];
}

- (void)thouchDetermine{
    // 判断验证码是否为6位纯数字
//    NSString *codeNsstring = [KJTools filterSpace:self.codeText.text];
//    if (codeNsstring.length != 6) {
//        [MBProgressHUD showError:@"请输入正确的验证码"];
//        [self.codeText canResignFirstResponder];
//        return;
//    }
//
//    // 判断密码是否正确
//    NSString *passwordNsstring = [KJTools filterSpace:self.passwordText.text];
//    if (passwordNsstring.length < 6){
//        [MBProgressHUD showError:@"密码位数小于6位"];
//        [self.passwordText canResignFirstResponder];
//        return;
//    }
    
//    [KJNetManager changeIphone:self.iphoneNum Password:passwordNsstring Code:codeNsstring completionHandler:^(id responseObj, NSError *error) {
//        if (CODE==0) {
//            [MBProgressHUD showSuccess:@"修改成功！"];
//        }
//        else if (CODE==10014) {
//            [MBProgressHUD showError:responseObj[@"m"]];
//        }
//        else if (CODE==10013) {
//            [MBProgressHUD showError:responseObj[@"m"]];
//        }
//        else if (CODE==10015) {
//            [MBProgressHUD showError:responseObj[@"m"]];
//        }
//    }];
}

//- (void)thouchNext{
//    // 判断验证码是否为6位纯数字
//    NSString *codeNsstring = [KJTools filterSpace:self.codeText.text];
//    if (codeNsstring.length != 6) {
//        [MBProgressHUD showError:@"请输入正确的验证码"];
//        [self.codeText canResignFirstResponder];
//        return;
//    }
//
//    // 判断密码是否正确
//    NSString *passwordNsstring = [KJTools filterSpace:self.passwordText.text];
//    if (passwordNsstring.length <= 6){
//        [MBProgressHUD showError:@"密码位数小于6位"];
//        [self.passwordText canResignFirstResponder];
//        return;
//    }
//
//    NSLog(@"下一步!");
//
//}


#pragma mark - UITextField 字数限制
- (void)codeTextChange:(UITextField *)textField{
    if (textField == self.iphoneText) {
        if (textField.text.length>11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    else if (textField == self.codeText){
        if (textField.text.length > 6){  // 验证码6位
            textField.text = [textField.text substringToIndex:6];
        }
    }
    else if (textField == self.passwordText){  // 密码最长16位
        if (textField.text.length > 16){
            textField.text = [textField.text substringToIndex:16];
        }
//        if ([KJTools checkSpecialCharacter:textField.text]) {
//            _weakself;
//            [KJTools ShowOnlyAlertWith:@"密码输入错误" message:@"密码含有特殊字符" andSureTitle:@"取消" viewControl:self andSureBack:^{
//                [weakself.passwordText  canResignFirstResponder]; // 成为第一响应
//            }];
//        }
        
    }
    
    if (self.codeText.text.length == 6 && self.passwordText.text.length > 5 && self.iphoneText.text.length == 11){
        self.nextButton.backgroundColor = MainColor(1);
        self.nextButton.enabled = YES;
        self.nextButton.selected = YES;
    }
    else{
        self.nextButton.backgroundColor = BtnUnEnableBgColor;
        self.nextButton.enabled = NO;
        self.nextButton.selected = NO;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    // 开始编辑之前
    if (self.passwordText == textField){
        self.eyeBtn.hidden = NO;
    }
    else{
        self.eyeBtn.hidden = YES;
    }
}

// 是否显示密码
- (void)eyeBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == YES){
        self.passwordText.secureTextEntry = NO;
    }
    else{
        self.passwordText.secureTextEntry = YES;
    }
}

- (void)setButtonTitleCountDown{
    _time = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getCountDownText) userInfo:nil repeats:YES];
    self.getCodeBut.enabled = NO;
    self.getCodeBut.selected = NO;
    self.getCodeBut.backgroundColor =BtnUnEnableBgColor;
    self.getCodeBut.layer.borderColor = UIColorFromHEXA(0xCCCCCC, 1.0).CGColor;
    [self.getCodeBut setTitleColor:UIColorFromHEXA(0xCCCCCC, 1.0) forState:UIControlStateNormal];
    [self.getCodeBut setTitleColor:UIColorFromHEXA(0xbbbbbb, 1.0) forState:UIControlStateSelected];
}

// NSTimer Action
- (void)getCountDownText{
    _time--;
    NSString *timeStr = [NSString stringWithFormat:@"%ds",_time];
    [self.getCodeBut setTitle:timeStr forState:UIControlStateNormal];
    if (_time <= 0) {
        [self.getCodeBut setTitle:@"重发(60s)" forState:UIControlStateNormal];
        self.getCodeBut.backgroundColor =[UIColor whiteColor];
        self.getCodeBut.layer.borderColor = UIColorFromHEXA(0x000000, 1.0).CGColor;
        [self.getCodeBut setTitleColor:UIColorFromHEXA(0x000000, 1.0) forState:UIControlStateNormal];
        [self.getCodeBut setTitleColor:UIColorFromHEXA(0x000000, 1.0) forState:UIControlStateSelected];
        //取消定时器
        [_timer invalidate];
        _timer = nil;
        self.getCodeBut.enabled = YES;
        self.getCodeBut.selected = YES;
        
    }
}


#pragma mark - setUI
- (void)setUI{
    [self.iphoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(Handle(50+64));
        make.left.mas_equalTo(self.view).mas_offset(Handle(30));
        make.height.mas_equalTo(Handle(15));
    }];
    
    [self.iphoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iphoneLabel.mas_bottom).mas_offset(Handle(18));
        make.left.mas_equalTo(self.iphoneLabel);
        make.right.mas_equalTo(self.view).mas_offset(Handle(-15));
        make.height.mas_equalTo(Handle(13));
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iphoneText.mas_bottom).mas_offset(Handle(11));
        make.left.mas_equalTo(self.iphoneLabel);
        make.right.mas_equalTo(self.view).mas_offset(Handle(-15));
        make.height.mas_equalTo(Handle(1));
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line1.mas_bottom).mas_offset(Handle(15));
        make.left.mas_equalTo(self.iphoneLabel);
        make.height.mas_equalTo(Handle(13));
    }];
    
    [self.view addSubview:self.getCodeBut];
    [self.getCodeBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeLabel.mas_bottom).mas_offset(Handle(12));
        make.right.mas_equalTo(self.view).mas_offset(Handle(-15));
        make.height.mas_equalTo(Handle(26));
        make.width.mas_equalTo(Handle(70));
    }];
    
    [self.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeLabel.mas_bottom).mas_offset(Handle(18));
        make.left.mas_equalTo(self.iphoneLabel);
        make.right.mas_equalTo(self.getCodeBut.mas_left).mas_offset(Handle(-10));
        make.height.mas_equalTo(Handle(13));
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeText.mas_bottom).mas_offset(Handle(11));
        make.left.mas_equalTo(self.iphoneLabel);
        make.right.mas_equalTo(self.view).mas_offset(Handle(-15));
        make.height.mas_equalTo(Handle(1));
    }];
    
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line2.mas_bottom).mas_offset(Handle(15));
        make.left.mas_equalTo(self.iphoneLabel);
        make.height.mas_equalTo(Handle(13));
    }];
    
    [self.passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordLabel.mas_bottom).mas_offset(Handle(18));
        make.left.mas_equalTo(self.iphoneLabel);
        make.right.mas_equalTo(self.view).mas_offset(Handle(-15));
        make.height.mas_equalTo(Handle(13));
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordText.mas_bottom).mas_offset(Handle(11));
        make.left.mas_equalTo(self.iphoneLabel);
        make.right.mas_equalTo(self.view).mas_offset(Handle(-15));
        make.height.mas_equalTo(Handle(1));
    }];
    
    [self.view addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line3.mas_bottom).mas_offset(Handle(51));
        make.right.mas_equalTo(self.view).mas_offset(Handle(-32));
        make.left.mas_equalTo(self.view).mas_offset(Handle(32));
        make.height.mas_equalTo(Handle(40));
    }];
}

- (UILabel*)iphoneLabel{
    if (!_iphoneLabel) {
        _iphoneLabel = InsertLabel(self.view, CGRectZero, NSTextAlignmentLeft, @"", SystemFontSize(14), DefaultTitleColor);
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"  手机号" attributes:nil];
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        UIImage * smileImage = [UIImage imageNamed:@"login_phone"];
        textAttachment.image = smileImage;
        NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [string insertAttributedString:textAttachmentString atIndex:0];
        _iphoneLabel.attributedText = string;
    }
    return _iphoneLabel;
}
- (UITextField*)iphoneText{
    if (!_iphoneText) {
        _iphoneText = InsertTextFieldWithTextColor(self.view,self, CGRectZero, @"请输入手机号", SystemFontSize(14), NSTextAlignmentLeft, UIControlContentVerticalAlignmentCenter, UIColorFromHEXA(0xbbbbbb, 1));
        [_iphoneText setValue:UIColorFromHEXA(0x999999, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
        _iphoneText.keyboardType = UIKeyboardTypeNumberPad;
        _iphoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_iphoneText addTarget:self action:@selector(codeTextChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _iphoneText;
}
- (UILabel*)codeLabel{
    if (!_codeLabel) {
        _codeLabel = InsertLabel(self.view, CGRectZero, NSTextAlignmentLeft, @"", SystemFontSize(14), DefaultTitleColor);
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"  验证码" attributes:nil];
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        UIImage * smileImage = [UIImage imageNamed:@"login_Verification"];
        textAttachment.image = smileImage;
        NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [string insertAttributedString:textAttachmentString atIndex:0];
        _codeLabel.attributedText = string;
    }
    return _codeLabel;
}
- (UITextField*)codeText{
    if (!_codeText) {
        _codeText = InsertTextFieldWithTextColor(self.view,self, CGRectZero, @"请输入验证码", SystemFontSize(14), NSTextAlignmentLeft, UIControlContentVerticalAlignmentCenter, UIColorFromHEXA(0xbbbbbb, 1));
        [_codeText setValue:UIColorFromHEXA(0x999999, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
        _codeText.keyboardType = UIKeyboardTypeNumberPad;
        _codeText.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_codeText addTarget:self action:@selector(codeTextChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _codeText;
}
- (UILabel*)passwordLabel{
    if (!_passwordLabel) {
        _passwordLabel = InsertLabel(self.view, CGRectZero, NSTextAlignmentLeft, @"", SystemFontSize(14), DefaultTitleColor);
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"  新密码" attributes:nil];
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        UIImage * smileImage = [UIImage imageNamed:@"login_password"];
        textAttachment.image = smileImage;
        NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [string insertAttributedString:textAttachmentString atIndex:0];
        _passwordLabel.attributedText = string;
    }
    return _passwordLabel;
}
- (UITextField*)passwordText{
    if (!_passwordText) {
        _passwordText = InsertTextField(self.view, self, CGRectZero,@"请设置6-16位密码", SystemFontSize(14), NSTextAlignmentLeft, UIControlContentVerticalAlignmentCenter);
        _passwordText.textColor = UIColorFromHEXA(0xbbbbbb, 1);
        [_passwordText setValue:UIColorFromHEXA(0x999999, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
      //  _passwordText.keyboardType = UIKeyboardTypeDefault;
        _passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordText.keyboardType=UIKeyboardTypeASCIICapable;
        [_passwordText addTarget:self action:@selector(codeTextChange:) forControlEvents:UIControlEventEditingChanged];
        _passwordText.secureTextEntry = NO;  // 明文
    }
    return _passwordText;
}

- (UIButton *)eyeBtn{
    if (!_eyeBtn) {
        _eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyeBtn setImage:[UIImage imageNamed:@"login_off"] forState:UIControlStateNormal];
        [_eyeBtn setImage:[UIImage imageNamed:@"login_on"] forState:UIControlStateSelected];
        [_eyeBtn addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _eyeBtn.hidden = YES;
//        [_eyeBtn setEnlargeEdgeWithTop:10 right:5 bottom:10 left:10];
    }
    return _eyeBtn;
}


- (UIView*)line1{
    if (!_line1) {
        _line1 = InsertView(self.view, CGRectZero, UIColorFromHEXA(0xe8e8e8, 1));
    }
    return _line1;
}
- (UIView*)line2{
    if (!_line2) {
        _line2 = InsertView(self.view, CGRectZero, UIColorFromHEXA(0xe8e8e8, 1));
    }
    return _line2;
}
- (UIView*)line3{
    if (!_line3) {
        _line3 = InsertView(self.view, CGRectZero, UIColorFromHEXA(0xe8e8e8, 1));
    }
    return _line3;
}

- (UIButton*)getCodeBut{
    if (!_getCodeBut) {
        _getCodeBut = [UIButton buttonWithType: UIButtonTypeCustom];
        _getCodeBut.layer.cornerRadius = Handle(13);
        _getCodeBut.layer.masksToBounds = YES;
        _getCodeBut.layer.borderWidth = 1;
        _getCodeBut.layer.borderColor = UIColorFromHEXA(0xCCCCCC, 1.0).CGColor;
        [_getCodeBut setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBut setTitleColor:UIColorFromHEXA(0xCCCCCC, 1.0) forState:UIControlStateNormal];
        [_getCodeBut setTitleColor:UIColorFromHEXA(0xbbbbbb, 1.0) forState:UIControlStateSelected];
        [_getCodeBut addTarget:self action:@selector(getPhoneCode) forControlEvents:UIControlEventTouchUpInside];
        _getCodeBut.titleLabel.font = SystemFontSize(12);
    }
    return _getCodeBut;
}
- (UIButton*)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.layer.cornerRadius = Handle(20);
        _nextButton.layer.masksToBounds = YES;
        _nextButton.backgroundColor = UIColorFromHEXA(0xbbbbbb, 1.0);
        [_nextButton setTitle:@"确    定" forState:UIControlStateNormal];
        [_nextButton setTitleColor:UIColorFromHEXA(0xffffff, 1.0) forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(thouchDetermine) forControlEvents:UIControlEventTouchUpInside];
        _nextButton.titleLabel.font = SystemFontSize(16);
    }
    return _nextButton;
}

@end
