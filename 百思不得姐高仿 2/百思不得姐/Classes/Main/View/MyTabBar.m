//
//  MyTabBar.m
//  百思不得姐
//
//  Created by Apple on 16/10/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyTabBar.h"
#import "UIImage+OriginalImage.h"

@interface MyTabBar ()
@property (nonatomic,weak) UIButton *plusBtn;
@property (nonatomic, assign) NSInteger previousClickedTag;
@end
@implementation MyTabBar

- (UIButton *)plusBtn
{
    if (!_plusBtn) {
        
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_plusBtn setImage:[UIImage originalImage:@"tabBar_publish_click_icon"]forState:UIControlStateSelected];
        [_plusBtn sizeToFit];
        [self addSubview:_plusBtn];
    }
    return _plusBtn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
         CGFloat count = self.items.count;
         CGFloat x = 0;
         CGFloat y = 0;
         CGFloat w = self.lee_w / (count + 1);
         CGFloat h = self.bounds.size.height;
         
         CGFloat i = 0;
         //NSLog(@"%@",self.subviews);
    
        for (UIControl *itemBtn in self.subviews) {
            if ([itemBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                if (i == 2) {
                    i = 3;
                }
                x = i * w;
                itemBtn.frame = CGRectMake(x, y, w, h);
                
                itemBtn.tag = i;
                [itemBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                i++;
                
            }
        }
    self.plusBtn.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    
}
- (void)btnClick:(UIControl *)btn{
    if (self.previousClickedTag == btn.tag) {
        LeeNSLog(@"ssdsd");
        [[NSNotificationCenter defaultCenter] postNotificationName:TabBarNotification object:nil];
    }
    self.previousClickedTag = btn.tag;
}
@end
