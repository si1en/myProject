//
//  MyContentCell.m
//  百思不得姐
//
//  Created by Apple on 2016/11/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyContentCell.h"
#import "MyDataItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TopicAudioView.h"
#import "TopicVideoView.h"
#import "TopicPictureView.h"

@interface MyContentCell()

@property (weak, nonatomic) IBOutlet UIImageView *myIcon;
@property (weak, nonatomic) IBOutlet UILabel *myID;
@property (weak, nonatomic) IBOutlet UILabel *myTimeLine;
@property (weak, nonatomic) IBOutlet UILabel *myText;

@property (weak, nonatomic) IBOutlet UILabel *hotComment;
@property (weak, nonatomic) IBOutlet UIView *hotView;

@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *repost;
@property (weak, nonatomic) IBOutlet UIButton *comment;

@property (nonatomic, strong) TopicAudioView *audio;
@property (nonatomic, strong) TopicVideoView *video;
@property (nonatomic, strong) TopicPictureView *picture;

@end

@implementation MyContentCell

- (TopicPictureView *)picture{
    if (!_picture) {
        _picture = [TopicPictureView hw_awakeFromNib];
        [self.contentView addSubview:_picture];
    }
    return _picture;
}
- (TopicVideoView *)video{
    if (!_video) {
        _video = [TopicVideoView hw_awakeFromNib];
        [self.contentView addSubview:_video];
    }
    return _video;
}

- (TopicAudioView *)audio{
    if (_audio == nil) {
        _audio = [TopicAudioView hw_awakeFromNib];
        [self.contentView addSubview:_audio];
    }
    return _audio;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setDataModel:(MyDataItem *)dataModel
{
    _dataModel = dataModel;
    [self.myIcon sd_setImageWithURL:[NSURL URLWithString:dataModel.profile_image]];
    self.myID.text = dataModel.name;
    
    self.myTimeLine.text = [self setUpDate:dataModel.created_at];
    
    self.myText.text = dataModel.text;
    
    if (dataModel.type == TopicTypePicture) {
        
        self.picture.hidden = NO;
        self.video.hidden = YES;
        self.audio.hidden = YES;
        self.picture.item = dataModel;
        
    }else if (dataModel.type == TopicTypeVoice){
        
        self.picture.hidden = YES;
        self.video.hidden = YES;
        self.audio.hidden = NO;
        self.audio.item = dataModel;
    }else if(dataModel.type == TopicTypeVideo){
        
        self.picture.hidden = YES;
        self.video.hidden = NO;
        self.audio.hidden = YES;
        self.video.item = dataModel;
    }else if(dataModel.type == TopicTypeWord){
        self.picture.hidden = YES;
        self.video.hidden = YES;
        self.audio.hidden = YES;
    }
    
    if (dataModel.top_cmt.count) {
        self.hotView.hidden = NO;
        self.hotComment.text = dataModel.hotComment;
    }else{
        self.hotView.hidden = YES;
    }

    NSString *numDing = [NSString stringWithFormat:@"顶 %@",[self setUpNumbers:dataModel.ding]];
    NSString *numCai = [NSString stringWithFormat:@"踩 %@",[self setUpNumbers:dataModel.cai]];
    [self.dingBtn setTitle:numDing forState: UIControlStateNormal];
    [self.caiBtn setTitle:numCai forState:UIControlStateNormal];
}

- (NSString *)setUpDate:(NSString *)creatTime
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yy-MM-dd HH:mm:ss";
    NSDate *creatDate = [format dateFromString:creatTime];
    
    if (creatDate.hw_isThisYear) {
        if (creatDate.hw_isYesterday) {
            format.dateFormat = @"Yesterday HH:mm:ss";
            creatDate = [format dateFromString:creatTime];
            return [format stringFromDate:creatDate];
        }else if (creatDate.hw_isToday){
            NSDateComponents *cmp = [creatDate timeInterval];
            if (cmp.hour > 1) {
                return [NSString stringWithFormat:@"Today %ldh ago",cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"Today %ldmin ago",cmp.minute];
            }else if(cmp.second > 1){
                return @"Just now";
            }
        }
        format.dateFormat = @"MM-dd HH:mm:ss";
        creatDate = [format dateFromString:creatTime];
        return [format stringFromDate:creatDate];
    }
    return [format stringFromDate:creatDate];
}

- (NSString *)setUpNumbers:(NSInteger)number{
    if (number >10000) {
        return [NSString stringWithFormat:@"%.2f万",number / 10000.0];
    }else if (number > 1000){
        return [NSString stringWithFormat:@"%.2f千",number / 1000.0];
    }
    return [NSString stringWithFormat:@"%ld",number];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.dataModel.type == TopicTypePicture){
        self.picture.frame = self.dataModel.centerFrame;
    }else if (self.dataModel.type == TopicTypeVoice){
        self.audio.frame = self.dataModel.centerFrame;
    }else if(self.dataModel.type == TopicTypeVideo){
        self.video.frame = self.dataModel.centerFrame;
    }
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    frame.origin.x += 5;
    frame.size.width -= 10;
    [super setFrame:frame];
}
@end
