//
//  UCARCameraBaseView.h
//  UCarDriver
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 szzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCARCameraPreview.h"
#import "UCARCameraToolBarView.h"
#import "UCARCameraAction.h"
#import "UCARCameraTitleBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UCARVerticalCameraBaseView : UIView

//底部按钮
@property(nonatomic,strong)UCARCameraToolBarView *toolBarView;
//头部按钮
@property(nonatomic,strong)UCARCameraTitleBarView *topNavBarView;
//预览
@property(nonatomic,strong)UIView *cameraPreview;
//捕获到的图像
@property(nonatomic,strong)UIImageView *takeImageView;
//活动代理
@property (nonatomic, weak) id<UCARCameraAction> action;
//自定义title文案
- (void)setCameraTitle:(NSString *)titleStr;

@end

NS_ASSUME_NONNULL_END
