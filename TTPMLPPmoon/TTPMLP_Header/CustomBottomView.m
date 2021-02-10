//
//  CustomBottomView.m
//  CYLTabBarController
//
//  Created by 易香城 on 2018/7/21.
//  Copyright © 2018年 微博@iOS程序犭袁. All rights reserved.
//

#import "CustomBottomView.h"


@implementation CustomBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// 初始化执行一次
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
self = [super initWithCoder:aDecoder];
    if (self) {
        
        if (self.tag == 10) {
            
            // 更改约束
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo([NSNumber numberWithInt:SAFE_AREA_BOTTOM_HEIGHT]);
            }];
        } else {
            // 更改约束
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo([NSNumber numberWithInt:SAFE_AREA_BOTTOM_HEIGHT]);
            }];
        }
        

    }
    return self;
}

@end
