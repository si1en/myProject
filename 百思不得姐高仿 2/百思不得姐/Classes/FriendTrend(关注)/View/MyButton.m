//
//  MyButton.m
//  百思不得姐
//
//  Created by Apple on 16/10/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.lee_x = (self.lee_w - self.imageView.lee_w)*0.5;
    self.imageView.lee_y = 0;
    
    
    [self.titleLabel sizeToFit];
    
    self.titleLabel.lee_x = (self.lee_w - self.titleLabel.lee_w)*0.5;
    self.titleLabel.lee_y = CGRectGetMaxY(self.imageView.frame);
}

@end
