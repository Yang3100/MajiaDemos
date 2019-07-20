//
//  KJBirthVC.m
//  HawkeyeLive
//
//  Created by 杨科军 on 2018/5/22.
//  Copyright © 2018年 HN. All rights reserved.
//

#import "KJBirthVC.h"
#import "CGXPickerView.h"
#import "CGXPickerViewManager.h"

@interface KJBirthVC ()

@property(nonatomic,strong) CGXPickerViewManager *manager;
@property(nonatomic,strong) UILabel *yearLabel;
@property(nonatomic,strong) UIView *yearBackView;  // 年龄背景图
@property(nonatomic,strong) UILabel *constellationLabel;
@property(nonatomic,strong) UIView *constellationBackView;  // 星座背景图

@property(nonatomic,copy) NSString *lastString;

@end

@implementation KJBirthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"出生日期";
    self.view.theme_backgroundColor = @"block_bg";
    
    [self setUI];
    [self addRightBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRightBtn {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    rightBarItem.tintColor = MainColor(1);
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)onClickedOKbtn {
//    [KJNetManager setMeInfoNickname:nil Avatar:nil Sex:nil Birth:self.lastString Country:nil State:nil City:nil Region:nil CoverImage:nil completionHandler:^(id responseObj, NSError *error) {
//        if (CODE==0) {
//            MBScuess(@"保存成功!");
//            // 不想每次进入我的界面就请求数据，这里扔个通知过去同步处理个人资料数据
//            NSDictionary *dict = @{@"birth":self.lastString};
//            [[NSNotificationCenter defaultCenter] postNotificationName:Me_changed_info_data object:nil userInfo:dict];
//            // 通过回调传输数据出去
//            if (self.sucessBlock) {
//                self.sucessBlock(self.lastString);
//            }
//            [self.navigationController popViewControllerAnimated:YES];
//
//        }
//    }];
}

- (void)setBirthTime:(NSString *)birthTime{
    _birthTime = birthTime;
    self.lastString = _birthTime;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.yearLabel.text = [KJTools getAgeFormYear:birthTime];
        self.constellationLabel.text = [KJTools getAstroWithMonth:birthTime];
    });
    // 设置数据
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *year = [birthTime isEqualToString:@""]?nowStr:birthTime;
    [self addYearPcikerView:year now:nowStr];
}

- (void)addYearPcikerView:(NSString*)year now:(NSString*)nowstr{
    _weakself;
    [CGXPickerView showDatePickerWithTitle:@"" DateType:UIDatePickerModeDate DefaultSelValue:year MinDateStr:@"1900-05-20" MaxDateStr:nowstr IsAutoSelect:YES Manager:self.manager ResultBlock:^(NSString *selectValue) {
        weakself.lastString = [selectValue substringWithRange:NSMakeRange(0,10)];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.yearLabel.text = [KJTools getAgeFormYear:weakself.lastString];
            weakself.constellationLabel.text = [KJTools getAstroWithMonth:weakself.lastString];
        });
    }];
}

#pragma mark - 执行触发的方法
- (void)event:(UITapGestureRecognizer *)gesture{
    // 设置数据
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *year = [self.lastString isEqualToString:@""]?nowStr:_lastString;
    [self addYearPcikerView:year now:nowStr];
}

#pragma mark - setUI
- (void)setUI{
    [self.yearBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(Handle(16+64));
        make.left.mas_equalTo(self.view).mas_offset(Handle(15));
        make.width.mas_equalTo(SCREEN_WIDTH-Handle(30));
        make.height.mas_equalTo(Handle(30));
    }];
    [self.constellationBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yearBackView.mas_bottom).mas_offset(Handle(10));
        make.left.mas_equalTo(self.view).mas_offset(Handle(15));
        make.width.mas_equalTo(SCREEN_WIDTH-Handle(30));
        make.height.mas_equalTo(Handle(30));
    }];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.yearBackView).mas_offset(Handle(-20));
        make.height.mas_equalTo(Handle(12));
        make.centerY.mas_equalTo(self.yearBackView.centerY);
    }];
    [self.constellationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.constellationBackView).mas_offset(Handle(-20));
        make.height.mas_equalTo(Handle(12));
        make.centerY.mas_equalTo(self.constellationBackView.centerY);
    }];
}

- (UIView*)yearBackView{
    if (!_yearBackView) {
        _yearBackView = InsertView(self.view, CGRectZero, UIColorFromHEXA(0xF6F6F6, 1.0));
        _yearBackView.layer.masksToBounds = YES;
        _yearBackView.layer.cornerRadius = Handle(15);
        _yearBackView.layer.borderWidth = Handle(1);
        _yearBackView.layer.borderColor = MainColor(1).CGColor;
        UILabel *labe = InsertLabel(_yearBackView, CGRectZero, NSTextAlignmentLeft, @"年龄", SystemFontSize(12), DefaultTitleColor);
        CGFloat w = [KJTools calculateTextWidthWithText:@"年龄" andFont:SystemFontSize(14)];
        labe.frame = CGRectMake(Handle(15), Handle(9), w, Handle(12));
        
        //添加手势
        _yearBackView.userInteractionEnabled = YES; // 打开用户交互(不可少)
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
        //将手势添加到需要相应的view中去
        [_yearBackView addGestureRecognizer:tapGesture];
        //选择触发事件的方式（默认单机触发）
        [tapGesture setNumberOfTapsRequired:1];
    }
    return _yearBackView;
}

- (UIView*)constellationBackView{
    if (!_constellationBackView) {
        _constellationBackView = InsertView(self.view, CGRectZero, UIColorFromHEXA(0xF6F6F6, 1.0));
        _constellationBackView.layer.masksToBounds = YES;
        _constellationBackView.layer.cornerRadius = Handle(15);
        _constellationBackView.layer.borderWidth = Handle(1);
        _constellationBackView.layer.borderColor = MainColor(1).CGColor;
        UILabel *labe = InsertLabel(_constellationBackView, CGRectZero, NSTextAlignmentLeft, @"星座", SystemFontSize(12), DefaultTitleColor);
        CGFloat w = [KJTools calculateTextWidthWithText:@"星座" andFont:SystemFontSize(14)];
        labe.frame = CGRectMake(Handle(15), Handle(9), w, Handle(12));
    }
    return _constellationBackView;
}

- (UILabel*)yearLabel{
    if (!_yearLabel) {
        _yearLabel = InsertLabel(self.yearBackView, CGRectZero, NSTextAlignmentRight, @"108岁", SystemBoldFontSize(12), DefaultLineColor);
    }
    return _yearLabel;
}

- (UILabel*)constellationLabel{
    if (!_constellationLabel) {
        _constellationLabel = InsertLabel(self.constellationBackView, CGRectZero, NSTextAlignmentRight, @"蛇夫座", SystemBoldFontSize(12), DefaultLineColor);
    }
    return _constellationLabel;
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

@end
