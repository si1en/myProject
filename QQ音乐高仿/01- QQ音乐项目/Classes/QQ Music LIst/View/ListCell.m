//
//  ListCell.m
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ListCell.h"

@interface ListCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@end
@implementation ListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageV.layer.cornerRadius = self.imageV.frame.size.width *0.5;
    self.imageV.layer.masksToBounds = YES;
}


+ (instancetype) creatCellWith:(UITableView *)tableView
{
    static NSString *ID = @"list";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)setSong:(SingleSong *)song
{
    _song = song;
    self.imageV.image = [UIImage imageNamed:song.singerIcon];
    self.titleLabel.text = song.name;
    self.singerLabel.text = song.singer;
}
@end
