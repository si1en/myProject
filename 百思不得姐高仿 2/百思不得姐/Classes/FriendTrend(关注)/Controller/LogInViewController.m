//
//  LogInViewController.m
//  百思不得姐
//
//  Created by Apple on 16/10/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "LogInViewController.h"
#import "LogRegisterView.h"
#import "FastLogInView.h"
@interface LogInViewController ()

@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (nonatomic, weak) LogRegisterView *logView;
@property (nonatomic, weak) LogRegisterView *registerView;
@property (nonatomic, weak) FastLogInView *fast;
@property (weak, nonatomic) IBOutlet FastLogInView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constriantX;
@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _logView = [LogRegisterView logInView];
    [self.middleView addSubview:_logView];
     _registerView = [LogRegisterView registerInView];
    [self.middleView addSubview:_registerView];

    _fast = [FastLogInView loadMyXib];
    [self.bottomView addSubview:_fast];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelEdit)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)cancelEdit{
    
    self.editing = NO;
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _logView.frame = CGRectMake(0, 0, ScreenW, self.middleView.lee_h);
    _registerView.frame = CGRectMake(ScreenW, 0, ScreenW, self.middleView.lee_h);
    _fast.frame = self.bottomView.bounds;
}

- (IBAction)back:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)logInResisterBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.5 animations:^{
        //NSLog(@"%f",self.middleView.lee_x);
        self.constriantX.constant = self.constriantX.constant ? 0 : (-ScreenW);
        // 直接修改其 frame 值第一次点击的时候不会移动,只有设置其NSLayoutConstraint的值才会移动
        //NSLog(@"%f",self.middleView.lee_x);
        [self.view layoutIfNeeded];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
