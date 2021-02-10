//
//  MosaiView.h
//  MosaiDemo
//
//  Created by Sylar on 2018/4/2.
//  Copyright © 2018年 Sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MosaiViewDelegate;
@interface MosaiView : UIView

//底图为马赛克图
@property (nonatomic, strong) UIImage *mosaicImage;
//表图为正常图片
@property (nonatomic, strong) UIImage *originalImage;
//OperationCount
@property (nonatomic, assign, readonly) NSInteger operationCount;
//CurrentIndex
@property (nonatomic, assign, readonly) NSInteger currentIndex;
//Delegate
@property (nonatomic, weak) id<MosaiViewDelegate> deleagate;

//ResetMosai
-(void)resetMosaiImage;

-(void)updateLineWidth;

//Redo
-(void)redo;

//Undo
-(void)undo;

-(BOOL)canUndo;

-(BOOL)canRedo;

//Render
-(UIImage*)render;
@end


@protocol MosaiViewDelegate<NSObject>

-(void)mosaiView:(MosaiView*)view TouchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

-(void)mosaiView:(MosaiView*)view TouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

-(void)mosaiView:(MosaiView*)view TouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
