//
//  MyTextField.m
//  百思不得姐
//
//  Created by Apple on 16/10/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyTextField.h"
#import "UITextField+Placehoder.h"
@implementation MyTextField

- (void)awakeFromNib{
    self.tintColor = [UIColor whiteColor];
    self.placehoderColor = [UIColor lightGrayColor];
    [self addTarget:self action:@selector(beginEditTextField) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(endEditTextField) forControlEvents:UIControlEventEditingDidEnd];
}
- (void)beginEditTextField{

    self.placehoderColor = [UIColor whiteColor];
    }
- (void)endEditTextField{
    self.placehoderColor = [UIColor lightGrayColor];
}
@end
