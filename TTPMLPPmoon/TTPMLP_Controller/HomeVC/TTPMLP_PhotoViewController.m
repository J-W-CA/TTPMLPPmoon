//
//  TTPMLP_PhotoViewController.m
//  FMLPFigureMonster
//
//  Created by apple on 2019/6/14.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import "TTPMLP_PhotoViewController.h"
#import "LMFilterChooserView.h"
#import "LMCameraManager.h"
#import "LMCameraFilters.h"
#import "GPUImage.h"

//    判断是否是iphone4
#define IS_IPHONE4 ([UIScreen mainScreen].bounds.size.height == 480)


#define iphone4_image_scale 480 / 320

#define iphone6_image_scale 500 / 375

#define upblackview_height 40.0f + 10 + SAFE_AREA_Top_HEIGHT

#define downblackview_height 140
@interface TTPMLP_PhotoViewController () {
    GPUImageStillCamera *videoCamera;
    GPUImageView *view1;
}

//    滤镜数组
@property (nonatomic , strong) NSArray *filters;
//    选择效果视图
@property (nonatomic , strong) LMCameraManager *cameraManager;

@property (nonatomic, strong) UIButton *leftBtn;//返回
//    闪光灯按钮
@property (nonatomic , strong) UIButton *flashButton;
//    摄像头位置按钮
@property (nonatomic , strong) UIButton *cameraPostionButton;
//    拍照
@property (nonatomic , strong) UIButton *snapshotButton;
//    background black view
@property (nonatomic , strong) UIView  *upBlackView;
@property (nonatomic , strong) UIView  *downBlackView;

@property (nonatomic , strong) UIImageView  *succeedImageView;//成功图片

//    filters选择器
@property (nonatomic , strong) LMFilterChooserView *filterChooserView;

@property (nonatomic, strong) UIButton *addBtn;//存入
@property (nonatomic, strong) UIButton *deleteBtn;//删除

/// 将要保存的图片
@property (nonatomic, strong) UIImage *postImage;

@end

@implementation TTPMLP_PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navView.hidden = YES;
    
    [self.cameraManager startCamera];
    [self.view addSubview:self.upBlackView];
    [self.upBlackView addSubview:self.leftBtn];
    [self.upBlackView addSubview:self.cameraPostionButton];
    [self.upBlackView addSubview:self.flashButton];
    [self.view addSubview:self.downBlackView];
    [self.downBlackView addSubview:self.snapshotButton];
    
    [self.filterChooserView addFilters:self.filters];
    [self.view addSubview:self.filterChooserView];
    
//    [self.cameraManager startCamera];
//    [self.view addSubview:self.upBlackView];
//    [self.upBlackView addSubview:self.leftBtn];
//    [self.upBlackView addSubview:self.cameraPostionButton];
//    [self.upBlackView addSubview:self.flashButton];
//    [self.view addSubview:self.downBlackView];
//    [self.downBlackView addSubview:self.snapshotButton];
//
//    [self.filterChooserView addFilters:self.filters];
//    [self.view addSubview:self.filterChooserView];
    
}

