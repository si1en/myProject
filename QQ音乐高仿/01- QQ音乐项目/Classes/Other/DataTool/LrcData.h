//
//  LrcData.h
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LrcModel;
@interface LrcData : NSObject
+ (NSArray<LrcModel *> *)loadLrcWith:(NSString *)lrcName;
+ (NSInteger)getLrcCurrenRowWith:(NSTimeInterval)currentPlaytime andLrcModels:(NSArray<LrcModel *> *)lrcModels;
@end

