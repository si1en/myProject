//
//  DataModel.h
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleSong.h"

@interface DataModel : NSObject
+ (void)loadDataWith:(void(^)(NSArray<SingleSong *> *playlist)) resultBlock;
@end
