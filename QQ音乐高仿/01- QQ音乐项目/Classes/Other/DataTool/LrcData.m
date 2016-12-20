//
//  LrcData.m
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "LrcData.h"

@implementation LrcData

+ (NSArray<LrcModel *> *)loadLrcWith:(NSString *)lrcName
{
    NSMutableArray *lrcArr = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:lrcName ofType:nil];
    NSString *lrc = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"--lrc%@",lrc);
    
    NSArray *lrcArray = [lrc componentsSeparatedByString:@"\n"];
    
    for (int i = 0; i < lrcArray.count; i++) {
        
        NSString *lrcLine = lrcArray[i];
        
        if ([lrcLine containsString:@"[ti:]"] || [lrc containsString:@"[ar:]"] || [lrc containsString:@"[al:]"]) {
            continue;
        }
        
        NSString *newLine = [lrcLine stringByReplacingOccurrencesOfString:@"[" withString:@""];
        NSArray *lrcResult = [newLine componentsSeparatedByString:@"]"];
    
        LrcModel *model = [[LrcModel alloc] init];
        NSString *beginTime = [lrcResult firstObject];
        model.beginTime = [TimeConvertTool setUpString:beginTime];
        NSString *lrcStr = [lrcResult lastObject];
        model.lrcStr = lrcStr;
        [lrcArr addObject:model];
        
    }
    NSInteger count = lrcArr.count;
    for (int j = 0; j < count; j++) {
        
        if (j == (count - 1)) {
            break;
        }
        LrcModel *model = lrcArr[j];
        LrcModel *modelNext = lrcArr[j+1];
        model.endTime = modelNext.beginTime;
    }
   // NSLog(@"%@",lrcArr);
    return lrcArr;
}


+ (NSInteger)getLrcCurrenRowWith:(NSTimeInterval)currentPlaytime andLrcModels:(NSArray<LrcModel*> *)lrcModels
{
    for (int i = 0; i < lrcModels.count; i++) {
        LrcModel *model = lrcModels[i];
        if (currentPlaytime >= model.beginTime && currentPlaytime < model.endTime) {
            return i;
        }
        
    }
    return lrcModels.count - 1;
}
@end
