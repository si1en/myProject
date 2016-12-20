//
//  UIView+MyFrame.h
//  百思不得姐
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MyFrame)

@property CGFloat lee_x;
@property CGFloat lee_y;
@property CGFloat lee_w;
@property CGFloat lee_h;
@property CGPoint lee_center;
@property CGFloat lee_centerX;
@property CGFloat lee_centerY;

- (BOOL)hasIntersectWithView:(UIView *)anotherView;
@end
