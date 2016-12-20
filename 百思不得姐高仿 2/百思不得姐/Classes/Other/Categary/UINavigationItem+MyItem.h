//
//  UINavigationItem+MyItem.h
//  百思不得姐
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (MyItem)
    
+ (UIBarButtonItem *)setNavItemWithImage:(NSString *)imageName andHilightedImage:(NSString *)highlight addTarget:(nullable id)target action:(SEL)action;
    
+ (UIBarButtonItem *)setNavItemWithImage:(NSString *)imageName andSelectedImage:(NSString *)highlight addTarget:(nullable id)target action:(SEL)action;

+ (UIBarButtonItem *)setBackNavItemWithImage:(NSString *)imageName andSelectedImage:(NSString *)highlight addTarget:(nullable id)target action:(SEL)action;
@end
