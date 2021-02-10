//
//  YNImageUploadView.h
//  上传图片控件
//
//  Created by 贾亚宁 on 2019/5/16.
//  Copyright © 2019 贾亚宁. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YNImageUploadAnimationStyle) {
    YNImageUploadAnimationStyleNormal = 0,          // 普通旋转的菊花
    YNImageUploadAnimationStyleProgressBar,         // 进度条
    YNImageUploadAnimationStylePercentCircle,       // 圆圈里面含有百分比数字
};

typedef NS_ENUM(NSInteger, YNImageUploadImageType) {
    YNImageUploadImageTypeImage = 0,
    YNImageUploadImageTypeImageUrl,
    YNImageUploadImageTypeImageName,
    YNImageUploadImageTypeUpload,
};

@interface YNImageUploadViewConfig : NSObject
/** 选取图片的个数 */
@property (nonatomic, assign) NSInteger photoCount;
/** 每行展示图片的个数 */
@property (nonatomic, assign) NSInteger rowCount;
/** 集合视图对于父控件的偏移 */
@property (nonatomic, assign) UIEdgeInsets insets;
/** 行间距 */
@property (nonatomic, assign) CGFloat lineSpace;
/** 列间距 */
@property (nonatomic, assign) CGFloat columnsSpace;
/** item的宽高比例 */
@property (nonatomic, assign) double scale;
/** 是否自适应高度, 如果设置为YES则collectionView设置的高度将无效 */
@property (nonatomic, assign, getter=isAutoHeight) BOOL autoHeight;
/** 是否需要上传 */
@property (nonatomic, assign) BOOL isNeedUpload;
/** 上传的Url */
@property (nonatomic, strong) NSString *uploadUrl;
/** 上传所需参数 */
@property (nonatomic, strong) NSDictionary *parameter;
/** 添加图片的icon */
@property (nonatomic, strong) UIImage *addImage;
/** 上传图片的动画类型 */
@property (nonatomic, assign) YNImageUploadAnimationStyle style;
/** 设置展示控件 */
- (void)setUploadViewShowImageWithType:(YNImageUploadImageType)type contents:(NSArray *)contents;
@end

typedef void(^TTPMLP_ImageUploadBtnBlock)(NSArray <UIImage *>*images); //

@interface YNImageUploadView : UICollectionView



/** 构造方法 */
- (instancetype)initWithConfig:(void(^)(YNImageUploadViewConfig *config))config;

@property (nonatomic, copy) TTPMLP_ImageUploadBtnBlock imageBlock;

- (void)addImages;

/** 返回图片的数组 */
@property (nonatomic, strong, readonly) NSArray <UIImage *>*images;
/** 返回图片名称的数组 */
@property (nonatomic, strong, readonly) NSArray <NSString *>*imageNames;
/** 返回所有图片名称的拼接字符串 */
@property (nonatomic, strong, readonly) NSString *imageNameString;
/** 是否完成所有的任务 */
@property (nonatomic, assign, readonly, getter=isFinish) BOOL finish;
/** 视图的高度 */
@property (nonatomic, assign) CGFloat viewH;
@end

NS_ASSUME_NONNULL_END
