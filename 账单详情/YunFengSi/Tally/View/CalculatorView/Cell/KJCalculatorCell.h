//
//  KJCalculatorCell.h
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/16.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJCalculatorModel.h"

@interface KJCalculatorCell : UICollectionViewCell

@property (nonatomic, readwrite, assign) NSInteger cell_tag;

- (void)configureModel:(KJCalculatorModel *)model;

@end
