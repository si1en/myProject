//
//  ADModel.h
//  百思不得姐
//
//  Created by Apple on 16/10/13.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADModel : NSObject
    /** 广告图片*/
    @property (nonatomic, strong) NSString *w_picurl;
    
    // 点击广告图片,进入界面
    @property (nonatomic, strong) NSString *ori_curl;
    
    @property (nonatomic, assign) CGFloat w;
    
    @property (nonatomic, assign) CGFloat h;
    
    
@end
