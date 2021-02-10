//
//  TTPMLP_ImageScrollView.h
//  FMLPFigureMonster
//
//  Created by mac on 2019/6/29.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTPMLP_ScrawlScrollView : UIScrollView

//@property (nonatomic, assign) NSInteger currentLightIndex; // 当前选中的样式

// block对象
@property (nonatomic, copy) void(^SelectCallBack)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
