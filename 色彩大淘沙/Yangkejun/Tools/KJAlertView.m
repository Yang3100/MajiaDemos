//
//  KJAlertView.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/25.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJAlertView.h"

@interface KJAlertView ()<UITableViewDelegate,UITableViewDataSource>{
    __block CGFloat bottomHeader;
}

@property (nonatomic, strong) NSString   *title;// 提示标题
@property (nonatomic, strong) NSString   *contentStr;// 提示内容
@property (nonatomic, strong) NSArray    *titleArray;// 按钮标题数组

@property (nonatomic, strong) UIButton     *bgView;
@property (nonatomic, strong) UIView       *centerView;
@property (nonatomic, strong) UITableView  *bottomView;

@end

@implementation KJAlertView


- (instancetype)initWithTitle:(NSString *)title Content:(NSString *)contentStr whitTitleArray:(NSArray *)titleArray withType:(NSString *)type{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        self.title = title;
        self.contentStr = contentStr;
        self.titleArray = titleArray;
        self.type = type;
        
        bottomHeader = 0.1;
        
        [self setUI];
        
        self.backgroundColor = UIColorFromHEXA(0x333333, 0.3);
    }
    return self;
}

- (void)setUI{
    if (self.titleArray == nil || self.type == nil) {
        return;
    }
    [self addSubview:self.bgView];
    
    if ([self.type isEqualToString:@"center"]) {
        [self createAlertViewCenter];
    }
    else if ([self.type isEqualToString:@"bottom"]){
        [self createAlertViewBottom];
    }
}

#pragma mark - AlertViewCenter
- (void)createAlertViewCenter {
    _centerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-Handle_width(270))/2, (SCREEN_HEIGHT-Handle_height(120))/2, Handle_width(270), Handle_height(120))];
    _centerView.theme_backgroundColor = @"block_bg";
    _centerView.layer.masksToBounds = YES;
    _centerView.layer.cornerRadius = Handle_width(10);
    [_bgView addSubview:_centerView];
    
    CGFloat titleHeight;
    CGFloat contentLabY;
    
    if ([self.title isEqualToString:@""] || self.title == nil) {
        titleHeight = 0;
        contentLabY = Handle_height(25);
    }
    else{
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(Handle_width(20), Handle_height(15), _centerView.width-Handle_width(20)*2, 20)];
        titleLab.text = self.title;
        titleLab.theme_textColor = @"text_h1";
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:Handle_height(16)];
        [_centerView addSubview:titleLab];
        
        titleHeight = titleLab.frame.size.height;
        contentLabY = titleLab.frame.origin.y + titleLab.frame.size.height+Handle_height(10);
    }
    
    CGRect rect = [KJTools getStringFrame:self.contentStr withFont:15 withMaxSize:CGSizeMake(_centerView.width-Handle_width(20)*2, MAXFLOAT)];
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake((_centerView.width-rect.size.width)/2, contentLabY, rect.size.width, rect.size.height)];
    contentLab.text = self.contentStr;
    contentLab.textColor = MainColor(1);
    contentLab.textAlignment = NSTextAlignmentCenter;
    contentLab.font = SystemFontSize(15);
    contentLab.numberOfLines = 0;
    [_centerView addSubview:contentLab];
    
    UILabel *line = [[UILabel alloc]init];
    line.theme_backgroundColor = @"line_color";
    line.frame = CGRectMake(0, contentLab.y+contentLab.height+Handle_height(25)-0.5, SCREEN_WIDTH, 0.5);
    [_centerView addSubview:line];
    
    for (int i = 0; i < self.titleArray.count; i ++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.tag = 2000+i;
        titleBtn.backgroundColor = [UIColor clearColor];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = SystemFontSize(15);
        
        if (self.titleArray.count == 1) {
            titleBtn.frame = CGRectMake(_centerView.width/self.titleArray.count*i, contentLab.y+contentLab.height+Handle_height(25), _centerView.width, Handle_height(45));
            [titleBtn setTitleColor:UIColorHexFromRGB(0xF1E9C3) forState:UIControlStateNormal];
        }
        else{
            titleBtn.frame = CGRectMake(_centerView.width/self.titleArray.count*i, contentLab.y+contentLab.height+Handle_height(25), _centerView.width/self.titleArray.count-0.5, Handle_height(45));
            if (i == 0) {
                [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            else{
                [titleBtn setTitleColor:MainColor(1) forState:UIControlStateNormal];
                
                UILabel *line = [[UILabel alloc]init];
                line.theme_backgroundColor = @"line_color";
                line.frame = CGRectMake(_centerView.width/self.titleArray.count*i-0.5, titleBtn.y, 0.5, titleBtn.height);
                [_centerView addSubview:line];
            }
            
            if (self.titleArray.count > 2) {
                [titleBtn setTitleColor:MainColor(1) forState:UIControlStateNormal];
            }
        }
        
        [_centerView addSubview:titleBtn];
    }
    
    _centerView.frame = CGRectMake((SCREEN_WIDTH-Handle_width(270))/2, (SCREEN_HEIGHT-Handle_height(120))/2, Handle_width(270), contentLab.y+contentLab.height+Handle_height(25)+Handle_height(45));
}


#pragma mark - AlertViewBottom
- (void)createAlertViewBottom{
    if ([self.title isEqualToString:@""] || self.title == nil) {
        bottomHeader = 0.1;
    }
    else{
        bottomHeader = Handle_height(50);
    }
    _bottomView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.titleArray.count*Handle_height(50)+Handle_height(10)+kBOTTOM_SPACE_HEIGHT+bottomHeader) style:UITableViewStyleGrouped];
    _bottomView.delegate = self;
    _bottomView.dataSource = self;
    _bottomView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _bottomView.scrollEnabled = NO;
    _bottomView.theme_backgroundColor = @"block_table_bg";
    [_bgView addSubview:_bottomView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.titleArray.count-1;
    }
    else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.theme_backgroundColor = @"block_table_bg";
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-Handle_width(150))/2, (Handle_height(50)-Handle_height(15))/2, Handle_width(150), Handle_height(15))];
    titleLab.font = SystemFontSize(15);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:titleLab];
    if (indexPath.section == 0) {
        titleLab.text = self.titleArray[indexPath.row];
        titleLab.textColor = MainColor(1);
        
        UILabel *line = [[UILabel alloc]init];
        line.theme_backgroundColor = @"line_color";
        line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
        [cell.contentView addSubview:line];
    }
    else{
        titleLab.text = [self.titleArray lastObject];
        titleLab.textColor = [UIColor redColor];
        UILabel *line = [[UILabel alloc]init];
        line.theme_backgroundColor = @"line_color";
        line.frame = CGRectMake(0, -12, SCREEN_WIDTH, 12);
        [cell.contentView addSubview:line];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Handle_height(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return bottomHeader;
    }
    else{
        return Handle_height(10);
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Handle_height(50))];
        titleLab.text = self.title;
        titleLab.theme_backgroundColor = @"block_table_bg";
        titleLab.theme_textColor = @"text_h1";
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = SystemFontSize(15);
        UILabel *line = [[UILabel alloc]init];
        line.theme_backgroundColor = @"line_color";
        line.frame = CGRectMake(2, Handle_height(50), SCREEN_WIDTH-4, 1);
        [titleLab addSubview:line];
        return titleLab;
    }else{
        return nil;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.myBlock) {
        
        [self dissmis];
        
        if (indexPath.section == 0) {
            self.myBlock(indexPath.row);
        }
        else{
            self.myBlock(self.titleArray.count-1);
        }
    }
    
    [self dissmis];
}

