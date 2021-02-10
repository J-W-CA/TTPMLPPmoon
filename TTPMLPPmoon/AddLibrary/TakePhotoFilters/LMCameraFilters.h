//
//  LMCameraFilters.h
//  GPUImageDemo
//
//  Created by xx11dragon on 15/9/22.
//  Copyright © 2015年 xx11dragon. All rights reserved.
//

#import "GPUImage.h"

@interface LMCameraFilters : NSObject

//    正常
+ (GPUImageFilterGroup *)normal;

+ (GPUImageFilterGroup *)saturation;

+ (GPUImageFilterGroup *)exposure;

+ (GPUImageFilterGroup *)contrast;

+ (GPUImageFilterGroup *)testGroup1;

+ (GPUImageFilterGroup *)testGroup2;

+ (GPUImageFilterGroup *)testGroup3;


+ (GPUImageFilterGroup *)ImageRGBFilter:(NSString *)title red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;


@end
