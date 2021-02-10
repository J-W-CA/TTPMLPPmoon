//
//  singleton.h
//  DealersApp
//
//  Created by arvinyi on 16/5/17.
//  Copyright © 2016年 arvinyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface singleton : NSObject

@property (nonatomic, strong) NSMutableArray *mosaiSourceArray;

+(singleton *)share;

@end
