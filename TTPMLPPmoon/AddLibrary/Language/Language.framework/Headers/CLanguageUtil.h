//
//  CLanguageUtil.h
//  eCarry
//
//  Created by whde on 16/1/6.
//  Copyright © 2016年 whde. All rights reserved.
//
// GitHub:https://github.com/whde/WhdeLocalized
#import <Foundation/Foundation.h>
typedef NS_OPTIONS (NSInteger, Language){
    Language_Default,
    Language_EN,
    Language_Hans,
    Language_Hant
};
#define LANGUAGE_CHANGE_NOTIFICATION @"LANGUAGE_CHANGE_NOTIFICATION"
#define CLocalizedString(key) NSLocalizedStringFromTableInBundle(key, @"Localizable", [CLanguageUtil bundle], nil)
#define CLocalizedNibName(key) [CLanguageUtil localizedNibName:key]
#define CLocalizedImgName(key) NSLocalizedStringFromTableInBundle(key, @"ImageLocalized", [CLanguageUtil bundle], nil)

@interface CLanguageUtil : NSObject
+(NSBundle *)bundle;//获取当前资源文件

// 获取当前语言
+ (Language)getCurrentLanguage;

// 设置语言
+ (void)setCurrentLanguage:(Language)language;

// 获取语言文件夹下的xib文件名
+ (NSString *)localizedNibName:(NSString *)key;
@end
