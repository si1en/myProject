//
//  LrcTVC.h
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LrcTVC : UITableViewController

@property (nonatomic, strong) NSArray<LrcModel *> *modelArr;
@property (nonatomic, assign) NSInteger currentRow;
@property (nonatomic, assign) float progress;

@end
