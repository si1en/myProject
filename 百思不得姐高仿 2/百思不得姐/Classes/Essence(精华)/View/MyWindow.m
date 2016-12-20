//
//  MyWindow.m
//  百思不得姐
//
//  Created by Apple on 19/12/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "MyWindow.h"


@implementation  MyWindowRootVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (BOOL)prefersStatusBarHidden{
    return [MyWindow sharedWindow].statusBarHidden;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return [MyWindow sharedWindow].statusBarStyle;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    void (^block)() = [MyWindow sharedWindow].myblock;
    if (block) {
        block();
    }
}

@end


@interface MyWindow ()<NSCopying>

@end

@implementation MyWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (point.y > 20) {
        return nil;
    }
    return [super hitTest:point withEvent:event];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle{
    _statusBarStyle = statusBarStyle;
    [self.rootViewController setNeedsStatusBarAppearanceUpdate];
}
- (void)setStatusBarHidden:(BOOL)statusBarHidden{
    _statusBarHidden = statusBarHidden;
    [self.rootViewController setNeedsStatusBarAppearanceUpdate];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
     [super setBackgroundColor:[UIColor clearColor]];
}

static MyWindow *mywindow;

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.statusBarHidden = NO;
        self.windowLevel = UIWindowLevelAlert;
        self.statusBarStyle = UIStatusBarStyleDefault;
        self.rootViewController = [[MyWindowRootVC alloc] init];
    }
    return self;
}

+ (instancetype)sharedWindow{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mywindow = [[self alloc] init];
    });
    return mywindow;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mywindow = [super allocWithZone:zone];
    });
    return mywindow;
}

- (id)copyWithZone:(NSZone *)zone{

    return mywindow;
}

@end
