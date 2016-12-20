//
//  UINavigationItem+MyItem.m
//  百思不得姐
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UINavigationItem+MyItem.h"

@implementation UINavigationItem (MyItem)
    
+ (UIBarButtonItem *)setNavItemWithImage:(NSString *)imageName andHilightedImage:(NSString *)highlight addTarget:(nullable id)target action:(SEL)action
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        UIView *contenView = [[UIView alloc] initWithFrame:btn.bounds];
        [contenView addSubview:btn];
        return [[UIBarButtonItem alloc] initWithCustomView:contenView];
        

    }
    
+ (UIBarButtonItem*)setNavItemWithImage:(NSString *)imageName andSelectedImage:(NSString *)select addTarget:(nullable id)target action:(SEL)action
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:select] forState:UIControlStateSelected];
        [btn sizeToFit];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchDown];
        
        UIView *contenView = [[UIView alloc] initWithFrame:btn.bounds];
        [contenView addSubview:btn];
        return [[UIBarButtonItem alloc] initWithCustomView:contenView];
    
    }
+ (UIBarButtonItem*)setBackNavItemWithImage:(NSString *)imageName andSelectedImage:(NSString *)highlight addTarget:(nullable id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    [btn setTitle:@"返回" forState: UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    UIView *btnContentView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnContentView addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:btnContentView];
    
}
@end
