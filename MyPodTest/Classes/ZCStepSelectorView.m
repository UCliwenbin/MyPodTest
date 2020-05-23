//
//  ZCStepSelectorView.m
//  zuche
//
//  Created by ZhangYuqing on 16/6/16.
//  Copyright © 2016年 zuche. All rights reserved.
//

#import "ZCStepSelectorView.h"
#import "Masonry.h"
#import <UCARUIKit/UCARUIKit.h>

#define kStepSelectorView_Tag_Start 300
#define kSelfSubview_Tag_Start 200
#define kViewLeftMargin 30
#define kImageViewWidth 16

@interface ZCStepSelectorView()
@property (strong,nonatomic) NSArray *titleArray; // 标题数组
@property (assign,nonatomic) NSInteger currentStep; // 当前的步骤状态
@end

@implementation ZCStepSelectorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArray = [[NSArray alloc]init];
        self.currentStep = 0;
        self.backgroundColor = UCAR_ColorFromHexString(@"1b2b3b");
    }
    return self;
}

/**
 *  设置标题数组和当前的步骤状态
 *
 *  @param titleArray 标题数组
 *  @param index      步骤状态
 */
- (void)setTitleArray:(NSArray *)titleArray withCurrentStep:(NSInteger)index
{
    if (!titleArray) {
        return;
    }
    self.titleArray = titleArray;
    self.currentStep = index;
    
    [self createSubviews];
}

/**
 *  创建子View
 */
- (void)createSubviews
{
    NSInteger tabWidth = ([UIScreen mainScreen].bounds.size.width - kViewLeftMargin * 2 - kImageViewWidth) /  (self.titleArray.count - 1);
    UIView *tab = nil;
    for (NSUInteger index = 0; index < self.titleArray.count; index++) {
        
        UIView *tabView = [self createSubTabView];
        [tabView setTag:(kSelfSubview_Tag_Start + index)];
        [self addSubview:tabView];
        
        [tabView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(tabWidth));
            make.height.mas_equalTo(self.mas_height).offset(0);
            make.top.mas_equalTo(self.mas_top).offset(0);
            if (!tab) {
                make.left.mas_equalTo(self.mas_left).offset(0);
            } else {
                make.left.mas_equalTo(tab.mas_right).offset(0);
            }
        }];
        
        UILabel *bottomLabel = (UILabel *)[tabView viewWithTag:(kStepSelectorView_Tag_Start + 4)];
        [bottomLabel setText:[self.titleArray objectAtIndex:index]];
        
        [self settingSubviewsWithTabView:tabView withIndex:index];
        
        
        tab = tabView;
    }
}


- (UIView *)createSubTabView
{
    UIView *tabView = [[UIView alloc]init];
    tabView.backgroundColor = [UIColor clearColor];
    
    UIImageView *topHeaderImageView = [[UIImageView alloc]init];
    [topHeaderImageView setTag:(kStepSelectorView_Tag_Start + 1)];
    [tabView addSubview:topHeaderImageView];
    
    UIImageView *topMiddleImageView = [[UIImageView alloc]init];
    [topMiddleImageView setTag:(kStepSelectorView_Tag_Start + 2)];
    [tabView addSubview:topMiddleImageView];
    
    UIImageView *topLastImageView = [[UIImageView alloc]init];
    [topLastImageView setTag:(kStepSelectorView_Tag_Start + 3)];
    [tabView addSubview:topLastImageView];
    
    UILabel *botomLabel = [[UILabel alloc]init];
    [botomLabel setBackgroundColor:[UIColor clearColor]];
    [botomLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [botomLabel setTextColor:[UIColor whiteColor]];
    [botomLabel setTag:(kStepSelectorView_Tag_Start + 4)];
    [botomLabel setTextAlignment:NSTextAlignmentCenter];
    [tabView addSubview:botomLabel];
    
    NSInteger centerYOffset = 12;
    
    [topHeaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@2);
        make.width.equalTo(@(kViewLeftMargin));
        make.left.mas_equalTo(tabView.mas_left).offset(0);
        make.centerY.mas_equalTo(tabView.mas_centerY).offset(-centerYOffset);
    }];
    
    [topMiddleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topHeaderImageView.mas_right).offset(0);
        make.width.equalTo(@16);
        make.height.equalTo(@16);
        make.centerY.mas_equalTo(topHeaderImageView.mas_centerY).offset(0);
    }];
    
    [topLastImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topMiddleImageView.mas_right).offset(0);
        make.height.equalTo(@2);
        make.centerY.mas_equalTo(topMiddleImageView.mas_centerY).offset(0);
        make.right.mas_equalTo(tabView.mas_right).offset(0);
    }];
    
    [botomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(tabView.mas_bottom).offset(0);
        make.width.mas_equalTo(tabView.mas_width).offset(0);
        make.centerY.mas_equalTo(tabView.mas_centerY).offset(centerYOffset);
        make.centerX.mas_equalTo(topMiddleImageView.mas_centerX).offset(0);
    }];
    
    return tabView;
}

