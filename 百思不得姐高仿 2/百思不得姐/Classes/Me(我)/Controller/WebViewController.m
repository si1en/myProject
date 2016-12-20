//
//  WebViewController.m
//  百思不得姐
//
//  Created by Apple on 16/10/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webV;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshBtn;
@property (weak, nonatomic) WKWebView *web;
@property (weak, nonatomic) UIProgressView *progress;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpVC];
    
}
- (IBAction)back:(UIBarButtonItem *)sender {
    [self.web goBack];
}
- (IBAction)forward:(UIBarButtonItem *)sender {
    [self.web goForward];
}
- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self.web reload];
}
- (void)viewDidLayoutSubviews{
    self.web.frame = self.view.bounds;
}
- (void)setUpVC{
    
    WKWebView *web = [[WKWebView alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [web loadRequest:request];
    _web = web;
    [self.view addSubview:web];
    
    UIProgressView *progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 2)];
    progress.backgroundColor = [UIColor greenColor];
    _progress =progress;
    [self.view addSubview:progress];
    
    // 谁添加的谁移除
    [self.web addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.web addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [self.web addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.web addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.web addObserver:self forKeyPath:@"url" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    self.backBtn.enabled = self.web.canGoBack;
    self.forwardBtn.enabled = self.web.canGoForward;
    _progress.progress = self.web.estimatedProgress;
    _progress.hidden = self.web.estimatedProgress < 1 ? NO : YES;
    self.title = _web.title;
}

- (void)dealloc{
    [self.web removeObserver:self forKeyPath:@"canGoBack"];
    [self.web removeObserver:self forKeyPath:@"canGoForward"];
    [self.web removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.web removeObserver:self forKeyPath:@"title"];
    [self.web removeObserver:self forKeyPath:@"url"];
}
@end
