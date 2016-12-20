//
//  MyCell.m
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyCell.h"
@interface MyCell()

@property (weak, nonatomic) IBOutlet LrcLabel *textLrc;

@end
@implementation MyCell

+ (instancetype)creatCellWith:(UITableView *) tableview
{
    static NSString *ID = @"lrc";
    MyCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}

- (void)setLrcText:(NSString *)lrcText
{
    _lrcText = lrcText;
    self.textLrc.text = lrcText;
}
- (void)setProgress:(float)progress
{
    _progress = progress;
    self.textLrc.ratio = progress;

}
@end
