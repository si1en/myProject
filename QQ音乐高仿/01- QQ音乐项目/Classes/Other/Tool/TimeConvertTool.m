//
//  TimeConvertTool.m
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/25.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "TimeConvertTool.h"

@implementation TimeConvertTool

+ (NSString *)setUpTime:(NSTimeInterval) time
{
    int min = (int)time / 60;
    int sec = (int)time % 60;
    return [NSString stringWithFormat:@"%02zd:%02d",min,sec];
}

+ (NSTimeInterval) setUpString:(NSString *)timeStr
{
    NSArray *arr = [timeStr componentsSeparatedByString:@":"];
    NSInteger min = [[arr firstObject] integerValue];
    double sec = [[arr lastObject] doubleValue];
    
    return (min * 60 + sec);
}

@end
