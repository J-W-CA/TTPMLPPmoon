//
//  YNImageUploadViewCollCell.h
//  上传图片控件
//
//  Created by 贾亚宁 on 2019/5/17.
//  Copyright © 2019 贾亚宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YNImageUploadState) {
    YNImageUploadStateNormal = 0,
    YNImageUploadStateUploading,
    YNImageUploadStateFinish,
    YNImageUploadStateFailed,
};

@interface YNImageModel : NSObject
/** 图片展示类型 */
@property (nonatomic, assign) NSInteger imageType;
/** 图片 */
@property (nonatomic, strong) UIImage *image;
/** 图片信息 */
@property (nonatomic, strong) PHAsset *asset;
/** 图片名称 */
@property (nonatomic, strong) NSString *imageName;
/** 网络图片 */
@property (nonatomic, strong) NSString *imageUrl;
/** 是否是最后一个 */
@property (nonatomic, assign, getter=isLast) BOOL last;
/** 上传任务 */
@property (nonatomic, strong) NSURLSessionDataTask *task;
/** 上传状态 */
@property (nonatomic, assign) YNImageUploadState state;
@end

@interface YNImageTool : NSObject
- (void)saveUploadFinishImageAsset:(YNImageModel *)imageModel;
/** 返回所有成功的imageAssetlocalIdentifiers */
@property (nonatomic, strong, readonly) NSArray <YNImageModel *>*imageModels;
@end

@interface YNImageUploadViewCollCell : UICollectionViewCell
/** 照片模型 */
@property (nonatomic, strong) YNImageModel *model;
/** 是否需要上传 */
@property (nonatomic, assign) BOOL isNeedUpload;
/** 上传Url */
@property (nonatomic, strong) NSString *uploadUrl;
/** 上传参数 */
@property (nonatomic, strong) NSDictionary *parameter;
/** 加载动画 */
@property (nonatomic, assign) NSInteger style;
/** 上传图片工具 */
@property (nonatomic, strong) YNImageTool *tool;
/** 删除按钮点击事件 */
@property (nonatomic, copy) void(^deleteBtnTapBlock)(YNImageUploadViewCollCell *deleCell);

// 长按事件
@property (nonatomic, copy) void(^longPressBtnTapBlock)(UILongPressGestureRecognizer *longPress);

@end

NS_ASSUME_NONNULL_END
