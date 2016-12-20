//
//  DataModel.m
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DataModel.h"
#import "MJExtension.h"
@implementation DataModel
+ (void)loadDataWith:(void(^)(NSArray<SingleSong *> *playlist)) resultBlock
{
    NSArray *list = [SingleSong objectArrayWithFilename:@"Musics.plist"];
    resultBlock(list);
}
@end

