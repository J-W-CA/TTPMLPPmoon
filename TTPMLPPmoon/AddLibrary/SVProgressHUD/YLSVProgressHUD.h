//
//  YLSVProgressHUD.h
//  DTWork
//
//  Created by 李留振 on 16/8/24.
//  Copyright © 2016年 广州海泉智腾贸易有限公司 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface YLSVProgressHUD : NSObject
/**
 *  等待中
 */
+ (void)showWarning:(NSString *)warning;
/**
 *  请求成功
 */
+ (void)showSuccess:(NSString *)success;
/**
 *  请求失败
 */
+ (void)showError:(NSString *)error;
/**
 *  显示信息
 */
+ (void)showMessage:(NSString *)message;
/**
    只显示信息
 */
+ (void)showOnlyText:(NSString *)message;
/**
 上传下载进度
 */
+ (void)showProgress:(CGFloat)progress;
/**
 *  隐藏
 */
+ (void)hideHUD;
@end
