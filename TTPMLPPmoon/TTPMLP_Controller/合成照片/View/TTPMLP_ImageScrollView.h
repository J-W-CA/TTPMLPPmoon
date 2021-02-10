//
//  TTPMLP_ImageScrollView.h
//  FMLPFigureMonster
//
//  Created by mac on 2019/6/29.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTPMLP_ImageScrollView : UIScrollView

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image;

@property (nonatomic, assign) float currentViewHeight; // 当前视图高度

@property (nonatomic, assign) CGRect currentframe;

@end

NS_ASSUME_NONNULL_END