- (UIImage *)getStretchingImageWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5f topCapHeight:image.size.height*0.5f];
    return image;
}


- (void)setCurrentStepIndex:(NSInteger)index withAnimated:(BOOL)animated
{
    self.currentStep = index;
    
    if ((NSUInteger)index >= self.titleArray.count) {
        return;
    }
    
    if (animated) {
        [UIView animateWithDuration:0.33f animations:^{
            [self applyUIChange];
        }];
    } else {
        [self applyUIChange];
    }
    
}

- (void)applyUIChange
{
    for (NSUInteger i = 0; i < self.titleArray.count; i ++) {
        UIView *tabView = [self viewWithTag:(kSelfSubview_Tag_Start + i)];
        [self settingSubviewsWithTabView:tabView withIndex:i];
    }
}

- (void)settingSubviewsWithTabView:(UIView *)tabView withIndex:(NSUInteger)i
{
    UIImageView *topHeaderImageView = (UIImageView *)[tabView viewWithTag:(kStepSelectorView_Tag_Start + 1)];
    UIImageView *topMiddleImageView = (UIImageView *)[tabView viewWithTag:(kStepSelectorView_Tag_Start + 2)];
    UIImageView *topLastImageView = (UIImageView *)[tabView viewWithTag:(kStepSelectorView_Tag_Start + 3)];
    UILabel *bottomLabel = (UILabel *)[tabView viewWithTag:kStepSelectorView_Tag_Start + 4];
    
    BOOL shouldFillColor = ((NSUInteger)self.currentStep > i);
    BOOL isSpecialTab = ((NSUInteger)self.currentStep > (i-1));
    BOOL isCurrentStep = (NSUInteger)self.currentStep >= i;
    
    BOOL topHeaderHidden = YES;
    BOOL topMiddleHidden = YES;
    BOOL topLastHidden = YES;
    
    if (i == 0) {
        topHeaderHidden = YES;
        topMiddleHidden = NO;
        topLastHidden = NO;
    } else if (i == self.titleArray.count - 1) {
        topHeaderHidden = NO;
        topMiddleHidden = NO;
        topLastHidden = YES;
    } else {
        topHeaderHidden = NO;
        topMiddleHidden = NO;
        topLastHidden = NO;
    }
    
    [topHeaderImageView setHidden:topHeaderHidden];
    [topMiddleImageView setHidden:topMiddleHidden];
    [topLastImageView setHidden:topLastHidden];
    
    topHeaderImageView.backgroundColor = UCAR_ColorFromHexString((shouldFillColor || isSpecialTab)? @"fabe00" : @"273645");
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    CGFloat systemVersion = [[[UIDevice currentDevice]systemVersion]floatValue];
    NSString *imageName = (isCurrentStep ? @"zucheLib_StepSelector.bundle/Y" : @"zucheLib_StepSelector.bundle/N");
    if (systemVersion < 8.0) {
        NSString *imagePatch = [bundle pathForResource:[NSString stringWithFormat:@"%@@2x",imageName] ofType:@"png"];
        topMiddleImageView.image = [[UIImage alloc]initWithContentsOfFile:imagePatch];
    } else {
        topMiddleImageView.image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    }
    topLastImageView.backgroundColor = UCAR_ColorFromHexString(shouldFillColor ? @"fabe00" : @"273645");
    bottomLabel.textColor = UCAR_ColorFromHexString(isCurrentStep? @"fabe00" : @"FFFFFF");
}
@end
