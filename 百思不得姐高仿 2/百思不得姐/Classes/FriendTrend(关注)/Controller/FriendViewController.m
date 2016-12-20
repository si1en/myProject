//
//  FriendViewController.m
//  百思不得姐
//
//  Created by Apple on 16/10/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "FriendViewController.h"
#import "LogInViewController.h"
@interface FriendViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentTetx;

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
}
- (void)setUpNav
{
    self.navigationItem.leftBarButtonItem = [UINavigationItem setNavItemWithImage:@"friendsRecommentIcon"  andHilightedImage:@"friendsRecommentIcon-click" addTarget:self action:@selector(addFriend)];
    [self.navigationItem setTitle:@"我的关注"];

}

- (IBAction)logInBtnClick:(UIButton *)sender {
    
    LogInViewController *logInVC = [[LogInViewController alloc] init];
    [self presentViewController:logInVC animated:YES completion:nil];
}

- (void)addFriend
{
    LeeFUNC
}
@end
