//
//  KJPictureCollectionViewCell.h
//  AnimationDemo
//
//  Created by 杨科军 on 2016/10/23.
//  Copyright © 2016年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KJPictureCollectionViewCell;
@protocol KJPictureCollectionCellDelegate <NSObject>

/**
 在图片拉出的时候调用
 @param pictureCollectionCell 当前cell
 @param image 被拉出的那张图片
 @param imageWorldRect 选中的图片的世界坐标rect
 */
- (void)pictureCollection:(KJPictureCollectionViewCell*)pictureCollectionCell didGestureSelectedImage:(UIImage*)image andImageWorldRect:(CGRect)imageWorldRect;

/**
 通过图片是否在window上来控制Scollview是否可以滑动
 @param pictureCollectionCell 当前cell
 @param isOnWindow 相片是否在window上
 */
- (void)pictureCollection:(KJPictureCollectionViewCell *)pictureCollectionCell lockScollViewWithOnWindow:(BOOL)isOnWindow;

@end

@interface KJPictureCollectionViewCell : UICollectionViewCell
/** 图片*/
@property(nonatomic,strong)UIImageView *imageView;
/** 代理*/
@property(nonatomic,weak)id<KJPictureCollectionCellDelegate> delegate;
@end
