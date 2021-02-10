//
//  TTPMLP_UploadViewController.m
//  FMLPFigureMonster
//
//  Created by apple on 2019/6/12.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import "TTPMLP_ScrawlViewController.h"

#import "TTPMLP_ImageScrollView.h"
#import "TTPMLP_SaveViewController.h"

#import "MosaiView.h"


@interface TTPMLP_ScrawlViewController () <MosaiViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>

/// 将要保存的图片
@property (nonatomic, strong) UIImage *postImage;
@property (assign, nonatomic) NSInteger pageCount;//读取第几次

@property (nonatomic, strong) UIScrollView *ImageScroll;

@property (nonatomic, strong) MosaiView *mosaicView;


//马赛克底层图
@property(nonatomic, strong)NSMutableArray *mosaiSourceArray;

@end

@implementation TTPMLP_ScrawlViewController {
    YNImageUploadView *imageView;
    float imageH;
    float offY; // 滑动的偏移量
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.leftButton setImage:IMageName(CLocalizedImgName(@"返回")) forState:UIControlStateNormal];
    [self.rightButton setImage:IMageName(CLocalizedImgName(@"image_upload_failed")) forState:UIControlStateNormal];
    [self.CenterButton setTitle:CLocalizedString(@"Mosaic") forState:UIControlStateNormal];
    
    
    CGFloat w = self.currentImage.size.width;
    CGFloat h = self.currentImage.size.height;
    CGFloat width = kscreenWidth;
    CGFloat height = h / (w/width);
    imageH += height;


    _ImageScroll.contentSize = CGSizeMake(self.ImageScroll.frame.size.width, imageH);
    _ImageScroll.scrollEnabled = NO;
    
    
    UILongPressGestureRecognizer *longPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressImage:)];
    longPressGesture.minimumPressDuration=0;//设置长按时间，默认0.5秒，一般这个值不要修改
    longPressGesture.numberOfTouchesRequired = 2;
    longPressGesture.delegate = self;
    //注意由于我们要做长按提示删除操作，因此这个手势不再添加到控制器视图上而是添加到了图片上
    [_ImageScroll addGestureRecognizer:longPressGesture];
    
    
    [self initView];
    
}

// 提示
- (void)searchMothod{
    [[HQToast shareInstance] showText:CLocalizedString(@"Mosaic_Tips")];
}

- (void)initView{
    
    _mosaiSourceArray = [[NSMutableArray alloc]init];
    
    
//    UIImage *img = [UIImage imageNamed:@"cat.jpg"];
    UIImage *img = self.currentImage;
    UIImage *newImg = [[self class] mosaicImage:img mosaicLevel:20];
    CGFloat ScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat ScreenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat imageSizeWidth = img.size.width;
    CGFloat imageSizeHeight = img.size.height;
//    CGFloat height = 0.0f;
    CGFloat scale = ScreenWidth * imageSizeHeight / imageSizeWidth;
    
    self.mosaicView = [[MosaiView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, scale)];
    self.mosaicView.deleagate = self;

    
    _mosaiSourceArray = [singleton share].mosaiSourceArray;
    
//    [singleton share].mosaiSourceArray = self.mosaiSourceArray;
    
       

    self.mosaicView.originalImage = img;
    self.mosaicView.mosaicImage = _mosaiSourceArray[[NSUserDefaults getCurrentFuzzyStatus]];
//    self.mosaicView.mosaicImage = newImg;
    [_ImageScroll addSubview:self.mosaicView];
//    [self.view addSubview:self.mosaicView];
    
//    self.currentScrawImage.image = [UIImage imageNamed:@"mosai1.jpg"];
    self.currentScrawImage.image = self.mosaicView.mosaicImage;
    
    self.currentScrawlScrollView.SelectCallBack = ^(NSInteger index) {
        self.mosaicView.mosaicImage = self.mosaiSourceArray[index];
        self.currentScrawImage.image = self.mosaicView.mosaicImage;
    };
    
    self.currentBrushSize.value = [NSUserDefaults getCurrentBrushSize];

}

- (IBAction)addBtnClick:(id)sender {
    // 保存
    [self saveImageToPhotos:[self.mosaicView render]];
}

// 选择画板
- (IBAction)selectColorClick:(id)sender {
    self.viewPanel.flag = !self.viewPanel.hidden;
}

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
        _ImageScroll.delegate = self;
        _ImageScroll.hidden = NO;
        _ImageScroll.frame  = CGRectMake( 0, NAVIGATETION_BAR_MAX_Y, kscreenWidth,  kscreenHeight -NAVIGATETION_BAR_MAX_Y -55 - SAFE_AREA_BOTTOM_HEIGHT);
        _ImageScroll.showsVerticalScrollIndicator = NO;
        _ImageScroll.showsHorizontalScrollIndicator = NO;
//        _ImageScroll.alwaysBounceVertical = YES; //当数据不多，不够一屏幕
        
        [self.view insertSubview:_ImageScroll belowSubview:self.viewPanel];
    }
    return _ImageScroll;
}

#pragma mark - 手势监听


