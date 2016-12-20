//
//  UIView+LoadNib.m
//  百思不得姐
//
//  Created by Apple on 2016/12/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIView+LoadNib.h"

@implementation UIView (LoadNib)

+ (instancetype)hw_awakeFromNib{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

@end
