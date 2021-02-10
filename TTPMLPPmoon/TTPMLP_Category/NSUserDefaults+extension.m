//
//  NSUserDefaults+extension.m
//  CYLTabBarController
//
//  Created by arvin on 2018/7/4.
//  Copyright © 2018年 微博@iOS程序犭袁. All rights reserved.
//

#import "NSUserDefaults+extension.h"


@implementation NSUserDefaults (extension)

// 默认值
+ (void)SMDS_appRegisterDefaults {
    NSDictionary *defaultValues = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:FuzzyStatusMosaic_One], @"FuzzyStatus_Defaults", // 默认
                                   [NSNumber numberWithFloat:0.5], @"BrushSize_Defaults", // 画笔大小
                                   nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
    
}

// 保存当前用户是否是的模糊值
+ (void)saveCurrentFuzzyStatus:(NSInteger)fuzzyStatus {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setInteger:fuzzyStatus forKey:@"FuzzyStatus_Defaults"];
    
}

// 获取当前用户是否是的模糊值
+ (NSInteger)getCurrentFuzzyStatus {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    return [user integerForKey:@"FuzzyStatus_Defaults"];
    
}

// 保存当前用户画笔大小
+ (void)saveCurrentBrushSize:(float)brushSize {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setFloat:brushSize forKey:@"BrushSize_Defaults"];
    
}

// 获取当前用户画笔大小
+ (float)getCurrentBrushSize {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    return [user floatForKey:@"BrushSize_Defaults"];
    
}


@end
