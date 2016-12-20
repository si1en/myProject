//
//  ADViewController.m
//  百思不得姐
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ADViewController.h"
#import "MainViewController.h"
#import <AFNetworking.h>
#import "ADModel.h"
#import <MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>

static NSString * const code2 = @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam";



@interface ADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageV;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) ADModel *model;
@property (nonatomic,strong) NSTimer *timer;

@end
@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 屏幕适配
    [self setUpLauchImage];
    [self loaddingADs];
  _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_timer invalidate];
}

- (void)setUpLauchImage{
    self.button.hidden = YES;
    if (iPhone4) { // iPhone4
        _myImageV.image = [UIImage imageNamed:@"LaunchImage-700"];
    } else if (iPhone5) {
        _myImageV.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if (iPhone6) {
        _myImageV.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iPhone6p) {
        _myImageV.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h"];
    }
}
    //加载网络图片
- (void)loaddingADs{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"code2"] = code2;
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
       // NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //解析返回的数据  并对图片进行赋值
       // NSLog(@"%@",responseObject);
        //[responseObject writeToFile:@"/Users/apple/Desktop/My Code/iOS/13-项目实战/百思不得姐/百思不得姐/Classes/AD(广告)/ad.plist" atomically:YES];
        NSDictionary *adDict = [responseObject[@"ad"] firstObject];
        
        _model = [ADModel mj_objectWithKeyValues:adDict];
        if (_model) {
            CGFloat height = ScreenW * _model.h/_model.w;
            CGRect rect =  CGRectMake(0, 0, ScreenW, height);
            UIImageView *imageV = [[UIImageView alloc] init];
            imageV.frame = rect;
            imageV.userInteractionEnabled = YES;
            [imageV sd_setImageWithURL:[NSURL URLWithString:_model.w_picurl]];
            [self.adView addSubview:imageV];
        }
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToApp)];
        [self.adView addGestureRecognizer:tap];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            LeeNSLog(@"%@",error);
        }
    }];
    

}
- (void)updateTime
{
    static NSInteger  t = 3;//static 只会加载一次内存
    self.button.hidden = NO;
    _button.titleLabel.text = [NSString stringWithFormat:@"跳转(%lu)",t];
    
    if (t==0) {
        [self jump:nil];
    }
    t --;
    
}
- (IBAction)jump:(id)sender {
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}
- (void)jumpToApp{
    
   // NSLog(@"lol");
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:_model.ori_curl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_model.ori_curl]];
    }

}
@end
