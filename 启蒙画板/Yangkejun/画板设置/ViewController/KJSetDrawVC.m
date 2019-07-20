//
//  KJSetDrawVC.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/24.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJSetDrawVC.h"
#import "KJModel.h"

@interface KJSetDrawVC ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    CGFloat fen,miao;
}

@property (weak, nonatomic) IBOutlet UIView *timeBackView;

@end

@implementation KJSetDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:self.timeBackView.bounds];
    pickerView.backgroundColor = [UIColor whiteColor];
    // 显示选中框
    pickerView.showsSelectionIndicator=YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self.timeBackView addSubview:pickerView];
    
//    self.timeBackView.userInteractionEnabled = YES;
//    pickerView.userInteractionEnabled = YES; // 打开用户交互(不可少)
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(SCREEN_WIDTH-42-70, 0, 70, 30);
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backButton setTitleColor:MainColor(1) forState:UIControlStateNormal];
    [backButton setTitle:@"确认" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [KJTools makeCornerRadius:8 borderColor:MainColor(0.8) layer:backButton.layer borderWidth:1];
    [self.timeBackView addSubview:backButton];
}

- (void)backButtonClick{
    [MBProgressHUD showSuccess:@"成功设置画板持续时间!!"];
    [[KJModel sharedInstance] retTime:fen+miao];
}

#pragma Mark -- UIPickerViewDataSource

// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component==0) {
        return 20;
    }else{
        return 60;
    }
}

#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return SCREEN_WIDTH/2-20;
}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (!component) { // 分
        fen = row*60;
    }else{
        miao = row+1;
    }
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return [NSString stringWithFormat:@"%ld 分",row];
    }else{
        return [NSString stringWithFormat:@"%ld 秒",row+1];
    }
}

- (IBAction)SelectDrawColor:(UIButton *)sender {
    [[KJModel sharedInstance] retColor:sender.tag];
    switch (sender.tag) {
        case 520:{
            [MBProgressHUD showSuccess:@"画笔颜色\"绿色\""];
        }
            break;
        case 521:{
            [MBProgressHUD showSuccess:@"画笔颜色\"黄色\""];
        }
            break;
        case 522:{
            [MBProgressHUD showSuccess:@"画笔颜色\"蓝色\""];
        }
            break;
        case 523:{
            [MBProgressHUD showSuccess:@"画笔颜色\"红色\""];
        }
            break;
        case 524:{
            [MBProgressHUD showSuccess:@"画笔颜色\"紫色\""];
        }
            break;
        case 525:{
            [MBProgressHUD showSuccess:@"画笔颜色\"黑色\""];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)SelectDrawSize:(UIButton *)sender {
    [[KJModel sharedInstance] retLineWitd:sender.tag];
    switch (sender.tag) {
        case 620:{
            [MBProgressHUD showSuccess:@"画笔尺寸\"小号\""];
        }
            break;
        case 621:{
            [MBProgressHUD showSuccess:@"画笔尺寸\"中号\""];
        }
            break;
        case 622:{
            [MBProgressHUD showSuccess:@"画笔尺寸\"大号\""];
        }
            break;
            
        default:
            break;
    }
}




@end
