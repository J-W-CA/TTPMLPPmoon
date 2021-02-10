//
//  TTPMLP_ImageScrollView.m
//  FMLPFigureMonster
//
//  Created by mac on 2019/6/29.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import "TTPMLP_ScrawlPanelView.h"

@interface TTPMLP_ScrawlPanelView()



@end

@implementation TTPMLP_ScrawlPanelView {
    UIView *back;
}

// 初始化执行一次
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {

        
    }
    return self;
}

- (void)setFlag:(BOOL)flag {
    if (flag) {
        self.hidden = flag;
        back.hidden = YES;
    } else {

        self.hidden = flag;
        self.width = 0;
        self.height = 0;
        float y = self.y;
        self.y = y + 80;
        // 添加动画
        [UIView animateWithDuration:0.5 animations:^{
            self.width = kscreenWidth - 20;
            self.height = 80;
            self.y = y;
        } completion:^(BOOL finished) {
            // 弹性动画
            [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionAllowUserInteraction animations:^{
                self.transform = CGAffineTransformMakeScale(0.9, 0.9);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction animations:^{
                    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction animations:^{
                        self.transform = CGAffineTransformIdentity;
                    } completion:^(BOOL finished) {
                        if (self->back == nil) {
                            // 添加背景视图
                            self->back =  [[UIView alloc] initWithFrame:CGRectMake( 0, NAVIGATETION_BAR_MAX_Y, kscreenWidth,  kscreenHeight -NAVIGATETION_BAR_MAX_Y -55 - SAFE_AREA_BOTTOM_HEIGHT)];
                            self->back.backgroundColor = [UIColor clearColor];
                            [[self superview] insertSubview:self->back belowSubview:self];
                            // 添加手势
                            UILongPressGestureRecognizer *longPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressImage:)];
                            longPressGesture.minimumPressDuration=0;//设置长按时间，默认0.5秒，一般这个值不要修改
                            
                            [self->back addGestureRecognizer:longPressGesture];
                        }
                        self->back.hidden = NO;
                    }];
                }];
            }];
        }];
    }
}


#pragma mark - 手势

- (void)longPressImage:(UILongPressGestureRecognizer *)state
{
    self.hidden = YES;
    back.hidden = YES;
}

@end
