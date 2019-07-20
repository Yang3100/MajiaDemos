//
//  KJSetDrawVC.m
//  专属橱窗
//
//  Created by 杨科军 on 2018/10/25.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJSetDrawVC.h"
#import "KJMapBankModel.h"
#import "UIColor+TDAdditions.h"
#import <AVFoundation/AVFoundation.h>
#import "Reward.h"

@interface KJSetDrawVC (){
    UIColor *currentColor;
    NSInteger imageIndex;
    UIImage *lastImage;
    NSMutableArray<KJMapBankModel*> *selectViewArray;
    
    AVAudioPlayer *myBackMusic;
    AVAudioPlayer *clickMusic;
    AVAudioPlayer *judgeMusic;
    
    NSTimer *timer;
    
    NSInteger maxThouchNum;
}

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *SelectLabel;

@property(nonatomic,assign) NSInteger sureColorNum;
@property(nonatomic,assign) NSInteger errorColorNum;

@end

@implementation KJSetDrawVC

- (instancetype)initWithOldImage:(UIImage*)oldImage{
    if (self==[super init]) {
        lastImage = oldImage;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    myBackMusic = nil;
    timer = nil;
}

- (void)dealloc{
    myBackMusic = nil;
    timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.theme_backgroundColor = @"block_bg";
    self.title = @"色彩大淘沙";
    
    selectViewArray = [NSMutableArray array];
    
    // hide sys navBar
    self.fd_prefersNavigationBarHidden = NO;
    // 去掉侧滑pop手势
    self.fd_interactivePopDisabled = YES;
    
    [self setUI];
    
//    self.navigationItem.rightBarButtonItem  = [UIBarButtonItem itemWithImage:@"shouchang" highImage:nil title:@"" titleColor:nil target:self action:@selector(onClickedOKbtn)];
    maxThouchNum = 0;
    __block int index = 0;
//    __block NSArray *ca = [self colors:_imageColors];
    // 主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        // 遍历父视图
        for (UIView *sender in self.view.subviews) {
            if (sender.tag>=520) {  // 筛选出颜色button
                index++;
                KJMapBankModel *model = self->selectViewArray[sender.tag-520];
                model.saveButton = (UIButton*)sender;
                if (self.imageColors.count-1>=index) { // 正确值
                    model.isTureAnswer = YES;
                    sender.backgroundColor = self.imageColors[index];
                }else{
                    model.isTureAnswer = NO;
                    sender.backgroundColor = [self ranmandColor];
                }
            }
        }
    });
    
    [self begion];
}

#pragma mark - 富文本部分字体飘灰
- (NSMutableAttributedString *)setupAttributeString:(NSString *)text highlightText:(NSString *)highlightText {
    NSRange hightlightTextRange = [text rangeOfString:highlightText];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    if (hightlightTextRange.length > 0) {
        [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:hightlightTextRange];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0f] range:hightlightTextRange];
        return attributeStr;
    }else {
        return [highlightText copy];
    }
}


- (UIColor*)ranmandColor{
    int R = (arc4random() % 256);
    int G = (arc4random() % 256);
    int B = (arc4random() % 256);
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}

- (NSArray*)colors:(NSArray*)arr{
    NSMutableArray *a = [NSMutableArray arrayWithObjects:arr, nil];
    while (a.count<15) {
        [a addObject:[self ranmandColor]];
    }
    return a;
}

- (void)begion{
    // 播放音乐
    [self music];
    __block int gameTime = 30;
    // 开启计时器
    _weakself;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        gameTime -= 1;
        // UI更新代码
        weakself.TimeLabel.text = [[NSString alloc] initWithFormat:@"倒计时: %d秒",gameTime];
        if (gameTime <= 0){
            [timer invalidate];
            timer = nil;
            weakself.TimeLabel.text = @"游戏时间到!!!";
            [self->myBackMusic pause];   // 停止音乐
        }
    } repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:tim forMode:NSRunLoopCommonModes];
    
}

- (void)onClickedOKbtn {
//    [[KJShowcaseModel sharedInstance] saveImage:self.bigImageView.image OldName:@""];
    [MBProgressHUD showSuccess:NSLocalizedString(@"收藏作品成功~^.^", nil)];
}