#pragma mark - 公用方法
- (void)show{
    if ([self.type isEqualToString:@"center"]) {
        UIWindow *window = [UIApplication sharedApplication].windows[0];
        [window addSubview:self];
        [self exChangeOut:_centerView dur:0.5];
    }
    else if ([self.type isEqualToString:@"bottom"]){
        UIWindow *window = [UIApplication sharedApplication].windows[0];
        [window addSubview:self];
        _weakself;
        [UIView animateWithDuration:0.25 animations:^{
            weakself.bottomView.frame = CGRectMake(0,
                                                   SCREEN_HEIGHT - weakself.titleArray.count * Handle_height(50) - Handle_height(10) - kBOTTOM_SPACE_HEIGHT - self->bottomHeader,
                                                   SCREEN_WIDTH,
                                                   weakself.titleArray.count * Handle_height(50) + Handle_height(10) + kBOTTOM_SPACE_HEIGHT + self->bottomHeader);
        }];
    }
}

- (void)dissmis{
    if ([self.type isEqualToString:@"center"]) {
        [self removeFromSuperview];
    }
    else if ([self.type isEqualToString:@"bottom"]){
        _weakself;
        [UIView animateWithDuration:0.25 animations:^{
            weakself.bottomView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_HEIGHT, self.titleArray.count*Handle_height(50)+Handle_height(10)+kBOTTOM_SPACE_HEIGHT);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)titleBtnClick:(UIButton *)btn{
    if (self.myBlock) {
        self.myBlock(btn.tag-2000);
    }
    [self dissmis];
}

- (void)showAlertView:(alertBlock)myBlock{
    [self show];
    self.myBlock = myBlock;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgView.frame = [UIScreen mainScreen].bounds;
        [_bgView addTarget:self action:@selector(butChack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgView;
}

- (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = dur;
    //animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

- (void)butChack{
    [self removeFromSuperview];
}

-(void)dissmissView{
    [self removeFromSuperview];
    if (self.myBlock){
        self.myBlock(0);
    }
}

@end

