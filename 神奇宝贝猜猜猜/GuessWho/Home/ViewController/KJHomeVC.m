//
//  GameViewController.m
//  GuessWho
//
//  Created by 杨科军 on 2018/11/18.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJHomeVC.h"
#import "KJHomeCell.h"
#import "KJGameVC.h"
//#import "KJEmitterView.h"

#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height

@interface KJHomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionVew;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *lvLabel;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *setButton;

@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)NSArray *nameArray;

@end

@implementation KJHomeVC
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];

    [self _setSubview];
}

- (void)_setSubview{
    self.historyLabel.text = [NSString stringWithFormat:@"历史记录（%ld / 451）",self.nameArray.count];
    
    self.mainCollectionVew.delegate = self;
    self.mainCollectionVew.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"KJHomeCell" bundle:nil];
    [self.mainCollectionVew registerNib:nib forCellWithReuseIdentifier:@"KJHomeCell"];
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //该方法也可以设置itemSize
    CGFloat w = (self.mainCollectionVew.frame.size.width-80)/4;
    layout.itemSize = CGSizeMake(w,w);
    [self.mainCollectionVew setCollectionViewLayout:layout];
    
//    // 添加雪花粒子效果
//    KJEmitterView *contentView = [KJEmitterView createEmitterView:^(KJEmitterView *obj) {
//        obj.Frame(self.view.frame).AddView(self.view);
//    }];
//    // 子视图超出父视图范围时, 会显示.
//    contentView.clipsToBounds = NO;
//
//    [self.view bringSubviewToFront:self.mainCollectionVew];
}

- (IBAction)setClickButton:(UIButton *)sender {
    
}
#pragma mark - UICollectionViewDelegate
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KJHomeCell *cell = (KJHomeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"KJHomeCell" forIndexPath:indexPath];
    cell.name = self.dataArray[indexPath.row];
    return cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 20, 10, 20);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    KJGameVC *vc = [[KJGameVC alloc]initWithSCNFileName:self.dataArray[indexPath.row] Name:self.nameArray[indexPath.row]];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (NSArray *)dataArray{
    if (!_dataArray){
        _dataArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"17",@"18",@"19",@"20",@"39",@"142",@"143",@"144",@"145",@"146",@"147",@"148",@"149"];
    }
    return _dataArray;
}

- (NSArray*)nameArray{
    if (!_nameArray) {
        _nameArray = @[@"杰尼龟",
                       @"喷火龙",
                       @"妙蛙种子",
                       @"小火龙",
                       @"皮卡丘",
                       @"巴大蝴",
                       @"玛丽露",
                       @"六尾",
                       @"超音蝠",
                       @"喵喵",
                       @"可达鸭",
                       @"哥达鸭",
                       @"风速狗",
                       @"蚊香蛙",
                       @"口呆花",
                       @"小磁怪",
                       @"飞天螳螂",
                       @"暴鲤龙",
                       @"乘龙",
                       @"金鱼王",
                       @"胖丁",
                       @"化石翼龙",
                       @"卡比兽",
                       @"急冻鸟",
                       @"闪电鸟",
                       @"火焰鸟",
                       @"迷你龙",
                       @"哈克龙",
                       @"快龙",
                       ];
    }
    return _nameArray;
}


@end
