//
//  CALayer+Border.m
//  DealersApp
//
//  Created by comeboby on 16/6/11.
//  Copyright © 2016年 arvinyi. All rights reserved.
//

#import "CALayer+Border.h"
@implementation CALayer (Border)

- (void)setBorderUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

- (UIColor *)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

+ (CALayer *)getBorderCALayer:(CGRect)rect color:(UIColor*)color {
    CALayer *Border = [CALayer layer];
    Border.frame = rect;
    Border.backgroundColor = [color CGColor];
    return Border;
}

// 顶部单边
+ (void)setTopBorderCALayer:(NSArray *)array height:(float)height color:(UIColor*)color{
    [array enumerateObjectsUsingBlock:^(UIView  *obj, NSUInteger idx, BOOL *stop) {
        [obj.layer addSublayer:[CALayer getBorderCALayer:CGRectMake(0.0f, 0.0f, obj.frame.size.width, height) color:color]];
    }];
}


@end
