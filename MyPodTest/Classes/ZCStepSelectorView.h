//
//  ZCStepSelectorView.h
//  zuche
//
//  Created by ZhangYuqing on 16/6/16.
//  Copyright © 2016年 zuche. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  步骤选择器
 */
@interface ZCStepSelectorView : UIView
/**
 *  数据设置:设置标题数组和当前的步骤状态
    该方法初始化后只需要设置一次就可以了
 *
 *  @param titleArray 标题数组
 *  @param index      步骤状态
 */
- (void)setTitleArray:(NSArray *)titleArray withCurrentStep:(NSInteger)index;
/**
 *  设置当前的选中步骤
 *
 *  @param index index
 */
- (void)setCurrentStepIndex:(NSInteger)index withAnimated:(BOOL)animated;
@end
