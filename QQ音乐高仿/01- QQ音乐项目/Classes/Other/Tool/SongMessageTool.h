//
//  SongMessageTool.h
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/25.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SongMessageTool : NSObject

@property (nonatomic, strong) SingleSong *songModel;
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) NSTimeInterval totalTime;
@property (nonatomic, assign) BOOL isPlaying;
@end
