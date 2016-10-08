//
//  MyViewController.m
//  网易新闻框架
//
//  Created by Apple on 10/8/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "MyViewController.h"
#import "TopViewController.h"
#import "HotViewController.h"
#import "VideoViewController.h"
#import "SocietyViewController.h"
#import "ReaderViewController.h"
#import "ScienceViewController.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpChildViewControllers];//父类需在 viewwillappear 中设置 titleButton ,不能在 viewDidLoad 中设置,因为要先加载子控制器,才能确定 titleButton 个数,子类会调用父类viewwillappear
}



- (void)setUpChildViewControllers
{
    TopViewController *topVc = [[TopViewController alloc] init];
    topVc.title = @"头条";
    [self addChildViewController:topVc];
    
    // 热点
    HotViewController *hotVc = [[HotViewController alloc] init];
    hotVc.title = @"热点";
    [self addChildViewController:hotVc];
    
    // 视频
    VideoViewController *videoVc = [[VideoViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    // 社会
    SocietyViewController *societyVc = [[SocietyViewController alloc] init];
    societyVc.title = @"社会";
    [self addChildViewController:societyVc];
    
    // 订阅
    ReaderViewController *readerVc = [[ReaderViewController alloc] init];
    readerVc.title = @"订阅";
    [self addChildViewController:readerVc];
    
    // 科技
    ScienceViewController *scienceVc = [[ScienceViewController alloc] init];
    scienceVc.title = @"科技";
    [self addChildViewController:scienceVc];
}

@end
