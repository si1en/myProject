//
//  LogRegisterView.m
//  百思不得姐
//
//  Created by Apple on 16/10/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "LogRegisterView.h"


@interface LogRegisterView ()
@property (weak, nonatomic) IBOutlet UIButton *logInBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@end

@implementation LogRegisterView

+ (instancetype)logInView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil][0];
}
+ (instancetype)registerInView{
 return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil][1];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self stretchableImage:_logInBtn];
    [self stretchableImage:_registerBtn];
    
}

- (void)stretchableImage:(UIButton *)btn{
    
    UIImage *image = btn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    
    UIImage *hilight = [btn backgroundImageForState:UIControlStateHighlighted];
    hilight = [hilight stretchableImageWithLeftCapWidth:hilight.size.width*0.5  topCapHeight:hilight.size.height*0.5];
    [btn setBackgroundImage:hilight forState:UIControlStateHighlighted];

}
@end
