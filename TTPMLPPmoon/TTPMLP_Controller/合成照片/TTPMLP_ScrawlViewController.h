//
//  TTPMLP_UploadViewController.h
//  FMLPFigureMonster
//
//  Created by apple on 2019/6/12.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//图片上传选择器合图

#import "TTPMLP_NavBaseViewController.h"
#import "TTPMLP_ScrawlScrollView.h"
#import "TTPMLP_ScrawlPanelView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTPMLP_ScrawlViewController : TTPMLP_NavBaseViewController

/// 图片数组
@property (nonatomic, strong) NSMutableArray *photoArr;

@property (nonatomic, strong) UIImage *currentImage;

@property (nonatomic, strong) UIImageView *sourceImageView;

@property (weak, nonatomic) IBOutlet TTPMLP_ScrawlPanelView *viewPanel; // 画板视图

@property (weak, nonatomic) IBOutlet UIImageView *currentScrawImage; // 当前选择的颜色值

@property (weak, nonatomic) IBOutlet TTPMLP_ScrawlScrollView *currentScrawlScrollView; // 当前的选择滚动视图

@property (weak, nonatomic) IBOutlet UISlider *currentBrushSize; // 画笔大小


@end

NS_ASSUME_NONNULL_END
