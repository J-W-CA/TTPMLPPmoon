//
//  LMCameraManager.h
//  Test1030
//
//  Created by xx11dragon on 15/10/30.
//  Copyright © 2015年 xx11dragon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPUImageFilterGroup;
/**
 *  闪光灯模式
 */
typedef NS_ENUM(NSInteger, LMCameraManagerFlashMode) {
    
    LMCameraManagerFlashModeAuto, //自动
    
    LMCameraManagerFlashModeOff, //关闭
    
    LMCameraManagerFlashModeOn //打开
};

/**
 *  摄像头模式
 */
typedef NS_ENUM(NSInteger, LMCameraManagerDevicePosition) {
    
    LMCameraManagerDevicePositionBack, //后摄像头
    
    LMCameraManagerDevicePositionFront //前摄像头
};

@interface LMCameraManager : NSObject
//    摄像头位置
@property (nonatomic , assign) LMCameraManagerDevicePosition position;
//    闪光灯模式
@property (nonatomic , assign) LMCameraManagerFlashMode flashMode;


- (id)initWithFrame:(CGRect)frame superview:(UIView *)superview;
//    设置对焦的图片
- (void)setfocusImage:(UIImage *)focusImage;

- (void)startCamera;

- (void)stopCamera;
//    拍照
- (void)snapshotSuccess:(void(^)(UIImage *image))success
        snapshotFailure:(void (^)(void))failure;


//    添加滤镜组
- (void)addFilters:(NSArray *)filters;
//    设置滤镜
- (void)setFilterAtIndex:(NSInteger)index;

@end
