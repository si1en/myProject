//
//  TopicPictureView.m
//  百思不得姐
//
//  Created by Apple on 2016/12/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "TopicPictureView.h"
#import "MyDataItem.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import "CheckContentVC.h"

@interface TopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *myPicture;
@property (weak, nonatomic) IBOutlet UIImageView *myGif;
@property (weak, nonatomic) IBOutlet UIButton *clickToBigPicture;


@end

@implementation TopicPictureView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.clickToBigPicture.userInteractionEnabled = NO;
    self.myPicture.userInteractionEnabled = YES;
    [self.myPicture addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushVC)]];
}
- (void)pushVC{
    CheckContentVC *vc = [[CheckContentVC alloc] init];
    vc.myItem = self.item;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}
- (void)setItem:(MyDataItem *)item{
    _item = item;
    self.myGif.hidden = !item.is_gif;
    [self.myPicture sd_setImageWithURL:[NSURL URLWithString:item.image1] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    [self.myPicture loadBigImage:item.image1 smallImage:item.image0 placeholder:@"placeholder"];
    
    CGFloat h = (ScreenW - 2 *Margin) * item.height / item.width;
    if (h > 300) {
        self.clickToBigPicture.hidden = NO;
        self.myPicture.contentMode = UIViewContentModeTop;
        self.myPicture.clipsToBounds = YES;
    }else{
        self.myPicture.contentMode = UIViewContentModeScaleToFill;
        self.clickToBigPicture.hidden = YES;
    }
    
}

@end
