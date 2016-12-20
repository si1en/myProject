//
//  LrcLabel.m
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "LrcLabel.h"

@implementation LrcLabel

-(void)setRatio:(float)ratio
{
    _ratio = ratio;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [[UIColor greenColor] set];
    
    CGRect fillRect = CGRectMake(0,0,rect.size.width * self.ratio,rect.size.height);
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}

@end
