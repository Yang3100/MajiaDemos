//
//  KJCalculatorView.m
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/16.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJCalculatorView.h"
#import "KJCalculatorCell.h"
#import "KJCalculatorModel.h"
// 瀑布流
#import <CHTCollectionViewWaterfallLayout.h>

@interface KJCalculatorView()<CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,readwrite,strong) NSMutableArray *temps;
@property (nonatomic,readwrite,strong) UICollectionView *mainCollectionView;
@property (nonatomic,readwrite,strong) UILabel *resultLabel;

@end

@implementation KJCalculatorView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 创建自控制器
        [self _setupSubViews];

        // 布局子控件
        [self _makeSubViewsConstraints];
        /// 注册cell
        [self.mainCollectionView registerClass:[KJCalculatorCell class]
         forCellWithReuseIdentifier:@"KJCalculatorCell"];
        self.result = @"";
    }
    return self;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%ld",indexPath.row);
    switch (indexPath.row) {
        case 3: // +
            !self.addClicked?:self.addClicked();
            [self inputNum:@"+"];
            break;
        case 7: // -
            !self.subClicked?:self.subClicked();
            [self inputNum:@"-"];
            break;
        case 11: // 完成
            !self.completeClicked?:self.completeClicked(self.result);
            break;
        case 12: // .
            !self.dotClicked?:self.dotClicked();
            [self inputNum:@"."];
            break;
        case 14: // 删除
            !self.delClicked?:self.delClicked();
            [self inputNum:@"del"];
            break;
        case 13: // 0
            !self.numClicked?:self.numClicked(0);
            [self inputNum:@"0"];
            break;
        case 8: // 1
            !self.numClicked?:self.numClicked(1);
            [self inputNum:@"1"];
            break;
        case 9: // 2
            !self.numClicked?:self.numClicked(2);
            [self inputNum:@"2"];
            break;
        case 10: // 3
            !self.numClicked?:self.numClicked(3);
            [self inputNum:@"3"];
            break;
        case 4: // 4
            !self.numClicked?:self.numClicked(4);
            [self inputNum:@"4"];
            break;
        case 5: // 5
            !self.numClicked?:self.numClicked(5);
            [self inputNum:@"5"];
            break;
        case 6: // 6
            !self.numClicked?:self.numClicked(6);
            [self inputNum:@"6"];
            break;
        case 0: // 7
            !self.numClicked?:self.numClicked(7);
            [self inputNum:@"7"];
            break;
        case 1: // 8
            !self.numClicked?:self.numClicked(8);
            [self inputNum:@"8"];
            break;
        case 2: // 9
            !self.numClicked?:self.numClicked(9);
            [self inputNum:@"9"];
            break;
        default:
            break;
    }
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
/// 子类必须override
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    KJCalculatorModel *model = self.temps[indexPath.item];
    return CGSizeMake(model.width, model.height);
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.temps.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KJCalculatorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KJCalculatorCell" forIndexPath:indexPath];
    cell.cell_tag = indexPath.row;
    [cell configureModel:self.temps[indexPath.row]];
    return cell;
}

#pragma mark - 创建自控制器
- (void)_setupSubViews{
    /// create collectionViewLayout
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumColumnSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.columnCount = 4; // 每行个数
    layout.footerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.mainCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    //4.设置代理
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    [self addSubview:_mainCollectionView];
}

- (void)_makeSubViewsConstraints{
    UILabel *money = InsertLabel(self, CGRectZero, NSTextAlignmentCenter, @"金额:", SystemFontSize(16), [UIColor blackColor]);
    money.backgroundColor = MainColor(0.1);
    money.clipsToBounds = YES;
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Handle(40));
        make.width.mas_equalTo(Handle(50));
        make.left.mas_equalTo(self.mainCollectionView.mas_left).mas_offset(Handle(15));
        make.top.mas_equalTo(self.mainCollectionView.mas_top).mas_offset(-(SCREEN_HEIGHT-SCREEN_HEIGHT/3-kSTATUSBAR_NAVIGATION_HEIGHT));
    }];
    self.resultLabel = InsertLabel(self, CGRectZero, NSTextAlignmentLeft, @"0 元", SystemFontSize(18), MainColor(1));
    _resultLabel.backgroundColor = MainColor(0.1);
    _resultLabel.clipsToBounds = YES;
    [_resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Handle(40));
        make.left.mas_equalTo(money.mas_right);
        make.right.mas_equalTo(self.mainCollectionView.mas_right).mas_offset(Handle(-15));
        make.centerY.mas_equalTo(money);
    }];
    
}

