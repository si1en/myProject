//
//  MyDataItem.h
//  百思不得姐
//
//  Created by Apple on 16/10/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyDataItem : NSObject

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *hotComment;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

@property (nonatomic, assign) NSInteger cellHeight;// 模型高度

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, strong) NSArray *top_cmt;

@property (nonatomic, assign) ContentType type;

@property (nonatomic, assign) CGRect centerFrame;

@property (nonatomic, assign) NSInteger voicetime;

@property (nonatomic, assign) NSInteger videotime;

@property (nonatomic, copy) NSString *image0;//小图
@property (nonatomic, copy) NSString *image1;//大图
@property (nonatomic, copy) NSString *image2;//中图

@property (nonatomic, assign) NSInteger playcount;

@property (nonatomic, assign) BOOL is_gif;


@end
