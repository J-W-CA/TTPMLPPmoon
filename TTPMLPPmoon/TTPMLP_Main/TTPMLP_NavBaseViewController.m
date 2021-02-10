//
//  TTPMLP_NavBaseViewController.m
//  FMLPFigureMonster
//
//  Created by apple on 2019/6/12.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import "TTPMLP_NavBaseViewController.h"

@interface TTPMLP_NavBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation TTPMLP_NavBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:LANGUAGE_CHANGE_NOTIFICATION
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(languageHasChanged)
                                                 name:LANGUAGE_CHANGE_NOTIFICATION
                                               object:nil];
//    [CLanguageUtil setCurrentLanguage:Language_Default];
    
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加子控件
    [self.view addSubview:self.navView];
    
    [self.view addSubview:self.navBackView];
    [self.view addSubview:self.CenterButton];
    [self.view addSubview:self.AddImageButton];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.rightButton];
    
//    [self.navView addSubview:self.navBackView];
//    [self.navView addSubview:self.CenterButton];
//    [self.view addSubview:self.AddImageButton];
//    [self.navView addSubview:self.leftButton];
//    [self.navView addSubview:self.rightButton];
}

#pragma mark - 导航条按钮方法
- (void)moreMethod{
    [self.navigationController popViewControllerAnimated:YES];
}
//语言切换通知
- (void)languageHasChanged{
    if ([self isViewLoaded] && self.view.window == nil) {
        for (UIView *v in self.view.subviews) {
            [v removeFromSuperview];
        }
        self.view = nil;
    }
}
- (void)searchMothod{
    
}

//push hideButtomBar 跳转隐藏ButtomBar
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

#pragma mark - 懒加载
//- (UIView *)navView{
//
//    if(!_navView){
//        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kscreenWidth , kscreenHeight)];
//        _navView.backgroundColor = RGBA(255, 255, 255, 1);
//    }
//    return _navView;
//}


- (UIImageView *)navBackView{
    if(!_navBackView){
        _navBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kscreenWidth, kNaviBarHeight)];
        _navBackView.image = IMageName(@"个人中心顶部");
        _navBackView.userInteractionEnabled = YES;
        _navBackView.hidden = YES;
    }
    return _navBackView;
}

- (UIButton *)leftButton{
    
    if(!_leftButton){
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat y = kStatusBarHeight+5.0;
        if(iPhoneX) y = kStatusBarHeight;
        if(ISIPHONE){
            _leftButton.frame = CGRectMake(0, y, BtnWeigth+20, BtnHeigth+10);
            _leftButton.titleLabel.font = SYSTEMFONT(14.0);
            _leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        }else{
            _leftButton.frame = CGRectMake(0, y, BtnWeigth+20, BtnHeigth+10);
            _leftButton.titleLabel.font = SYSTEMFONT(16.0);
        }
        [_leftButton addTarget:self action:@selector(moreMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)CenterButton{
    
    if(!_CenterButton){
        
        CGFloat y = kStatusBarHeight+5.0;
        if(iPhoneX) y = kStatusBarHeight;
        _CenterButton = [[UIButton alloc]initWithFrame:CGRectMake(BtnWeigth + Magin, y, [UIScreen mainScreen].bounds.size.width - 3 * BtnWeigth - 2 * Magin, BtnHeigth + 10)];
        _CenterButton.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, _CenterButton.center.y);
        
        if(ISIPHONE){
            _CenterButton.titleLabel.font = BoldSystemfont(16);
        }else{
            _CenterButton.titleLabel.font =BoldSystemfont(20);
        }
        //        [_CenterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_CenterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _CenterButton;
}

// 添加图片按钮
- (UIButton *)AddImageButton{
    
    if(!_AddImageButton){
        
        _AddImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_rightButton setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
        CGFloat y = kStatusBarHeight+5.0;
        if(iPhoneX) y = kStatusBarHeight;
//        if(ISIPHONE){
//            _AddImageButton.frame = CGRectMake(kscreenWidth - BtnWeigth - 40, y, BtnWeigth+40,BtnHeigth+10);
//            _AddImageButton.titleLabel.font = BoldSystemfont(14.0);
//        }else{
//            _AddImageButton.frame = CGRectMake(kscreenWidth - BtnWeigth - 30, y, BtnWeigth+20,BtnHeigth+10);
//            _AddImageButton.titleLabel.font = BoldSystemfont(17.0);
//        }
        _AddImageButton.frame = CGRectMake(0, 0, 44, 44);
//        _AddImageButton.titleLabel.font = BoldSystemfont(17.0);
//        _AddImageButton.titleLabel.textColor = UIColorFromHex(0x666666);
//        _AddImageButton.backgroundColor = [UIColor orangeColor];
        _AddImageButton.center = CGPointMake(self.view.center.x, kscreenHeight  - 75);
        _AddImageButton.hidden = YES;
        [_AddImageButton addTarget:self action:@selector(addImageMothod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _AddImageButton;
}


- (UIButton *)rightButton{
    
    if(!_rightButton){
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
        CGFloat y = kStatusBarHeight+5.0;
        if(iPhoneX) y = kStatusBarHeight;
        if(ISIPHONE){
            _rightButton.frame = CGRectMake(kscreenWidth - BtnWeigth - 40, y, BtnWeigth+40,BtnHeigth+10);
            _rightButton.titleLabel.font = BoldSystemfont(14.0);
        }else{
            _rightButton.frame = CGRectMake(kscreenWidth - BtnWeigth - 30, y, BtnWeigth+20,BtnHeigth+10);
            _rightButton.titleLabel.font = BoldSystemfont(17.0);
        }
        [_rightButton addTarget:self action:@selector(searchMothod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}




@end
