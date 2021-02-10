//
//  CALayer+Border.h
//  DealersApp
//
//  Created by comeboby on 16/6/11.
//  Copyright © 2016年 arvinyi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CALayer (Border)

@property(nonatomic, weak) UIColor *borderUIColor; // 使用storyboard或者Xib给View设置颜色能够准确设置，而不是黑边

+ (void)setTopBorderCALayer:(NSArray *)array height:(float)height color:(UIColor*)color;

@end
