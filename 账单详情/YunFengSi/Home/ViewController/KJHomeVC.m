//
//  KJHomeVC.m
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/16.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJHomeVC.h"
#import "YCMenuView.h"   // 菜单选择
#import "KJHomeModel.h"
#import "FMDBMonthModel.h"
#import "KJTallyVC.h"
#import "JHIndexPath.h"

@interface KJHomeVC ()<JHColumnChartDelegate>

@property(nonatomic,copy) NSMutableArray *monthMenuViewArray;

/// 自定义的导航条
@property (nonatomic, readwrite, weak)UIView *navBar;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *incomeLabel;
@property (nonatomic, strong) UILabel *expendLabel;
@property (nonatomic, strong) UILabel *unitLabel;

@property (nonatomic, strong) JHColumnChart *column;
@property (nonatomic, strong) JHLineChart *lineChart;
@property (nonatomic, strong) JHRingChart *ring;

@property (nonatomic, copy) NSArray *dataArr;

@property (nonatomic, copy) NSArray *threeMonthSumArr;

@end

@implementation KJHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // hide sys navBar
    self.fd_prefersNavigationBarHidden = YES;
    // 去掉侧滑pop手势
    self.fd_interactivePopDisabled = YES;
    
    self.threeMonthSumArr = [self getThreeMonthSum];
    
    [self _initDataBase];
    
    [self setUI];
    
    [self event:nil];
 
    [self _setData];
    
    
    // 添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isReload) name:@"isReload" object:nil];
}

- (void)isReload{
    // 刷新
    self.threeMonthSumArr = [self getThreeMonthSum];
    self.dataArr = [[KJHomeModel sharedInstance] getMonthData:11];
    self.monthLabel.text = @"12月";
    [self.column clear];
    [self.lineChart clear];
    [self.ring clear];
    [self addCH];
    [self _setData];
}

- (void)judgeFristCretaTable:(int)month{
    NSString *name = [NSString stringWithFormat:@"FirstCretaTable%d",month];
    BOOL First = [[NSUserDefaults standardUserDefaults] boolForKey:name];
    if (!First){  // 第一次启动
        [[KJHomeModel sharedInstance] loadDataBase:month];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:name];
    }
}

- (NSArray *)getThreeMonthSum{
    [self judgeFristCretaTable:12];
    [self judgeFristCretaTable:1];
    [self judgeFristCretaTable:2];
    
    NSArray *eMonthArr = [[KJHomeModel sharedInstance] getMonthData:12];
    NSArray *nMonthArr = [[KJHomeModel sharedInstance] getMonthData:1];
    NSArray *tMonthArr = [[KJHomeModel sharedInstance] getMonthData:2];
    CGFloat expendSum = 0;
    CGFloat expendSum2 = 0;
    CGFloat expendSum3 = 0;
    for (int i = 0; i<eMonthArr.count; i++) {
        FMDBMonthModel *model = eMonthArr[i];
        FMDBMonthModel *model3 = tMonthArr[i];
        expendSum = expendSum + model.expendSum;
        expendSum3 = expendSum3 + model3.expendSum;
        if (nMonthArr.count>i) {
            FMDBMonthModel *model2 = nMonthArr[i];
            expendSum2 = expendSum2 + model2.expendSum;
        }
    }
    if (expendSum==0) {
        expendSum = 1;
    }
    
    return @[@[@(expendSum),@(expendSum2),@(expendSum3)]];
}

- (void)_initDataBase{
    self.dataArr = [[KJHomeModel sharedInstance] getMonthData:11];
}

#pragma mark - 执行触发的方法
- (void)event:(UITapGestureRecognizer *)gesture{
    NSLog(@"yue");
    YCMenuView *menuView = [YCMenuView menuWithActions:self.monthMenuViewArray width:100 relyonView:self.monthLabel];
    menuView.maxDisplayCount = self.monthMenuViewArray.count;
    menuView.textFont = SystemFontSize(13);
    menuView.menuCellHeight = Handle(38);
    [menuView show];
}

