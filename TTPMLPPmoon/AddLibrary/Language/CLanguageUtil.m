//
//  CLanguageUtil.m
//  eCarry
//
//  Created by whde on 16/1/6.
//  Copyright © 2016年 whde. All rights reserved.
//

#import "CLanguageUtil.h"

static NSBundle *bundle = nil;
@implementation CLanguageUtil

// 获取Bundle
+(NSBundle *)bundle{
    if (bundle == nil) {
        NSString *userLanguage = [[NSUserDefaults standardUserDefaults] valueForKey:@"userLanguage"];
        if (userLanguage) {
            NSString *path = [[NSBundle mainBundle] pathForResource:userLanguage ofType:@"lproj"];
            bundle = [NSBundle bundleWithPath:path];
            return bundle;
        } else {
            bundle = [NSBundle mainBundle];
        }
    }
    return bundle;
}

// 设置Bundle
+ (void)setBundle:(nullable NSString *)userLanguage{
    if (userLanguage) {
        NSString *path = [[NSBundle mainBundle] pathForResource:userLanguage ofType:@"lproj"];
        bundle = [NSBundle bundleWithPath:path];
    } else {
        bundle = [NSBundle mainBundle];
    }
}

// 获取当前语言
+ (Language)getCurrentLanguage {
    NSString *language = [[NSUserDefaults standardUserDefaults] valueForKey:@"userLanguage"];
    if (language) {
        if ([language rangeOfString:@"en"].location != NSNotFound) {
            return Language_EN;
        } else if ([language rangeOfString:@"Hans"].location != NSNotFound) {
            return Language_Hans;
        } else if ([language rangeOfString:@"Hant"].location != NSNotFound) {
            return Language_Hant;
        } else {
            return Language_Default;
        }
#if DEBUG
        NSLog( @"%@" , language);
#endif
    } else{
        return Language_Default;
        //        NSArray *languages = [NSLocale preferredLanguages];
        //        language = [languages objectAtIndex:0];
        //#if DEBUG
        //        NSLog( @"%@" , language);
        //#endif
    }
}

// 设置语言
+ (void)setCurrentLanguage:(Language)language{
    switch (language) {
        case Language_Default:
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userLanguage"];
            [self setBundle:nil];
            break;
        case Language_EN:
            [[NSUserDefaults standardUserDefaults] setValue:@"en" forKey:@"userLanguage"];
            [self setBundle:@"en"];
            break;
        case Language_Hans:
            [[NSUserDefaults standardUserDefaults] setValue:@"zh-Hans" forKey:@"userLanguage"];
            [self setBundle:@"zh-Hans"];
            break;
        case Language_Hant:
            [[NSUserDefaults standardUserDefaults] setValue:@"zh-Hant" forKey:@"userLanguage"];
            [self setBundle:@"zh-Hant"];
            break;
        default:
            break;
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGE_NOTIFICATION object:nil];
}

// 获取xib国际化文件
+ (NSString *)localizedNibName:(NSString *)key{
    switch ([self getCurrentLanguage]) {
        case Language_Default:
            return key;
            break;
        case Language_EN:
            return [@"en.lproj/" stringByAppendingString:key];
            break;
        case Language_Hans:
            return [@"zh-Hans.lproj/" stringByAppendingString:key];
            break;
        case Language_Hant:
            return [@"zh-Hant.lproj/" stringByAppendingString:key];
            break;
        default:
            break;
    }
}
@end
