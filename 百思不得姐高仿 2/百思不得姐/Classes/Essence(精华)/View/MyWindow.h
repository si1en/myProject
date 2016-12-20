//
//  MyWindow.h
//  百思不得姐
//
//  Created by Apple on 19/12/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWindowRootVC : UIViewController

@end


@interface MyWindow : UIWindow

+ (instancetype)sharedWindow;

@property (nonatomic, assign, getter = isStatusBarHidden) BOOL statusBarHidden;
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, copy) void (^myblock)();
@end
