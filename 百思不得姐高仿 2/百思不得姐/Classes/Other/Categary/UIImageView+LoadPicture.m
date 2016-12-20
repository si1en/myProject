//
//  UIImageView+LoadPicture.m
//  百思不得姐
//
//  Created by Apple on 2016/12/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIImageView+LoadPicture.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
@implementation UIImageView (LoadPicture)
- (void)loadBigImage:(NSString *)original smallImage:(NSString *)smallImage placeholder:(NSString *)placeholder
{
    
    // 真机调试的时候
    self.image = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:original];
    if (!self.image) {
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        if (manager.isReachableViaWiFi) {
        [self sd_setImageWithURL:[NSURL URLWithString:original] placeholderImage:[UIImage imageNamed:placeholder]];
            
        }else if (manager.isReachableViaWWAN){
        self.image = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:smallImage];
            if (!self.image) {
                [self sd_setImageWithURL:[NSURL URLWithString:smallImage] placeholderImage:[UIImage imageNamed:placeholder]];
            }
        }else{
            [self sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:placeholder]];
        }
    }
}
@end
