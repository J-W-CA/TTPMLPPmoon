//
//  MosaiPath.m
//  MosaiDemo
//
//  Created by Sylar on 2018/4/2.
//  Copyright © 2018年 Sylar. All rights reserved.
//

#import "MosaiPath.h"

@interface MosaiPath()<NSCopying,NSMutableCopying>

@end

@implementation MosaiPath

- (instancetype)init
{
    self = [super init];
    if (self) {
        _startPoint = CGPointZero;
        _endPoint = CGPointZero;
        _pathPointArray = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)resetStatus{
    _startPoint = CGPointZero;
    _endPoint = CGPointZero;
    [_pathPointArray removeAllObjects];
}



- (id)copyWithZone:(NSZone *)zone
{
    MosaiPath *obj = [[[self class] allocWithZone:zone] init];
    obj.pathPointArray = [self.pathPointArray copyWithZone:zone];
    obj.startPoint = self.startPoint;
    obj.endPoint = self.endPoint;
    
    return obj;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    MosaiPath *obj = [[[self class] allocWithZone:zone] init];
    obj.pathPointArray = [self.pathPointArray copyWithZone:zone];
    obj.startPoint = self.startPoint;
    obj.endPoint = self.endPoint;
    return obj;
}

@end


@implementation PathPoint

- (instancetype)init
{
    self = [super init];
    if (self) {
        _xPoint = _yPoint = 0;
    }
    return self;
}

@end
