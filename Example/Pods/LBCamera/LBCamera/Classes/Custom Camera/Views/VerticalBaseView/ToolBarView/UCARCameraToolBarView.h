//
//  UCARCameraToolBarView.h
//  UCarDriver
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 szzc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UCARCameraToolBarView : UIView

//点击拍照按钮后回调
@property(nonatomic,copy)void(^takePhoneBlock)(void);
//点击重照按钮回调
@property(nonatomic,copy)void(^goBackClickedBlock)(void);
//点击确认按钮回调
@property(nonatomic,copy)void(^okClickedBlock)(void);

@end

NS_ASSUME_NONNULL_END
