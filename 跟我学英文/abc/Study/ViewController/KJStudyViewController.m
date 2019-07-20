//
//  KJStudyViewController.m
//  跟我学英文
//
//  Created by 杨科军 on 2018/12/3.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJStudyViewController.h"
#import "KJWordsCheckButton.h"
#import "NSString+StringToWords.h"
#import "KJWordButton.h"

@interface KJStudyViewController (){
    __block NSString *_answer;
    NSMutableArray *_allAddButtons,*_chooseBtnIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet KJWordsCheckButton *checkBtn;

@end

@implementation KJStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"开始学英语";
    
    /// 去掉返回文字
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem kj_ItemWithImage:@"Arrow" HighImage:@"" Title:@"  " TitleColor:UIColor.clearColor Target:self Action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem kj_ItemWithImage:@"" HighImage:@"" Title:@"  刷新  " TitleColor:UIColor.blackColor Target:self Action:@selector(update)];
    
    [self setUI];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)update{
    [self _setData];
}

- (void)setUI{
    _allAddButtons = [NSMutableArray array];
    _chooseBtnIndex = [NSMutableArray array];
    [self _setData];
    
    self.checkBtn.endEditBlock = ^(NSString *text){
        NSLog(@"end text:%@",text);
        if ([text isEqualToString:self->_answer]) {
            self.checkBtn.btnType = KJBtnTypeRight;
            [self.checkBtn setTitle:self->_answer forState:UIControlStateNormal];
            [self isRight];
        }else{
            self.checkBtn.btnType = KJBtnTypeEorror;
            [self.checkBtn setTitle:self->_answer forState:UIControlStateNormal];
            [self isError];
        }
    };
}

#pragma mark - 结算界面
- (void)isRight{
    KJEmitterView *em = [KJEmitterView createEmitterViewWithType:(KJEmitterTypeFireworks) Block:^(KJEmitterView *obj) {
        obj.KJFrame(self.view.bounds).KJAddView([UIApplication sharedApplication].keyWindow).KJBackgroundColor([UIColor.blackColor colorWithAlphaComponent:0.5]);
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 50)];
    label.center = self.view.center;
    label.text = _answer;
    label.textColor = [UIColor colorWithRed:96/255.0 green:189/255.0 blue:250/255.0 alpha:0.8];
    label.font = [UIFont systemFontOfSize:40];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    //  延时执行
    int64_t delayInSeconds = 3.0; // 延迟的时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [em removeFromSuperview];
        [label removeFromSuperview];
        [UIView animateWithDuration:0.5 animations:^{
            [self _setData];
        }];
    });
}

- (void)isError{
    KJErrorView *em = [KJErrorView createErrorView:^(KJErrorView * _Nonnull obj) {
        obj.KJFrame(self.view.bounds).KJAddView([UIApplication sharedApplication].keyWindow).KJBackgroundColor([UIColor.whiteColor colorWithAlphaComponent:0.3]);
    }];
    em.delayTime = 1.0;
    //  延时执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, em.delayTime * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self->_currentIndex -= 1;
        [UIView animateWithDuration:0.5 animations:^{
            [self _setData];
        }];
    });
}

