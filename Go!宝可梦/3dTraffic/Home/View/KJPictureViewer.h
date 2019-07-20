//
//  KJPictureViewer.h
//  AnimationDemo
//
//  Created by 杨科军 on 2016/10/23.
//  Copyright © 2016年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KJPictureViewer;
@protocol KJPictureViewerDelegate <NSObject>

- (void)pictureViewer:(KJPictureViewer*)pictureViewer didGestureSelectedImage:(UIImage*)image andImageWorldRect:(CGRect)imageWorldRect Index:(NSInteger)index;

@end

@interface KJPictureViewer : UIView

/** 代理*/
@property(nonatomic,weak) id<KJPictureViewerDelegate> delegate;
/** 图片数组*/
@property(nonatomic,copy) NSArray *kj_imageArray;

@end
