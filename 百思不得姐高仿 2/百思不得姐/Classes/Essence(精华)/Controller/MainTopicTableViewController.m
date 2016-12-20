//
//  MainTopicTableViewController.m
//  百思不得姐
//
//  Created by Apple on 14/12/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "MainTopicTableViewController.h"
#import "MyDataItem.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "MyContentCell.h"
#import <SDWebImage/SDImageCache.h>
#import "NewViewController.h"
#import "MyHeader.h"
#import "MyFooter.h"

static NSString * const ID = @"topic";

@interface MainTopicTableViewController ()
@property (nonatomic, weak) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *itemArr;
@property (nonatomic, weak) UIView *footer;
@property (nonatomic, weak) UILabel *footerLabel;
@property (nonatomic, weak) UIView *header;
@property (nonatomic, weak) UILabel *headerLabel;

@property (nonatomic,assign,getter=isHeadRefreshing) BOOL headRefreshing;
@property (nonatomic,assign,getter=isFootRefreshing) BOOL footRefreshing;
@property (nonatomic,assign,getter=isFirst) BOOL first; // 是否为第一次加载数据
/** 用来加载下一页数据的 */
@property (nonatomic, copy) NSString *maxtime;

@end

@implementation MainTopicTableViewController

- (ContentType)myType{
    return 0;
};

- (NSMutableArray *)itemArr
{
    if (!_itemArr) {
        _itemArr = [NSMutableArray array];
    }
    return _itemArr;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = LeeColor;
    self.tableView.contentInset = UIEdgeInsetsMake( NavBarH + TitleH, 0, TabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyContentCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    self.first = YES;
    [self loadNewData];
    [self setUpFreshBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealWithTabNotification) name:TabBarNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealWithTitleNotification) name:TitleNotification object:nil];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)dealWithTabNotification{
    if (self.view.window == nil) {
        return;
    }
    if (![self.view hasIntersectWithView:nil]) {
        return;
    }
    
    [self.tableView.mj_header beginRefreshing];
}
- (void)dealWithTitleNotification{
    [self dealWithTabNotification];
}

- (void)setUpFreshBar
{
    MyHeader *header = [MyHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    MyFooter *footer = [MyFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
}
- (NSString *)mylist{
    if ([self.parentViewController isKindOfClass:[NewViewController class]]) {
        return @"newlist";
    }
    return @"list";
}
- (void)loadNewData
{
    _manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.mylist;
    parameters[@"type"] = @(self.myType); // @1
    parameters[@"c"] = @"data";
    [_manager GET:baseURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.itemArr = [MyDataItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        [self.tableView.mj_header endRefreshing];
    }];
    
}


- (void)loadMoreData
{
    _manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.mylist;
    parameters[@"type"] = @(self.myType); // @1
    parameters[@"c"] = @"data";
    parameters[@"maxtime"] = self.maxtime;
    
    [_manager GET:baseURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSMutableArray *newData = [MyDataItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.itemArr addObjectsFromArray:newData];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        [self.tableView.mj_footer endRefreshing];
    
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static UIColor *random = nil;
    if (!random) {
        random = LeeColor;
    }
    MyContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    MyDataItem *item = self.itemArr[indexPath.row];
    cell.dataModel = item;
    return cell;
}

#pragma mark - Table view  delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyDataItem *item = self.itemArr[indexPath.row];
    return item.cellHeight;
}
@end
