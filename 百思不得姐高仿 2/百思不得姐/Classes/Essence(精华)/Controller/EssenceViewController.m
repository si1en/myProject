//
//  EssenceViewController.m
//  百思不得姐
//
//  Created by Apple on 16/10/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "EssenceViewController.h"
#import "MyTitleButton.h"

#import "ALLTableViewController.h"
#import "VideoTableViewController.h"
#import "SoundTableViewController.h"
#import "PictureTableViewController.h"
#import "JokeTableViewController.h"

@interface EssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIView *titleV;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, weak) UIView *bottomLine;
@property (nonatomic, weak) UIScrollView *scroll;
@property (nonatomic, strong) NSMutableArray *btnArr;

@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpScroll];
    [self setUpNav];
    [self setUpTitleView];
}
#pragma mark - 初始化控制器
- (void)setUpScroll{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scroll];
    _scroll = scroll;
    _scroll.pagingEnabled = YES;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.delegate = self;
    _scroll.backgroundColor = LeeColor;
    [self addChildVC];
}

- (void)addChildVC
{
    [self addChildViewController:[[ALLTableViewController alloc] init]];
    [self addChildViewController:[[VideoTableViewController alloc] init]];
    [self addChildViewController:[[SoundTableViewController alloc] init]];
    [self addChildViewController:[[PictureTableViewController alloc] init]];
    [self addChildViewController:[[JokeTableViewController alloc] init]];

    CGFloat count = self.childViewControllers.count;
    self.scroll.contentSize = CGSizeMake(count * ScreenW, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)addChildViewControllerAtIndex:(NSInteger)index{
    UITableViewController *vc = self.childViewControllers[index];
    if (vc.view.superview) {
        return;
    }
    vc.tableView.frame = CGRectMake(index *ScreenW, 0, ScreenW, ScreenH);
    vc.tableView.contentOffset = CGPointMake(0, 100);
    [self.scroll addSubview:vc.view];
}

- (void)setUpTitleView
{
    UIView *titleV = [[UIView alloc] init];
    titleV.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    _titleV = titleV;
    self.titleV.frame = CGRectMake(0, NavBarH, ScreenW, TitleH);
    [self.view addSubview:titleV];
    [self addTitleButton];
    [self addTitleBottomLine];
}

- (void)addTitleBottomLine
{
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = self.selectedBtn.currentTitleColor;
    [self.titleV addSubview:bottomLine];
    _bottomLine = bottomLine;
    
    bottomLine.lee_h = 2;
    bottomLine.lee_y = TitleH - 2;
    [self.selectedBtn.titleLabel sizeToFit];
    bottomLine.lee_w = self.selectedBtn.titleLabel.lee_w + 10;
    // 必须先确定宽度 在确定 center 否则view会从 center.x想有延展
    bottomLine.lee_centerX = self.selectedBtn.lee_centerX;
}

- (void)addTitleButton
{
    NSArray *titleArr = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat count = titleArr.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = ScreenW / 5;
    CGFloat h = TitleH;
    for (int i = 0; i < count; i++) {
        MyTitleButton *btn = [MyTitleButton buttonWithType:UIButtonTypeCustom];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
        btn.tag = i;
        [self.titleV addSubview:btn];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [self btnClick:btn];
        }
        [self.btnArr addObject:btn];
    }
}
- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}
- (void)setUpNav
{
    self.navigationItem.leftBarButtonItem = [UINavigationItem setNavItemWithImage:@"nav_item_game_icon"  andHilightedImage:@"nav_item_game_click_icon" addTarget:self action:@selector(game)];
    self.navigationItem.rightBarButtonItem = [UINavigationItem setNavItemWithImage:@"navigationButtonRandom"  andHilightedImage:@"navigationButtonRandomClick" addTarget:self action:@selector(random)];
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]]];
}

#pragma mark - 点击事件

- (void)btnClick:(MyTitleButton *)button
{
    if (self.selectedBtn == button) {
        [[NSNotificationCenter defaultCenter] postNotificationName:TitleNotification object:nil];
    }
    
    _selectedBtn.selected = NO;
    button.selected = YES;
    _selectedBtn = button;
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomLine.lee_centerX = self.selectedBtn.lee_centerX;
        self.scroll.contentOffset = CGPointMake(button.tag * ScreenW, 0);
        [self addChildViewControllerAtIndex:button.tag];
    }];
}
- (void)game
{
    LeeNSLog(@"game")
    LeeFUNC
}
- (void)random
{
    LeeFUNC
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger count = scrollView.contentOffset.x / ScreenW;
    NSLog(@"%f--%ld",scrollView.contentOffset.x,count);
   // MyTitleButton *btn = self.titleV.subviews[count];
    MyTitleButton *btn = self.btnArr[count];
    [self btnClick:btn];
    
}


@end
