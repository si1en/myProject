//
//  MusicPlayer.m
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MusicPlayerTool.h"
@interface MusicPlayerTool()<AVAudioPlayerDelegate>
@end
@implementation MusicPlayerTool

- (instancetype)init
{
    if ([super init]) {
        
        [self playBack];
    }
    return self;
}
- (void)playBack
{
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
}
- (void)playMusicWithName:(NSString *)name
{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:nil];
    if (url == nil) {
        return;
        
    }
    if ([self.currentPlayer.url isEqual:url]) {
        [self.currentPlayer play];
        return;
    }
    // 先进行判断后进行赋值 这样新旧值就可以进行对比
    _currentPlayer= [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    _currentPlayer.delegate = self;
    [self.currentPlayer prepareToPlay];
    [self.currentPlayer play];
}


- (void)musicStop
{
    [self.currentPlayer stop];
    self.currentPlayer.currentTime = 0;
}
- (void)musicPause
{
    [self.currentPlayer pause];
}

- (void)currentMusicContinue
{
    [self.currentPlayer play];
}
- (void)currentMusicPause
{
    [self.currentPlayer pause];
}
- (void)startFrom:(NSTimeInterval)time
{
    self.currentPlayer.currentTime = time;

}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationNext object:nil];
    }

}
@end