#pragma mark 滤镜组
- (NSArray *)filters {
    if (!_filters) {
        
#warning  滤镜需要自定义，demo只是演示来用
        
        GPUImageFilterGroup *f1 = [LMCameraFilters normal];
        [videoCamera addTarget:f1];
        
//        GPUImageFilterGroup *f2 = [LMCameraFilters contrast];
//        [videoCamera addTarget:f2];
//
//        GPUImageFilterGroup *f3 = [LMCameraFilters exposure];
//        [videoCamera addTarget:f3];
//
//        GPUImageFilterGroup *f4 = [LMCameraFilters saturation];
//        [videoCamera addTarget:f4];
//
//        GPUImageFilterGroup *f5 = [LMCameraFilters testGroup1];
//        [videoCamera addTarget:f5];
//
//        GPUImageFilterGroup *f6 = [LMCameraFilters testGroup2];
//        [videoCamera addTarget:f6];
//
//        GPUImageFilterGroup *f7 = [LMCameraFilters testGroup3];
//        [videoCamera addTarget:f7];
        
        NSArray *colorFilters = [NSArray arrayWithObjects:
                                 @[@"0X86E3CE",@"A1"],
                                 @[@"0XD0E6A5",@"A2"],
                                 @[@"0XFFDD94",@"A3"],
                                 @[@"0XFA897B",@"A4"],
                                 @[@"0XCCABD8",@"A5"],
                                 @[@"0X5D7599",@"B1"],
                                 @[@"0XABB6C8",@"B2"],
                                 @[@"0XDADADA",@"B3"],
                                 @[@"0XF7F0C6",@"B4"],
                                 @[@"0XC2C4B6",@"B5"],
                                 @[@"0X80BEAF",@"C1"],
                                 @[@"0XB3DDD1",@"C2"],
                                 @[@"0XD1DCE2",@"C3"],
                                 @[@"0XF58994",@"C4"],
                                 @[@"0XEE9C6C",@"C5"],
                                 @[@"0XD6A3DC",@"D1"],
                                 @[@"0XF7DB70",@"D2"],
                                 @[@"0XEABEBF",@"D3"],
                                 @[@"0X75CCE8",@"D4"],
                                 @[@"0XA5DEE5",@"D5"],
                                 @[@"0X478BA2",@"E1"],
                                 @[@"0XDE5B6D",@"E2"],
                                 @[@"0XE9765B",@"E3"],
                                 @[@"0XF2A490",@"E4"],
                                 @[@"0XB9D4DB",@"E5"],
                                 @[@"0XDA2864",@"F1"],
                                 @[@"0XEC6091",@"F2"],
                                 @[@"0XF2A7BE",@"F3"],
                                 @[@"0X9AE1E2",@"F4"],
                                 @[@"0X16A5A3",@"F5"],
                                 @[@"0X60EFDB",@"G1"],
                                 @[@"0XBEF2E5",@"G2"],
                                 @[@"0XC5E7F1",@"G3"],
                                 @[@"0X79CEED",@"G4"],
                                 @[@"0X6F89A2",@"G5"],
                                 @[@"0XAAC9CE",@"H1"],
                                 @[@"0XB6B4C2",@"H2"],
                                 @[@"0XC9BBC8",@"H3"],
                                 @[@"0XE5C1CD",@"H4"],
                                 @[@"0XF3D8CF",@"H5"],
                                 @[@"0X33539E",@"I1"],
                                 @[@"0X7FACD6",@"I2"],
                                 @[@"0XBFB8DA",@"I3"],
                                 @[@"0XE8B7D4",@"I4"],
                                 @[@"0XA5678E",@"I5"],
                                 
                                 
                                 nil];
        
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:f1,nil];
//         NSMutableArray *arr = [NSMutableArray arrayWithObjects:f1,f2,f3,f4,f5,f6,f7,nil];
        [colorFilters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 将十六进制字符串转成整型
            long colorLong = strtoul([obj[0] cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
            // 再通过位与方法获取三色值
            int R = (colorLong & 0xFF0000 )>>16;
            int G = (colorLong & 0x00FF00 )>>8;
            int B = colorLong & 0x0000FF;

            
            GPUImageFilterGroup *filter = [LMCameraFilters ImageRGBFilter:obj[1] red:R green:G blue:B];
            [self->videoCamera addTarget:filter];
            [arr addObject:filter];
        }];
        
//        NSArray *arr = [NSArray arrayWithObjects:f1,f2,f3,f4,f5,f6,f7,nil];
        _filters = arr;
    }
    return _filters;
}

#pragma mark 选择滤镜视图

- (LMFilterChooserView *)filterChooserView {
    if (!_filterChooserView) {
        float screen_width = [UIScreen mainScreen].bounds.size.width;
        float screen_height = [UIScreen mainScreen].bounds.size.height;
        LMFilterChooserView *scrollView = [[LMFilterChooserView alloc] initWithFrame:CGRectMake(0, screen_height - downblackview_height - 60, screen_width, 60)];
        TTPMLP_WEAKSELF(weakSelf);
        [scrollView addSelectedEvent:^(GPUImageFilterGroup *filter, NSInteger idx) {
            [weakSelf.cameraManager setFilterAtIndex:idx];
        }];
        _filterChooserView = scrollView;
    }
    return _filterChooserView;
}

