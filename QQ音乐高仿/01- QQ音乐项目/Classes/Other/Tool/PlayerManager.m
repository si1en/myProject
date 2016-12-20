//
//  PlayerManager.m
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "PlayerManager.h"
#import "MusicPlayerTool.h"
#import <MediaPlayer/MediaPlayer.h>
@interface PlayerManager()
@property (nonatomic, strong) MusicPlayerTool *player;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation PlayerManager

single_implementation(PlayerManager)

- (MusicPlayerTool *)player
{
    if (_player == nil) {
        _player = [[MusicPlayerTool alloc] init];
    }
    return _player;
}


- (void)setCurrentIndex:(NSInteger)currentIndex
{
    NSInteger count = self.musicModels.count;
    if (currentIndex > count - 1) {
        currentIndex = 0;
    }
    if (currentIndex < 0) {
        currentIndex = count - 1;
    }
    
    _currentIndex = currentIndex;
}


/*
//- (NSTimeInterval)currentTime
//{
//    return self.player.player.currentTime;
//}
//- (NSTimeInterval)totalTime
//{
//    return self.player.player.duration;
//
//}
//
//- (NSString *)setUpTotalTime
//{
//    int min = (int)self.totalTime / 60;
//    int sec = (int)self.totalTime % 60;
//    return [NSString stringWithFormat:@"%02zd:%02d",min,sec];
//}
*/

- (void)updateLockScreen
{
    SongMessageTool *message = self.messageTool;
    // 锁屏显示
    MPNowPlayingInfoCenter *infoCenter = [MPNowPlayingInfoCenter defaultCenter];
    
    /**
     // MPMediaItemPropertyAlbumTitle
     // MPMediaItemPropertyAlbumTrackCount
     // MPMediaItemPropertyAlbumTrackNumber
     // MPMediaItemPropertyArtist
     // MPMediaItemPropertyArtwork
     // MPMediaItemPropertyComposer
     // MPMediaItemPropertyDiscCount
     // MPMediaItemPropertyDiscNumber
     // MPMediaItemPropertyGenre
     // MPMediaItemPropertyPersistentID
     // MPMediaItemPropertyPlaybackDuration
     // MPMediaItemPropertyTitle
     */
    // 重新生成新的带有歌词的 image;
    

     UIImage *image = [UIImage imageNamed:message.songModel.icon];
     NSArray *lrcModels = [LrcData loadLrcWith:message.songModel.lrcname];
     NSInteger num =  [LrcData getLrcCurrenRowWith:message.currentTime andLrcModels:lrcModels];
     LrcModel *model = lrcModels[num];
    
     UIImage *newImage = [image creatNewImageWithLrcName:model.lrcStr];
    
     MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:newImage];
     NSDictionary *dict = @{
                           MPMediaItemPropertyAlbumTitle : message.songModel.name,
                           MPMediaItemPropertyArtist : message.songModel.singer,
                           MPMediaItemPropertyArtwork : artwork,
                           MPMediaItemPropertyPlaybackDuration : @(message.totalTime),
                           MPNowPlayingInfoPropertyElapsedPlaybackTime : @(message.currentTime)
                           };
    
     [infoCenter setNowPlayingInfo:dict];
    
     [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

- (SongMessageTool *)messageTool
{
    if (_messageTool == nil) {
        _messageTool = [[SongMessageTool alloc] init];
    }
    _messageTool.currentTime = self.player.currentPlayer.currentTime;
    _messageTool.totalTime = self.player.currentPlayer.duration;
    _messageTool.songModel = self.currentSong;
    _messageTool.isPlaying = self.player.currentPlayer.isPlaying;
    return _messageTool;
}

//*************************音乐播放*********************************************//

- (void)playMusicWith:(SingleSong *)song
{
    self.currentSong = song;
    [self.player playMusicWithName:song.filename];
    
    NSArray *filename = [self.musicModels valueForKey:@"filename"];
    self.currentIndex = [filename indexOfObject:song.filename];
    
}
- (void)pauseCurrentMusic
{
    [self.player currentMusicPause];
}
- (void)playCurrentMusic
{
    [self.player currentMusicContinue];
}
- (void)goToPreMusic
{
    self.currentIndex --;
    self.currentSong = self.musicModels[self.currentIndex];
    NSLog(@"%ld",self.currentIndex);
    [self.player playMusicWithName:self.currentSong.filename];
}

- (void)startFrom:(NSTimeInterval)time
{
    [self.player startFrom:time];
}


- (void)goToNextMusic
{
    self.currentIndex ++;
    self.currentSong = self.musicModels[self.currentIndex];
    [self.player playMusicWithName:self.currentSong.filename];
}

@end
