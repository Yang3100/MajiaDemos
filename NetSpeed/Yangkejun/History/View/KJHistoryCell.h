//
//  KJHistoryCell.h
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/9.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJBaseTableViewCell.h"
#import "KJHistoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJHistoryCell : KJBaseTableViewCell

@property(nonatomic,strong) KJHistoryModel *model;

@end

NS_ASSUME_NONNULL_END
