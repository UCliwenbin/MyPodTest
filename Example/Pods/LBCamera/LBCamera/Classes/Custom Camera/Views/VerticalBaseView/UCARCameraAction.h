//
//  UCARCameraFunction.h
//  UCarDriver
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 szzc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 相机功能函数
 */
@protocol UCARCameraAction <NSObject>

@optional

//点击了返回按钮
- (void)didClickBackAction;
//点击了切换摄像头按钮
- (void)didClickSwitchCameraAction;
//点击了拍照按钮
- (void)didClickTakingPhotoAction;
//点击了取消按钮
- (void)didClickCancelAction;
//点击了确认按钮
- (void)didClickConfirmAction;

@end

NS_ASSUME_NONNULL_END
