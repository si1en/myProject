//
//  GlobalNavViewController.m
//  百思不得姐
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "GlobalNavViewController.h"

@interface GlobalNavViewController ()<UIGestureRecognizerDelegate>
@end

@implementation GlobalNavViewController

+(void)load{
    
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [bar setTitleTextAttributes:dict];
    
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSLog(@"%@",self.interactivePopGestureRecognizer);
    // <UIScreenEdgePanGestureRecognizer: 0x7fe6e3477570; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fe6e34790c0>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fe6e3536320>)>>
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate  action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
}

    
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count) {
    viewController.navigationItem.leftBarButtonItem = [UINavigationItem setBackNavItemWithImage:@"navigationButtonReturn" andSelectedImage:@"navigationButtonReturnClick" addTarget:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)back{
    [self popViewControllerAnimated:YES];
}
    
    
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count > 1;
}

@end
