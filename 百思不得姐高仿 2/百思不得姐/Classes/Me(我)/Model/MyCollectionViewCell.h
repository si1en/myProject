//
//  MyCollectionViewCell.h
//  百思不得姐
//
//  Created by Apple on 16/10/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyItem;
@interface MyCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) MyItem *item;
@end
