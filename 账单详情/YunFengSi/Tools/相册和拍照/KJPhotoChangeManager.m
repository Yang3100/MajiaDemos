//
//  KJPhotoChangeManager.m
//  MoLiao
//
//  Created by 杨科军 on 2018/8/8.
//  Copyright © 2018年 杨科军. All rights reserved.
//  

#import "KJPhotoChangeManager.h"
#import "HMImagePickerController.h" // 照片选择器

@interface KJPhotoChangeManager()<
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
HMImagePickerControllerDelegate
>

@property (copy,nonatomic) void (^imageBlock)(UIImage *image);
@property (weak,nonatomic) UIViewController *vc;

@end

@implementation KJPhotoChangeManager

+ (instancetype)manager{
    static KJPhotoChangeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KJPhotoChangeManager alloc] init];
    });
    return manager;
}

- (void)showInVC:(UIViewController *)vc Name:(NSString*)name image:(void(^)(UIImage *image))image{
    // 保存block
    _imageBlock = image;
    _vc = vc;
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    KJAlertView *view = [[KJAlertView alloc] initWithTitle:name Content:nil whitTitleArray:@[@"拍照",@"相册选择",@"取消"] withType:@"bottom"];
    [view showAlertView:^(NSInteger index) {
        if (index == 0){ // 选择相机
            [self jhTakePhoto];
        }
        else if (index == 1){ // 选择相册
            [self jhOpenLocalPhoto];
        }
    }];
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
}

#pragma mark - 拍照
- (void)jhTakePhoto{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;

        [_vc presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
#if 0
    UIImage *image = info[UIImagePickerControllerOriginalImage]; //原图
#else
    UIImage *image = info[UIImagePickerControllerEditedImage]; //编辑图
#endif
    if (self.imageBlock) {
        self.imageBlock(image);
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 本地相册
- (void)jhOpenLocalPhoto{
    HMImagePickerController *imagePicker = [[HMImagePickerController alloc]initWithSelectedAssets:nil];
    imagePicker.pickerDelegate = self;
    imagePicker.maxPickerCount = 1;  // 选择图片张数
    [self.vc presentViewController:imagePicker animated:YES completion:nil];

//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    picker.delegate = self;
//    picker.allowsEditing = YES; //设置选择后的图片可被编辑
//    [_vc presentViewController:picker animated:YES completion:nil];
}

#pragma mark - HMImagePickerControllerDelegate 图像选择完成代理方法
/// @param picker         图像选择控制器
/// @param images         用户选中图像数组
/// @param selectedAssets 选中素材数组，方便重新定位图像
- (void)imagePickerController:(HMImagePickerController * _Nonnull)picker
      didFinishSelectedImages:(NSArray <UIImage *> * _Nonnull)images
               selectedAssets:(NSArray <PHAsset *> * _Nullable)selectedAssets{
    [picker dismissViewControllerAnimated:YES completion:^{
        if (self.imageBlock) {
            self.imageBlock(images[0]);
        }
    }];
}


@end







