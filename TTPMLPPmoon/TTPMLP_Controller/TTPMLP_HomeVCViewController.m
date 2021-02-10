//
//  TTPMLP_HomeVCViewController.m
//  FMLPFigureMonster
//
//  Created by apple on 2019/6/12.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import "TTPMLP_HomeVCViewController.h"
#import "TTPMLP_UploadViewController.h"
#import "TTPMLP_PhotoViewController.h"
#import "StoryMakeFilterFooterView.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface TTPMLP_HomeVCViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate, StoryMakeFilterFooterViewDelegate>
//@property (nonatomic,strong)  UIImageView *TTPMLP_backgroundView;//背景图片
@property (nonatomic,strong)  UIImageView *iconView;//背景图片
@property (nonatomic,strong)  UILabel *iconLable;//背景图片
@property (nonatomic,strong)  UIButton *TTPMLP_registeredButton;//注册按钮
@property (nonatomic,strong)  UIButton *TTPMLP_changeButton;//切换按钮
@property (nonatomic,strong)  UIButton *TTPMLP_filterButton;//图片滤镜按钮

@property (nonatomic, strong) StoryMakeFilterFooterView *filterFooterView;
@end

@implementation TTPMLP_HomeVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.labPotho.text = CLocalizedString(@"Shooting");
    self.labSktich.text = CLocalizedString(@"Stitch");
    self.labFilter.text = CLocalizedString(@"Filter");
    

//    [self.CenterButton setTitle:CLocalizedString(@"Figure Monster") forState:UIControlStateNormal];
    
//    [self.view addSubview:self.TTPMLP_backgroundView];
//    [_TTPMLP_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
//    }];
    
//    [self.TTPMLP_backgroundView addSubview:self.iconView];
//    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.TTPMLP_backgroundView.mas_top).offset(40);
//        make.height.equalTo(@(72));
//        make.width.equalTo(@(88));
//        make.right.equalTo(self.TTPMLP_backgroundView.mas_centerX).offset(-10);
//
//    }];
//    
//    [self.TTPMLP_backgroundView addSubview:self.iconLable];
//    [_iconLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.iconView.mas_centerY);
//        make.width.mas_lessThanOrEqualTo(@(200));
//        make.left.equalTo(self.iconView.mas_right).offset(10);
//    }];
//    
//    
//    [self.TTPMLP_backgroundView addSubview:self.TTPMLP_registeredButton];
//    [_TTPMLP_registeredButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.TTPMLP_backgroundView.mas_centerX);
//         make.height.equalTo(self.TTPMLP_backgroundView.mas_width).multipliedBy(0.17);
//        make.width.equalTo(self.TTPMLP_backgroundView.mas_width).multipliedBy(0.52);
//        make.bottom.equalTo(self.TTPMLP_backgroundView.mas_centerY).offset(-18);
//    }];
//    
//    
//    [self.TTPMLP_backgroundView addSubview:self.TTPMLP_changeButton];
//    [_TTPMLP_changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.TTPMLP_backgroundView.mas_centerX);
//        make.height.equalTo(self.TTPMLP_backgroundView.mas_width).multipliedBy(0.17);
//        make.width.equalTo(self.TTPMLP_backgroundView.mas_width).multipliedBy(0.52);
//        make.top.equalTo(self.TTPMLP_backgroundView.mas_centerY).offset(18);
//    }];
//    
//    [self.TTPMLP_backgroundView addSubview:self.TTPMLP_filterButton];
//    [_TTPMLP_filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.TTPMLP_backgroundView.mas_centerX);
//        make.height.equalTo(self.TTPMLP_backgroundView.mas_width).multipliedBy(0.17);
//        make.width.equalTo(self.TTPMLP_backgroundView.mas_width).multipliedBy(0.52);
//        make.top.equalTo(self.TTPMLP_backgroundView.mas_centerY).offset(108);
//    }];
    
    
    [self.view addSubview:self.filterFooterView];

}
- (IBAction)registeredTouch:(id)sender {
    UIButton *Btn = (UIButton *)sender;
    if (Btn.tag == 1) {//去拍照
        TTPMLP_PhotoViewController *photo = [[TTPMLP_PhotoViewController alloc]init];
        [self.navigationController pushViewController:photo animated:YES];
        
    }else if (Btn.tag == 2){//去改图
        TTPMLP_UploadViewController *upload = [[TTPMLP_UploadViewController alloc] init];
        [self.navigationController pushViewController:upload animated:YES];
    } else if (Btn.tag == 3){
        [self openAlbum];
    }
}

