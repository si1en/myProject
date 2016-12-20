//
//  MainViewController.m
//  百思不得姐
//
//  Created by Apple on 16/10/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MainViewController.h"

#import "EssenceViewController.h"
#import "FriendViewController.h"
#import "MeTableViewController.h"
#import "NewViewController.h"
#import "UIImage+OriginalImage.h"
#import "GlobalNavViewController.h"

#import "MyTabBar.h"
@interface MainViewController ()

@end

@implementation MainViewController

+(void)load{
    
    UITabBarItem *item =  [UITabBarItem appearanceWhenContainedIn:[self class], nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:dict1 forState:UIControlStateSelected];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildViewControllers];
    [self setUpTabBar];
    // 在系统他tabbar加载子控件之前,重写 tabbar方法
   // NSLog(@"%@",self.tabBar.subviews);
    [self setUpTabBarItem];
}

- (void)setUpTabBarItem
{
    MyTabBar *myTab = [[MyTabBar alloc] init];
    [self setValue:myTab forKey:@"tabBar"];
}

- (void)setUpChildViewControllers{
    
    EssenceViewController *vc = [[EssenceViewController alloc] init];
    GlobalNavViewController *nav = [[GlobalNavViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    NewViewController *vc1 = [[NewViewController alloc] init];
    GlobalNavViewController *nav1 = [[GlobalNavViewController alloc] initWithRootViewController:vc1];
    [self addChildViewController:nav1];
    
    FriendViewController *vc3 = [[FriendViewController alloc] init];
    GlobalNavViewController *nav3 = [[GlobalNavViewController alloc] initWithRootViewController:vc3];
    [self addChildViewController:nav3];


    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([MeTableViewController class]) bundle:nil];
    MeTableViewController *me = [storyboard instantiateInitialViewController];
    GlobalNavViewController *nav4 = [[GlobalNavViewController alloc] initWithRootViewController:me];
    [self addChildViewController:nav4];
    
}

- (void)setUpTabBar
{
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.selectedImage = [UIImage originalImage:@"tabBar_essence_click_icon"];
    
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.selectedImage = [UIImage originalImage:@"tabBar_new_click_icon"];
    
//    UINavigationController *nav2 = self.childViewControllers[2];
//    nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
//    nav2.tabBarItem.title = @"发布";
//    nav2.tabBarItem.selectedImage = [UIImage originalImage:@"tabBar_publish_click_icon"];
    
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.selectedImage = [UIImage originalImage:@"tabBar_friendTrends_click_icon"];
    
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.selectedImage = [UIImage originalImage:@"tabBar_me_click_icon"];

}
@end
