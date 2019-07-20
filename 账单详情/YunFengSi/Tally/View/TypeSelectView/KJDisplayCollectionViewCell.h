//
//  KJDisplayCollectionViewCell.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJDisplayCollectionViewCell : UICollectionViewCell

@property (nonatomic,assign)BOOL isCellSelect;
@property (nonatomic, readwrite, assign) NSInteger cell_tag;

@end
