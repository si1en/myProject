//
//  AppDelegate.m
//  百思不得姐
//
//  Created by Apple on 10/11/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "AppDelegate.h"
//#import "MainViewController.h"
#import "ADViewController.h"
#import "MyWindow.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //MainViewController *tab = [[MainViewController alloc] init];
    // self.window.rootViewController = tab;
    ADViewController *ad = [[ADViewController alloc] init];
    self.window.rootViewController = ad;
    [self.window makeKeyAndVisible];
    
    
    [MyWindow sharedWindow].hidden = NO;
    
    [MyWindow sharedWindow].myblock = ^{
        LeeNSLog(@"点击了状态栏区域")
        [self searchScrollInView:[UIApplication sharedApplication].keyWindow];
    };
    
    return YES;
}

- (void)searchScrollInView:(UIView *)view{
    
    if (![view hasIntersectWithView:nil]) {
        return;
    }
    
    for (UIView *subV in view.subviews) {
        [self searchScrollInView:subV];
    }
    
    if (![view isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    UIScrollView *scrollV = (UIScrollView *)view;
    CGPoint offset = scrollV.contentOffset;
    offset.y = - scrollV.contentInset.top;
    [scrollV setContentOffset:offset animated:YES];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
