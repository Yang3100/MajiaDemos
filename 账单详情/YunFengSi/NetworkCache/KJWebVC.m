//
//  KJWebVC.m
//  MoLiao
//
//  Created by 杨科军 on 2018/8/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJWebVC.h"
#import "UIImage+GIF.h"

@interface KJWebVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *lanType;  // 语言类型
@property (nonatomic, strong) UIImageView *loadImageView;  // 加载背景

@end

@implementation KJWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
//    // 判断当前语言
//    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] valueForKey:SetLocationLanauage];
//    if ([currentLanguage isEqualToString:Zh]) {
//        self.lanType = Zh;
//    }else if ([currentLanguage isEqualToString:En]){
//        self.lanType = En;
//    }
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - loadData
- (void)loadData{
    if (self.isH5){
        [self loadDataWithH5];
    }
}

#pragma mark - loadData
- (void)loadDataWithH5{
//    NSString *urlStr;
//    if (self.game_id.length>0) {
//        urlStr = [NSString stringWithFormat:@"%@%@/%@?lang=%@",REQUEST,self.h5Type,_game_id,self.lanType];
//    }
//    else{
//        urlStr = [NSString stringWithFormat:@"%@%@?lang=%@",REQUEST,self.h5Type,self.lanType];
//    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    UIImage *image = [UIImage sd_animatedGIFNamed:@"H5loading"];
//    self.loadImageView.image = image;
//    [[UIApplication sharedApplication].keyWindow addSubview:self.loadImageView];
    NSLog(@"开始请求webview:%@",request.URL.relativeString);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"开始加载webview");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    //  延时执行
//    int64_t delayInSeconds = 5.0; // 延迟的时间
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.loadImageView removeFromSuperview];
//    });
    NSLog(@"结束加载webview");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nonnull NSError *)error {
    NSLog(@"webView加载失败");
}

#pragma mark - getter
- (UIWebView *)webView{
    if (!_webView){
        _webView = InsertWebView(nil, CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64), self, 88);
        _webView.scrollView.scrollEnabled = YES;
        _webView.scrollView.bounces = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
    }
    return _webView;
}
- (UIImageView*)loadImageView{
    if (!_loadImageView) {
        _loadImageView = InsertImageView(nil, CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64), GetImage(@"H5loadError"));
    }
    return _loadImageView;
}


@end
