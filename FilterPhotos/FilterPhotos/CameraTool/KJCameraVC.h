//
//  KJCameraVC.h
//  FilterPhotos
//
//  Created by 杨科军 on 2018/11/17.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KJCameraDelegate <NSObject>

//选取照片的回调
- (void)kj_cameraTakePhoto:(UIImage *)image;

@end

@interface KJCameraVC : UIViewController

@property (nonatomic, weak)id<KJCameraDelegate> delegate;



@end