- (void)setUI{
    for (int i = 0; i<15; i++) {
        UIView *indicatorView = [[UIView alloc] init];
        indicatorView.backgroundColor = [UIColor clearColor];
        indicatorView.userInteractionEnabled = YES;
        [self.view addSubview:indicatorView];
        KJMapBankModel *model = [[KJMapBankModel alloc]init];
        model.indicatorView = indicatorView;
        [selectViewArray addObject:model];
    }
    
    UILabel *iconLabel = InsertLabel(self.view, CGRectZero, NSTextAlignmentRight, kAppName, SystemFontSize(10), MainColor(0.5));
    [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-5);
        make.right.mas_equalTo(self.view).mas_offset(-10);
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.bigImageView.image = lastImage;
    
    NSDictionary *subDic = @{
                             NSFontAttributeName : SystemFontSize(25),
                             NSForegroundColorAttributeName : [UIColor redColor]
                             };
    NSString *numStr = [NSString stringWithFormat:@"%lu", (long)self.imageColors.count-1];
    NSString *str = [NSString stringWithFormat:@"找出图片中%@种主要颜色",numStr];
    NSRange range = [str rangeOfString:numStr];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:subDic range:range];
    
    self.NameLabel.text = attributeStr.string;
}
- (IBAction)changeColor:(UIButton *)sender {
    maxThouchNum++;
    if (maxThouchNum>self.imageColors.count-1) {
        return;
    }
    
    KJMapBankModel *model = selectViewArray[sender.tag-520];
    // 避免重复设置frame
    if (CGRectEqualToRect(model.indicatorView.frame, CGRectZero)) {
       model.indicatorView.frame = CGRectMake(sender.frame.origin.x - 8,sender.frame.origin.y  - 8, sender.frame.size.width + 16, sender.frame.size.height + 16);
    }
    
    model.isSelect = !model.isSelect;
    model.currentColor = sender.backgroundColor;
    [self.view bringSubviewToFront:sender]; // 将sender放在最顶层
    if (model.isSelect) {
        [clickMusic stop];
        [clickMusic play];   // 点击音效播放
        [KJTools makeCornerRadius:2 borderColor:model.currentColor layer:model.indicatorView.layer borderWidth:5];
    }else{
        [judgeMusic stop];
        [judgeMusic play];
        [KJTools makeCornerRadius:0 borderColor:nil layer:model.indicatorView.layer borderWidth:0];
    }
    
    if (maxThouchNum == self.imageColors.count-1) {
        [timer invalidate];
        timer = nil;
        // 结算判断
        for (KJMapBankModel *model in selectViewArray) {
            if (model.isSelect) {
                if (model.isTureAnswer) {
                    NSLog(@"%ld正确",(long)model.saveButton.tag);
                    self.sureColorNum += 1;
                }else{
                    NSLog(@"%ld错误",(long)model.saveButton.tag);
                    self.errorColorNum += 1;
                }
            }
        }
        Reward *r = [[Reward alloc] init];
        [self.view addSubview:r];
        r.sureColorNum = _sureColorNum;
        r.errorColorNum = _errorColorNum;
        [r show];
    }
}

//背景音乐
- (void)music{
    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"sound_bg" ofType:@"mp3"];       //创建音乐文件路径
    NSURL *musicURL = [[NSURL alloc] initFileURLWithPath:musicFilePath];
    myBackMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    //创建播放器
    [myBackMusic prepareToPlay];
    [myBackMusic setVolume:1];   //设置音量大小
    myBackMusic.numberOfLoops = -1;//设置音乐播放次数  -1为一直循环
    [myBackMusic play];   //播放
    
    NSString *musicFilePath1 = [[NSBundle mainBundle] pathForResource:@"splat" ofType:@"mp3"];       //创建音乐文件路径
    NSURL *musicURL1 = [[NSURL alloc] initFileURLWithPath:musicFilePath1];
    clickMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL1 error:nil];
    //创建播放器
    [clickMusic prepareToPlay];
    [clickMusic setVolume:1];   //设置音量大小
    clickMusic.numberOfLoops = 1;//设置音乐播放次数  -1为一直循环
    
    NSString *musicFilePath2 = [[NSBundle mainBundle] pathForResource:@"sound_scaleUp" ofType:@"mp3"];       //创建音乐文件路径
    NSURL *musicURL2 = [[NSURL alloc] initFileURLWithPath:musicFilePath2];
    judgeMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL2 error:nil];
    //创建播放器
    [judgeMusic prepareToPlay];
    [judgeMusic setVolume:1];   //设置音量大小
    judgeMusic.numberOfLoops = 1;//设置音乐播放次数  -1为一直循环
}

//- (void)playYinXiao{
//    NSString *audioFile=[[NSBundle mainBundle] pathForResource:@"splat" ofType:@"mp3"];
//    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
//    //1.获得系统声音ID
//    SystemSoundID soundID=0;
//    /**
//     * inFileUrl:音频文件url
//     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
//     */
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
//    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
//    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
//    //2.播放音频
////    AudioServicesPlaySystemSound(soundID);//播放音效
//    AudioServicesPlayAlertSound(soundID);//播放音效并震动
//    //3.销毁声音
//    AudioServicesDisposeSystemSoundID(soundID);
//}
///**
// *  播放完成回调函数
// *
// *  @param soundID    系统声音ID
// *  @param clientData 回调时传递的数据
// */
//void soundCompleteCallback(SystemSoundID soundID,void * clientData){
//    NSLog(@"播放完成...");
//}


@end
