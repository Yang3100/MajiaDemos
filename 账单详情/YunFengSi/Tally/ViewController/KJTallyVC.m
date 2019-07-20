//
//  KJTallyVC.m
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/16.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJTallyVC.h"
#import "KJCalculatorView.h"  // 计算器
#import "KJDisplayCollectionView.h"  // 类型选择
#import "KJScrollTextView.h"  // 纵向滚动文字
#import "KJTypeView.h"

#import "CGXPickerView.h"
#import "CGXPickerViewManager.h"

#import "KJHomeModel.h"
#import "FMDBMonthModel.h"

@interface KJTallyVC ()<KJScrollTextViewDelegate>{
    __block NSString *money;
    __block NSInteger moneyType;
    FBKVOController *KVOController;
}

@property(nonatomic,strong) KJCalculatorView *calculatorView;
@property(nonatomic,strong) KJDisplayCollectionView *priceView;//价格
@property(nonatomic,strong) UILabel *typeLabel;
@property(nonatomic,strong) KJScrollTextView *scrollTextView;
@property(nonatomic,strong) KJTypeView *typeView;//
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UILabel *remarkLabel;
@property(nonatomic,strong) CGXPickerViewManager *manager;
@property(nonatomic,strong) UILabel *yearLabel;
@property(nonatomic,strong) UITextField *remarkTextField;

@end

@implementation KJTallyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    money =@"0";
    moneyType = 0; // 默认为支出
    
    UIButton *backButton = InsertButtonRoundedRect(self.view, CGRectMake(Handle(15), kSTATUSBAR_HEIGHT+Handle(10), Handle(44), Handle(22)), 520, @"取消", self, @selector(_backItemDidClicked));
    backButton.tintColor = MainColor(1);
    UIButton *saveButton = InsertButtonRoundedRect(self.view, CGRectMake(SCREEN_WIDTH-Handle(44)-Handle(15), kSTATUSBAR_HEIGHT+Handle(10), Handle(44), Handle(22)), 521, @"保存", self, @selector(_savwItemDidClicked));
    saveButton.tintColor = MainColor(1);
    
    [self _setUI];
    
    [self _setData];
    
    // 添加键值观察
    /*
     1 观察者，负责处理监听事件的对象
     2 观察的属性
     3 观察的选项
     4 上下文
     */
    KVOController = [FBKVOController controllerWithObserver:self];
    [KVOController observe:self.calculatorView keyPath:@"result" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        self->money = change[NSKeyValueChangeNewKey];
    }];
}

- (void)dealloc{
    //删除监听器
    //方式一
    [KVOController unobserve:self.calculatorView];
}

- (void)_backItemDidClicked{ /// 回去
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)_savwItemDidClicked{ /// 保存
    CGFloat expendSum = 0.0,incomeSum = 0.0;
    if (moneyType) { // 收入
        incomeSum = [money floatValue];
    }else{
        expendSum = [money floatValue];
    }
    NSDictionary *dict = @{
                           @"expendSum":@(expendSum),
                           @"incomeSum":@(incomeSum),
                           @"remark":@"备注说明"
                           };
    NSArray *array = [self.yearLabel.text componentsSeparatedByString:@"-"]; //从字符A中分隔成2个元素的数组
    NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
    int month = [array[1] intValue];
    int tian = [array[2] intValue];
    NSString *day = [NSString stringWithFormat:@"%d号",tian];
    [[KJHomeModel sharedInstance] updateTableMonth:month Day:day keyValues:dict];
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"isReload" object:nil userInfo:nil];
    }];
}

- (void)_setData{
    NSArray *name = @[@"餐饮",@"电子设备",@"旅游",@"话费",@"交通",@"娱乐",@"学习",@"住宿",@"其他"];
    self.scrollTextView.textDataArr = name;
    // 开始滚动
    [_scrollTextView startScrollBottomToTopWithNoSpace];
}

#pragma mark - 执行触发的方法
- (void)event:(UITapGestureRecognizer *)gesture{
    // 设置数据
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *year = [self.yearLabel.text isEqualToString:@""]?nowStr:self.yearLabel.text;
    [self addYearPcikerView:year now:nowStr];
}

#pragma mark - KJScrollTextViewDelegate
- (void)scrollTextView:(KJScrollTextView *)scrollTextView currentTextIndex:(NSInteger)index{
    //    NSLog(@"当前是信息%ld",index);
}
- (void)scrollTextView:(KJScrollTextView *)scrollTextView clickIndex:(NSInteger)index content:(NSString *)content{
    NSLog(@"#####点击的是：第%ld条信息 内容：%@",index,content);
}

