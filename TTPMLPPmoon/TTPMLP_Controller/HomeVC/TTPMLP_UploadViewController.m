//
//  TTPMLP_UploadViewController.m
//  FMLPFigureMonster
//
//  Created by apple on 2019/6/12.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import "TTPMLP_UploadViewController.h"
#import "TTPMLP_SyntheticViewController.h"

@interface TTPMLP_UploadViewController ()
/// 图片数组
@property (nonatomic, strong) NSMutableArray *photoArr;
/// 将要保存的图片
@property (nonatomic, strong) UIImage *postImage;
@property (assign, nonatomic) NSInteger pageCount;//读取第几次

@property (nonatomic, strong) UIScrollView *ImageScroll;
@property (nonatomic, strong) UIImageView *showImg;

@property (nonatomic, strong) UIButton *addBtn;//存入
@property (nonatomic, strong) UIButton *deleteBtn;//删除
@end

@implementation TTPMLP_UploadViewController {
    YNImageUploadView *imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.leftButton setImage:IMageName(CLocalizedImgName(@"返回")) forState:UIControlStateNormal];
    [self.CenterButton setTitle:CLocalizedString(@"Stitch") forState:UIControlStateNormal];
 
//    [self.AddImageButton setTitle:CLocalizedString(@"添加") forState:UIControlStateNormal];
    [self.AddImageButton setImage:IMageName(CLocalizedImgName(@"添加拼图")) forState:UIControlStateNormal];
    self.AddImageButton.hidden = NO;
    [self.rightButton setTitle:CLocalizedString(@"Compose") forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    TTPMLP_WEAKSELF(weakSelf);
    imageView = [[YNImageUploadView alloc] initWithConfig:^(YNImageUploadViewConfig * _Nonnull config) {
        config.insets = UIEdgeInsetsMake(5, 10, 5, 10);
        config.autoHeight = YES;
        config.isNeedUpload = NO;
        config.rowCount = 1;
        config.scale = 0.25; // 高宽比
        //        config.uploadUrl = @"你的上传链接";
        //        config.parameter = @{@"parameter" : @"这里是你的参数"};
    }];
    
    [self.view insertSubview:imageView belowSubview:self.AddImageButton];
    
//    [self.view addSubview:imageView];
    
    
    // 设置视图区域
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(NAVIGATETION_BAR_MAX_Y);
        make.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(SAFE_AREA_BOTTOM_HEIGHT);
//        make.height.equalTo(@(100));
    }];
    TTPMLP_WEAKSELF(weakself);
    imageView.imageBlock = ^(NSArray<UIImage *> * _Nonnull images) {
        FBLog (@"%ld",images.count);
        [weakself. photoArr removeAllObjects];
        if (images.count >= 2) {
            [weakself.rightButton setTitleColor:UIColorFromHex(0x764C24) forState:UIControlStateNormal];
            weakself.rightButton.userInteractionEnabled = YES;
            weakself. photoArr = [NSMutableArray arrayWithArray:images];
        }else{
            [weakself.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            weakself.rightButton.userInteractionEnabled = NO;
        }
        
    };
    
}

// 自定义添加按钮
- (void)addImageMothod {
    [imageView addImages];
}


//合成
- (void)searchMothod{

    if (self.photoArr.count >= 2) {
        [self.rightButton setTitleColor:UIColorFromHex(0x764C24) forState:UIControlStateNormal];
        self.rightButton.userInteractionEnabled = YES;
//        self.ImageScroll.hidden = NO;
//        [self showImageOnViewWithImage:[self composeImages:self.photoArr]];
        TTPMLP_SyntheticViewController *synthetic = [[TTPMLP_SyntheticViewController alloc] init];
        synthetic.photoArr = self.photoArr;
        [self.navigationController pushViewController:synthetic animated:YES];
    }else{
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:CLocalizedString(@"Prompt") message:CLocalizedString(@"Please select the image you want to synthesize") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *contactAction = [UIAlertAction actionWithTitle:CLocalizedString(@"Enter") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // dismiss
            [alertVC dismissViewControllerAnimated:YES completion:^{
                
            }];
            
            [self dismissView];
        }];
        
        [alertVC addAction:contactAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        
        
        [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.rightButton.userInteractionEnabled = NO;
    }
    
}

- (UIImage *)composeImages:(NSArray<UIImage *> *)arr{
    //间隔
    int margin = 20;
    //左右间距
    int marginL = 15;
    //合成宽度
    CGFloat width = 2*[UIScreen mainScreen].bounds.size.width - 2*marginL;
    //合成高度
    CGFloat height = 0;
    //计算高度
    for (UIImage *img in arr) {
        CGFloat h = img.size.height / (img.size.width/width) + margin;
        height += h;
    }
    //画板大小
    UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width*2, height+margin+10));
    
    //当前y值
    CGFloat y = 20;
    
    //画图
    for (int i = 0; i<arr.count;i++) {
        UIImage *img = arr[i];
        CGFloat w = img.size.width;
        CGFloat h = img.size.height;
        [img drawInRect:CGRectMake(marginL, y, width, h / (w/width))];
        y += h / (w/width) +margin ;
    }
    
    CGFloat x = 30;
    CGFloat imgW =90;// x/52.f*428;
    //水印
    [IMageName(@"FMLPFigureMonsterW") drawInRect:CGRectMake([UIScreen mainScreen].bounds.size.width*2-imgW-marginL, height+5, 68, x)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}


