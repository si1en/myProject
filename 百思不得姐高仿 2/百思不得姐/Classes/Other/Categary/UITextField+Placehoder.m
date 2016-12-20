//
//  UITextField+Placehoder.m
//  百思不得姐
//
//  Created by Apple on 16/10/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UITextField+Placehoder.h"
#import <objc/message.h>

@implementation UITextField (Placehoder)
+(void)load{
    Method m1 = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method m2 = class_getInstanceMethod(self, @selector(lee_setPlaceholder:));
    method_exchangeImplementations(m1, m2);
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor{

    objc_setAssociatedObject(self, @"placehoderColor", placehoderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel *placehoder = [self valueForKeyPath:@"placeholderLabel"];
    placehoder.textColor = placehoderColor;
    
}

- (UIColor *)placehoderColor{
    return objc_getAssociatedObject(self, @"placehoderColor");;
}

- (void)lee_setPlaceholder:(NSString *)placeholder{
    [self lee_setPlaceholder:placeholder];
    [self setPlacehoderColor:self.placehoderColor];
}

@end
