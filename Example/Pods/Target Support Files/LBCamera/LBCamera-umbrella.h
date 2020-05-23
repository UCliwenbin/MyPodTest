#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "macro_ui.h"
#import "UCARCameraViewController.h"
#import "UCARCameraPreview.h"
#import "UIImage+UCARAppearanceImage.h"
#import "UCARCameraTitleBarView.h"
#import "UCARCameraToolBarView.h"
#import "UCARCameraAction.h"
#import "UCARVerticalCameraBaseView.h"

FOUNDATION_EXPORT double LBCameraVersionNumber;
FOUNDATION_EXPORT const unsigned char LBCameraVersionString[];

