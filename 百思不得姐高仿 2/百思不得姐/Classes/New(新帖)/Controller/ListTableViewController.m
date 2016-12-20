//
//  ListTableViewController.m
//  百思不得姐
//
//  Created by Apple on 16/10/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ListTableViewController.h"
#import <AFNetworking.h>
#import "ListItem.h"
#import <MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MyCell.h"
#import <SVProgressHUD.h>

static NSString *const ID = @"cell";
@interface ListTableViewController ()
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, weak) AFHTTPSessionManager *manager;
@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐标签";
    [self loadData];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}
- (NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (void)loadData
{
    [SVProgressHUD showWithStatus:@"loadding~~"];
    _manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"tag_recommend";
    dict[@"action"] = @"sub";
    dict[@"c"] = @"topic";
    [_manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        [responseObject writeToFile:@"/Users/apple/Desktop/My Code/iOS/13-项目实战/百思不得姐/百思不得姐/Classes/New(新帖)/Controller/list.plist" atomically:YES];
//        for (NSDictionary *dict in responseObject) {
//        ListItem *item = [ListItem mj_objectWithKeyValues:dict];
//        [self.arr addObject:item];
//        }
        _arr = [ListItem mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@",error);
            [SVProgressHUD dismiss];
        }
    }];

}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    ListItem *item = _arr[indexPath.row];
    cell.item = item;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
@end
