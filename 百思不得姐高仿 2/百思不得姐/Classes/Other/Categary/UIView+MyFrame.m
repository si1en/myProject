//
//  UIView+MyFrame.m
//  百思不得姐
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIView+MyFrame.h"

@implementation UIView (MyFrame)

- (BOOL)hasIntersectWithView:(UIView *)anotherView
{
    if (anotherView == nil) {
        anotherView = [UIApplication sharedApplication].keyWindow;
    }
    CGRect rect1 = [self convertRect:self.bounds toView:nil];
    CGRect rect2 = [anotherView convertRect:anotherView.bounds toView:nil];
    return CGRectIntersectsRect(rect1, rect2);
}

- (void)setLee_x:(CGFloat)lee_x
{
    CGRect rect = self.frame;
    rect.origin.x = lee_x;
    self.frame = rect;
}

- (void)setLee_y:(CGFloat)lee_y
    {
        CGRect rect = self.frame;
        rect.origin.y = lee_y;
        self.frame = rect;
    }
    
    - (void)setLee_w:(CGFloat)lee_w
    {
        CGRect rect = self.frame;
        rect.size.width = lee_w;
        self.frame = rect;
    }
    
    - (void)setLee_h:(CGFloat)lee_h
    {
        CGRect rect = self.frame;
        rect.size.height = lee_h;
        self.frame = rect;
    }
    
    - (CGFloat)lee_x{
    
        return self.frame.origin.x;
    }
    - (CGFloat)lee_y{
        
        return self.frame.origin.y;
    }
    - (CGFloat)lee_w{
        
        return self.frame.size.width;
    }
    - (CGFloat)lee_h{
        
        return self.frame.size.height;
    }

- (void)setLee_center:(CGPoint)lee_center{
    CGPoint center = self.center;
    center.x = lee_center.x;
    center.y = lee_center.y;
    self.center = center;
}
- (CGPoint)lee_center{
    return self.center;
}

- (void)setLee_centerX:(CGFloat)lee_centerX{
    CGPoint center = self.center;
    center.x = lee_centerX;
    self.center = center;
}
- (CGFloat)lee_centerX{
    return self.center.x;
}

- (void)setLee_centerY:(CGFloat)lee_centerY{
    CGPoint center = self.center;
    center.y = lee_centerY;
    self.center = center;
}
- (CGFloat)lee_centerY{
    return self.center.y;
}

@end
