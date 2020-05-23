//
//  UCARCameraTitleBarView.m
//  UCarDriver
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 szzc. All rights reserved.
//

// import分组次序：Frameworks、Services、UI
#import "UCARCameraTitleBarView.h"
#import "macro_ui.h"
#import "UIImage+UCARAppearanceImage.h"
#import <Masonry/Masonry.h>

#pragma mark - @class

#pragma mark - 常量

#pragma mark - 枚举

@interface UCARCameraTitleBarView ()

#pragma mark - 私有属性

@property(nonatomic,strong)UIButton *topBackButton;
@property(nonatomic,strong)UILabel *topTitleLabel;
@property(nonatomic,strong)UIButton *switchCameraButton;

@end

@implementation UCARCameraTitleBarView


#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
        [self createSubViewsConstraints];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)dealloc {
    NSLog(@"%@ - dealloc", NSStringFromClass([self class]));
}

#pragma mark - Events

#pragma mark - UIOtherComponentDelegate

#pragma mark - Custom Delegates

#pragma mark - Public Methods

- (void)setTitle:(NSString *)title {
    [self.topTitleLabel setText:title];
}

- (void)hiddenSwitchCameraButton:(BOOL)ishidden {
    if (ishidden) {
        self.switchCameraButton.hidden = YES;
    } else {
        self.switchCameraButton.hidden = NO;
    }
}

#pragma mark - Private Methods

- (void)dissmissClicked {
    if (self.backClick) {
        self.backClick();
    }
}
- (void)switchCameraClicked {
    if (self.switchCameraClick) {
        self.switchCameraClick();
    }
}

// 添加子视图
- (void)createSubViews {
    [self addSubview:self.topBackButton];
    [self addSubview:self.topTitleLabel];
    [self addSubview:self.switchCameraButton];
}

// 添加约束
- (void)createSubViewsConstraints {
    [self.topTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).mas_offset(10.f);
    }];
    [self.topBackButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).mas_offset(10.f);
        make.left.mas_equalTo(self.mas_left).mas_offset(REALITY_VALUE(15.f));
        make.width.mas_equalTo(REALITY_VALUE(40));
        make.height.mas_equalTo(REALITY_VALUE(40));
    }];
    
    [self.switchCameraButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).mas_offset(10.f);
        make.right.mas_equalTo(self.mas_right).mas_offset(-REALITY_VALUE(15.f));
        make.width.mas_equalTo(REALITY_VALUE(self.switchCameraButton.imageView.image.size.width));
        make.height.mas_equalTo(REALITY_VALUE(self.switchCameraButton.imageView.image.size.height));
    }];
}

#pragma mark - Getters and Setters

- (UIButton *)topBackButton {
    if (!_topBackButton) {
        _topBackButton = [[UIButton alloc]init];
        [_topBackButton setImage:[UIImage imageFromResourceBundle:[self class] ImageName:@"返回icon"] forState:(UIControlStateNormal)];
        _topBackButton.imageEdgeInsets = UIEdgeInsetsMake(0, -22, 0, 0);
        [_topBackButton addTarget:self action:@selector(dissmissClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topBackButton;
}
- (UILabel *)topTitleLabel {
    if (!_topTitleLabel) {
        _topTitleLabel = [[UILabel alloc]init];
        _topTitleLabel.font = [UIFont boldSystemFontOfSize:17.f];
        _topTitleLabel.textColor = [UIColor whiteColor];
        _topTitleLabel.textAlignment = NSTextAlignmentCenter;
        _topTitleLabel.text = @"";
    }
    return _topTitleLabel;
}

-(UIButton *)switchCameraButton {
    if (!_switchCameraButton) {
        _switchCameraButton = [[UIButton alloc]init];
        [_switchCameraButton setImage:[UIImage imageFromResourceBundle:[self class] ImageName:@"切换相机"] forState:UIControlStateNormal];
        [_switchCameraButton addTarget:self action:@selector(switchCameraClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchCameraButton;
}

@end
