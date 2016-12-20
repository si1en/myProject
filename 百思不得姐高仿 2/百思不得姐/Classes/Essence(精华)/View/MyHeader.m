//
//  MyHeader.m
//  百思不得姐
//
//  Created by Apple on 14/12/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "MyHeader.h"
@interface MyHeader ()
@property (nonatomic, weak) UIImageView *imagev;
@end

@implementation MyHeader

- (void)prepare{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    
    [self setTitle:@"Idel" forState:MJRefreshStateIdle];
    [self setTitle:@"Pulling" forState:MJRefreshStatePulling];
    [self setTitle:@"Refreshing" forState:MJRefreshStateRefreshing];
    
   // self.lastUpdatedTimeLabel.hidden = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:15];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.imagev = imageV;
    [self addSubview:imageV];
}
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.imagev.lee_y = - self.imagev.lee_h;
    self.imagev.lee_center = CGPointMake(self.lee_w * 0.5, self.imagev.lee_y);

}
@end
