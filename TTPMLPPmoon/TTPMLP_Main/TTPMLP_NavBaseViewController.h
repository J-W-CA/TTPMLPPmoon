//
//  TTPMLP_NavBaseViewController.h
//  FMLPFigureMonster
//
//  Created by apple on 2019/6/12.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BtnWeigth 30
#define BtnHeigth 20
#define Magin 20
#define ToolBarHeight     50.0


NS_ASSUME_NONNULL_BEGIN

@interface TTPMLP_NavBaseViewController : UIViewController
/**
 *  自定义的导航视图
 */
@property(nonatomic,strong) UIView *navView;

/**
 自定义导航视图背景图片默认不显示
 */
@property(nonatomic,strong) UIImageView *navBackView;

@property(nonatomic,strong) UIButton *leftButton;

@property(nonatomic,strong) UIButton *CenterButton;

@property(nonatomic,strong) UIButton *rightButton;

@property(nonatomic,strong) UIButton *AddImageButton;

/**
 *  左边方法
 */
- (void)moreMethod;
/**
 *  右边方法
 */
- (void)searchMothod;

@end

NS_ASSUME_NONNULL_END
