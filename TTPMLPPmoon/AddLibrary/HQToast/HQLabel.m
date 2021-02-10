//
//  HQLabel.m
//  HQMytoast
//
//  Created by HQ on 2018/4/23.
//  Copyright © 2018年 HQ. All rights reserved.
//

#import "HQLabel.h"

@implementation HQLabel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:14];
        self.layer.cornerRadius = 4.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor blackColor];
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
- (void)setToastText:(NSString *)toastText LabelFrame:(CGPoint)labelFrame
{
    [self setText:toastText];
    
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil];
    
    CGFloat width = rect.size.width + 20;
    CGFloat height = rect.size.height + 20 + 20;
    
    CGFloat x;
    CGFloat y;
    
    if (labelFrame.x > 0 || labelFrame.y > 0) {
        x = labelFrame.x;
        y = labelFrame.y;
        
    }else{
        x = ([UIScreen mainScreen].bounds.size.width-width)/2;
        y = [UIScreen mainScreen].bounds.size.height/2-height/2;
        
    }
    self.frame = CGRectMake(x, y, width, height);
}

@end
