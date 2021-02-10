//
//  LMFilterChooserView.h
//  LMUpLoadPhoto
//
//  Created by xx11dragon on 15/8/31.
//  Copyright (c) 2015年 xx11dragon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPUImageFilterGroup;
typedef  void(^ LMFilterChooserBlock)(GPUImageFilterGroup *filter, NSInteger idx);

@interface LMFilterChooserView : UIScrollView {
    LMFilterChooserBlock _filterChooserBlock;
}

@property (nonatomic , retain) UIImage *filterImage;

- (void)addFilters:(NSArray *)filters;

- (void)addSelectedEvent:(LMFilterChooserBlock)filterChooseBlock;

@end
