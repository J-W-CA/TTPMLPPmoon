//
//  TTPMLP_UploadViewController.m
//  FMLPFigureMonster
//
//  Created by apple on 2019/6/12.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import "TTPMLP_SyntheticViewController.h"

#import "TTPMLP_ImageScrollView.h"
#import "TTPMLP_SaveViewController.h"
#import "TTPMLP_ScrawlViewController.h"


@interface TTPMLP_SyntheticViewController ()

/// 将要保存的图片
@property (nonatomic, strong) UIImage *postImage;
@property (assign, nonatomic) NSInteger pageCount;//读取第几次

@property (nonatomic, strong) UIScrollView *ImageScroll;


@end

@implementation TTPMLP_SyntheticViewController {
    YNImageUploadView *imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.leftButton setImage:IMageName(CLocalizedImgName(@"返回")) forState:UIControlStateNormal];
    [self.CenterButton setTitle:CLocalizedString(@"Stitch") forState:UIControlStateNormal];
    
    float imageH = 0;
    
    float lastY = 0;
    
    //画图
    for (int i = 0; i<self.photoArr.count;i++) {
        UIImage *img = self.photoArr[i];
        CGFloat w = img.size.width;
        CGFloat h = img.size.height;
        CGFloat width = kscreenWidth;
        CGFloat height = h / (w/width);
        imageH += height;
        
        
        
        
        TTPMLP_ImageScrollView *sc = [[TTPMLP_ImageScrollView alloc] initWithFrame:CGRectMake(0, lastY, width, height) image:img];
        sc.tag = 1000 + i; // 标记值
        [self.ImageScroll addSubview:sc];
         // 添加约束

        lastY = imageH;
    }

     _ImageScroll.contentSize = CGSizeMake(self.ImageScroll.frame.size.width, imageH);
//    [self.view addSubview:self.addBtn];
//    [self.view addSubview:self.scrawlBtn];
//    [self.view addSubview:self.viewLine];
    
}

- (IBAction)addBtnClick:(id)sender {
    //保存
    [self saveImageToPhotos:[self captureCollectionView:self.ImageScroll]];
}

// 马赛克涂鸦
- (IBAction)scrawlBtnClick:(id)sender {
    UIImage *image = [self captureCollectionView:self.ImageScroll];
    [YLSVProgressHUD showMessage:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  (int64_t)(0.5 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            [YLSVProgressHUD hideHUD];
            TTPMLP_ScrawlViewController *scraw = [[TTPMLP_ScrawlViewController alloc] init];
            scraw.currentImage = image;
            [self.navigationController pushViewController:scraw animated:YES];
        
    });
}

//-(void)addBtn:(UIButton *)btn{
//    //保存
//    [self saveImageToPhotos:[self captureCollectionView:self.ImageScroll]];
//}

- (UIImage *)captureCollectionView:(UIScrollView *)myView {
    UIImage* image = nil;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(myView.contentSize.width, myView.contentSize.height - 22), NO, [UIScreen mainScreen].scale);
    //    UIGraphicsBeginImageContextWithOptions(myView.contentSize, NO, [UIScreen mainScreen].scale); // 这个函数是是截取的图片更加的清晰
    {
        CGPoint savedContentOffset = myView.contentOffset;
        CGRect savedFrame = myView.frame;
        myView.contentOffset = CGPointZero;
        myView.frame = CGRectMake(0, 0, myView.contentSize.width, myView.contentSize.height);
        
        [myView.layer renderInContext: UIGraphicsGetCurrentContext()];
        
        myView.contentOffset = savedContentOffset;
        myView.frame = savedFrame;
        
        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    
    return nil;
    
}

- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    [YLSVProgressHUD showMessage:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  (int64_t)(0.5 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        NSString *msg = nil ;
        if(error != NULL){
            msg =CLocalizedString(@"Failed to save image");
            [YLSVProgressHUD showError:msg];
        }else{
            [YLSVProgressHUD showSuccess:nil];
            TTPMLP_SaveViewController *save = [[TTPMLP_SaveViewController alloc] init];
            save.currentImage = image;
            [self.navigationController pushViewController:save animated:YES];
        }
    });
}

-(UIScrollView *)ImageScroll{
    if (!_ImageScroll) {
        _ImageScroll = [[UIScrollView alloc]init];
        _ImageScroll.backgroundColor = [UIColor clearColor];
//        _ImageScroll.delegate = self;
        _ImageScroll.hidden = NO;
        _ImageScroll.frame  = CGRectMake( 0, NAVIGATETION_BAR_MAX_Y, kscreenWidth,  kscreenHeight -NAVIGATETION_BAR_MAX_Y -55 - SAFE_AREA_BOTTOM_HEIGHT);
        _ImageScroll.showsVerticalScrollIndicator = NO;
        _ImageScroll.showsHorizontalScrollIndicator = NO;
        _ImageScroll.alwaysBounceVertical = YES; //当数据不多，不够一屏幕
        [self.view  addSubview:_ImageScroll];
    }
    return _ImageScroll;
}

@end
