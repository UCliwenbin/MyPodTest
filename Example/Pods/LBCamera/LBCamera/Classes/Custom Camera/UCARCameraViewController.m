//
//  UCARCameraViewController.m
//  UCarDriver
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 szzc. All rights reserved.
//


#import "UCARCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UCARCameraPreview.h"
#import "UIImage+UCARAppearanceImage.h"
#import "UCARVerticalCameraBaseView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Masonry/Masonry.h>

@interface UCARCameraViewController ()<UCARCameraAction>

@property(nonatomic,strong)AVCaptureSession *session;//会话
@property(nonatomic,strong)AVCaptureDeviceInput *deviceInput;//输入
@property(nonatomic,strong)AVCaptureStillImageOutput *imageOutput; //输出
@property(nonatomic,strong)UCARVerticalCameraBaseView *verticalCameraView;  //自定义窗口
@property(nonatomic,strong)UCARCameraPreview *preView;   //预览视图
@property(nonatomic,strong)UIImage *uploadImage;    //要上传的图片

@end

@implementation UCARCameraViewController

#pragma mark - Life Cycle

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupSubView];
    [self setupCamera];
}

- (void)setupSubView {
    self.verticalCameraView.cameraPreview = self.preView;
    [self.view addSubview:self.verticalCameraView];
    [self.verticalCameraView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
}

//控制VC并不跟随系统自动旋转
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)dealloc
{
    NSLog(@"---dealloc----%s",__FUNCTION__);
}

#pragma mark - public Method

- (void)setupSubViewToPreviewLayer:(_Nonnull CustomSubViewsBlock)customBlock {
    customBlock(self.preView);
}

- (void)setCameraTitle:(NSString *)cameraTitle {
    [self.verticalCameraView setCameraTitle:cameraTitle];
}

#pragma mark - 配置相机
//相机设置
- (void)setupCamera {
    if (![self canUseCamera]) {//判断相机使用权限
       [self canUseCameraAlertView];
        return;
    }
    NSError *error;
    [self setupSession:&error];
    if (!error) {
        self.preView.captureSessionsion = self.session;
        [[(AVCaptureVideoPreviewLayer*)self.preView.layer connection] setVideoOrientation:AVCaptureVideoOrientationPortrait];
        [self startCaptureSession];
    }else{
        NSLog(@"设置session异常：%@",error.localizedDescription);
    }
}

- (BOOL)canUseCamera
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

//使用相机提示界面
- (void)canUseCameraAlertView
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您没有使用相机的权限" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self showViewController:alert sender:nil];
}

#pragma mark - -会话控制
// 开启捕捉
- (void)startCaptureSession{
    if (!self.session.isRunning){
        [self.session startRunning];
    }
}
// 停止捕捉
- (void)stopCaptureSession{
    if (self.session.isRunning){
        [self.session stopRunning];
    }
}

// 会话
- (void)setupSession:(NSError **)error{
    self.session = [[AVCaptureSession alloc]init];
    self.session.sessionPreset = AVCaptureSessionPresetHigh;
    [self setupSessionInputs:error];
    [self setupSessionOutputs:error];
}

// 输入
- (void)setupSessionInputs:(NSError **)error{
    // 获取前置摄像头
    AVCaptureDevice *frontCameraDevice = [self cameraWithPosition:(AVCaptureDevicePositionFront)];
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:frontCameraDevice error:error];
    if (videoInput) {
        if ([self.session canAddInput:videoInput]){
            [self.session addInput:videoInput];
        }
    }
    self.deviceInput = videoInput;
}

// 输出
- (void)setupSessionOutputs:(NSError **)error{
    // 静态图片输出
    AVCaptureStillImageOutput *imageOutput = [[AVCaptureStillImageOutput alloc] init];
    imageOutput.outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    if ([self.session canAddOutput:imageOutput]) {
        [self.session addOutput:imageOutput];
    }
    self.imageOutput = imageOutput;
}

