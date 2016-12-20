//
//  UIImage+Extension.m
//  01- QQ音乐项目
//
//  Created by Apple on 16/8/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
- (UIImage *)creatNewImageWithLrcName:(NSString *)lrc
{
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName : [UIColor whiteColor],
                           NSFontAttributeName : [UIFont systemFontOfSize:20],
                           NSParagraphStyleAttributeName : style
                           };
    
    [lrc drawInRect:CGRectMake(0, 0, self.size.width, 30) withAttributes:dict];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