#pragma mark 上黑色视图
- (UIView *)upBlackView {
    if (!_upBlackView) {
        float x = 0;
        float y = 0;
        float width = [UIScreen mainScreen].bounds.size.width;
        float height = upblackview_height;
        UIView *view= [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
//            view.backgroundColor = [UIColor redColor];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        view.userInteractionEnabled = YES;
        [self.view addSubview:view];
        _upBlackView = view;
    }
    return _upBlackView;
}

#pragma mark 下黑色视图
- (UIView *)downBlackView {
    if (!_downBlackView) {
        float x = 0;
        float y = [UIScreen mainScreen].bounds.size.height - downblackview_height;
        float width = [UIScreen mainScreen].bounds.size.width;
        float height = downblackview_height;
        UIView *view= [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
//        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        _downBlackView = view;
    }
    return _downBlackView;
}

#pragma mark 摄像头管理器
- (LMCameraManager *)cameraManager {
    if (!_cameraManager) {
        CGRect rect;
        float width = [UIScreen mainScreen].bounds.size.width;
        
//        if (IS_IPHONE4) rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, width * iphone4_image_scale);
//        else  rect = CGRectMake(0, 0, width, width * iphone6_image_scale);
        rect = CGRectMake(0, 0, width, [UIScreen mainScreen].bounds.size.height - downblackview_height - 60);
        
        LMCameraManager *cameraManager = [[LMCameraManager alloc] initWithFrame:rect superview:self.view];
        [cameraManager addFilters:self.filters];
        [cameraManager setfocusImage:[UIImage imageNamed:@"touch_focus"]];
        _cameraManager = cameraManager;
    }
    return _cameraManager;
}



#pragma mark 按钮点击事件
- (void)selectedButton:(UIButton *)button {
    
    switch (button.tag) {
        case 1:
            [self snapshot];
            break;
        case 2:
            [self changeFlashMode:button];
            break;
        case 3:
            [self changeCameraPostion];
            break;
        case 4://返回
               [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}

#pragma mark 拍照

- (void)snapshot {
    
    [self.cameraManager snapshotSuccess:^(UIImage *image) {
        self.postImage = nil;
        self.postImage = image;
        if (image == nil)return;
        [self.cameraManager stopCamera];
        self.succeedImageView.hidden = NO;
        [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            // 执行动画
            self.succeedImageView.frame  = CGRectMake(0, 0, kscreenWidth, kscreenHeight);
        } completion:^(BOOL finished) {
            // 动画完成做什么事情
        }];
        self.succeedImageView.image = self.postImage;
        
        self.addBtn.hidden = NO;
        self.deleteBtn.hidden = NO;
        
    } snapshotFailure:^{
        NSLog(@"拍照失败");
        
            [self.cameraManager startCamera];
    }];
}

-(void)addBtn:(UIButton *)btn{
    
    if (btn.tag ==1 ) {//保存
        //保存
        [self saveImageToPhotos:self.postImage];
        
        
    }else{
        
        [self dismissView];
    }
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
        self.succeedImageView.hidden = YES;
        [self.cameraManager startCamera];
    } completion:^(BOOL finished) {
        // 动画完成做什么事情
    }];
    
}


#pragma mark 改变摄像头位置
- (void)changeCameraPostion {
    if (self.cameraManager.position == LMCameraManagerDevicePositionBack)
        self.cameraManager.position = LMCameraManagerDevicePositionFront;
    else
        self.cameraManager.position = LMCameraManagerDevicePositionBack;
    
}

#pragma mark 改变闪光灯状态
- (void)changeFlashMode:(UIButton *)button {
    
    switch (self.cameraManager.position) {
        case LMCameraManagerDevicePositionBack:
        {
            switch (self.cameraManager.flashMode) {
                case LMCameraManagerFlashModeAuto:
                    self.cameraManager.flashMode = LMCameraManagerFlashModeOn;
                    [button setImage:[UIImage imageNamed:@"flashing_on"] forState:UIControlStateNormal];
                    break;
                case LMCameraManagerFlashModeOff:
                    self.cameraManager.flashMode = LMCameraManagerFlashModeAuto;
                    [button setImage:[UIImage imageNamed:@"flashing_auto"] forState:UIControlStateNormal];
                    break;
                case LMCameraManagerFlashModeOn:
                    self.cameraManager.flashMode = LMCameraManagerFlashModeOff;
                    [button setImage:[UIImage imageNamed:@"flashing_off"] forState:UIControlStateNormal];
                    break;
        
                default:
                    break;
            }
        }
            break;
            
        case LMCameraManagerDevicePositionFront:
        {
            switch (self.cameraManager.flashMode) {
                case LMCameraManagerFlashModeAuto:
                    self.cameraManager.flashMode = LMCameraManagerFlashModeOff;
                    [button setImage:[UIImage imageNamed:@"flashing_on"] forState:UIControlStateNormal];
                    break;
                case LMCameraManagerFlashModeOff:
                    self.cameraManager.flashMode = LMCameraManagerFlashModeAuto;
                    [button setImage:[UIImage imageNamed:@"flashing_auto"] forState:UIControlStateNormal];
                    break;
                case LMCameraManagerFlashModeOn:
                    self.cameraManager.flashMode = LMCameraManagerFlashModeOff;
                    [button setImage:[UIImage imageNamed:@"flashing_off"] forState:UIControlStateNormal];
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}



- (void)saveImageToPhotos:(UIImage*)savedImage
{
    [YLSVProgressHUD showMessage:nil];
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
//        msg =CLocalizedString(@"Failed to save image");
       
         [YLSVProgressHUD showError:nil];
    }else{
         [YLSVProgressHUD showSuccess:nil];
        [self dismissView];
    }
}

-(UIImageView *)succeedImageView{
    if (!_succeedImageView) {
        _succeedImageView = [[UIImageView alloc]init];
        
        _succeedImageView.backgroundColor = [UIColor blackColor];
        //        button.bounds = CGRectMake(0, 0, width, height);
        //        button.center = center;
        _succeedImageView.contentMode  =    UIViewContentModeScaleAspectFit;
        _succeedImageView.hidden = YES;
        _succeedImageView.userInteractionEnabled = YES;
        [self.view addSubview:_succeedImageView];
    }
    return _succeedImageView;
}
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        float width = 40.0f;
        float height = 40.0f;
        float x = 0;
        float y = 10 + SAFE_AREA_Top_HEIGHT;
        [_leftBtn setImage:IMageName(@"返回") forState:UIControlStateNormal];
        _leftBtn.frame = CGRectMake( x, y, width, height);
        _leftBtn.tag = 4;
        [_leftBtn addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

#pragma mark 闪光灯按钮
- (UIButton *)flashButton {
    if (!_flashButton) {
        float width = 40.0f;
        float height = 40.0f;
        float x = [UIScreen mainScreen].bounds.size.width - width;
        float y = 10 + SAFE_AREA_Top_HEIGHT;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 2;
        [button setImage:[UIImage imageNamed:@"flashing_auto"] forState:UIControlStateNormal];
        button.frame = CGRectMake(x, y, width, height);
        [button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
        _flashButton = button;
    }
    return _flashButton;
}

#pragma mark 摄像头位置按钮

- (UIButton *)cameraPostionButton {
    if (!_cameraPostionButton) {
        float width = 40.0f;
        float height = 40.0f;
        float x =  [UIScreen mainScreen].bounds.size.width/2 - width/2;
        float y = 10 + SAFE_AREA_Top_HEIGHT;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 3;
        [button setImage:[UIImage imageNamed:@"chage"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"chage"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(x, y, width, height);
        [button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
        _cameraPostionButton = button;
    }
    return _cameraPostionButton;
}

#pragma mark 快照按钮

- (UIButton *)snapshotButton {
    if (!_snapshotButton) {
        float width = 80.0f;
        float height = 80.0f;
        
        CGPoint center = CGPointMake(self.downBlackView.bounds.size.width / 2, self.downBlackView.bounds.size.height / 2);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1;
        //        [button setTitle:@"拍照" forState:UIControlStateNormal];
        [button setImage:IMageName(@"TakePhoto") forState:UIControlStateNormal];
        //        button.backgroundColor = [UIColor redColor];
        button.bounds = CGRectMake(0, 0, width, height);
        button.center = center;
        [button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
        _snapshotButton = button;
    }
    return _snapshotButton;
}
- (UIButton *)addBtn{
    
    if(!_addBtn){
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(kscreenWidth - 50, kscreenHeight - 55 - SAFE_AREA_BOTTOM_HEIGHT, 40,40);
        _addBtn.titleLabel.font = BoldSystemfont(14.0);
        //        [_addBtn setTitle:CLocalizedString(@"Save") forState:UIControlStateNormal];
        [_addBtn setImage:IMageName(@"seve") forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor blueColor  ] forState:UIControlStateNormal];
        _addBtn.tag = 1;
        [_addBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.hidden = YES;
        
        [self.succeedImageView addSubview:_addBtn];
    }
    return _addBtn;
}

- (UIButton *)deleteBtn{
    
    if(!_deleteBtn){
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         _deleteBtn.frame = CGRectMake(10, kscreenHeight - 55 - SAFE_AREA_BOTTOM_HEIGHT, 40,40);
        _deleteBtn.titleLabel.font = BoldSystemfont(14.0);
        _deleteBtn.tag = 2;
        [_deleteBtn setImage:IMageName(@"cancel") forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.hidden = YES;
        [self.succeedImageView addSubview:_deleteBtn];
    }
    return _deleteBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
