//
//  HQToast.m
//  HQMytoast
//
//  Created by HQ on 2018/4/23.
//  Copyright © 2018年 HQ. All rights reserved.
//

#import "HQToast.h"

@implementation HQToast
+ (instancetype)shareInstance
{
    static HQToast *hqtoast = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hqtoast = [[HQToast alloc] init];
    });
    return hqtoast;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        hqlabel = [[HQLabel alloc] init];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(changeTimeCount) userInfo:nil repeats:YES];
        timer.fireDate = [NSDate distantFuture];
    }
    return self;
}
- (void)changeTimeCount
{
    if (timeCount-- <= 0) {
        timer.fireDate = [NSDate distantFuture];
        [UIView animateWithDuration:0.25f animations:^{
            hqlabel.alpha = 0;
        } completion:^(BOOL finished) {
            [hqlabel removeFromSuperview];
        }];
    }
}

- (void)showText:(NSString *)text
{
    if ([text length] == 0) {
        return;
    }
//    [MBProgressHUD hideHUD:nil]; // 强制隐藏悬浮
    [self setToastText:text Duration:1.8 CornerRadiusNum:4.0 LabelBackColor:[UIColor blackColor] LabelFont:[UIFont systemFontOfSize:14] LabelColor:[UIColor whiteColor] LabelFrame:CGPointMake(0, 0)];
}

- (void)showText:(NSString *)text currentController:(UIViewController *)currentController responseObject:(id)responseObject
{
    if ([text length] == 0) {
        return;
    }
//    [MBProgressHUD hideHUD:nil]; // 强制隐藏悬浮
    if (currentController != nil) {
        [self setToastText:text Duration:1.8 CornerRadiusNum:4.0 LabelBackColor:[UIColor blackColor] LabelFont:[UIFont systemFontOfSize:14] LabelColor:[UIColor whiteColor] LabelFrame:CGPointMake(0, 0)];
    }
}

- (void)showTextDuration:(CGFloat)duration CornerRadiusNum:(CGFloat)cornerRadiusNum TextBackColor:(UIColor *)textBackColor TextFont:(UIFont *)textFont TextColor:(UIColor *)textColor TextFrame:(CGPoint)textFrame Text:(NSString *)text
{
    if ([text length] == 0) {
        return;
    }
    
    [self setToastText:text Duration:duration CornerRadiusNum:cornerRadiusNum LabelBackColor:textBackColor LabelFont:textFont LabelColor:textColor LabelFrame:textFrame];
    
}
- (void)setToastText:(NSString *)text Duration:(CGFloat)duration CornerRadiusNum:(CGFloat)cornerRadiusNum LabelBackColor:(UIColor *)labelBackColor LabelFont:(UIFont *)labelFont LabelColor:(UIColor *)labelColor LabelFrame:(CGPoint)labelFrame
{
    [hqlabel setToastText:text LabelFrame:labelFrame];
    [[[UIApplication sharedApplication] keyWindow] addSubview:hqlabel];
    hqlabel.alpha = 0.8;
    timer.fireDate = [NSDate distantPast];
    timeCount = duration;
    hqlabel.layer.cornerRadius = cornerRadiusNum;
    hqlabel.backgroundColor = labelBackColor;
    hqlabel.font = labelFont;
    hqlabel.textColor = labelColor;
}
@end