#pragma mark- 拍照
//切换摄像头
- (void)switchCamera{
    if (![self canSwitchCamera]) {
        return;
    }
    AVCaptureDevice *newCamera = [self inactiveCamera];
    AVCaptureDeviceInput *newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
    //获取当前相机的方向(前还是后)
    AVCaptureDevicePosition position = [self activeCamera].position;
    //为摄像头的转换加转场动画
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.5;
    animation.type = @"oglFlip";
    if (position == AVCaptureDevicePositionFront) {
        animation.subtype = kCATransitionFromRight;
    }else{
        animation.subtype = kCATransitionFromLeft;
    }
    
    [self.preView.layer addAnimation:animation forKey:nil];
    if (newInput != nil) {
        [self.session beginConfiguration];
        //先移除原来的input
        [self.session removeInput:self.deviceInput];
        if ([self.session canAddInput:newInput]) {
            [self.session addInput:newInput];
            self.deviceInput = newInput;
        } else {
            //如果不能加现在的input，就加原来的input
            [self.session addInput:self.deviceInput];
        }
        [self.session commitConfiguration];
    }
}

- (void)shutterCamera
{
    if (![self canUseCamera]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    AVCaptureConnection *connection = [_imageOutput connectionWithMediaType:AVMediaTypeVideo];
    connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    if ([connection isVideoStabilizationSupported]) {
        connection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeCinematic;
    }
    
    //前置摄像头保留镜像
    if ([self activeCamera].position == AVCaptureDevicePositionFront) {
        if (connection.supportsVideoMirroring) {
            //镜像设置
            connection.videoMirrored = YES;
        }
    }
    __weak typeof(self) weakSelf = self;
    [_imageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
        
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (!error) {
                if (imageDataSampleBuffer != NULL) {
                    NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                    UIImage *image = [[UIImage alloc]initWithData:imageData];
                    [weakSelf setImageData:image connection:connection];
                }
            }else {
                NSLog(@"获取图片错误：%@",error.localizedDescription);
            }
            
        });
    }];
}

- (void)setImageData:(UIImage *)image connection:(AVCaptureConnection *)connection{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = self.preView.frame;
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = image;
    UIImage *timage = [UIImage convertViewToImage:imageView];
    imageView.image = timage;
    self.uploadImage = timage;
    self.verticalCameraView.takeImageView.image = timage;
    
}

//判断是否能切换摄像头
- (BOOL)canSwitchCamera {
    BOOL frontAvailable = [UIImagePickerController isCameraDeviceAvailable:(UIImagePickerControllerCameraDeviceFront)];
    BOOL rearAvailable = [UIImagePickerController isCameraDeviceAvailable:(UIImagePickerControllerCameraDeviceRear)];
    if (frontAvailable && rearAvailable) {
        return YES;
    }
    return NO;
}

- (AVCaptureDevice *)inactiveCamera{
    AVCaptureDevice *device = nil;
    if ([[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count] > 1) {
        if ([self activeCamera].position == AVCaptureDevicePositionBack) {
            device = [self cameraWithPosition:AVCaptureDevicePositionFront];
        } else {
            device = [self cameraWithPosition:AVCaptureDevicePositionBack];
        }
    }
    return device;
}
- (AVCaptureDevice *)activeCamera{
    return self.deviceInput.device;
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

//保存照片
- (void)finishTakingPicture {
    __weak typeof(self) weakSelf = self;
    [weakSelf dismissViewControllerAnimated:YES completion:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didFinishTakingPicture:)]) {
            [weakSelf.delegate didFinishTakingPicture:weakSelf.uploadImage];
        }
    }];
    
    
}

#pragma mark - getter

- (UCARVerticalCameraBaseView *)verticalCameraView {
    if (!_verticalCameraView) {
        _verticalCameraView = [[UCARVerticalCameraBaseView alloc] initWithFrame:CGRectZero];
        _verticalCameraView.action = self;
    }
    return _verticalCameraView;
}

- (UCARCameraPreview *)preView {
    if (!_preView) {
        _preView = [[UCARCameraPreview alloc]init];
    }
    return _preView;
}

#pragma mark - Camera Action
- (void)didClickBackAction {
    [self dismissViewControllerAnimated:YES completion:^{
        [self stopCaptureSession];
    }];
}

- (void)didClickCancelAction {
    [self startCaptureSession];
}

- (void)didClickConfirmAction {
    [self finishTakingPicture];
}

- (void)didClickSwitchCameraAction {
    [self switchCamera];
}

- (void)didClickTakingPhotoAction {
    [self shutterCamera];
}



@end
