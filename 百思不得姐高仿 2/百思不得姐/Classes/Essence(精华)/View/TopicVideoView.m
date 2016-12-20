//
//  TopicVideoView.m
//  百思不得姐
//
//  Created by Apple on 2016/12/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "TopicVideoView.h"
#import <UIImageView+WebCache.h>
#import "CheckContentVC.h"
#import "MyDataItem.h"

@interface TopicVideoView()
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *playTime;
@property (weak, nonatomic) IBOutlet UIImageView *backImageV;

@end

@implementation TopicVideoView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.backImageV.userInteractionEnabled = YES;
    [self.backImageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushVC)]];
}
- (void)pushVC
{
    CheckContentVC *vc = [[CheckContentVC alloc] init];
    vc.myItem = self.item;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)setItem:(MyDataItem *)item
{
    _item = item;
    NSInteger m = item.videotime / 60;
    NSInteger s = item.videotime % 60;
    
    self.playTime.text = [NSString stringWithFormat:@"%02ld:%ld",m,s];
    
    if (self.item.playcount > 10000) {
        self.playCount.text = [NSString stringWithFormat:@"%.2f万播放",item.playcount / 10000.0];
    }else if(self.item.playcount > 1000){
        self.playCount.text = [NSString stringWithFormat:@"%.2f千播放",item.playcount/1000.0];
    }else{
        self.playCount.text = [NSString stringWithFormat:@"%ld播放",item.playcount];
    }
    
    [self.backImageV sd_setImageWithURL:[NSURL URLWithString:item.image1] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    CGFloat h = (ScreenW - 2 * Margin) * item.height / item.width;
    if (h > 300) {
        self.backImageV.contentMode = UIViewContentModeTop;
        self.backImageV.clipsToBounds = YES;
    }else{
        self.backImageV.contentMode = UIViewContentModeScaleToFill;
    }
    
}


@end