#pragma mark - JHColumnChartDelegate
-(void)columnChart:(JHColumnChart*)chart columnItem:(JHColumnItem *)item didClickAtIndexPath:(JHIndexPath *)indexPath{
//    ind = indexPath;
    NSLog(@"---%@,%d",indexPath,indexPath.section);
}

#pragma mark - setData
- (void)_setData{
    // 柱状图数据
    NSMutableArray *dayArr = [NSMutableArray array];
    NSMutableArray *valArr = [NSMutableArray array];
    [dayArr removeAllObjects];
    [valArr removeAllObjects];

    CGFloat expendSum = 0;
    CGFloat incomeSum = 0;
    
    for (int i = 0; i<self.dataArr.count; i++) {
        FMDBMonthModel *model = self.dataArr[i];
        [valArr addObject:@[@(model.expendSum)]];
        NSString *day = model.day;
        [dayArr addObject:day];
        expendSum = expendSum + model.expendSum;
        incomeSum = incomeSum + model.incomeSum;
    }
    
    self.expendLabel.text = [NSString stringWithFormat:@"￥%.2f",expendSum];
    self.incomeLabel.text = [NSString stringWithFormat:@"￥%.2f",incomeSum];
    
    self.column.valueArr = valArr;
    self.column.xShowInfoText = dayArr;
    [self.column showAnimation];
    
    // 折线图
    self.lineChart.xLineDataArr = @[@"十二月份",@"一月份",@"二月份"];
    self.lineChart.valueArr = self.threeMonthSumArr;
    // 找出最大值和最小值
    NSArray *numbers = self.threeMonthSumArr[0];
    numbers = [numbers sortedArrayUsingSelector:@selector(compare:)];
    float min = [numbers[0] floatValue];
    float max = [[numbers lastObject] floatValue];
    if (min==max) {
        max = max + 1;
    }
    self.lineChart.yLineDataArr = @[@[@(max/2),@(max)],@[@1,@2]];
    [self.lineChart showAnimation];
    
    // 环形图
    self.ring.valueDataArr = @[@"0.5",@"5",@"2",@"10",@"6",@"6"];
    /*        Fill color for each section of the ring diagram         */
    self.ring.fillColorArray = @[[UIColor colorWithRed:1.000 green:0.783 blue:0.371 alpha:1.000],
                                 [UIColor colorWithRed:1.000 green:0.562 blue:0.968 alpha:1.000],
                                 [UIColor colorWithRed:0.313 green:1.000 blue:0.983 alpha:1.000],
                                 [UIColor colorWithRed:0.560 green:1.000 blue:0.276 alpha:1.000],
                                 [UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000],
                                 [UIColor colorWithRed:0.239 green:0.651 blue:0.870 alpha:1.000]];
    [self.ring showAnimation];
}

