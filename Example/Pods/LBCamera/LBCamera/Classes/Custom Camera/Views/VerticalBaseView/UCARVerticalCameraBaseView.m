//
//  UCARCameraBaseView.m
//  UCarDriver
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 szzc. All rights reserved.
//


#import "UCARVerticalCameraBaseView.h"
#import "macro_ui.h"
#import <Masonry/Masonry.h>

@implementation UCARVerticalCameraBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createChildViews];
    }
    return self;
}
- (void)createChildViews {
    [self addSubview:self.toolBarView];
    [self addSubview:self.topNavBarView];
    
}

- (void)setCameraPreview:(UCARCameraPreview *)cameraPreview {
    _cameraPreview = cameraPreview;
    [self addSubview:cameraPreview];
    [self.cameraPreview addSubview:self.takeImageView];
    [self layoutViews];
}

- (void)layoutViews {
    [self.toolBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(-IPHONEXSERIES_SAFE_AREA_BOTTOM_GAP);
        make.height.mas_equalTo(REALITY_VALUE(120.f));
    }];
    
    [self.topNavBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(iPhoneXSERIES ? 24 : 0);
        make.height.mas_equalTo(64);
    }];
    
    [self.cameraPreview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.topNavBarView.mas_bottom);
        make.bottom.mas_equalTo(self.toolBarView.mas_top);
    }];
    
    [self.takeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.cameraPreview);
    }];
    
}


#pragma mark - public Method

- (void)setCameraTitle:(NSString *)titleStr {
    self.topNavBarView.title = titleStr;
}

#pragma mark - getter方法

- (UCARCameraToolBarView *)toolBarView {
    if (!_toolBarView) {
        __weak typeof(self) weakSelf = self;
        _toolBarView = [[UCARCameraToolBarView alloc] initWithFrame:CGRectZero];
        _toolBarView.takePhoneBlock = ^{
            weakSelf.takeImageView.hidden = NO;
            [weakSelf.topNavBarView hiddenSwitchCameraButton:YES];
            if ([weakSelf.action respondsToSelector:@selector(didClickTakingPhotoAction)]) {
                [weakSelf.action didClickTakingPhotoAction];
            }
        };
        _toolBarView.goBackClickedBlock = ^{
            weakSelf.takeImageView.image = nil;
            weakSelf.takeImageView.hidden = YES;
            [weakSelf.topNavBarView hiddenSwitchCameraButton:NO];
            if ([weakSelf.action respondsToSelector:@selector(didClickCancelAction)]) {
                [weakSelf.action didClickCancelAction];
            }
        };
        _toolBarView.okClickedBlock = ^{
            weakSelf.takeImageView.image = nil;
            weakSelf.takeImageView.hidden = YES;
            if ([weakSelf.action respondsToSelector:@selector(didClickConfirmAction)]) {
                [weakSelf.action didClickConfirmAction];
            }
        };
    }
    return _toolBarView;
}

- (UCARCameraTitleBarView *)topNavBarView {
    if (!_topNavBarView) {
        _topNavBarView = [[UCARCameraTitleBarView alloc] initWithFrame:CGRectZero];
        _topNavBarView.backgroundColor = [UIColor blackColor];
        __weak typeof(self) weakSelf = self;
        _topNavBarView.backClick = ^{
            if ([weakSelf.action respondsToSelector:@selector(didClickBackAction)]) {
                [weakSelf.action didClickBackAction];
            }
        };
        
        _topNavBarView.switchCameraClick = ^{
            if ([weakSelf.action respondsToSelector:@selector(didClickSwitchCameraAction)]) {
                [weakSelf.action didClickSwitchCameraAction];
            }
        };
    }
    return _topNavBarView;
}

- (UIImageView *)takeImageView {
    if (!_takeImageView) {
        _takeImageView = [[UIImageView alloc]init];
        _takeImageView.backgroundColor = [UIColor blackColor];
        _takeImageView.hidden = YES;
        _takeImageView.layer.masksToBounds = YES;
        _takeImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _takeImageView;
}

@end