-(UIButton *)TTPMLP_registeredButton{
    if (!_TTPMLP_registeredButton) {
        _TTPMLP_registeredButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_TTPMLP_registeredButton setTitle:CLocalizedString(@"Filter Shooting") forState:UIControlStateNormal];
        [_TTPMLP_registeredButton setBackgroundImage:IMageName(@"jingpai") forState:UIControlStateNormal];
        _TTPMLP_registeredButton.titleLabel.font = FONT_OF_SIZE(15); 
        [_TTPMLP_registeredButton setTitleColor:UIColorFromHex(0xD8708F) forState:UIControlStateNormal];
        _TTPMLP_registeredButton.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 7, 0);
        [_TTPMLP_registeredButton addTarget:self action:@selector(registeredTouch:) forControlEvents:UIControlEventTouchUpInside];
        _TTPMLP_registeredButton.tag = 1;
    }
    return _TTPMLP_registeredButton;
}

-(UIButton *)TTPMLP_changeButton{
    
    if (!_TTPMLP_changeButton) {
        _TTPMLP_changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_TTPMLP_changeButton setTitle:CLocalizedString(@"Stitch") forState:UIControlStateNormal];
        [_TTPMLP_changeButton setBackgroundImage:IMageName(@"hetu") forState:UIControlStateNormal];
        _TTPMLP_changeButton.titleLabel.font = FONT_OF_SIZE(15);
        _TTPMLP_changeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 7, 0);
        [_TTPMLP_changeButton setTitleColor:UIColorFromHex(0xD8708F) forState:UIControlStateNormal];
        [_TTPMLP_changeButton addTarget:self action:@selector(registeredTouch:) forControlEvents:UIControlEventTouchUpInside];
        _TTPMLP_changeButton.tag = 2;
    }
    return _TTPMLP_changeButton;
}

-(UIButton *)TTPMLP_filterButton{
    
    if (!_TTPMLP_filterButton) {
        _TTPMLP_filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_TTPMLP_filterButton setTitle:CLocalizedString(@"图片滤镜") forState:UIControlStateNormal];
        [_TTPMLP_filterButton setBackgroundImage:IMageName(@"hetu") forState:UIControlStateNormal];
        _TTPMLP_filterButton.titleLabel.font = FONT_OF_SIZE(15);
        _TTPMLP_filterButton.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 7, 0);
        [_TTPMLP_filterButton setTitleColor:UIColorFromHex(0xD8708F) forState:UIControlStateNormal];
        [_TTPMLP_filterButton addTarget:self action:@selector(registeredTouch:) forControlEvents:UIControlEventTouchUpInside];
        _TTPMLP_filterButton.tag = 3;
    }
    return _TTPMLP_filterButton;
}


//-(UIImageView *)TTPMLP_backgroundView{
//    if (!_TTPMLP_backgroundView) {
//        _TTPMLP_backgroundView = [[UIImageView alloc]init];
//        _TTPMLP_backgroundView.image = IMageName(@"homeBack");
//        _TTPMLP_backgroundView.userInteractionEnabled = YES;
//    }
//    return _TTPMLP_backgroundView;
//}
-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]initWithImage:IMageName(@"homeIcon")];
    }
    return _iconView;
}

-(UILabel *)iconLable{
    if (!_iconLable) {
        _iconLable = [[UILabel alloc]init];
        _iconLable.textColor = [UIColor whiteColor];
        _iconLable.text = CLocalizedString(@"Figure Monster");
        _iconLable.font = SYSTEMFONT(16);
    }
    return _iconLable;
}

#pragma mark - 图片滤镜

- (StoryMakeFilterFooterView *)filterFooterView
{
    if (!_filterFooterView) {
        _filterFooterView = [[StoryMakeFilterFooterView alloc] init];
        _filterFooterView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame), SCREEN_WIDTH, SCREEN_HEIGHT);
        _filterFooterView.delegate = self;
        _filterFooterView.hidden = YES;
    }
    return _filterFooterView;
}

- (void)storyMakeFilterFooterViewCloseBtnClicked {
    [self hideFilterFooterView];
}

- (void)storyMakeFilterFooterViewConfirmBtnClicked:(UIImage *)drawImage {
    [self hideFilterFooterView];
}

- (void)showFilterFooterView:(UIImage *)image
{

    
    self.filterFooterView.hidden = NO;
    [self.filterFooterView updateFilterViewWithImage:image];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.filterFooterView.center = self.view.center;
                     }];
    
}

- (void)hideFilterFooterView
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.filterFooterView.center = CGPointMake(self.view.center.x, self.view.center.y + SCREENAPPLYHEIGHT(667));
                     } completion:^(BOOL finished) {
                         self.filterFooterView.hidden = YES;
                     }];
}



- (void)openAlbum{
    
    UIImagePickerController *imagePicker= [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    imagePicker.allowsEditing = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    [YLSVProgressHUD showMessage:nil];
    [picker dismissViewControllerAnimated:YES completion:^{

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
   
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self showFilterFooterView:image];
                [YLSVProgressHUD hideHUD];
            });
        });
        
        
//        [self showFilterFooterView:image];
//        StoryMakeImageEditorViewController *storyMakerVc = [[StoryMakeImageEditorViewController alloc] initWithImage:image];
//        [self presentViewController:storyMakerVc animated:YES completion:nil];
    }];
}

@end
