//
//  KJSimpleDrawCell.h
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/23.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJWaterfall.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJSimpleDrawCell : UICollectionViewCell
- (void)configureModel:(KJWaterfall *)waterfall;
@end

NS_ASSUME_NONNULL_END
