//
//  TTPMLP_ImageScrollView.m
//  FMLPFigureMonster
//
//  Created by mac on 2019/6/29.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import "TTPMLP_ScrawlScrollView.h"

@interface TTPMLP_ScrawlScrollView()

@property (nonatomic, strong) NSMutableArray *mosaiSourceArray;

@property (nonatomic, strong) NSMutableArray *colorViewSourceArray;

@property (nonatomic, strong) UIControl *currentViewColor; // 颜色视图

@end

@implementation TTPMLP_ScrawlScrollView {
 
}

// 初始化执行一次
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _colorViewSourceArray = [[NSMutableArray alloc]init];
        _mosaiSourceArray = [[NSMutableArray alloc]init];
        
        
        //添加马赛克图
//            [_mosaiSourceArray addObject:newImg];
        
        [_mosaiSourceArray addObject:[UIImage imageNamed:@"mosai1.jpg"]];
        [_mosaiSourceArray addObject:[UIImage imageNamed:@"mosai2.jpg"]];
        [_mosaiSourceArray addObject:[UIImage imageNamed:@"mosai3.jpg"]];
        [_mosaiSourceArray addObject:[UIImage createImageWithColor:ColorFromSixteen(0x7559b9,1.0)]];
        [_mosaiSourceArray addObject:[UIImage createImageWithColor:ColorFromSixteen(0x783bc6,1.0)]];
        [_mosaiSourceArray addObject:[UIImage createImageWithColor:ColorFromSixteen(0x9c4ccb,1.0)]];
        [_mosaiSourceArray addObject:[UIImage createImageWithColor:ColorFromSixteen(0x4884cb,1.0)]];
        [_mosaiSourceArray addObject:[UIImage createImageWithColor:ColorFromSixteen(0x2ccfbb,1.0)]];
        [_mosaiSourceArray addObject:[UIImage createImageWithColor:ColorFromSixteen(0xa4c745,1.0)]];
        [_mosaiSourceArray addObject:[UIImage createImageWithColor:ColorFromSixteen(0x53bc48,1.0)]];
        //       ColorFromSixteen(0x28844a,1.0),
        //       ColorFromSixteen(0x4c9e65,1.0),
        //       ColorFromSixteen(0x67b37d,1.0),
        //       ColorFromSixteen(0x008781,1.0),
        //       ColorFromSixteen(0x98186d,1.0),
        //       ColorFromSixteen(0xd7534a,1.0),
        //       ColorFromSixteen(0xce3b3c,1.0),
        //       ColorFromSixteen(0xd7612e,1.0),
        
        [singleton share].mosaiSourceArray = _mosaiSourceArray;
        
        
        float width = _mosaiSourceArray.count * 40 + 10;
        [self setContentSize:CGSizeMake(width, 0)];
        
        [_mosaiSourceArray enumerateObjectsUsingBlock:^(UIImage *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIControl *color = [[UIControl alloc] initWithFrame:CGRectMake((idx * 40) + 10, 5, 30, 30)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, color.width, color.height)];
            imageView.image = obj;
            [color addSubview:imageView];
            color.layer.cornerRadius = 15;
            color.layer.masksToBounds = YES;
            color.tag = idx;
            [self addSubview:color];
            
            UIView *lightColor = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
            lightColor.backgroundColor = [UIColor whiteColor];
                lightColor.layer.cornerRadius = 10;
            lightColor.hidden = YES;
            lightColor.tag = 100;
            [color addSubview:lightColor];
            
            if ([NSUserDefaults getCurrentFuzzyStatus]== idx) {
                lightColor.hidden = NO;
                self.currentViewColor = color;
            }
            
            [color addTarget:self action:@selector(addView:) forControlEvents:UIControlEventTouchUpInside];
            
            [self->_colorViewSourceArray addObject:color];
        }];
        
    }
    return self;
}


-(void)addView:(id)sender {
    
    //声明一个block函数（void）
    void(^block)(void) = ^(void)
    {
        for (UIView *view in [  self.currentViewColor subviews]) {
            if (view.tag == 100 && view.hidden == NO) {
                view.hidden = YES;
            }
        }
    };
    
    UIControl *newView = (UIControl *)sender;
    for (UIView *view in [newView subviews]) {
        if (view.tag == 100 && view.hidden == YES) {
            block();
            view.hidden = NO;
            self.currentViewColor = newView;
            if (self.SelectCallBack) {
                [NSUserDefaults saveCurrentFuzzyStatus:newView.tag];
                self.SelectCallBack(newView.tag);
            }
        }
    }
    
}


@end