- (NSMutableArray*)temps{
    if (!_temps) {
        _temps = [NSMutableArray array];
        NSArray *name = @[@"7",@"8",@"9",@"+",@"4",@"5",@"6",@"-",@"1",@"2",@"3",@"完成",@".",@"0",@"删除"];
        int a = (int)name.count;
        for (int i=0; i<a; i++) {
            KJCalculatorModel *model = [[KJCalculatorModel alloc] init];
            model.title = name[i];
            if (i==11) {
                model.width = self.frame.size.width/4;
                model.height = self.frame.size.height/2;
            }else{
                model.width = self.frame.size.width/4;
                model.height = self.frame.size.height/4;
            }
            [_temps addObject:model];
        }
    }
    return _temps;
}

#pragma mark - 计算器算法
- (void)inputNum:(NSString *)str{
    if ([str isEqualToString:@"del"]){
        self.result = [self removeLastOneChar:_result];
        if (_result.length==0) {
            self.result = @"0";
        }
        [self updateMemories];
        return;
    }
    
    if (_result.length>15) {
        return;
    }
    
    if ([str isEqualToString:@"."]){
        // 判断result 是否含有"."
        if([_result rangeOfString:@"."].location != NSNotFound){
            NSLog(@"yes");
            return;
        }else{
            self.result = [NSString stringWithFormat:@"%@%@",_result,str];
        }
        [self updateMemories];
        return;
    }
    if (![str isEqualToString:@"+"]&&![str isEqualToString:@"-"]) {
        if ([_result isEqualToString:@"0"]) {
            self.result = [self removeLastOneChar:_result];
        }
        self.result = [NSString stringWithFormat:@"%@%@",_result,str];
        [self updateMemories];
    }
}
- (void)updateMemories{
    !self.updateClicked?:self.updateClicked(self.result);
    self.resultLabel.text = [NSString stringWithFormat:@"%@ 元",_result];
}

// 删除最后一位
- (NSString*) removeLastOneChar:(NSString*)origin{
    NSString* cutted;
    if([origin length] > 0){
        cutted = [origin substringToIndex:([origin length]-1)];// 去掉最后一个","
    }else{
        cutted = origin;
    }
    return cutted;
}
//判断是否为整形
- (BOOL)isPureInt:(NSString*)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSString *)jiafa:(NSString *)inputa b:(NSString *)inputb{
    NSLog(@"is pure %d",[self isPureInt:inputa]);
    if ([self isPureInt:inputa] && [self isPureInt:inputb]) {
        return [NSString stringWithFormat:@"%d",[inputa intValue]+[inputb intValue]];
    }else{
        return [NSString stringWithFormat:@"%.2f",[inputa floatValue]+[inputb floatValue]];
    }
}
- (NSString *)jianfa:(NSString *)inputa b:(NSString *)inputb{
    NSLog(@"is pure %d",[self isPureInt:inputa]);
    if ([self isPureInt:inputa] && [self isPureInt:inputb]) {
        return [NSString stringWithFormat:@"%d",[inputa intValue]-[inputb intValue]];
    }else{
        return [NSString stringWithFormat:@"%.2f",[inputa floatValue]-[inputb floatValue]];
    }
}
// 加减运算
- (NSString *)calcSimpleFormula:(NSString *)formula {
    NSString *resultnum = @"0";
    char symbol = '+';
    int len = (int)formula.length;
    int numStartPoint = 0;
    for (int i = 0; i < len; i++) {
        char c = [formula characterAtIndex:i];
        if (c == '+' || c == '-') {
            NSString *num = [formula substringWithRange:NSMakeRange(numStartPoint, i - numStartPoint)];
            switch (symbol) {
                case '+':
                    resultnum = [self jiafa:resultnum b:num];
                    break;
                case '-':
                    resultnum = [self jianfa:resultnum b:num];
                    break;
                default:
                    break;
            }
            symbol = c;
            numStartPoint = i + 1;
        }
    }
    if (numStartPoint < len) {
        NSString *num = [formula substringWithRange:NSMakeRange(numStartPoint, len - numStartPoint)];
        switch (symbol) {
            case '+':
                resultnum = [self jiafa:resultnum b:num];
                break;
            case '-':
                resultnum = [self jianfa:resultnum b:num];
                break;
            default:
                break;
        }
    }
    return resultnum;
}
// 获取字符串中的后置数字
- (NSString *)lastNumberWithString:(NSString *)str {
    int numStartPoint = 0;
    for (int i = (int)str.length - 1; i >= 0; i--) {
        char c = [str characterAtIndex:i];
        if ((c < '0' || c > '9') && c != '.') {
            numStartPoint = i + 1;
            break;
        }
    }
    return [str substringFromIndex:numStartPoint];
}
// 获取字符串中的前置数字
- (NSString *)firstNumberWithString:(NSString *)str {
    int numEndPoint = (int)str.length;
    for (int i = 0; i < str.length; i++) {
        char c = [str characterAtIndex:i];
        if ((c < '0' || c > '9') && c != '.') {
            numEndPoint = i;
            break;
        }
    }
    return [str substringToIndex:numEndPoint];
}

@end
