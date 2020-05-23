//
//  UCARCameraTitleBarView.h
//  UCarDriver
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 szzc. All rights reserved.
//

// import分组次序：Frameworks、Services、UI
#import <UIKit/UIKit.h>

#pragma mark - @class

#pragma mark - 常量

#pragma mark - 枚举

NS_ASSUME_NONNULL_BEGIN

/**
 * 相机TitleToolBar
 * @note
 */
@interface UCARCameraTitleBarView : UIView

//返回回调
@property(nonatomic,copy)void(^backClick)(void);
//切换摄像头回调
@property(nonatomic,copy)void(^switchCameraClick)(void);
//设置title文案
@property (nonatomic, copy) NSString *title;
//隐藏切换摄像头按钮
- (void)hiddenSwitchCameraButton:(BOOL)ishidden;
@end

NS_ASSUME_NONNULL_END
