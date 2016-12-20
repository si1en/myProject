//
//  PlayerManager.h
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerManager : NSObject
// 用过拿到整个模型数组 确定currentSong 的索引 然后通过改变索引进行前后切换歌曲
single_interface(PlayerManager)

@property (nonatomic, strong) NSArray *musicModels;
@property (nonatomic, strong) SingleSong *currentSong;
@property (nonatomic, strong) SongMessageTool *messageTool;

//@property (nonatomic, assign) NSTimeInterval currentTime;
//@property (nonatomic, assign) NSTimeInterval totalTime;

//- (NSString *)setUpTotalTime;

- (void)playMusicWith:(SingleSong *) song;
- (void)pauseCurrentMusic;
- (void)playCurrentMusic;
- (void)goToPreMusic;
- (void)goToNextMusic;

- (void)updateLockScreen;
- (void)startFrom:(NSTimeInterval) time;
@end

