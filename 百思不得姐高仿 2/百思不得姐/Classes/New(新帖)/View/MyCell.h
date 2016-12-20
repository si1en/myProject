//
//  MyCell.h
//  百思不得姐
//
//  Created by Apple on 16/10/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListItem;
@interface MyCell : UITableViewCell
+ (instancetype)creatCell;
@property (nonatomic, strong) ListItem *item;
@end