#pragma mark - 初始化子控件
- (void)setUI{
    /// Create NavBar;
    UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, kSTATUSBAR_HEIGHT-20, kScreenW, SCREEN_HEIGHT/4)];
    self.navBar = navBar;
    [self.view addSubview:navBar];
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    // 设置背景渐变色层的大小
    gradientLayer.frame = CGRectMake(0, 0, kScreenW, SCREEN_HEIGHT/2);
    UIColor *lightColor = MainColor(1);
    UIColor *darkColor = MainColor(0.5);
    gradientLayer.colors = @[(__bridge id)lightColor.CGColor,(__bridge id)darkColor.CGColor];
    // 让变色层成45度角变色
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    // 渐变色添加
    [navBar.layer addSublayer:gradientLayer];
    
    /// 搜索框View
    CGFloat w = kScreenW/4;
    CGFloat x = kScreenW/2 - w/2;
    CGFloat h = 20;
    CGFloat y = kSTATUSBAR_HEIGHT+10;
    UIImageView *titleView = InsertImageView(nil, CGRectMake(x, y, w, h), GetImage(@"biaoti"));
    titleView.contentMode = UIViewContentModeScaleToFill;
    [navBar addSubview:titleView];
    
    NSArray *nameArr = @[@"2018年",@"收入",@"支出"];
    NSArray *Arr = @[@"12月",@"￥0.00",@"￥0.00"];
    for (int i = 0; i<3; i++) {
     UILabel *lab = InsertLabel(navBar, CGRectZero, NSTextAlignmentLeft, nameArr[i], SystemFontSize(14), [UIColor whiteColor]);
        CGFloat w = (SCREEN_WIDTH - Handle(80))/3;
        CGFloat h = Handle(20);
        CGFloat x = Handle(20) + (w+Handle(20))*i;
        CGFloat y = titleView.bottom + Handle(30);
        lab.frame = CGRectMake(x, y, w, h);
        
        UILabel *lab2 = InsertLabel(navBar, CGRectZero, NSTextAlignmentLeft, Arr[i], SystemFontSize(14), [UIColor blackColor]);
        lab2.backgroundColor = [UIColor yellowColor];
        lab2.alpha = 0.85;
        [KJTools makeCornerRadius:Handle(5) borderColor:nil layer:lab2.layer borderWidth:0];
        CGFloat w2 = (SCREEN_WIDTH - Handle(80))/3;
        CGFloat h2 = Handle(30);
        CGFloat x2 = Handle(20) + (w2+Handle(20))*i;
        CGFloat y2 = lab.bottom + Handle(10);
        if (i==0) {
            lab2.textAlignment = NSTextAlignmentCenter;
            lab2.frame = CGRectMake(x2, y2, Handle(50), h2);
            self.monthLabel = lab2;
            // 添加手势
            self.monthLabel.userInteractionEnabled = YES; // 打开用户交互(不可少)
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
            // 将手势添加到需要相应的view中去
            [self.monthLabel addGestureRecognizer:tapGesture];
            // 选择触发事件的方式（默认单机触发）
            [tapGesture setNumberOfTapsRequired:1];
            continue;
        }else if (i==1){
            self.incomeLabel = lab2;
        }else if (i==2){
            self.expendLabel = lab2;
        }
        lab2.frame = CGRectMake(x2, y2, w2, h2);
    }
    
    [self addCH];
    
    //头顶上的时间标志
    UILabel *unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(Handle(15), 5, SCREEN_WIDTH, Handle(20))];
    unitLabel.text = @"支出报表";
    unitLabel.textColor = [UIColor lightGrayColor];
    unitLabel.font = [UIFont systemFontOfSize:15.f];
    self.unitLabel = unitLabel;
    [self.column addSubview:unitLabel];
    
    //头顶上的时间标志
    UILabel *FirstQuardrantLabel = [[UILabel alloc]initWithFrame:CGRectMake(Handle(15), self.lineChart.top-Handle(25), SCREEN_WIDTH, Handle(20))];
    FirstQuardrantLabel.text = @"近期消费汇总";
    FirstQuardrantLabel.textColor = [UIColor lightGrayColor];
    FirstQuardrantLabel.font = [UIFont systemFontOfSize:15.f];
    [self.view addSubview:FirstQuardrantLabel];
    
    //头顶上的时间标志
    UILabel *RingLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.ring.left, self.ring.top-Handle(25), SCREEN_WIDTH, Handle(20))];
    RingLabel.text = @"消费百分百";
    RingLabel.textColor = [UIColor lightGrayColor];
    RingLabel.font = [UIFont systemFontOfSize:15.f];
    [self.view addSubview:RingLabel];
}

- (void)addCH{
    // 柱状图
    [self showColumnView];
    // 第一象限折线图
    [self showFirstQuardrant];
    // 环形图
    [self showRingChartView];
}

#pragma mark - 柱状图
- (void)showColumnView{
    JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(0, self.navBar.bottom, kScreenW, SCREEN_HEIGHT/3)];
    /*       This point represents the distance from the lower left corner of the origin.         */
    column.originSize = CGPointMake(30, 20);
    /*    The first column of the distance from the starting point     */
    column.drawFromOriginX = 5;
    column.backgroundColor = [UIColor whiteColor];
    column.typeSpace = 10;
    column.isShowYLine = NO;
    column.contentInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    column.columnWidth = 20;
    column.drawTextColorForX_Y = [UIColor blackColor];
    column.colorForXYLine = [UIColor darkGrayColor];
    column.columnBGcolorsArr = @[@[MainColor(0.4),MainColor(0.2)]];//如果为复合型柱状图 即每个柱状图分段 需要传入如上颜色数组 达到同时指定复合型柱状图分段颜色的效果
    /*        Module prompt         */
    column.isShowLineChart = YES;
    column.delegate = self;
    self.column = column;
    [self.view addSubview:column];
}

