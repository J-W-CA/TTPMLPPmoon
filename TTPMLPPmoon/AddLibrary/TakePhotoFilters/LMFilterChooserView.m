//
//  LMFilterChooserView.m
//  LMUpLoadPhoto
//
//  Created by xx11dragon on 15/8/31.
//  Copyright (c) 2015年 xx11dragon. All rights reserved.
//

#import "LMFilterChooserView.h"
#import "LMFilterChooserViewCell.h"
#import "GPUImage.h"
//#include "UIImage+Filter.h"

static float const cell_width = 100.0f;

@interface LMFilterChooserView () {
    LMFilterChooserViewCell *_selectCell;
    NSArray *_filters;
    NSMutableArray *_cells;
    BOOL _start;
    NSInteger _currentSelectIndex;
}

@end

@implementation LMFilterChooserView


- (void)addFilters:(NSArray *)filters{
    _currentSelectIndex = -1;
    _filters = filters;
    _cells = [NSMutableArray arrayWithCapacity:0];
    
    self.showsHorizontalScrollIndicator = NO;
    if (self.subviews.count) [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.contentSize = CGSizeMake(cell_width * _filters.count, 0);
    
    [_filters enumerateObjectsUsingBlock:^(GPUImageFilterGroup *filters, NSUInteger idx, BOOL *stop) {
        LMFilterChooserViewCell *cell = [[LMFilterChooserViewCell alloc] initWithFrame:CGRectMake(self.contentSize.width + idx * cell_width, 0.0f, cell_width, self.bounds.size.height)];
        cell.tag = idx + 1;
        [cell setFilter:filters];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
        [cell addGestureRecognizer:tap];
        [self addSubview:cell];
        [self->_cells addObject:cell];
    }];
    LMFilterChooserViewCell *cell = _cells[0];
    [cell setState:UIControlStateSelected];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!_start) [self animationStart];

}

- (void)animationStart {
    __weak LMFilterChooserView *weakSelf = self;
    [_cells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [weakSelf performSelector:@selector(go:) withObject:obj afterDelay:idx *0.05f];
        
    }];

    _start = YES;
    
}

- (void) go:(id)timer {
    
    LMFilterChooserViewCell *cell = (LMFilterChooserViewCell *)timer;

    [UIView animateWithDuration:0.5f animations:^{
        
        cell.frame = CGRectMake((cell.tag - 1) * cell_width - 10, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2f animations:^{
            cell.frame = CGRectMake((cell.tag - 1) * cell_width , cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        }];
        
    }];
}

- (void)clicked:(UITapGestureRecognizer *)tap {
    if (tap.view.tag == _currentSelectIndex) return;
    
    LMFilterChooserViewCell *cell = (LMFilterChooserViewCell *)tap.view;
    
    
    
    [_cells enumerateObjectsUsingBlock:^(LMFilterChooserViewCell *  _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell setState:UIControlStateNormal];
    }];
    [cell setState:UIControlStateSelected];
    
    _currentSelectIndex = tap.view.tag;

    if (_filterChooserBlock) {
        _filterChooserBlock(cell.getFilter ,tap.view.tag - 1);
    }
}

- (void)addSelectedEvent:(LMFilterChooserBlock)filterChooseBlock {
    _filterChooserBlock = [filterChooseBlock copy];
}

@end
