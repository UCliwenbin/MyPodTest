//
//  UCARCameraViewController.h
//  UCarDriver
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 szzc. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN


@protocol UCARCameraViewControllerDelegate <NSObject>

- (void)didFinishTakingPicture:(UIImage *)image;

@end


typedef void(^CustomSubViewsBlock)(UIView *containerView);

/**
 请使用presentViewController来推入相机
 */
@interface UCARCameraViewController : UIViewController


@property (nonatomic, strong) NSString *cameraTitle;   //自定义相机的Title
@property (nonatomic, weak)id<UCARCameraViewControllerDelegate> delegate;

/**
 用来设定自定义的View到预览视图上面

 @param customBlock 将View写到这个block内部
 */
- (void)setupSubViewToPreviewLayer:(_Nonnull CustomSubViewsBlock)customBlock;

@end

NS_ASSUME_NONNULL_END
