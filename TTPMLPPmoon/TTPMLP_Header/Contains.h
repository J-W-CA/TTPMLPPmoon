//
//  Contains.h
//  NewIntegrated01
//
//  Created by IMAC on 2017/5/26.
//  Copyright © 2017年 IMAC. All rights reserved.
//


/****  debug log **/ //NSLog输出信息


#ifdef DEBUG

#define FBLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#else

#define FBLog( s, ... )

#endif




/**********************************颜色******************************************/
//RBG color
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RandColor [UIColor colorWithRed:arc4random() % 256 /255.0 green:arc4random() % 256 /255.0 blue:arc4random() % 256 /255.0 alpha:1]//随机色
#define ColorFromSixteen(s,al)  ([UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:al])
// 16进制颜色
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
#define kWeiboListTextColor kUIColorFromHex(0x555555)

#define UIColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREENAPPLY(x, y) CGSizeMake(SCREEN_WIDTH / 375.0 * (x), SCREEN_HEIGHT / 667.0 * (y))
#define SCREENAPPLYSPACE(x) SCREEN_WIDTH / 375.0 * (x)
#define SCREENAPPLYHEIGHT(x) SCREEN_HEIGHT / 667.0 * (x)

/**********************************控制参数******************************************/

#define SCROLLVIEWHEIGHT 200//图轮高度

/**********************************坐标尺寸类******************************************/
#define kscreenWidth                 ([[UIScreen mainScreen] bounds].size.width)
#define kscreenHeight                ([[UIScreen mainScreen] bounds].size.height)
#define kscreenBouns                 [UIScreen mainScreen].bounds
//    系统控件的默认高度
#define kStatusBarHeight   [[UIApplication sharedApplication] statusBarFrame].size.height
#define kTopBarHeight      (44.f)
#define kBottomBarHeight   ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kNaviBarHeight     (kStatusBarHeight + kTopBarHeight)
#define BottomInset         (kBottomBarHeight - 49)

#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

#define NAVIGATETION_BAR_MAX_Y (iPhoneX?88:64)
#define SAFE_AREA_Top_HEIGHT (iPhoneX?22:0)
#define SAFE_AREA_BOTTOM_HEIGHT (iPhoneX?34:0)
#define SENDERGROOVE_HEIGHT (iPhoneX?30:0)
#define SENDERGROOVE_MARGIN (iPhoneX?14:0)
#define STATUS_BAR_HEIGHT ((iPhoneX)?44:20)
#define STATUS_Top_HEIGHT ((iPhoneX)?24:0)


/**********************************设备版本类******************************************/
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.f)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.f)
#define IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.f)
#define iOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]//版本

// 判断设备是不是iPad.
#define DEVICE_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 判断设备是不是iPhone.
#define DEVICE_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// 判断设备是不是iPhoneX带刘海系列.
#define iPhoneX (IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES)
//是否iPhone5
#define ISIPHONE                  [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && DEVICE_IS_IPHONE : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && DEVICE_IS_IPHONE : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && DEVICE_IS_IPHONE : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && DEVICE_IS_IPHONE : NO)

// 获取本地应用完整版本号
#define APP_SHORT_VERSION [[NSDictionary dictionaryWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Info.plist"]] objectForKey:@"CFBundleShortVersionString"]

// 判断系统版本是否低于 v
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

// 判断系统版本是否高于 v
#define SYSTEM_VERSION_MORE_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)



/**********************************其他******************************************/


#define kUrl(x) [NSURL URLWithString:x]
#define IsPortrait   [NSObject TTPMLP_M_isOrientationPortrait]

/**********************************判空类******************************************/
#define NOTNULL(x) ((![x isKindOfClass:[NSNull class]])&&x)

#define TTPMLP_IS_STR_NIL(objStr) (![objStr isKindOfClass:[NSString class]] || objStr == nil || [objStr length] <= 0 || [objStr isKindOfClass:[NSNull class]])

#define TTPMLP_IS_DICT_NIL(objDict) (![objDict isKindOfClass:[NSDictionary class]] || objDict == nil || [objDict count] <= 0 || [objDict isKindOfClass:[NSNull class]])

#define TTPMLP_IS_ARRAY_NIL(objArray) (![objArray isKindOfClass:[NSArray class]] || objArray == nil || [objArray count] <= 0 || [objArray isKindOfClass:[NSNull class]])

#define TTPMLP_IS_ARRAY_NOT_NIL(objArray) (!TTPMLP_IS_ARRAY_NIL(objArray))

#define TTPMLP_IS_STR_NOT_NIL(str) (!TTPMLP_IS_STR_NIL(str))


#define TTPMLP_WEAKSELF(weakSelf) __weak __typeof(&*self)  weakSelf  = self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;


#pragma mark - Funtion Method (宏 方法)
//PNG JPG 图片路径
#define PNGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME,EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

//加载图片
#define PNGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME,EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]
#define IMageName(NAME)       [UIImage imageNamed:NAME]
#define URLSTRING(URLString)   [NSURL URLWithString:(URLString)]

//当前语言
#define CURRENTLANGUAGE           ([[NSLocale preferredLanguages] objectAtIndex:0])
//应用程序的名字
#define AppDisplayName              [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

//NSUSerDefault
#define userDefault [NSUserDefaults standardUserDefaults]

// 常用颜色值
#define AppUIColor UIColorFromRGB(0xff6a1d)
/**********************************字体类******************************************/
#define FONT_OF_SIZE(s) [UIFont systemFontOfSize:s]

// 基本字体颜色
#define TitleColor RGBA(51, 51, 51, 1.0)
//字体大小（常规/粗体）
#define BoldSystemfont(fontSize) [UIFont boldSystemFontOfSize:fontSize]
#define SYSTEMFONT(FONTSIZE)     [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME,FONTSIZE)      [UIFont fontWithName:(NAME) size:(FONTSIZE)]

//typedef void(^BlockIntHandler)(int index);
typedef void(^BlockBoolHandler)(_Bool flag);
//typedef void(^BlockBoolStringHandler)(BOOL flag, NSString *fileName);
//typedef void(^BlockHandler)(void);
//typedef void(^SuccessHandler)(id responseObject);
//typedef void(^FailureHandler)(NSError *error);


