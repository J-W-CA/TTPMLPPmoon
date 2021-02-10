//
//  MosaiPath.h
//  MosaiDemo
//
//  Created by Sylar on 2018/4/2.
//  Copyright © 2018年 Sylar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PathPoint:NSObject

@property(nonatomic)float xPoint;

@property(nonatomic)float yPoint;

@end


@interface MosaiPath : NSObject

@property(nonatomic)CGPoint startPoint;
@property(nonatomic)NSMutableArray *pathPointArray;
@property(nonatomic)CGPoint endPoint;

-(void)resetStatus;

@end
