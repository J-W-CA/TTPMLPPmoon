//
//  UICollectionViewCell+CLMove.h
//  KuaiziHealth
//
//  Created by 余汪送 on 2017/3/30.
//  Copyright © 2017年 capsule. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CLMoveItemBlock)(NSIndexPath *fromIndexPath, NSIndexPath *toIndexPath);


@interface UICollectionViewCell (CLMove)

@property (nonatomic, assign) BOOL cl_moveEnabled;

///更新数据源的block
- (void)cl_setMoveItemBlock:(CLMoveItemBlock)block;

@end
