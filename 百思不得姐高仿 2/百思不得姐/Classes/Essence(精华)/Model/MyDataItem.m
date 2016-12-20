//
//  MyDataItem.m
//  百思不得姐
//
//  Created by Apple on 16/10/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyDataItem.h"

@implementation MyDataItem


- (NSInteger)cellHeight{
    if (_cellHeight) {
        return _cellHeight;
    }
    NSInteger rowHeight = 0;
    NSInteger iconHeight = 35;
    rowHeight = iconHeight + 2 * Margin;
    // 内容文字高度
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    rowHeight += ([self.text boundingRectWithSize:CGSizeMake(ScreenW - 2 * Margin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height + Margin);
    
    //视频 图片等
    if (self.type != TopicTypeWord) {
        CGFloat x = Margin;
        CGFloat y = rowHeight;
        CGFloat w = (ScreenW - 2 * Margin);
        CGFloat h = w * self.height / self.width;
        if (h > 300) {
            h = 300;
        }
        self.centerFrame = CGRectMake(x, y, w, h);
        
        rowHeight += (h + Margin);
     }
    
    //最热评论 有/无 时候的高度
    if (self.top_cmt.count) {
        NSInteger hotTitleHeight = 20;
        rowHeight += ([self.hotComment boundingRectWithSize:CGSizeMake(ScreenW - 2 * Margin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height + Margin + hotTitleHeight);
    }
    rowHeight += (35 + Margin);//cell 底部button 高度
    return rowHeight;
}

- (NSString *)hotComment{
    NSMutableDictionary *dict = self.top_cmt.firstObject;
    NSString *hotUser = dict[@"user"][@"username"];
    NSString *content = dict[@"content"];
    return [NSString stringWithFormat:@"%@ : %@",hotUser,content];
}

@end
