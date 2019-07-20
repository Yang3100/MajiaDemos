//
//  KJStudyViewController.h
//  跟我学英文
//
//  Created by 杨科军 on 2018/12/3.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJStudyViewController : UIViewController

@property(nonatomic,strong) NSArray <KJHomeModel*>*modelArray;
@property(nonatomic,assign) NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
