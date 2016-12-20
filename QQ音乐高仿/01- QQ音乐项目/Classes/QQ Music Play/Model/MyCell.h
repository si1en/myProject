//
//  MyCell.h
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
+ (instancetype)creatCellWith:(UITableView *) tableview;
@property (nonatomic, copy) NSString *lrcText;
@property (nonatomic, assign) float progress;
@end
