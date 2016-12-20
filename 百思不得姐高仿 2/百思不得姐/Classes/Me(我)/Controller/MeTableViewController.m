//
//  MeTableViewController.m
//  百思不得姐
//
//  Created by Apple on 16/10/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MeTableViewController.h"
#import "SettingViewController.h"
#import "MyCollectionViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "MyItem.h"
#import "WebViewController.h"
#import <SafariServices/SafariServices.h>
#import "WebViewController.h"

static NSInteger const cols = 4;
static NSInteger const marrgin = 1;
#define cellWH ((ScreenW - marrgin * (cols - 1))/4)
static NSString * const ID = @"cell";

@interface MeTableViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray *itemsArr;

@end

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setUpFooter];
    [self requestForItemData];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   // NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
}

- (void)setUpFooter{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(cellWH, cellWH);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collection = collection;
    [collection registerNib:[UINib nibWithNibName:NSStringFromClass([MyCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    collection.dataSource = self;
    collection.delegate = self;
    collection.scrollEnabled = NO;
    collection.backgroundColor = [UIColor lightGrayColor];
    
    self.tableView.tableFooterView = collection;
}

- (void)requestForItemData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    [manager GET:baseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       _itemsArr = [MyItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        [self resolveData];
        CGFloat rows = ((self.itemsArr.count - 1) / cols + 1);
        self.collection.lee_h = rows * cellWH;
        self.tableView.tableFooterView = _collection;
        [self.collection reloadData];
        // 对footerView的高度重新赋值,tableVIew 需要重新刷新才会将其高度计算在contensize内,如果不刷新的话 tableView 计算数值不准确,就会出现多出的部分;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (void)resolveData{
    if (self.itemsArr.count) {
        NSUInteger count = cols - self.itemsArr.count % 4;
        for (int i = 0; i < count; i++) {
            MyItem *item = [[MyItem alloc] init];
            [_itemsArr addObject:item];
        }
    }
}

- (void)setUpNav
{
    UIBarButtonItem *item1 = [UINavigationItem setNavItemWithImage:@"mine-setting-icon" andHilightedImage:@"mine-setting-icon-click" addTarget:self action:@selector(set)];
    
    UIBarButtonItem *item2 = [UINavigationItem setNavItemWithImage:@"mine-moon-icon" andSelectedImage:@"mine-sun-icon-click" addTarget:self action:@selector(select:)];
        self.navigationItem.rightBarButtonItems = @[item1,item2];
        [self.navigationItem setTitle:@"我的"];
}
- (void)select:(UIButton *)btn
{
    btn.selected = !btn.selected;
}
- (void)set{
    SettingViewController *vc = [[SettingViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",NSStringFromCGRect(cell.frame));
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemsArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    MyItem *item = self.itemsArr[indexPath.row];
    cell.item = item;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MyItem *item = self.itemsArr[indexPath.row];
    //打开相应网页
    if ([item.url hasPrefix:@"http"]) {
    //  SFSafariViewController *savc =[[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:item.url]];
        WebViewController *webvc = [[WebViewController alloc] init];
        webvc.url = [NSURL URLWithString:item.url];
        webvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webvc animated:YES];
    }
}

@end