-(void)showImageOnViewWithImage:(UIImage *)imageStr{
    self.ImageScroll.center = self.view.center;
    
    // 方式四
    // UIViewAnimationOptionCurveEaseInOut 缓入缓出
    // UIViewAnimationOptionCurveEaseIn 缓入
    // UIViewAnimationOptionCurveEaseOut 缓出
    // UIViewAnimationOptionCurveLinear 线性
    // delay: 延时执行
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        // 执行动画
      self.ImageScroll.frame  = CGRectMake( 0, NAVIGATETION_BAR_MAX_Y, kscreenWidth,  kscreenHeight -NAVIGATETION_BAR_MAX_Y -45);
    } completion:^(BOOL finished) {
        // 动画完成做什么事情
    }];
    

    //    CGFloat imageH;
    CGFloat imgHeight = imageStr.size.height;
    CGFloat imgWidth = imageStr.size.width;
    CGFloat imageH = imgHeight * (kscreenWidth / imgWidth);
    //    imageH = imageStr.size.height;
    self.showImg.frame = CGRectMake(0, 0, kscreenWidth, imageH);
    self.showImg.image =imageStr;
    //设置imageView的背景图
    _ImageScroll.contentSize=CGSizeMake(0, imageH+60);
    self.showImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.ImageScroll addSubview: self.showImg];
    self.addBtn.hidden = NO;
    self.deleteBtn.hidden = NO;
}

-(void)addBtn:(UIButton *)btn{
    
    if (btn.tag ==1 ) {//保存
        //保存
        [self saveImageToPhotos:[self composeImages:self.photoArr]];
    }else{
        [self dismissView];
    }
}

/// 发布图片
- (void)postPhoto {
    
    self.postImage = nil;
    self.pageCount = 0;
    if (self.photoArr.count) {
        for (NSInteger i = 0 ; i < self.photoArr.count; i ++) {
            self.postImage = [self mergeImages:self.photoArr[i]];
        }
    }
    //    [self saveImageToPhotos:self.postImage];
}

#pragma mark - 合成图片
// 获得顶部图片
- (UIImage *)getImageFromView{
    // 已经合成过一次,就去上次的合成结果
    if(self.postImage)
        return self.postImage;
    else
        return nil;
}

// 获得待合成图片
- (UIImage *)mergeImages:(UIImage *)mergeImage
{
    
    UIImage *newimage = mergeImage;
    UIImage *postImage = [self getImageFromView];
    
    
    //    FBLog(@"",mergeImage.size.height,mergeImage.size.height)
    // 获取位图上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kscreenWidth, postImage.size.height + mergeImage.size.height), NO, 0.0);
    [newimage drawInRect:CGRectMake(0, postImage.size.height, kscreenWidth, mergeImage.size.height)];
    
    [postImage drawAtPoint:CGPointMake(0,0)];
    // 获取位图
    UIImage *saveimage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭位图上下文
    UIGraphicsEndImageContext();
    // 保存图片，需要转换成二进制数据
    //    [self saveImageToPhotos:saveimage];
    
    self.pageCount ++;
    if (self.pageCount == self.photoArr.count) {
        // 保存图片，需要转换成二进制数据
        [self saveImageToPhotos:saveimage];
    }
    return saveimage;
}
- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg =CLocalizedString(@"Failed to save image");
    }else{

    }

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:CLocalizedString(@"保存图片结果提示") message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *contactAction = [UIAlertAction actionWithTitle:CLocalizedString(@"Enter") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // dismiss
        [alertVC dismissViewControllerAnimated:YES completion:^{
          
        }];
          [self dismissView];
    }];
    [alertVC addAction:contactAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(void)dismissView{
    

    
    // 方式四
    // UIViewAnimationOptionCurveEaseInOut 缓入缓出
    // UIViewAnimationOptionCurveEaseIn 缓入
    // UIViewAnimationOptionCurveEaseOut 缓出
    // UIViewAnimationOptionCurveLinear 线性
    // delay: 延时执行
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // 执行动画
        self.addBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
        self.ImageScroll.hidden = YES;
        
    } completion:^(BOOL finished) {
        // 动画完成做什么事情
    }];

}

- (NSMutableArray *)photoArr{
    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}
-(UIScrollView *)ImageScroll{
    if (!_ImageScroll) {
        _ImageScroll = [[UIScrollView alloc]init];
        _ImageScroll.backgroundColor = [UIColor whiteColor];
        //        _ImageScroll.showsVerticalScrollIndicator=NO;
//        _ImageScroll.layer.borderWidth = 0.3;
//        _ImageScroll.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.view  addSubview:_ImageScroll];
    }
    return _ImageScroll;
}

-(UIImageView *)showImg{
    if (!_showImg) {
        _showImg = [[UIImageView alloc]init];
        //给imageView设置区域
        
        //超出边界的剪切
        //        [_showImg setClipsToBounds:YES];
        //把视图添加到当前的滚动视图中
        
    }
    return _showImg;
}

- (UIButton *)addBtn{
    
    if(!_addBtn){
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(kscreenWidth - 50, kscreenHeight - 55, 40,40);
        _addBtn.titleLabel.font = BoldSystemfont(14.0);
//        [_addBtn setTitle:CLocalizedString(@"Save") forState:UIControlStateNormal];
        [_addBtn setImage:IMageName(@"seve") forState:UIControlStateNormal];
        _addBtn.tag = 1;
        [_addBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.hidden = YES;
        
         [self.view addSubview:_addBtn];
    }
    return _addBtn;
}

- (UIButton *)deleteBtn{
    
    if(!_deleteBtn){
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(10, kscreenHeight - 55, 40,40);
        _deleteBtn.titleLabel.font = BoldSystemfont(14.0);
                _deleteBtn.tag = 2;
                [_deleteBtn setImage:IMageName(@"cancel") forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
           _deleteBtn.hidden = YES;
        [self.view addSubview:_deleteBtn];
    }
    return _deleteBtn;
}
@end