#pragma mark - 第一象限折线图
- (void)showFirstQuardrant{
    /*     Create object        */
    JHLineChart *lineChart = [[JHLineChart alloc] initWithFrame:CGRectMake(10, self.column.bottom+Handle(30), (kScreenW-20)/2, (kScreenW-60)/2) andLineChartType:JHChartLineValueNotForEveryX];
    lineChart.contentInsets = UIEdgeInsetsMake(0, 25, 20, 25);
    lineChart.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrant;
    lineChart.showYLevelLine = YES;
    lineChart.showYLine = YES;
    //    lineChart.drawPathFromXIndex = 1;
    lineChart.animationDuration = 2.0;
    lineChart.showDoubleYLevelLine = YES;
    lineChart.showValueLeadingLine = NO;
    lineChart.valueFontSize = 9.0;
    lineChart.backgroundColor = [UIColor whiteColor];
    lineChart.showPointDescription = NO;
    lineChart.showXDescVertical = YES;
    lineChart.xDescMaxWidth = 10;
    /* Line Chart colors */
    lineChart.valueLineColorArr =@[[UIColor greenColor]];
    /* Colors for every line chart*/
    lineChart.pointColorArr = @[[UIColor orangeColor]];
    /* color for XY axis */
    lineChart.xAndYLineColor = [UIColor blackColor];
    /* XY axis scale color */
    lineChart.xAndYNumberColor = [UIColor darkGrayColor];
    /* Dotted line color of the coordinate point */
    lineChart.positionLineColorArr = @[[UIColor blueColor]];
    /*        Set whether to fill the content, the default is False         */
    lineChart.contentFill = NO;
    /*        Set whether the curve path         */
    lineChart.pathCurve = YES;
    /*        Set fill color array         */
    lineChart.contentFillColorArr = @[[UIColor colorWithRed:0 green:1 blue:0 alpha:0.468]];
    [self.view addSubview:lineChart];
    self.lineChart = lineChart;
}

#pragma mark - 环状图
- (void)showRingChartView{
    JHRingChart *ring = [[JHRingChart alloc] initWithFrame:CGRectMake(self.lineChart.right, self.column.bottom+Handle(30), (kScreenW)/2, (kScreenW)/2)];
    ring.backgroundColor = [UIColor whiteColor];
    ring.ringWidth = Handle(20);
    [self.view addSubview:ring];
    self.ring = ring;
}


- (NSMutableArray*)monthMenuViewArray{
    if (!_monthMenuViewArray) {
        _monthMenuViewArray = [NSMutableArray array];
        // Do any additional setup after loading the view.
        NSArray *name = @[@"12月",@"1月",@"2月"];
        NSArray *imageName = @[@"wujiaoxing",@"tuichu",@"aixin"];
        for (int i = 0; i<name.count; i++) {
            YCMenuAction *a = [YCMenuAction actionWithTitle:name[i] image:GetImage(imageName[i]) handler:^(YCMenuAction *action) {
                if ([action.title isEqualToString:@"12月"]) {
                    self.dataArr = [[KJHomeModel sharedInstance] getMonthData:9];
                    self.unitLabel.text = @"12月份支出报表";
                }else if ([action.title isEqualToString:@"1月"]){
                    self.dataArr = [[KJHomeModel sharedInstance] getMonthData:10];
                    self.unitLabel.text = @"1月份支出报表";
                }
                else if ([action.title isEqualToString:@"2月"]){
                    self.unitLabel.text = @"2月份支出报表";
                    self.dataArr = [[KJHomeModel sharedInstance] getMonthData:11];
                }
                
                self.monthLabel.text = action.title;
                [self.column clear];
                [self.lineChart clear];
                [self.ring clear];
                [self addCH];
                [self _setData];
            }];
            [_monthMenuViewArray addObject:a];
        }
    }
    return _monthMenuViewArray;
}

@end
