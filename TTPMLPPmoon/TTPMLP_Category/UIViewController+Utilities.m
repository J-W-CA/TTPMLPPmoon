//
//  UIViewController+Utilities.m
//  CYLTabBarController
//
//  Created by 易香城 on 2018/8/7.
//  Copyright © 2018年 微博@iOS程序犭袁. All rights reserved.
//

#import "UIViewController+Utilities.h"


@implementation UIViewController (Utilities)


// （通过class定位返回）
+ (void)BackClassViewController:(UIViewController *)parentVC ToViewController:(UIViewController *)toViewController {
    BOOL flag = true;
    for (UIViewController *controller in parentVC.navigationController.viewControllers) {
        if ([controller isKindOfClass:[toViewController class]] ) {
            flag = false;
            [parentVC.navigationController popToViewController:controller animated:YES];
        }
    }
    if (flag) {
        // 无法返回就返回当前最顶层
        UIViewController *topmostVC = parentVC.navigationController.viewControllers[0];
        [parentVC.navigationController popToViewController:topmostVC animated:YES];
    }
}


// 获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

@end
