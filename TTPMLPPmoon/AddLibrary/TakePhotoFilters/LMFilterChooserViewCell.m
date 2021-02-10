//
//  LMFilterChooserViewCell.m
//  LMUpLoadPhoto
//
//  Created by xx11dragon on 15/8/31.
//  Copyright (c) 2015年 xx11dragon. All rights reserved.
//

#import "LMFilterChooserViewCell.h"
#import "LMFliterGroup.h"
#import "GPUImage.h"

@interface LMFilterChooserViewCell () {
    GPUImageView *view1;
    GPUImageFilterGroup * group;
}

@property (nonatomic , strong) UIImageView *previewView;
@property (nonatomic , strong) UILabel *titleLabel;

@end

@implementation LMFilterChooserViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        view1 = [[GPUImageView alloc] initWithFrame:CGRectMake(5, 0, frame.size.width- 10, frame.size.height)];
        view1.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
        [self addSubview:view1];
        [view1 addSubview:self.titleLabel];

    }
    return self;
}


- (void)setFilter:(GPUImageFilterGroup *)filter {
    
    
    [filter addTarget:view1];
    
    group = filter;
    view1.layer.borderColor = filter.color.CGColor;
    
    self.titleLabel.backgroundColor = filter.color;
    self.titleLabel.text = filter.title;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view1.bounds.size.height - 20, view1.bounds.size.width, 20)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}


- (GPUImageFilterGroup *)getFilter {
    
    
    return group;
    
}

- (void)setState:(UIControlState)state {

    switch (state) {
        case UIControlStateNormal: {
            view1.layer.borderWidth  = 0.0f;
        }
            break;
        case UIControlStateSelected:{
            view1.layer.borderWidth  = 2.0f;
        }
            break;
        default:
            break;
    }
    
}

@end
