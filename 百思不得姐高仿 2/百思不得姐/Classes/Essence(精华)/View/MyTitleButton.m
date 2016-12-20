//
//  MyTitleButton.m
//  百思不得姐
//
//  Created by Apple on 16/10/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyTitleButton.h"

@implementation MyTitleButton

- (void)setHighlighted:(BOOL)highlighted{}

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setFont:[UIFont systemFontOfSize:15]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    //Returning 'self' while it is not set to the result of '[(super or self) init...]'
    return self;
}
@end
