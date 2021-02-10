//
//  singleton.m
//  DealersApp
//
//  Created by arvinyi on 16/5/17.
//  Copyright © 2016年 arvinyi. All rights reserved.
//

#import "singleton.h"

@implementation singleton

// 单例对象
static singleton *instance;

// 单例
+ (singleton *) share {
    @synchronized(self) {
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

-(id) init
{
    if (self = [super init]) {
        
    }
    return self;
}

// 确保单例对象的唯一性
+ (id)allocWithZone:(NSZone *)zone {
    if (!instance) {
        instance = [super allocWithZone:zone];
    }
    return instance;
}

@end