-(void)longPressImage:(UILongPressGestureRecognizer *)gesture{

//    NSLog(@"longpress:%li",(long)gesture.state);


    
        switch (gesture.state) {
            case UIGestureRecognizerStateBegan: {
                CGPoint transP = [gesture locationInView:_ImageScroll];
                offY = transP.y;
            }

                break;

            case UIGestureRecognizerStateChanged: {
                
                if (imageH >= _ImageScroll.frame.size.height) {
                    
                CGPoint transP = [gesture locationInView:_ImageScroll];
                float offsetY = transP.y - offY;
                
                float Y =  _ImageScroll.contentOffset.y - offsetY;
                if (Y < 0) {
                    Y = 0;
                }
                
                float heigt = imageH - _ImageScroll.frame.size.height;
                
                if (Y > heigt) {
                    Y = heigt;
                }
                
                CGPoint position =CGPointMake( _ImageScroll.contentOffset.x, Y);

                _ImageScroll.contentOffset = position;
                }
            }
                break;

            default:
                _ImageScroll.scrollEnabled = NO;
                offY = 0;
                break;
        }

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;

//      return NO;
}


#pragma mark - 马赛克

- (IBAction)undoRedo:(UIButton *)sender {
    if (sender.tag == 8000) {
        [self.mosaicView undo];
    }else if (sender.tag == 8001){
        [self.mosaicView redo];
    }
//    UILabel *operationLabel = [self.view viewWithTag:5000];
//    operationLabel.text = [NSString stringWithFormat:@"操作数:%ld次,当前操作数:%ld次",self.mosaicView.operationCount, self.mosaicView.currentIndex];
}

-(void)mosaiView:(MosaiView *)view TouchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _ImageScroll.scrollEnabled = NO;
    NSLog(@"结束移动数量:%li", touches.count);
    UILabel *operationLabel = [self.view viewWithTag:5000];
    operationLabel.text = [NSString stringWithFormat:@"操作数:%ld次,当前操作数:%ld次",self.mosaicView.operationCount,self.mosaicView.currentIndex];
}

//生成原图马赛克
+(UIImage *)mosaicImage:(UIImage *)sourceImage mosaicLevel:(NSUInteger)level{
    
    //1、这一部分是为了把原始图片转成位图，位图再转成可操作的数据
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//颜色通道
    CGImageRef imageRef = sourceImage.CGImage;//位图
    CGFloat width = CGImageGetWidth(imageRef);//位图宽
    CGFloat height = CGImageGetHeight(imageRef);//位图高
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, width * 4, colorSpace, kCGImageAlphaPremultipliedLast);//生成上下午
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, width, height), imageRef);//绘制图片到上下文中
    unsigned char *bitmapData = CGBitmapContextGetData(context);//获取位图的数据
    
    
    //2、这一部分是往右往下填充色值
    NSUInteger index,preIndex;
    unsigned char pixel[4] = {0};
    for (int i = 0; i < height; i++) {//表示高，也可以说是行
        for (int j = 0; j < width; j++) {//表示宽，也可以说是列
            index = i * width + j;
            if (i % level == 0) {
                if (j % level == 0) {
                    //把当前的色值数据保存一份，开始为i=0，j=0，所以一开始会保留一份
                    memcpy(pixel, bitmapData + index * 4, 4);
                }else{
                    //把上一次保留的色值数据填充到当前的内存区域，这样就起到把前面数据往后挪的作用，也是往右填充
                    memcpy(bitmapData +index * 4, pixel, 4);
                }
            }else{
                //这里是把上一行的往下填充
                preIndex = (i - 1) * width + j;
                memcpy(bitmapData + index * 4, bitmapData + preIndex * 4, 4);
            }
        }
    }
    
    //把数据转回位图，再从位图转回UIImage
    NSUInteger dataLength = width * height * 4;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData, dataLength, NULL);
    
    CGImageRef mosaicImageRef = CGImageCreate(width, height,
                                              8,
                                              32,
                                              width*4 ,
                                              colorSpace,
                                              kCGBitmapByteOrderDefault,
                                              provider,
                                              NULL, NO,
                                              kCGRenderingIntentDefault);
    CGContextRef outputContext = CGBitmapContextCreate(nil,
                                                       width,
                                                       height,
                                                       8,
                                                       width*4,
                                                       colorSpace,
                                                       kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(outputContext, CGRectMake(0.0f, 0.0f, width, height), mosaicImageRef);
    CGImageRef resultImageRef = CGBitmapContextCreateImage(outputContext);
    UIImage *resultImage = nil;
    if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
        float scale = [[UIScreen mainScreen] scale];
        resultImage = [UIImage imageWithCGImage:resultImageRef scale:scale orientation:UIImageOrientationUp];
    } else {
        resultImage = [UIImage imageWithCGImage:resultImageRef];
    }
    CFRelease(resultImageRef);
    CFRelease(mosaicImageRef);
    CFRelease(colorSpace);
    CFRelease(provider);
    CFRelease(context);
    CFRelease(outputContext);
    return resultImage;
}

// 改变值的时候发生
- (IBAction)BrushSizeClick:(id)sender {
    float value = self.currentBrushSize.value;
    [NSUserDefaults saveCurrentBrushSize:value];
    [self.mosaicView updateLineWidth];
}

@end
