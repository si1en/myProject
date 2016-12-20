//
//  VideoTableViewController.m
//  百思不得姐
//
//  Created by Apple on 16/10/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ALLTableViewController.h"

//#import "MyDataItem.h"
//#import <AFNetworking.h>
//#import <MJExtension/MJExtension.h>
//#import "MyContentCell.h"
//#import <SDWebImage/SDImageCache.h>
//
//#import "MyHeader.h"
//#import "MyFooter.h"
//
//static NSString * const ID = @"topic";

@interface ALLTableViewController ()

//@property (nonatomic, weak) AFHTTPSessionManager *manager;
//@property (nonatomic, strong) NSMutableArray *itemArr;
//@property (nonatomic, weak) UIView *footer;
//@property (nonatomic, weak) UILabel *footerLabel;
//@property (nonatomic, weak) UIView *header;
//@property (nonatomic, weak) UILabel *headerLabel;
//
//@property (nonatomic,assign,getter=isHeadRefreshing) BOOL headRefreshing;
//@property (nonatomic,assign,getter=isFootRefreshing) BOOL footRefreshing;
//@property (nonatomic,assign,getter=isFirst) BOOL first; // 是否为第一次加载数据
///** 用来加载下一页数据的 */
//@property (nonatomic, copy) NSString *maxtime;
//


@end

@implementation ALLTableViewController

- (ContentType)myType{
    return TopicTypeAll;
};

//- (NSMutableArray *)itemArr
//{
//    if (!_itemArr) {
//        _itemArr = [NSMutableArray array];
//    }
//    return _itemArr;
//}
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.view.backgroundColor = LeeColor;
//    self.tableView.contentInset = UIEdgeInsetsMake( NavBarH + TitleH, 0, TabBarH, 0);
//    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyContentCell class]) bundle:nil] forCellReuseIdentifier:ID];
//    
//    self.first = YES;
//    [self loadNewData];
//    [self setUpFreshBar];
//}
//- (void)setUpFreshBar
//{
//    
//   MyHeader *header = [MyHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    [self.tableView.mj_header beginRefreshing];
//    MyFooter *footer = [MyFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    self.tableView.mj_header = header;
//    self.tableView.mj_footer = footer;
//    [self setUpFooter];
//    [self setUpHeader];
//}

/*
//- (void)setUpFooter
//{
//    UIView *footer = [[UIView alloc] init];
//    footer.backgroundColor = LeeColor;
//    footer.lee_h = 35;
//    _footer = footer;
//    self.tableView.tableFooterView = footer;
//    
//    UILabel *footerLabel = [[UILabel alloc] initWithFrame:footer.bounds];
//    footerLabel.text = @"上拉进行刷新";
//    footerLabel.textColor = [UIColor whiteColor];
//    footerLabel.textAlignment = NSTextAlignmentCenter;
//    _footerLabel = footerLabel;
//    [self.footer addSubview:footerLabel];
//
//}
//- (void)setUpHeader
//{
//    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, -35, ScreenW, 35)];
//    header.backgroundColor = LeeColor;
//    _header = header;
//    [self.tableView addSubview:header];
//    UISwitch *sw = [[UISwitch alloc] init];
//    sw.lee_h = 20;
//    self.tableView.tableHeaderView = sw;
//    UILabel *headerLabel = [[UILabel alloc] initWithFrame:self.header.bounds];
//    headerLabel.text = @"下拉进行刷新";
//    headerLabel.textColor = [UIColor whiteColor];
//    headerLabel.textAlignment = NSTextAlignmentCenter;
//    _headerLabel = headerLabel;
//    [self.header addSubview:headerLabel];
//}
*/

