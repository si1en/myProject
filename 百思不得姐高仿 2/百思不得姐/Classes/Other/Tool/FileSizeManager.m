//
//  FileSizeManager.m
//  百思不得姐
//
//  Created by Apple on 16/10/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "FileSizeManager.h"

@implementation FileSizeManager

+ (void)getCurrentMemoryWithPath:(NSString *)filePath completion:(void (^)(CGFloat count))myBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 获得文件夹  遍历所有文件获得地址  将文件大小叠加
        CGFloat count = 0;
        NSFileManager *manager = [NSFileManager defaultManager];
        //核心代码
        NSArray *subpaths = [manager subpathsAtPath:filePath];
        
        BOOL isDirectory;
        BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || !isDirectory) {
            NSException *exception = [NSException exceptionWithName:filePath reason:@"not a file" userInfo:nil];
            [exception raise];
        }
        
        for (NSString *subPath in subpaths) {
            NSString *myfile = [filePath stringByAppendingPathComponent:subPath];
            BOOL isDirectory;
            BOOL isExist = [manager fileExistsAtPath:myfile isDirectory:&isDirectory];
            if (isExist && !isDirectory && ![myfile containsString:@"DS"]) {
                //核心代码
                NSDictionary *dict = [manager attributesOfItemAtPath:myfile error:nil];
                //NSLog(@"%@",dict[@"NSFileSize"]);
                NSString *fileSize = dict[@"NSFileSize"];
                count += [fileSize floatValue];
                //LeeNSLog(@"%@",[NSThread currentThread]);
            }
        }
        // 在内部进行回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (myBlock) {
                myBlock(count);
               // LeeNSLog(@"%@",[NSThread currentThread]);
            }
        });
    });
}

+ (void)deleteMemoryWithPath:(NSString *)filePath{
    // 获得文件夹  遍历所有文件获得地址  将文件移除
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (!isExist) {
        return;
    }
    if (isDirectory) {
        NSArray *subpaths = [manager subpathsAtPath:filePath];
        for (NSString *subpath in subpaths) {
            NSString *fileFullPath = [filePath stringByAppendingPathComponent:subpath];
            [manager removeItemAtPath:fileFullPath error:nil];
        }
    }else{
        [manager removeItemAtPath:filePath error:nil];
    }
}


+ (CGFloat)getFileSize:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDictionary *dict = [manager attributesOfItemAtPath:filePath error:nil];
    NSString *fileSize = dict[@"NSFileSize"];
    return [fileSize floatValue];
}

@end
