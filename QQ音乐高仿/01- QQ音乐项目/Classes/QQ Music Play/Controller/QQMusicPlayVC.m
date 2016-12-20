//
//  QQMusicPlayVC.m
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "QQMusicPlayVC.h"
#import "PlayerManager.h"
#import "LrcTVC.h"
#import "LrcLabel.h"
@interface QQMusicPlayVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
// top
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIButton *more;
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UILabel *singer;
// center
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *singerIcon;
@property (weak, nonatomic) IBOutlet LrcLabel *lrcLabel;
@property (weak, nonatomic) LrcTVC *lrcTVC;
// bottom
@property (weak, nonatomic) IBOutlet UIButton *playAndPauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *preSong;
@property (weak, nonatomic) IBOutlet UIButton *nextSong;
@property (weak, nonatomic) IBOutlet UILabel *currentPlayTime;
@property (weak, nonatomic) IBOutlet UILabel *totalSongTime;
@property (weak, nonatomic) IBOutlet UISlider *timeProgress;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CADisplayLink *link;
@end

@implementation QQMusicPlayVC


#pragma mark - Lazy Loading

- (LrcTVC *)lrcTVC
{
    if (!_lrcTVC) {
        LrcTVC *tableV = [[LrcTVC alloc] init];
        _lrcTVC = tableV;
        [self addChildViewController:_lrcTVC];
    }
    return _lrcTVC;
}


#pragma mark - Systerm

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpInit];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self reloadViewDataOneTime];
    [self startTimer];
    [self startDisplay];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2.0, 0);
    self.lrcTVC.tableView.frame = self.scrollView.bounds;
    CGRect frame = self.lrcTVC.tableView.frame;
    frame.origin.x = self.view.frame.size.width;
    self.lrcTVC.tableView.frame = frame;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.singerIcon.layer.cornerRadius = self.singerIcon.frame.size.width * 0.5;
    self.singerIcon.layer.masksToBounds = YES;
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self.timer invalidate];
    self.timer = nil;
    
    [self.link invalidate];
    self.link = nil;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

// *******************自定义方法***************************
- (void)setUpInit
{
    [self.scrollView addSubview:self.lrcTVC.tableView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.timeProgress setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextMusicPlay:) name:KNotificationNext object:nil];
}


- (void)reloadViewDataOneTime
{
    PlayerManager *manager = [PlayerManager sharedPlayerManager];
    self.backImage.image = [UIImage imageNamed:manager.currentSong.icon];
    self.singerIcon.image = [UIImage imageNamed:manager.currentSong.icon];
    self.songName.text = manager.currentSong.name;
    self.singer.text = manager.messageTool.songModel.singer;
    self.totalSongTime.text = [TimeConvertTool setUpTime:manager.messageTool.totalTime];
    [self startRotate];
    
    self.playAndPauseBtn.selected = manager.messageTool.isPlaying;
    if (self.playAndPauseBtn.selected) {
        [self.singerIcon.layer resumeAnimate];
    }else
    {
        [self.singerIcon.layer pauseAnimate];
    }
    self.lrcTVC.modelArr = [LrcData loadLrcWith:manager.currentSong.lrcname];
    
    
}
- (void)updateLrc
{
    PlayerManager *manager = [PlayerManager sharedPlayerManager];
    // 加载歌词数据

    NSInteger num = [LrcData getLrcCurrenRowWith:manager.messageTool.currentTime andLrcModels:self.lrcTVC.modelArr];
    self.lrcTVC.currentRow = num;
    
    LrcModel *lrcModel = self.lrcTVC.modelArr[num];

    self.lrcLabel.text = lrcModel.lrcStr;
    
    self.lrcLabel.ratio = (manager.messageTool.currentTime - lrcModel.beginTime) / (lrcModel.endTime - lrcModel.beginTime);
    
    [manager updateLockScreen];
    self.lrcTVC.progress = self.lrcLabel.ratio;
}


- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    PlayerManager *manager = [PlayerManager sharedPlayerManager];
    switch (event.subtype) {

        case UIEventSubtypeRemoteControlPlay: {
            [manager playCurrentMusic];
            break;
        }
        case UIEventSubtypeRemoteControlPause: {
            [manager pauseCurrentMusic];
            break;
        }

        case UIEventSubtypeRemoteControlNextTrack: {
            [manager goToNextMusic];
            break;
        }
        case UIEventSubtypeRemoteControlPreviousTrack: {
            [manager goToPreMusic];
            break;
        }
        default:
            break;
    }
    [self reloadViewDataOneTime];
}


- (void)startRotate
{
    [self.singerIcon.layer removeAnimationForKey:@"roll"];
    
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.fromValue = 0;
    animation.toValue = @((M_PI)*2);
    animation.repeatCount = NSIntegerMax;
    animation.duration = 30;
    animation.keyPath =  @"transform.rotation.z";
    animation.removedOnCompletion = NO;
    
    [self.singerIcon.layer addAnimation:animation forKey:@"roll"];

}
//********************************定时刷新界面*******************

- (void)updateViewScheduled
{
    PlayerManager *manager = [PlayerManager sharedPlayerManager];
    self.currentPlayTime.text = [TimeConvertTool setUpTime:manager.messageTool.currentTime];
    self.timeProgress.value = manager.messageTool.currentTime / manager.messageTool.totalTime;
}

- (void)startTimer
{
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateViewScheduled) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)startDisplay
{
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrc)];
    self.link = link;
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

// ******************************点击事件***************************

- (IBAction)nextMusicPlay:(UIButton *)sender {
    [[PlayerManager sharedPlayerManager] goToNextMusic];
    [self reloadViewDataOneTime];
}
- (IBAction)musicPlay:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        NSLog(@"play Music");
        [[PlayerManager sharedPlayerManager] playCurrentMusic];
        [self.singerIcon.layer resumeAnimate];
    }else
    {
        NSLog(@"pause Music");
        [[PlayerManager sharedPlayerManager] pauseCurrentMusic];
        [self.singerIcon.layer pauseAnimate];
    }
}
- (IBAction)preMusicPlay:(UIButton *)sender {
    [[PlayerManager sharedPlayerManager] goToPreMusic];
    [self reloadViewDataOneTime];
}

- (IBAction)quit:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



/**
 *  点击进度条 切换音乐进度
 */


- (IBAction)valueChange:(UISlider *)sender {
    NSTimeInterval time = sender.value * [PlayerManager sharedPlayerManager].messageTool.totalTime;
    
    self.currentPlayTime.text = [TimeConvertTool setUpTime:time];

}

- (IBAction)touchINside:(UISlider *)sender {
    
  NSTimeInterval time = sender.value * [PlayerManager sharedPlayerManager].messageTool.totalTime;
    [[PlayerManager sharedPlayerManager] startFrom:time];
    [self startTimer];
}
- (IBAction)touchDown:(UISlider *)sender {
    
    [self.timer invalidate];
    self.timer = nil;
}


- (IBAction)tapInprogress:(UITapGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:self.timeProgress];
    CGFloat ratio = point.x / self.timeProgress.width;
    self.timeProgress.value = ratio;
    [self touchINside:self.timeProgress];
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat ratio = 1 - scrollView.contentOffset.x / self.view.frame.size.width;
    self.singerIcon.alpha = ratio;
    self.lrcLabel.alpha = ratio;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