//- (void)loadNewData
//{
//    _manager = [AFHTTPSessionManager manager];
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"a"] = @"list";
//    parameters[@"type"] = @"1"; // @1
//    parameters[@"c"] = @"data";
//    [_manager GET:baseURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//     self.maxtime = responseObject[@"info"][@"maxtime"];
//     self.itemArr = [MyDataItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//    [self.tableView reloadData];
//    self.headRefreshing = NO;
//    if (!self.first) {
//            [UIView animateWithDuration:0.5 animations:^{
//                UIEdgeInsets inset = self.tableView.contentInset;
//                inset.top -= 35;
//                self.tableView.contentInset = inset;
//            }];
//            
//        }
//        [self.tableView.mj_header endRefreshing];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//        
//        [self.tableView.mj_header endRefreshing];
        // 不适用框架时手动设置相应模块的显示
        /*
        self.headRefreshing = NO;
        [UIView animateWithDuration:0.5 animations:^{
            UIEdgeInsets inset = self.tableView.contentInset;
            inset.top -= 35;
            self.tableView.contentInset = inset;
        }];
//         */
//    }];
//         
//}
//
//- (void)loadMoreData
//{
//    _manager = [AFHTTPSessionManager manager];
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"a"] = @"list";
//    parameters[@"type"] = @"1"; // @1
//    parameters[@"c"] = @"data";
//    [_manager GET:baseURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//       
//        self.maxtime = responseObject[@"info"][@"maxtime"];
//        
////        [responseObject writeToFile:@"/Users/apple/Desktop/My Code/iOS/13-项目实战/百思不得姐/百思不得姐/Classes/Essence(精华)/ss.plist" atomically:YES];
//        
//        NSMutableArray *newData = [MyDataItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        [self.itemArr addObjectsFromArray:newData];
//        [self.tableView reloadData];
//        
////        self.footRefreshing = NO;
////        self.footerLabel.text = @"上拉进行刷新";
//        
//        [self.tableView.mj_footer endRefreshing];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//       
//        NSLog(@"%@",error);
//        
////        self.footRefreshing = NO;
////        self.footerLabel.text = @"上拉进行刷新";
//        
//        [self.tableView.mj_footer endRefreshing];
//        
//    }];
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return self.itemArr.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static UIColor *random = nil;
//    if (!random) {
//        random = LeeColor;
//    }
//    MyContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    MyDataItem *item = self.itemArr[indexPath.row];
//    cell.dataModel = item;
//    return cell;
//}
//
//#pragma mark - Table view  delegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    MyDataItem *item = self.itemArr[indexPath.row];
//    return item.cellHeight;
//}
//#pragma mark - scroll滚动监听从而设置其刷新控件
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   // NSLog(@"%f",scrollView.contentOffset.y);
    
    [[SDImageCache sharedImageCache] clearMemory];//滚动式清楚缓存
    
    CGFloat offsetHY = -(NavBarH + TitleH + 35);
    if (scrollView.contentOffset.y <= offsetHY) {
        if (self.headRefreshing) {
            return;
        }
        self.headerLabel.text = @"松开加载更多数据...";
        self.headRefreshing = YES;
        self.header.backgroundColor = LeeColor;
    }else{
     self.headerLabel.text = @"下拉加载更多数据...";
     self.headRefreshing = NO;
    }

    CGFloat offsetFY = scrollView.contentSize.height - ScreenH + TabBarH;
    if (scrollView.contentOffset.y >= offsetFY) {
        if (self.footRefreshing) {
            return;
        }
        [UIView animateWithDuration:0.5 animations:^{
            self.footerLabel.text = @"正在刷新...";
            self.footRefreshing = YES;
            [self loadMoreData];
        }];
    } else{
        self.footerLabel.text = @"上拉刷新...";
        self.footRefreshing = NO;
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    CGFloat offsetHY = -(NavBarH + TitleH + 35);
    if (self.tableView.contentOffset.y <= offsetHY) {
        self.headRefreshing = YES;
        self.headerLabel.text = @"正在刷新...";
        self.header.backgroundColor = LeeColor;
        [UIView animateWithDuration:0.5 animations:^{
            UIEdgeInsets inset = self.tableView.contentInset;
            inset.top += 35;
            self.tableView.contentInset = inset;
            self.first = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self loadNewData];
            });
        }];
    }
}
*/
@end
