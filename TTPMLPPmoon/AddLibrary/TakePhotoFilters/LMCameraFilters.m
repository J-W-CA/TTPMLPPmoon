//
//  LMCameraFilters.m
//  GPUImageDemo
//
//  Created by xx11dragon on 15/9/22.
//  Copyright © 2015年 xx11dragon. All rights reserved.
//

#import "LMCameraFilters.h"
#import "LMFliterGroup.h"

@implementation LMCameraFilters

+ (GPUImageFilterGroup *)normal {
    GPUImageFilter *filter = [[GPUImageFilter alloc] init]; //默认
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *) group setInitialFilters:[NSArray arrayWithObject: filter]];
    [(GPUImageFilterGroup *) group setTerminalFilter:filter];
    group.title = CLocalizedString(@"Normal");
    group.color = [UIColor blackColor];
    return group;
    
}

+ (GPUImageFilterGroup *)saturation {
    GPUImageSaturationFilter *filter = [[GPUImageSaturationFilter alloc] init]; //饱和度
    filter.saturation = 2.0f;
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *) group setInitialFilters:[NSArray arrayWithObject: filter]];
    [(GPUImageFilterGroup *) group setTerminalFilter:filter];
    group.title = CLocalizedString(@"Saturation");
    group.color = RGB(254, 67, 101);
    
//    深红色: R=254 G=67 B=101
    return group;
}


+ (GPUImageFilterGroup *)exposure {
    GPUImageExposureFilter *filter = [[GPUImageExposureFilter alloc] init]; //曝光
    filter.exposure = 1.0f;
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *) group setInitialFilters:[NSArray arrayWithObject: filter]];
    [(GPUImageFilterGroup *) group setTerminalFilter:filter];
    group.title = CLocalizedString(@"Exposure");
    group.color = RGB(249, 205, 173);
//    [UIColor greenColor];
//        浅黄色: R=249 G=205 B=173


    return group;
}



+ (GPUImageFilterGroup *)contrast {
    GPUImageContrastFilter *filter = [[GPUImageContrastFilter alloc] init]; //对比度
    filter.contrast = 2.0f;
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *) group setInitialFilters:[NSArray arrayWithObject: filter]];
    [(GPUImageFilterGroup *) group setTerminalFilter:filter];
    group.title = CLocalizedString(@"Contrast");
     group.color = RGB(252, 157, 154);
//    group.color = [UIColor redColor];
    return group;
    
//    浅红色: R=252 G=157 B=154

}

+ (GPUImageFilterGroup *)testGroup1 {
    GPUImageFilterGroup *filters = [[GPUImageFilterGroup alloc] init];
    
    GPUImageExposureFilter *filter1 = [[GPUImageExposureFilter alloc] init]; //曝光
    filter1.exposure = 0.0f;
    GPUImageSaturationFilter *filter2 = [[GPUImageSaturationFilter alloc] init]; //饱和度
    filter2.saturation = 2.0f;
    GPUImageContrastFilter *filter3 = [[GPUImageContrastFilter alloc] init]; //对比度
    filter3.contrast = 2.0f;
    
    [filter1 addTarget:filter2];
    [filter2 addTarget:filter3];
    
    [(GPUImageFilterGroup *) filters setInitialFilters:[NSArray arrayWithObject: filter1]];
    [(GPUImageFilterGroup *) filters setTerminalFilter:filter3];
    filters.title = CLocalizedString(@"Combination");
//    filters.color = [UIColor yellowColor];
       filters.color = RGB(200, 200, 169);
//    浅青色: R=200 G=200 B=169
//    淡青色: R=131 G=175 B=155
    return filters;
}

+ (GPUImageFilterGroup *)testGroup2 {

    GPUImageFalseColorFilter *filter = [[GPUImageFalseColorFilter alloc] init]; //颜色值
    
    filter.firstColor = (GPUVector4){0.0f, 0.0f, 0.5f, 1.0f};
    filter.secondColor = (GPUVector4){0.0f, 0.5f, 0.5f, 1.0f};
    
//    filter.firstColor = (GPUVector4){255 / 255.0f, 182 / 255.0f, 193 / 255.0f, 1.0f};
//    filter.secondColor = (GPUVector4){255 / 255.0f, 192 / 255.0f, 203 / 255.0f, 1.0f};
    
    
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *) group setInitialFilters:[NSArray arrayWithObject: filter]];
    [(GPUImageFilterGroup *) group setTerminalFilter:filter];
    group.title = CLocalizedString(@"Exposure");
    group.color = RGB(249, 205, 173);
    //    [UIColor greenColor];
    //        浅黄色: R=249 G=205 B=173
    
    
    return group;

}

+ (GPUImageFilterGroup *)testGroup3 {
    
    GPUImageRGBFilter *filter = [[GPUImageRGBFilter alloc] init]; //颜色值
    
    filter.red = 255 / 255.0f;
    
      filter.green = 182 / 255.0f;
    
      filter.blue = 193 / 255.0f;
    
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *) group setInitialFilters:[NSArray arrayWithObject: filter]];
    [(GPUImageFilterGroup *) group setTerminalFilter:filter];
    group.title = CLocalizedString(@"Exposure");
    group.color = RGB(249, 205, 173);
    //    [UIColor greenColor];
    //        浅黄色: R=249 G=205 B=173
    
    
    return group;
    
}

+ (GPUImageFilterGroup *)ImageRGBFilter:(NSString *)title red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    
    GPUImageRGBFilter *filter = [[GPUImageRGBFilter alloc] init]; //颜色值
    
    filter.red = red / 255.0f;
    
    filter.green = green / 255.0f;
    
    filter.blue = blue / 255.0f;
    
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *) group setInitialFilters:[NSArray arrayWithObject: filter]];
    [(GPUImageFilterGroup *) group setTerminalFilter:filter];
    group.title = CLocalizedString(title);
    group.color = RGB(red, green, blue);
    //    [UIColor greenColor];
    //        浅黄色: R=249 G=205 B=173
    
    
    return group;
    
}



//GPUImageFalseColorFilter


@end
