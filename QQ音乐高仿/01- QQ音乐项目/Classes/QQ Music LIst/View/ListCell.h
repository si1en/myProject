//
//  ListCell.h
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell
@property (nonatomic ,strong) SingleSong *song;
+ (instancetype) creatCellWith:(UITableView *)tableView;

@end