#pragma mark - 内部方法
- (void)addYearPcikerView:(NSString*)year now:(NSString*)nowstr{
    _weakself;
    [CGXPickerView showDatePickerWithTitle:@"消费时间" DateType:UIDatePickerModeDate DefaultSelValue:year MinDateStr:@"1900-05-20" MaxDateStr:nowstr IsAutoSelect:YES Manager:self.manager ResultBlock:^(NSString *selectValue) {
        weakself.yearLabel.text = [NSString stringWithFormat:@"  %@", [selectValue substringWithRange:NSMakeRange(0,10)]];
    }];
}
- (void)textFieldDidChange:(UITextField *)textField{
    
}

#pragma mark - setUI
- (void)_setUI{
    [self.view addSubview:self.calculatorView];
    [self.view addSubview:self.priceView];
    
    self.typeLabel = InsertLabel(self.view, CGRectZero, NSTextAlignmentLeft, @"消费类型", SystemFontSize(14), [UIColor lightGrayColor]);
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceView.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self.view).mas_offset(Handle(15));
        make.height.mas_equalTo(Handle(30));
    }];
    
    [self.view addSubview:self.scrollTextView];
    [self.scrollTextView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(self.priceView);
        make.right.mas_equalTo(self.view).mas_offset(-Handle(15));
        make.height.mas_equalTo(Handle(20));
        make.width.mas_equalTo(SCREEN_WIDTH/3);
    }];
    
    [self.view addSubview:self.typeView];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    line.alpha = 0.5;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.typeView.mas_bottom).mas_offset(Handle(15));
        make.left.mas_equalTo(self.view).mas_offset(Handle(15));
        make.width.mas_equalTo(self.typeLabel);
        make.height.mas_equalTo(Handle(1));
    }];
    
    self.timeLabel = InsertLabel(self.view, CGRectZero, NSTextAlignmentLeft, @"消费时间", SystemFontSize(14), [UIColor lightGrayColor]);
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self.view).mas_offset(Handle(15));
        make.height.mas_equalTo(Handle(30));
    }];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeLabel);
        make.left.mas_equalTo(self.view).mas_offset(Handle(90));
        make.right.mas_equalTo(self.view).mas_offset(Handle(-15));
        make.height.mas_equalTo(Handle(25));
    }];
    
    self.remarkLabel = InsertLabel(self.view, CGRectZero, NSTextAlignmentLeft, @"备注说明", SystemFontSize(14), [UIColor lightGrayColor]);
    [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self.view).mas_offset(Handle(15));
        make.height.mas_equalTo(Handle(30));
    }];
    [self.remarkTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.remarkLabel);
        make.left.mas_equalTo(self.view).mas_offset(Handle(90));
        make.right.mas_equalTo(self.view).mas_offset(Handle(-15));
        make.height.mas_equalTo(Handle(25));
    }];
    UIView *remarkLine = [UIView new];
    remarkLine.backgroundColor = [UIColor lightGrayColor];
    remarkLine.alpha = 0.5;
    [self.remarkTextField addSubview:remarkLine];
    [remarkLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.remarkTextField.mas_bottom).mas_offset(Handle(-1));
        make.left.mas_equalTo(self.remarkTextField);
        make.width.mas_equalTo(self.remarkTextField);
        make.height.mas_equalTo(Handle(1));
    }];
}

