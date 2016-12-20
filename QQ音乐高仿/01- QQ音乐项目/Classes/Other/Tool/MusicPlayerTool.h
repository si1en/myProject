//
//  MusicPlayer.h
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicPlayerTool : NSObject
@property (nonatomic, strong) AVAudioPlayer *currentPlayer;

- (void)playMusicWithName:(NSString *)name;
- (void)musicStop;
- (void)musicPause;

- (void)currentMusicContinue;
- (void)currentMusicPause;
- (void)startFrom:(NSTimeInterval)time;
@end
