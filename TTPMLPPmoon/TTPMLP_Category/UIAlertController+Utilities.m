//
//  UIAlertController+Utilities.m
//  CYLTabBarController
//
//  Created by ArvinYi on 2018/12/5.
//  Copyright © 2018年 微博@iOS程序犭袁. All rights reserved.
//

#import "UIAlertController+Utilities.h"


@implementation UIAlertController (Utilities)


/**
 自定义回调弹框(封装多处可以使用)

 @param title 标题
 @param cancel 取消按钮
 @param define 确定按钮
 @param success 回调
 */
+ (void)alertShowTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel  define:(NSString *)define viewController:(UIViewController *)viewController blockBoolHandler:(BlockBoolHandler)flagBool {
    //显示弹出框列表选择
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                             if (flagBool) {
                                                                 flagBool(false);
                                                             }
                                                         }];
    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:define style:UIAlertActionStyleDestructive
                                                       handler:^(UIAlertAction * action) {
                                                           if (flagBool) {
                                                               flagBool(true);
                                                           }
                                                       }];
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    [viewController presentViewController:alert animated:YES completion:nil];
}



@end
