//
//  TTPMLP_ImageScrollView.m
//  FMLPFigureMonster
//
//  Created by mac on 2019/6/29.
//  Copyright © 2019 feceYouCompany. All rights reserved.
//

#import "TTPMLP_ImageScrollView.h"

@interface TTPMLP_ImageScrollView() <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic, strong) UIImageView *sourceImageView;

@property (nonatomic, strong) UIColor *currentColor;

@property (nonatomic, strong) UIView *viewColor; // 颜色视图

@end

@implementation TTPMLP_ImageScrollView {
 
}



static int lightColorInt = 0; // 当前高亮的数量
static int lightTag = 0; // 当前的绝对值间隔
- (id)initWithFrame:(CGRect)frame image:(UIImage *)image {

    self = [super initWithFrame:frame];
    if (self) {
        self.sourceImage = image;

        self.sourceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.sourceImageView.image = image;
        self.currentframe = frame;
        [self addSubview:self.sourceImageView];
        
        
        self.viewColor = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.viewColor.backgroundColor = [self getCurrentColor];
        self.viewColor.hidden = YES;
//        self.backgroundColor = [self getCurrentColor];

        [self addSubview:self.viewColor];
        

        UILongPressGestureRecognizer *longPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressImage:)];
        longPressGesture.minimumPressDuration=0;//设置长按时间，默认0.5秒，一般这个值不要修改
        longPressGesture.delegate = self;
        //注意由于我们要做长按提示删除操作，因此这个手势不再添加到控制器视图上而是添加到了图片上
        [self addGestureRecognizer:longPressGesture];
        
        // 拖拽
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
          pan.delegate = self;
        
        [self addGestureRecognizer:pan];
        
    }
    return self;
}

#pragma mark - 手势

- (void)pan:(UIPanGestureRecognizer *)pan
{
    // 只有相互临时的两个才可以滑动
    if (lightTag != 1) {
        return;
    }
//    return;
//    NSLog(@"当前高亮的图片数量:%d",lightColor);
    if (self.viewColor.hidden == NO && lightColorInt == 2) {
        // 同时选中两张图片才支持
        
        // 获取当前的值
//        NSLog(@"位置Y:%f...高度:%f",self.frame.origin.y, self.frame.size.height);
        
        //获取偏移量
        // 返回的是相对于最原始的手指的偏移量
        CGPoint transP = [pan translationInView:self];
        
//      NSLog(@"偏移X:%f...Y:%f",transP.x, transP.y);
        
        // 移动图片控件
//        self.transform = CGAffineTransformTranslate(self.transform, 0, transP.y);
        
        if (self.tag == 1000) {
            
            float height = self.height - transP.y;
            
            if (height > self.currentframe.size.height) {
                height = self.currentframe.size.height;
            }
            self.height = height;
            [self sizeToFit];
            [self updateALLScrollViewHeight:self.tag];
//             NSLog(@"第一个额");
        }
    
        else {
            TTPMLP_ImageScrollView *first = (TTPMLP_ImageScrollView *)[[self superview] viewWithTag:self.tag - 1];
            if (first.viewColor.hidden == NO) {
                float height =  self.height + transP.y;
                if (height > self.currentframe.size.height) {
                    height = self.currentframe.size.height;
                }
                self.height = height;
                
                self.sourceImageView.y = height - self.currentframe.size.height;
                
                [self sizeToFit];
                [self updateALLScrollViewHeight:self.tag];
//                NSLog(@"第三个在滑动");
            } else {
                float height =  self.height - transP.y;
                if (height > self.currentframe.size.height + self.sourceImageView.y) {
                    height = self.currentframe.size.height + self.sourceImageView.y;
                }
                self.height = height;
                self.sourceImageView.y = self.sourceImageView.y;
                [self sizeToFit];
                [self updateALLScrollViewHeight:self.tag];
//                  NSLog(@"第二个在滑动");
            }
            
        }
        
        // 复位,表示相对上一次
        [pan setTranslation:CGPointZero inView:self];
        
        
    }

}

// 重新刷新全部视图
- (void)updateALLScrollViewHeight:(NSInteger)tag {
    UIScrollView *topScrollView = (UIScrollView *)[self superview];
    float height = 0;
    for (UIScrollView *subView in topScrollView.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]]) {

            if (subView.tag == 1000) {
                subView.y = 0;
                height = subView.y + subView.height;
            } else {
                UIScrollView *sc = (UIScrollView *)[[self superview] viewWithTag:(subView.tag - 1)];
                subView.y = sc.y + sc.height;
                height = subView.y + subView.height;
            }
        }
    }
    // 从新更改滚动视图的滚动范围
    UIScrollView *sc =  (UIScrollView *)[self superview];
    sc.contentSize = CGSizeMake(sc.frame.size.width, height);
}


-(void)longPressImage:(UILongPressGestureRecognizer *)gesture{
    
//    NSLog(@"longpress:%i",gesture.state);
    

    // 当前选中图片的数量
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            if (self.viewColor.hidden == YES && lightColorInt < 2) {
                self.viewColor.hidden = NO;
                lightColorInt ++;
                lightTag = abs(lightTag - (int)self.tag);
            }
            
            break;
            
        case UIGestureRecognizerStateChanged:
            if (self.viewColor.hidden == YES && lightColorInt < 2) {
                self.viewColor.hidden = NO;
                lightColorInt ++;
                lightTag = abs(lightTag - (int)self.tag);
            }
            
            break;
            
        default: {
            if (self.viewColor.hidden == NO) {
                self.viewColor.hidden = YES;
                [self resetColor];
                lightColorInt --;
                if (lightColorInt <= 0 ) {
                    lightTag = 0;
                }
            }
        }
            break;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{


    return YES;
    
//  return NO;

}

- (void)resetColor {
    self.currentColor = nil;
       self.viewColor.backgroundColor = [self getCurrentColor];
}

- (UIColor *)getCurrentColor {
    
    if (self.currentColor == nil) {
        NSArray* arrColor = [[NSArray alloc] initWithObjects:
                             ColorFromSixteen(0x7559b9,0.3),
                             ColorFromSixteen(0x783bc6,0.3),
                             ColorFromSixteen(0x9c4ccb,0.3),
                             ColorFromSixteen(0x4884cb,0.3),
                             ColorFromSixteen(0x2ccfbb,0.3),
                             ColorFromSixteen(0xa4c745,0.3),
                             ColorFromSixteen(0x53bc48,0.3),
                             ColorFromSixteen(0x28844a,0.3),
                             ColorFromSixteen(0x4c9e65,0.3),
                             ColorFromSixteen(0x67b37d,0.3),
                             ColorFromSixteen(0x008781,0.3),
                             ColorFromSixteen(0x98186d,0.3),
                             ColorFromSixteen(0xd7534a,0.3),
                             ColorFromSixteen(0xce3b3c,0.3),
                             ColorFromSixteen(0xd7612e,0.3),
                             nil];
        int R = (arc4random() % arrColor.count);
        UIColor *color= arrColor[R];
        self.currentColor = color;
    }
    return self.currentColor;
}


@end
