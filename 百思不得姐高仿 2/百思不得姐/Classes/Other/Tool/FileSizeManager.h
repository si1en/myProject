//
//  FileSizeManager.h
//  百思不得姐
//
//  Created by Apple on 16/10/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileSizeManager : NSObject
+ (void)getCurrentMemoryWithPath:(NSString *)filePath completion:(void (^)(CGFloat count))myBlock;

+ (void)deleteMemoryWithPath:(NSString *)filePath;

+ (CGFloat)getFileSize:(NSString *)filePath;
@end
