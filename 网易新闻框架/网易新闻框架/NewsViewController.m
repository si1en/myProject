//
//  NewsViewController.m
//  网易新闻框架
//
//  Created by Apple on 10/8/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "NewsViewController.h"


#define NavH 64
#define TitleH 44
#define MyWidth  [UIScreen mainScreen].bounds.size.width
#define MyHeight [UIScreen mainScreen].bounds.size.height
static CGFloat const btnW = 100;
static CGFloat const btnScale = 1.2;

@interface NewsViewController ()<UIScrollViewDelegate>
// 命名是避免与系统相同 会产生莫名其妙的错误
@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *btnArr;
@end

@implementation NewsViewController

- (NSMutableArray *)btnArr
{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题栏
    [self setUpTitleView];
    //设置内容栏
    [self setUpContenView];
       self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置标题栏 button
    [self setUpTitleButton];
}

- (void)setUpTitleView
{
    UIScrollView *titleView = [[UIScrollView alloc] init];
    CGFloat titleX = 0;
    CGFloat titleY = self.navigationController ? NavH : 0;
    CGFloat titleH = TitleH;
    CGFloat titleW = MyWidth;
    titleView.frame = CGRectMake(titleX, titleY, titleW, titleH);
    titleView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:titleView];
    _titleScrollView = titleView;
}

- (void)setUpContenView
{
    UIScrollView *contentView = [[UIScrollView alloc] init];
    CGFloat contentX = 0;
    CGFloat contentY = CGRectGetMaxY(self.titleScrollView.frame);
    CGFloat contentH = MyHeight - contentY;
    CGFloat contentW = MyWidth;
    contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    contentView.backgroundColor = [UIColor greenColor];
    contentView.delegate = self;
    [self.view addSubview:contentView];
    _contentScrollView = contentView;
}


- (void)setUpTitleButton
{
    NSInteger count = self.childViewControllers.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnH = TitleH;
    for (int i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = i;
        [self.titleScrollView addSubview:btn];
        [self.btnArr addObject:btn];
        
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        if (i == 0) {
            [self btnClick:btn];
        }
    }
    self.titleScrollView.contentSize = CGSizeMake(count * btnW, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
}

- (void)btnClick:(UIButton *)button
{
    // 设置 button 颜色
    [self setSelectedButtonColor:button];
    [self setButtontToCenter:button];

    // 设置控制器 frame, 添加到对应位置
    NSInteger count = self.childViewControllers.count;
    [self layoutCildVc:button];
    
    self.contentScrollView.contentOffset = CGPointMake(button.tag * MyWidth, 0);
    self.contentScrollView.contentSize = CGSizeMake(count * MyWidth, 0);
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.bounces = NO;
}

- (void)layoutCildVc:(UIButton *)button
{

    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = MyWidth;
    CGFloat height = self.contentScrollView.frame.size.height;
    
    NSInteger i = button.tag;
    UIViewController *vc = self.childViewControllers[i];
    if (vc.view.superview) return;
    x = i * MyWidth;
    vc.view.frame = CGRectMake(x, y, width, height);
    [self.contentScrollView addSubview:vc.view];
    
}

- (void)setSelectedButtonColor:(UIButton *)button
{
    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectedBtn.transform = CGAffineTransformIdentity;
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTransform:CGAffineTransformMakeScale(btnScale, btnScale)];
    _selectedBtn = button;
    [self setButtontToCenter:button];
}

- (void)setButtontToCenter:(UIButton *)button
{
    CGFloat x = button.center.x - MyWidth *0.5;
    if (x < 0) {
        x = 0;
    }
    if (x > self.titleScrollView.contentSize.width - MyWidth) {
        x = self.titleScrollView.contentSize.width - MyWidth;
    }
    CGPoint point = CGPointMake(x, 0);
    [self.titleScrollView setContentOffset:point animated:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger i = scrollView.contentOffset.x / MyWidth;
    // 获得 第 i 个button,使用数组保存
    UIButton *button = self.btnArr[i];
    [self setSelectedButtonColor:button];
    [self layoutCildVc:button];//懒加载形式只有在用到时才加载
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger leftTag = scrollView.contentOffset.x / MyWidth;
    NSInteger rightTag = leftTag + 1;
    UIButton *leftBtn = self.btnArr[leftTag];
    UIButton *rightBtn;
    //rightTag 最大等于 btn的总数
    if (rightTag < self.btnArr.count) {
        rightBtn = self.btnArr[rightTag];
    }
    
    CGFloat rightScale = scrollView.contentOffset.x / MyWidth - leftTag;//0~1
    CGFloat leftScale = 1 - rightScale;//1~0
    
    CGFloat scale = btnScale - 1;
    leftBtn.transform = CGAffineTransformMakeScale(leftScale * scale + 1, leftScale * scale + 1);
    rightBtn.transform =  CGAffineTransformMakeScale(rightScale * scale + 1, rightScale * scale + 1);
    
    [leftBtn setTitleColor:[UIColor colorWithRed:leftScale green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithRed:rightScale green:0 blue:0 alpha:1] forState:UIControlStateNormal];
}
@end
