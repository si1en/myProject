//
//  QQLIstTVC.m
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "QQLIstTVC.h"
#import "ListCell.h"
#import "PlayerManager.h"

@interface QQLIstTVC ()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation QQLIstTVC
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initParts];
    [self loadData];
}

- (void)loadData{
    [DataModel loadDataWith:^(NSArray<SingleSong *> *playlist) {
        self.dataArray = playlist;
        [PlayerManager sharedPlayerManager].musicModels = playlist;
    }];
}
- (void)initParts{

    self.navigationController.navigationBarHidden = YES;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QQListBack"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 80;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark -DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCell *cell =[ListCell creatCellWith:tableView];
    SingleSong *song = self.dataArray[indexPath.row];
    cell.song = song;
    // 核心动画
    [cell.layer removeAnimationForKey:@"rotate"];
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
    animation.keyPath = @"transform.translation.x";
    animation.values = @[@10,@0,@-10,@0];
    animation.duration = 0.5;
    [cell.layer addAnimation:animation forKey:@"rotate"];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SingleSong *playSong = self.dataArray[indexPath.row];
    NSLog(@"点击播放%@--%@",playSong.singer,playSong.name);
    [[PlayerManager sharedPlayerManager] playMusicWith:playSong];
    
    [self performSegueWithIdentifier:@"2Detail" sender:nil];
}


@end
