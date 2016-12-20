//
//  SettingViewController.m
//  百思不得姐
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SettingViewController.h"
#import "FileSizeManager.h"
#import <SVProgressHUD/SVProgressHUD.h>

static NSString * const ID = @"cell";
#define MainPath (NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0])

@interface SettingViewController ()
@property (nonatomic, assign) CGFloat mycount;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTable];
    [SVProgressHUD showWithStatus:@"计算缓存中..."];
    // tableview 一直在后台刷新???
    [FileSizeManager getCurrentMemoryWithPath:MainPath completion:^(CGFloat count) {
        _mycount = count;
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    }];
}
- (void)setUpTable{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    
    cell.textLabel.text = [self getSizeStringWithValue:_mycount];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [FileSizeManager deleteMemoryWithPath:MainPath];
    [FileSizeManager getCurrentMemoryWithPath:MainPath completion:^(CGFloat count) {
        self.mycount = count;
        [self.tableView reloadData];
    }];
    
}

- (NSString *)getSizeStringWithValue:(CGFloat)count{
    NSString *textStr;
    if (count >= (1000 * 1000)) {
        textStr = [NSString stringWithFormat:@"清除缓存(%.1fMB)",count/(1000 * 1000)];
    }else if (count >= 1000){
        textStr = [NSString stringWithFormat:@"清除缓存(%.1fKB)",count/1000];
    }
    return count > 0 ? textStr : @"清除缓存";
}
@end
