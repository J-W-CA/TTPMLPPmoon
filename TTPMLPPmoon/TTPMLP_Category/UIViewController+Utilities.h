//
//  UIViewController+Utilities.h
//  CYLTabBarController
//
//  Created by 易香城 on 2018/8/7.
//  Copyright © 2018年 微博@iOS程序犭袁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utilities)

+ (void)BackClassViewController:(UIViewController *)parentVC ToViewController:(UIViewController *)toViewController;

+ (UIViewController *)getCurrentVC;


@end
