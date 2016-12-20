//
//  UIImageView+LoadPicture.h
//  百思不得姐
//
//  Created by Apple on 2016/12/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LoadPicture)

- (void)loadBigImage:(NSString *)original smallImage:(NSString *)smallImage placeholder:(NSString *)placeholder;

@end
