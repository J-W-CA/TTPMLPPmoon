//
//  config.h
//  AVFoundationCamera
//
//  Created by ArvinMini on 2017/7/31.
//  Copyright © 2017年 cmjstudio. All rights reserved.
//

#ifndef config_h
#define config_h


/**
 *  模糊状态
 */
typedef NS_ENUM(NSUInteger, FuzzyStatus) {
    FuzzyStatusMosaic_One = 0, // 马赛克1(默认值)
    FuzzyStatusMosaic_Two, // 马赛克2
    FuzzyStatusMap_One, // 贴图1
    FuzzyStatusMap_Two, // 贴图2
    FuzzyStatusColor_One, // 涂鸦颜色1
    FuzzyStatusColor_Two, // 涂鸦颜色2
    FuzzyStatusColor_Three, // 涂鸦颜色3
};


#endif /* config_h */
