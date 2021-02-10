//
//  UIImage+TTPMLP_Extension.m
//  FMLPFigureMonster
//
//  Created by mac on 2019/7/9.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import "UIImage+TTPMLP_Extension.h"

@implementation UIImage (TTPMLP_Extension)

// 颜色转图片
+ (UIImage*)createImageWithColor:(UIColor*) color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();return theImage;
}


@end
