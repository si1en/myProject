//
//  MyCollectionViewCell.m
//  百思不得姐
//
//  Created by Apple on 16/10/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "MyItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MyCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *itemName;

@end
@implementation MyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(MyItem *)item{
    _item = item;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    self.itemName.text = item.name;
}
@end
