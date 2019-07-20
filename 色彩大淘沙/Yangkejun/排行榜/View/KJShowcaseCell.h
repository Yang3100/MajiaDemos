//
//  KJShowcaseCell.h
//  涂鸦填填乐
//
//  Created by 杨科军 on 2018/10/27.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJWaterfall.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJShowcaseCell : UICollectionViewCell

- (void)configureModel:(KJWaterfall *)waterfall Index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
