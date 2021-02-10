//
//  TTPMLP_UploadViewController.m
//  FMLPFigureMonster
//
//  Created by apple on 2019/6/12.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import "TTPMLP_SaveViewController.h"

#import "TTPMLP_HomeVCViewController.h"

@interface TTPMLP_SaveViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIButton *btnComplete;

@end


@implementation TTPMLP_SaveViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    [self.leftButton setImage:IMageName(CLocalizedImgName(@"返回")) forState:UIControlStateNormal];
    [self.CenterButton setTitle:CLocalizedString(@"The Saved") forState:UIControlStateNormal];
    self.currentSaveImageView.image = self.currentImage;
   
    [self.btnShare setTitle:CLocalizedString(@"Share") forState:UIControlStateNormal];
    [self.btnComplete setTitle:CLocalizedString(@"Complete") forState:UIControlStateNormal];
}

// 分享
- (IBAction)btnShareClick:(id)sender {

    
    NSData *imageData = UIImagePNGRepresentation(self.currentImage);
   
    NSArray * items = @[imageData];
    
    if (items.count > 0) {
        UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
        
        //        // 屏蔽AirDrop分享(需要屏蔽的内容)
        //        NSArray *excludedActivities = @[UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
        //                                        UIActivityTypePostToWeibo,
        //                                        UIActivityTypeMessage, UIActivityTypeMail,
        //                                        UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
        //                                        UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
        //                                        UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
        //                                        UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
        //        controller.excludedActivityTypes = excludedActivities;
        
        UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(NSString *activityType,BOOL completed,NSArray *returnedItems,NSError *activityError)
        {
            NSLog(@"activityType :%@", activityType);
            if (completed)
            {
                NSLog(@"completed");
            }
            else
            {
                NSLog(@"cancel");
            }
        };
        
        // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
        controller.completionWithItemsHandler = myBlock;
        
        [self presentViewController:controller animated:YES completion:nil];
    }
}

// 返回主页
- (IBAction)btnBackMainClick:(id)sender {
    [UIViewController BackClassViewController:self ToViewController:[TTPMLP_HomeVCViewController new]];
    
}


@end