- (KJCalculatorView*)calculatorView{
    if (!_calculatorView) {
        _calculatorView = [[KJCalculatorView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-SCREEN_HEIGHT/3, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
        _calculatorView.backgroundColor = [UIColor redColor];
        _weakself;
        _calculatorView.completeClicked = ^(NSString *str) {
            self->money = str;
            CGFloat expendSum = 0.0,incomeSum = 0.0;
            if (self->moneyType) { // 收入
                incomeSum = [self->money floatValue];
            }else{
                expendSum = [self->money floatValue];
            }
            NSDictionary *dict = @{
                                   @"expendSum":@(expendSum),
                                   @"incomeSum":@(incomeSum),
                                   @"remark":@"备注说明"
                                   };
            NSArray *array = [weakself.yearLabel.text componentsSeparatedByString:@"-"]; //从字符A中分隔成2个元素的数组
            NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
            int month = [array[1] intValue];
            int tian = [array[2] intValue];
            NSString *day = [NSString stringWithFormat:@"%d号",tian];
            [[KJHomeModel sharedInstance] updateTableMonth:month Day:day keyValues:dict];

            [weakself dismissViewControllerAnimated:YES completion:^{            
                [[NSNotificationCenter defaultCenter] postNotificationName:@"isReload" object:nil userInfo:nil];
            }];
        };
    }
    return _calculatorView;
}

- (KJDisplayCollectionView*)priceView{
    if (!_priceView){
        _priceView = [[KJDisplayCollectionView alloc]initWithFrame:CGRectMake(Handle(15), Handle(40)+kSTATUSBAR_NAVIGATION_HEIGHT+Handle(10), SCREEN_WIDTH-Handle(30), SCREEN_WIDTH/6/3)];
        _priceView.updateClicked = ^(NSInteger index) {
            self->moneyType = index;
        };
    }
    return _priceView;
}

- (KJScrollTextView*)scrollTextView{
    if (!_scrollTextView){
        _scrollTextView = [[KJScrollTextView alloc] init];
        _scrollTextView.backgroundColor = MainColor(0.1);
        _scrollTextView.delegate            = self;
        _scrollTextView.textStayTime        = 2;
        _scrollTextView.scrollAnimationTime = 0.5;
        _scrollTextView.textColor           = MainColor(0.7);
        _scrollTextView.textFont            = [UIFont boldSystemFontOfSize:15.f];
        _scrollTextView.textAlignment       = NSTextAlignmentLeft;
        _scrollTextView.touchEnable         = YES;
    }
    return _scrollTextView;
}

- (KJTypeView*)typeView{
    if (!_typeView) {
        _typeView = [[KJTypeView alloc] initWithFrame:CGRectMake(Handle(90), self.priceView.bottom+Handle(20), SCREEN_WIDTH-Handle(90)-Handle(15), SCREEN_HEIGHT/3-Handle(60))];
        _typeView.backgroundColor = [UIColor whiteColor];
        [KJTools makeCornerRadius:Handle(5) borderColor:[UIColor lightGrayColor] layer:_typeView.layer borderWidth:Handle(1)];
    }
    return _typeView;
}

- (UILabel*)yearLabel{
    if (!_yearLabel) {
        _yearLabel = InsertLabel(self.view, CGRectZero, NSTextAlignmentLeft, @"  2018-10-10", SystemBoldFontSize(12), DefaultLineColor);
        [KJTools makeCornerRadius:Handle(5) borderColor:[UIColor lightGrayColor] layer:_yearLabel.layer borderWidth:Handle(1)];
        //添加手势
        _yearLabel.userInteractionEnabled = YES; // 打开用户交互(不可少)
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
        //将手势添加到需要相应的view中去
        [_yearLabel addGestureRecognizer:tapGesture];
        //选择触发事件的方式（默认单机触发）
        [tapGesture setNumberOfTapsRequired:1];
    }
    return _yearLabel;
}

- (CGXPickerViewManager*)manager{
    if (!_manager) {
        _manager = [[CGXPickerViewManager alloc]init];
        _manager.kPickerViewH = Handle(236);
        _manager.kTopViewH = Handle(45);
        _manager.pickerTitleSize = 15;
        _manager.pickerTitleColor = DefaultTitleColor;
        _manager.lineViewColor = UIColorFromHEXA(0xaaaaaa, 1.0);
        
        _manager.titleLabelColor = CGXPickerRGBColor(252, 96, 134, 1);
        _manager.titleSize = 16;
        _manager.titleLabelBGColor = [UIColor whiteColor];
        
        _manager.rightBtnTitle = @"确定";
        _manager.rightBtnBGColor =  UIColorFromHEXA(0xffffff, 1.0);
        _manager.rightBtnTitleSize = 16;
        _manager.rightBtnTitleColor = DefaultTitleColor;
        _manager.isDisplayRightButton = YES;
        
        _manager.rightBtnborderColor = UIColorFromHEXA(0xffffff, 1.0);
        _manager.rightBtnCornerRadius = 6;
        _manager.rightBtnBorderWidth = 1;
        
        _manager.leftBtnTitle = @"取消";
        _manager.leftBtnBGColor =  CGXPickerRGBColor(252, 96, 134, 1);
        _manager.leftBtnTitleSize = 16;
        _manager.leftBtnTitleColor = [UIColor whiteColor];
        _manager.isDisplayLeftButton = NO;
        
        _manager.leftBtnborderColor = CGXPickerRGBColor(252, 96, 134, 1);
        _manager.leftBtnCornerRadius = 6;
        _manager.leftBtnBorderWidth = 1;
    }
    return _manager;
}

- (UITextField*)remarkTextField{
    if (!_remarkTextField) {
        _remarkTextField = InsertTextFieldWithTextColor(self.view,self, CGRectZero, @"说点说明吧~", SystemFontSize(14), NSTextAlignmentLeft, UIControlContentVerticalAlignmentCenter, [UIColor lightGrayColor]);
        _remarkTextField.keyboardType = UIKeyboardTypeDefault;
        _remarkTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _remarkTextField;
}


@end
