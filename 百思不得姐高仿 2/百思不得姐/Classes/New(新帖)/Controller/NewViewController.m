//
//  NewViewController.m
//  百思不得姐
//
//  Created by Apple on 16/10/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NewViewController.h"
#import "ListTableViewController.h"
@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    [self setUpNav];
    
}

- (void)setUpNav
    {
        self.navigationItem.leftBarButtonItem = [UINavigationItem setNavItemWithImage:@"MainTagSubIcon"  andHilightedImage:@"MainTagSubIconClick" addTarget:self action:@selector(list)];
        
        [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]]];
    }

- (void)list{
    
    ListTableViewController *listVC = [[ListTableViewController alloc] init];
    [self.navigationController pushViewController:listVC animated:YES];
}

@end
