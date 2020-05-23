//
//  UCARCameraToolBarView.m
//  UCarDriver
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 szzc. All rights reserved.
//

#import "UCARCameraToolBarView.h"
#import <Masonry/Masonry.h>
#import "macro_ui.h"
#import "UIImage+UCARAppearanceImage.h"

@interface UCARCameraToolBarView ()

@property(nonatomic,strong)UIButton *cameraButton;
@property(nonatomic,strong)UIButton *goBackButton;
@property(nonatomic,strong)UIButton *okButton;

@end

@implementation UCARCameraToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self creatChildViews];
    }
    return self;
}

- (void)creatChildViews {
    [self addSubview:self.goBackButton];
    [self addSubview:self.okButton];
    [self addSubview:self.cameraButton];
    [self takingPhotoLayout];
}

#pragma mark - Layout

- (void)takingPhotoLayout {
    __weak typeof(self) weakSelf = self;
    self.goBackButton.hidden = YES;
    self.okButton.hidden = YES;
    self.cameraButton.hidden = NO;
    [self.goBackButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf);
        make.width.mas_equalTo(REALITY_VALUE(weakSelf.goBackButton.imageView.image.size.width));
        make.height.mas_equalTo(REALITY_VALUE(weakSelf.goBackButton.imageView.image.size.height));
    }];
    
    [self.okButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf);
        make.width.mas_equalTo(REALITY_VALUE(weakSelf.okButton.imageView.image.size.width));
        make.height.mas_equalTo(REALITY_VALUE(weakSelf.okButton.imageView.image.size.height));
    }];
    
    [self.cameraButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf);
        make.width.mas_equalTo(REALITY_VALUE(weakSelf.cameraButton.imageView.image.size.width));
        make.height.mas_equalTo(REALITY_VALUE(weakSelf.cameraButton.imageView.image.size.height));
    }];
}

- (void)confirmPhontLayout {
    __weak typeof(self) weakSelf = self;
    self.goBackButton.hidden = NO;
    self.okButton.hidden = NO;
    [self.goBackButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.mas_equalTo(weakSelf.mas_left).mas_offset(REALITY_VALUE(80.f));
        make.width.mas_equalTo(REALITY_VALUE(weakSelf.goBackButton.imageView.image.size.width));
        make.height.mas_equalTo(REALITY_VALUE(weakSelf.goBackButton.imageView.image.size.height));
    }];
    [self.okButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.right.mas_equalTo(weakSelf.mas_right).mas_offset(-REALITY_VALUE(80.f));
        make.width.mas_equalTo(REALITY_VALUE(weakSelf.goBackButton.imageView.image.size.width));
        make.height.mas_equalTo(REALITY_VALUE(weakSelf.goBackButton.imageView.image.size.height));
    }];
    self.cameraButton.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - takePhone -
- (void)cameraClick {
    [self confirmPhontLayout];
    if (self.takePhoneBlock) {
        self.takePhoneBlock();
    }
}


- (void)goBackClicked {
    [self takingPhotoLayout];
    if (self.goBackClickedBlock) {
        self.goBackClickedBlock();
    }
}
- (void)okClicked {
    if (self.okClickedBlock) {
        self.okClickedBlock();
    }
}
#pragma mark - lazy -
- (UIButton *)cameraButton {
    if (!_cameraButton) {
        _cameraButton = [[UIButton alloc]init];
        [_cameraButton setImage:[UIImage imageFromResourceBundle:[self class] ImageName:@"拍照"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(cameraClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}
- (UIButton *)goBackButton {
    if (!_goBackButton) {
        _goBackButton = [[UIButton alloc]init];
        [_goBackButton setImage:[UIImage imageFromResourceBundle:[self class] ImageName:@"返回"] forState:UIControlStateNormal];
        [_goBackButton addTarget:self action:@selector(goBackClicked) forControlEvents:UIControlEventTouchUpInside];
        _goBackButton.hidden = YES;
    }
    return _goBackButton;
}

- (UIButton *)okButton {
    if (!_okButton) {
        _okButton = [[UIButton alloc]init];
        [_okButton setImage:[UIImage imageFromResourceBundle:[self class] ImageName:@"确认"] forState:UIControlStateNormal];
        [_okButton addTarget:self action:@selector(okClicked) forControlEvents:UIControlEventTouchUpInside];
        _okButton.hidden = YES;
    }
    return _okButton;
}

@end
