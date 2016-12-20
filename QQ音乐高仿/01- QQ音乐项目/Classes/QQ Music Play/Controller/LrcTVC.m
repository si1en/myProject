//
//  LrcTVC.m
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "LrcTVC.h"
#import "MyCell.h"
@interface LrcTVC ()

@end
@implementation LrcTVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpInit];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.tableView.height * 0.5, 0);

}
- (void)setUpInit
{
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)setModelArr:(NSArray<LrcModel *> *)modelArr
{
    _modelArr = modelArr;
    [self.tableView reloadData];
}
- (void)setCurrentRow:(NSInteger)currentRow
{
   // 对传入的值进行判断
    if (currentRow < 0 || currentRow > self.modelArr.count - 1) {
        return;
    }
    if (_currentRow == currentRow) {
        return;
    }
    _currentRow = currentRow;
    
    [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationFade];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentRow inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyCell *cell = [MyCell creatCellWith:tableView];

    LrcModel *model = self.modelArr[indexPath.row];
    cell.lrcText = model.lrcStr;
    
    if (self.currentRow == indexPath.row) {
        cell.textLabel.textColor = [UIColor greenColor];
    }else{
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    return cell;
}
- (void)setProgress:(float)progress
{
    _progress = progress;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_currentRow inSection:0];
    MyCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.progress = progress;

}
@end
