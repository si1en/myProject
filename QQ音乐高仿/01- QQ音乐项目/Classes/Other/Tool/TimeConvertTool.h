//
//  TimeConvertTool.h
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/25.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeConvertTool : NSObject
+ (NSString *)setUpTime:(NSTimeInterval) time;
+ (NSTimeInterval) setUpString:(NSString *)timeStr;
@end
