//
//  HQToast.h
//  HQMytoast
//
//  Created by HQ on 2018/4/23.
//  Copyright © 2018年 HQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQLabel.h"

@interface HQToast : NSObject
{
    HQLabel *hqlabel;
    NSTimer *timer;
    CGFloat timeCount;
}
+ (instancetype)shareInstance;

/// 设置提示文字
- (void)showText:(NSString *)text;

- (void)showText:(NSString *)text currentController:(UIViewController *)currentController responseObject:(id)responseObject;

/// 设置文字属性
- (void)showTextDuration:(CGFloat)duration CornerRadiusNum:(CGFloat)cornerRadiusNum TextBackColor:(UIColor *)textBackColor TextFont:(UIFont *)textFont TextColor:(UIColor *)textColor TextFrame:(CGPoint)textFrame Text:(NSString *)text;
@end
