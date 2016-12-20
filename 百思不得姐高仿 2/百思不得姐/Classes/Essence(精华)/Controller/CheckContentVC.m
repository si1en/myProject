//
//  CheckContentVC.m
//  百思不得姐
//
//  Created by Apple on 2016/12/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CheckContentVC.h"
#import <UIImageView+WebCache.h>
#import "MyDataItem.h"
#import <Photos/Photos.h>
#import <SVProgressHUD.h>
#import <MapKit/MapKit.h>

@interface CheckContentVC ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *myImageV;
@property (nonatomic,strong) UIScrollView *myScroll;

@property (nonatomic,strong) PHAssetCollection *myCollection;

- (PHFetchResult *)assests;
@end

@implementation CheckContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [self.view insertSubview:scroll atIndex:0];
    _myScroll = scroll;
    [scroll addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.myItem.image1] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    [scroll addSubview:imageV];
     _myImageV = imageV;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.myScroll.frame = self.view.bounds;
    
    CGFloat y = 0;
    CGFloat x = 0;
    CGFloat w = ScreenW;
    CGFloat h = self.myItem.height * ScreenW / self.myItem.width;
    if (h > ScreenH) {
        self.myScroll.contentSize = CGSizeMake(0, h);
    }else{
        y = (ScreenH - h) * 0.5;
    }
    self.myImageV.frame = CGRectMake(x, y, w, h);
    self.myScroll.delegate = self;
    self.myScroll.maximumZoomScale = self.myItem.height / h;

}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    //授权
    PHAuthorizationStatus myStatus = [PHPhotoLibrary authorizationStatus];
    switch (myStatus) {
        case PHAuthorizationStatusRestricted:
        {
            LeeNSLog(@"PHAuthorizationStatusRestricted")
            break;
        }
        case PHAuthorizationStatusNotDetermined:{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusDenied) {
                    LeeNSLog(@"已拒绝访问相册,请设置")
                }else if (status == PHAuthorizationStatusAuthorized){
                    
                    [self saveImage];
                }
            }];
            break;
        }
        case PHAuthorizationStatusDenied:{
            LeeNSLog(@"PHAuthorizationStatusDenied")

            break;
        }
        case PHAuthorizationStatusAuthorized:
        {
            [self saveImage];
            break;
        }

    }
    
}

- (PHAssetCollection *)myCollection{

    if (!_myCollection) {
        
        
        __block NSString *assetCollectionID = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            assetCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:AssetCollectionName].placeholderForCreatedAssetCollection.localIdentifier;
        } error:nil];
        
        return _myCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionID] options:nil].firstObject;
    }
    
    return _myCollection;
}

- (PHFetchResult *)assests{
    
    __block NSString *assetsID = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            assetsID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.myImageV.image].placeholderForCreatedAsset.localIdentifier;
        } error:nil];
    
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetsID] options:nil];
}

- (void)saveImage{
    //直接保存图片
//    UIImageWriteToSavedPhotosAlbum(self.myImageV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    // 保存图片基本步骤  1.保存图片 2.新建相册 3. 将图片保存到新建相册中去
    NSError *error = nil;
    PHAssetCollection *assetCollection = self.myCollection;
    PHFetchResult *assets = self.assests;

    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        
        [request insertAssets:assets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    if (error) {
        LeeNSLog(@"保存失败")
        [SVProgressHUD showErrorWithStatus:@"Fail"];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"Success"];
        LeeNSLog(@"保存成功")
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        LeeNSLog(@"保存失败")
    }else {
        LeeNSLog(@"保存成功")
    }
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.myImageV;
}

@end
