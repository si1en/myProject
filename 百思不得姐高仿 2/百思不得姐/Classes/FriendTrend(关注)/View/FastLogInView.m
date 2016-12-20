//
//  FastLogInView.m
//  百思不得姐
//
//  Created by Apple on 16/10/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "FastLogInView.h"

@implementation FastLogInView

+ (instancetype)loadMyXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil][0];
}

@end
