//
//  NSUserDefaults+extension.h
//  CYLTabBarController
//
//  Created by arvin on 2018/7/4.
//  Copyright © 2018年 微博@iOS程序犭袁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (extension)

+ (void)SMDS_appRegisterDefaults;


// 保存当前用户是否是的模糊值
+ (void)saveCurrentFuzzyStatus:(NSInteger)fuzzyStatus;
// 获取当前用户是否是的模糊值
+ (NSInteger)getCurrentFuzzyStatus;

// 保存当前用户画笔大小
+ (void)saveCurrentBrushSize:(float)brushSize;

// 获取当前用户画笔大小
+ (float)getCurrentBrushSize;

@end
