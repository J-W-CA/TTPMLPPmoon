//
//  YLSVProgressHUD.m
//  DTWork
//
//  Created by 李留振 on 16/8/24.
//  Copyright © 2016年 广州海泉智腾贸易有限公司 All rights reserved.
//

#import "YLSVProgressHUD.h"
#import "UIImage+GIF.h"

@implementation YLSVProgressHUD
#define IS_NEWHUD  0        //为0时用原先的加载失败hud，为1时用新的hud
#define NEW_IMAGEVIEW_TAG   999

#define afterTime 1.0 // 悬浮层等待时间
/**
 *  请求等待
 */
+(void)showWarning:(NSString *)warning{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showInfoWithStatus:warning];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  (int64_t)(afterTime * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
/**
 *  请求成功
 */
+ (void)showSuccess:(NSString *)success{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showSuccessWithStatus:success];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  (int64_t)(afterTime * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        [self hideHUD];
    });
}
/**
 *  请求失败
 */
+ (void)showError:(NSString *)error{
    if (IS_NEWHUD) {
        //新的加载失败hud效果
        [SVProgressHUD setMinimumDismissTimeInterval:afterTime];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        //通过kvc获取SVProgressHUD的私有变量
        UIImageView *imageView = [[SVProgressHUD sharedView]valueForKey:@"imageView"];
        UIView *hudView = [[SVProgressHUD sharedView] valueForKey:@"hudView"];
        CGRect imgFrame = imageView.frame;
        //重新设置图片大小
        imgFrame.size = CGSizeMake(68, 68);
        imageView.frame = imgFrame;
        UIImageView *newImageView = [[UIImageView alloc]init];
        newImageView.tag = NEW_IMAGEVIEW_TAG;
        newImageView.frame = imgFrame;
        for (UIView *subView in hudView.subviews) {
            if (subView.tag == NEW_IMAGEVIEW_TAG) {
                [subView removeFromSuperview];
            }
        }
        
        [hudView insertSubview:newImageView atIndex:0];
        newImageView.image = [UIImage imageNamed:@"加载失败"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
        [SVProgressHUD setForegroundColor:nil];
        [SVProgressHUD setErrorImage:nil];
        [SVProgressHUD showErrorWithStatus:nil];
        
    }else{
        //原先的加载失败hud效果
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showErrorWithStatus:error];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  (int64_t)(afterTime * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            [self hideHUD];
        });
    }
   
}

/**
 *  显示信息
 */
+ (void)showMessage:(NSString *)message{
    if (IS_NEWHUD) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"加载" ofType:@"gif"];
        NSData *localGifData = [NSData dataWithContentsOfFile:path];
        UIImage *newImage = [UIImage sd_animatedGIFWithData:localGifData];
        //通过kvc获取SVProgressHUD的私有变量
        UIImageView *imageView = [[SVProgressHUD sharedView]valueForKey:@"imageView"];
        CGRect imgFrame = imageView.frame;
        //重新设置图片大小
        imgFrame.size = CGSizeMake(68, 68);
        imageView.frame = imgFrame;
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
        [SVProgressHUD setInfoImage:newImage];
        [SVProgressHUD showInfoWithStatus:nil];
    }else{
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:message];
    }
}
/**
 只显示信息
 */
+ (void)showOnlyText:(NSString *)message{
    
    [SVProgressHUD showOnlyText: message];
}
/**
 上传下载进度
 */
+ (void)showProgress:(CGFloat)progress{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showProgress:progress];
}
/**
 *  隐藏
 */
+ (void)hideHUD{
    [SVProgressHUD dismiss];
}
@end
