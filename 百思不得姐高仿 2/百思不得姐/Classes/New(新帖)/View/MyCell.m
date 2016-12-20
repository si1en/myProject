//
//  MyCell.m
//  百思不得姐
//
//  Created by Apple on 16/10/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyCell.h"
#import "ListItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imagV;
@property (weak, nonatomic) IBOutlet UILabel *nameTitle;
@property (weak, nonatomic) IBOutlet UILabel *numberTitle;

@end
@implementation MyCell

+ (instancetype)creatCell{
    return [[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:self options:nil][0];
}
- (void)awakeFromNib{
    [super awakeFromNib];
}
- (void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    [super setFrame:frame];

}
- (void)setItem:(ListItem *)item{
    _item  = item;

    [self.imagV sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
//        self.imagV.layer.cornerRadius = self.imagV.lee_h*0.5;
//        self.imagV.layer.masksToBounds = YES;
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        [path addClip];
        [image drawAtPoint:CGPointZero];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.imagV.image = image;
        
    }];
    self.nameTitle.text = item.theme_name;
    NSString *str = [NSString stringWithFormat:@"%ld人",item.sub_number];
    if (item.sub_number > 10000.0) {
        str = [NSString stringWithFormat:@"%.2f万人",item.sub_number / 10000.0];
    }
    self.numberTitle.text = str;
    
}

- (IBAction)dingyue:(UIButton *)sender {
    sender.selected = !sender.selected;
    LeeNSLog(@"已订阅");
}

@end
