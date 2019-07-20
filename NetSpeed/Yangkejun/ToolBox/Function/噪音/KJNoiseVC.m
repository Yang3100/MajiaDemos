//
//  KJNoiseVC1.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/11.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJNoiseVC.h"
#import "KJWaveView.h"
#import <AVFoundation/AVFoundation.h>
@interface KJNoiseVC (){
    CGFloat max,min;
}
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) NSTimer *levelTimer;

@property (strong, nonatomic) KJWaveView *waveView;
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UIButton *begion;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;

@end

@implementation KJNoiseVC

- (void)dealloc{
    [self stopTest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NoiseTest";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self _setSubview];
}
- (IBAction)ClickButton:(UIButton *)sender {
    self.begion.selected = !_begion.selected;
    if (_begion.selected) {
        [self testVoice];
        [_begion setTitle:@"Testing" forState:UIControlStateSelected];
    }else{
        [_begion setTitle:@"Begion" forState:UIControlStateNormal];
        [self stopTest];
    }
}

- (void)stopTest{
    _recorder = nil;
    [_levelTimer invalidate];
    _levelTimer = nil;
    self.currentLabel.text = @"0";
    self.maxLabel.text = @"0";
    self.minLabel.text = @"0";
    max = 0.0;
    min = 1000.0;
    _waveView.progress = 0;
}

- (void)_setSubview{
    self.waveView = [[KJWaveView alloc] initWithFrame:self.BackView.bounds];
    [self.BackView addSubview:_waveView];
    _waveView.backgroundColor = UIColorFromHEXA(0x6b98ff, 1);
    _waveView.progress = 0;
    
    max = 0.0;
    min = 1000.0;
}

- (void)testVoice{
    /* 必须添加这句话，否则在模拟器可以，在真机上获取始终是0  */
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    
    /* 不需要保存录音文件 */
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
                              [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                              [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                              [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey,
                              nil];
    
    NSError *error;
    _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if (_recorder){
        [_recorder prepareToRecord];
        //是否启用音频测量
        _recorder.meteringEnabled = YES;
        //开始录音
        [_recorder record];
        _levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    }
    else{
        NSLog(@"%@", [error description]);
    }
}
/* 该方法确实会随环境音量变化而变化，但具体分贝值是否准确暂时没有研究 */
- (void)levelTimerCallback:(NSTimer *)timer {
    [_recorder updateMeters];
    
    //最终获取的值 0~1之间
    float level;
    
    //最小分贝 -80 去除分贝过小的声音
    float minDecibels = -80.0f;
    
    //获取通道0的分贝
    float decibels = [_recorder averagePowerForChannel:0];
    
    if (decibels < minDecibels){
        //控制最小值 0
        level = 0.0f;
    }else if (decibels >= 0.0f){
        //控制最大值 1
        level = 1.0f;
    }else{
        level =(1 - decibels/(float)minDecibels);
    }
    //扩大范围 0~1 -> 0~110
    CGFloat theVal = level * 100;
    self.waveView.progress = level;
    
    [self.currentLabel setText:[NSString stringWithFormat:@"%.0f",theVal]];
    NSString *needText = [NSString stringWithFormat:@"%.0fdB",theVal];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(needText.length-2,2)];
    [_currentLabel setAttributedText:attrString];
    
    if (theVal>max) {
        max = theVal;
        self.maxLabel.text = [NSString stringWithFormat:@"%.f",theVal];
    }
    
    if (theVal<min && theVal>0) {
        min = theVal;
        self.minLabel.text = [NSString stringWithFormat:@"%.f",theVal];
    }
}



@end
