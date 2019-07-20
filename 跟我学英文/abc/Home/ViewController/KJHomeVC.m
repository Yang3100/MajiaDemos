//
//  HomeVC.m
//  跟我学英文
//
//  Created by 杨科军 on 2018/12/4.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJHomeVC.h"
#import "KJStudyViewController.h"
#import "KJHomeModel.h"

@interface KJHomeVC ()

@property (nonatomic,strong) KJTagTextView *tagView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

//@property (nonatomic,copy) NSArray *englishAnswers;
//@property (nonatomic,copy) NSArray *chinaTitles;

@property (nonatomic,copy) NSMutableArray *dataArray;
@property (nonatomic,copy) NSMutableArray *studyDataArray;

@end

@implementation KJHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"跟我学英语";
    
    [self _setDatas];
    
    [self setUI];
}

- (void)setUI{
    [KJEmitterView createEmitterViewWithType:(KJEmitterTypeSnowflake) Block:^(KJEmitterView *obj) {
        obj.KJAddView(self.bgImageView).KJFrame(self.view.bounds);
    }];
    
    // 初始30，看起来大一点
    self.headerImageView.kj_Radius = CGRectGetWidth(self.headerImageView.frame)/2;
    self.headerImageView.kj_RectCorner = UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerTopRight;
}

- (IBAction)ClickStart:(UIButton *)sender {
    KJStudyViewController *vc = [[KJStudyViewController alloc]init];
//    vc.EnglishNameArray = self.englishAnswers;
//    vc.ChinaNameArray = self.chinaTitles;
    vc.modelArray = self.dataArray;
    vc.currentIndex = arc4random() % self.dataArray.count;  /// 随机
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_setDatas{
    NSString *acc = [[NSUserDefaults standardUserDefaults] valueForKey:@"account"];
    NSString *pas = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    [KJNetManager LoginForIphoneIsNum:acc Password:pas completionHandler:^(id responseObj, NSError *error) {
        if (KJ_CODE == 200) {
            /// 储存数据
            KJUserModel *model = [KJUserModel initUserModelManager];
            model.face = responseObj[@"data"][@"face"];
            model.nickname = responseObj[@"data"][@"nickname"];
            model.signature = responseObj[@"data"][@"signature"];
            model.userid = responseObj[@"data"][@"userid"];
            model.phone = responseObj[@"data"][@"phone"];
            
            self.nameLabel.text = model.nickname;
            self.contentLabel.text = model.signature;
        }else if(KJ_CODE == 0){
            
        }
    }];
    
    [KJNetManager GetAllWord:User_ID completionHandler:^(id responseObj, NSError *error) {
        if (KJ_CODE==200) {
            NSArray *array = responseObj[@"data"][@"list"];
            for (NSInteger i=0; i<array.count; i++) {
                KJHomeModel *model = [[KJHomeModel alloc]init];
                model.word_id = [array[i] valueForKey:@"word_id"];
                model.english = [array[i] valueForKey:@"english"];
                model.chinese = [array[i] valueForKey:@"chinese"];
                model.is_study = [array[i] valueForKey:@"is_study"];
                [self.dataArray addObject:model];
            }
        }
    }];
    
    [KJNetManager GetStudyedWord:User_ID completionHandler:^(id responseObj, NSError *error) {
        if (KJ_CODE==200) {
            NSArray *array = responseObj[@"data"][@"list"];
            NSMutableArray *ens = [NSMutableArray array];
            for (NSInteger i=0; i<array.count; i++) {
                KJHomeModel *model = [[KJHomeModel alloc]init];
                model.word_id = [array[i] valueForKey:@"word_id"];
                model.english = [array[i] valueForKey:@"english"];
                model.chinese = [array[i] valueForKey:@"chinese"];
                model.is_study = [array[i] valueForKey:@"is_study"];
                [self.studyDataArray addObject:model];
                [ens addObject:model.english];
            }
            
            
            KJTagTextView *tagView = [KJTagTextView createTagTextViewWithType:(KJTagTextViewTypeLeft) TagArray:ens Block:^(KJTagTextView *obj) {
                obj.KJFrame(self.backView.bounds).KJAddView(self.backView).KJBackgroundColor(UIColor.clearColor);
                /// 以下属性均有默认值
                obj.KJTagColor(UIColor.clearColor, [UIColor.whiteColor colorWithAlphaComponent:0.8], UIColor.lightGrayColor);
            }];
            
            [tagView setBlock:^(NSInteger index) {
//                KJStudyViewController *vc = [[KJStudyViewController alloc]init];
//                vc.EnglishNameArray = self.englishAnswers;
//                vc.ChinaNameArray = self.chinaTitles;
//                vc.currentIndex = index;
//                [self.navigationController pushViewController:vc animated:YES];
            }];
        }
    }];
    
//    self.englishAnswers = @[@"Book",@"Good",@"Watermelon",@"Police",@"Congratulation",@"English"];
//    self.chinaTitles = @[@"书",@"好",@"西瓜",@"警察",@"祝贺",@"英文"];
}

- (NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray*)studyDataArray{
    if (!_studyDataArray) {
        _studyDataArray = [NSMutableArray array];
    }
    return _studyDataArray;
}

@end
