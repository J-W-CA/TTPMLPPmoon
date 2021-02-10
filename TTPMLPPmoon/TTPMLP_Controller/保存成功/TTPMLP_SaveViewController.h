//
//  TTPMLP_UploadViewController.h
//  FMLPFigureMonster
//
//  Created by apple on 2019/6/12.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//图片上传选择器合图

#import "TTPMLP_NavBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTPMLP_SaveViewController : TTPMLP_NavBaseViewController

@property (nonatomic, strong) UIImage *currentImage;
@property (weak, nonatomic) IBOutlet UIImageView *currentSaveImageView;

@end

NS_ASSUME_NONNULL_END
