//
//  KJFoldClockVC.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/10.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJFoldClockVC.h"
#import "XLFoldClock.h"

@interface KJFoldClockVC (){
    NSTimer *_timer;
    XLFoldClock *_foldClock;
}

@end

@implementation KJFoldClockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FoldClock";
    _foldClock = [[XLFoldClock alloc] init];
    _foldClock.frame = self.view.bounds;
    _foldClock.date = [NSDate date];
    [self.view addSubview:_foldClock];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeLabel) userInfo:nil repeats:true];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _foldClock.frame = self.view.bounds;
}

- (void)updateTimeLabel {
    _foldClock.date = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
