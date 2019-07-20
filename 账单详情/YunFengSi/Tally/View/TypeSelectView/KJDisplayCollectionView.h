//
//  KJDisplayCollectionView.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJDisplayCollectionView : UIView

@property (nonatomic, readwrite, copy)void(^updateClicked)(NSInteger index);

@end