- (void)_setSubview{
    for (KJWordButton* btn in _allAddButtons) {
        [btn removeFromSuperview];
    }
    [_allAddButtons removeAllObjects];
    //计算可显示button的区域
    CGFloat rectTopY = self.tipLabel.frame.origin.y + self.tipLabel.frame.size.height + 50;
    
    CGRect showRect;
    showRect.origin.x = 15;
    showRect.origin.y = rectTopY;
    showRect.size.width = kScreenWidth - 30;
    showRect.size.height = kScreenHeight - rectTopY - self.checkBtn.frame.size.height - 30;
    
    NSArray* words = [_answer words];
    NSInteger count = 0;
    for (int i = 0; i < 100; i ++) {
        if ((i - 1) * (i - 1) <= words.count && i * i > words.count) {
            count = i;
            break;
        }
    }
    NSLog(@"count :%ld",count);
    CGFloat width = showRect.size.width / (float)count;
    CGFloat height = showRect.size.height / (float)count;
    CGFloat length = width < height ? width : height;
//    length = length * 0.8;
    NSMutableArray* rectArray = [NSMutableArray array];
    for (int j = 0; j < count * count; j ++) {
        CGRect rect;
        CGFloat ratio;
        if (width < height) {
            ratio = height - width;
            CGFloat randRatio = arc4random() % 2;
            rect = CGRectMake(showRect.origin.x + j / count * width, showRect.origin.y + j % count * height + randRatio * ratio, length, length);
        }else{
            ratio = width - height;
            CGFloat randRatio = arc4random() % 2;
            rect = CGRectMake(showRect.origin.x + j / count * width + randRatio * ratio, showRect.origin.y + j % count * height, length, length);
        }
        NSValue* value = [NSValue valueWithCGRect:rect];
        [rectArray addObject:value];
    }
    //从所有的数组中选取响应的位置
    NSMutableArray* showRectArray = [NSMutableArray array];
    do{
        NSInteger index = arc4random() % rectArray.count;
        NSValue* value = rectArray[index];
        if (![showRectArray containsObject:value]) {
            [showRectArray addObject:value];
        }
    }while (showRectArray.count < words.count);
    
    for (int a = 0; a < showRectArray.count; a ++) {
        NSValue *value = showRectArray[a];
        KJWordButton *wordButton = [[KJWordButton alloc]initWithFrame:[value CGRectValue]];
        wordButton.fromPosition = wordButton.center;
        wordButton.layer.masksToBounds = YES;
        wordButton.layer.cornerRadius = CGRectGetHeight(wordButton.frame) * 0.5;
        [wordButton setBackgroundColor:[UIColor colorWithRed:96/255.0 green:189/255.0 blue:250/255.0 alpha:1.0]];
        [wordButton setTitle:words[a] forState:UIControlStateNormal];
        wordButton.titleLabel.font = [UIFont systemFontOfSize:30];
        wordButton.tag = a;
        [wordButton addTarget:self action:@selector(ClickWordButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:wordButton];
        [_allAddButtons addObject:wordButton];
    }
}

#pragma mark - setData
- (void)_setData{
    _checkBtn.btnType = KJBtnTypeNomal;
    KJHomeModel *model = self.modelArray[_currentIndex];
    _titleLabel.text = model.chinese;
    _answer = model.english;
    _checkBtn.answer = _answer;
    [_chooseBtnIndex removeAllObjects];
    [self _setSubview];
    _currentIndex ++;
    if (_currentIndex == self.modelArray.count) {
        _currentIndex = 0;
    }
}

#pragma mark - 处理事件
- (void)ClickWordButton:(KJWordButton* )sender{
    NSLog(@"button tag:%ld",sender.tag);
    NSArray *words = [_answer words];
    NSString *word = words[sender.tag];
    _checkBtn.content = [_checkBtn.content stringByAppendingString:word];
    [_chooseBtnIndex addObject:[NSNumber numberWithInteger:sender.tag]];
    //计算button的终点位置
    float xRatio = [self getOriginXWithNum:words.count Index:_chooseBtnIndex.count];
    float yRatio = _checkBtn.center.y;
    sender.toPosition = CGPointMake(xRatio, yRatio);
    [sender animationDismiss];
}

- (float)getOriginXWithNum:(NSInteger)num Index:(NSInteger)index{
    float codeViewWidth = 0.0;
    //计算codeView的宽度
    if (num > kBaseLineNum) {
        codeViewWidth = kScreenWidth * 0.8;
    }else{
        codeViewWidth = kScreenWidth * 0.8 / kBaseLineNum * num;
    }
    //计算起点位置(codeView的起点位置 + 每个显示字符长度的一半)
    float codeOriginX = (kScreenWidth - codeViewWidth) * 0.5 + codeViewWidth / num * (index - 0.45);
    return codeOriginX;
}

- (IBAction)ClickWordsCheckButton:(KJWordsCheckButton *)sender {
    //为了保证动画显示完整 点击之后动画显示时间 不能再次点击
    if (sender.content.length > 0) {
        sender.enabled = NO;
        NSString* content = sender.content;
        sender.content = [content substringToIndex:content.length - 1];
        NSInteger index = [[_chooseBtnIndex lastObject] integerValue];
        [_chooseBtnIndex removeLastObject];
        KJWordButton* btn = _allAddButtons[index];
        [btn animationShow];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            sender.enabled = YES;
        });
    }
}


@end
