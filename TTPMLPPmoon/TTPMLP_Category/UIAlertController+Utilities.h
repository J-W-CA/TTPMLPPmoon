//
//  UIAlertController+Utilities.h
//  CYLTabBarController
//
//  Created by ArvinYi on 2018/12/5.
//  Copyright © 2018年 微博@iOS程序犭袁. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (Utilities)

+ (void)alertShowTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel  define:(NSString *)define viewController:(UIViewController *)viewController blockBoolHandler:(BlockBoolHandler)flagBool;


@end

NS_ASSUME_NONNULL_END
