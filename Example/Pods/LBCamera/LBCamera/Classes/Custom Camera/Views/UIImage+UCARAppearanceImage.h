//
//  UIImage+UCARAppearanceImage.h
//  UCarDriver
//
//  Created by hyx on 2018/10/18.
//  Copyright © 2018年 szzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UCARAppearanceImage)
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

- (UIImage *)rotate:(UIImageOrientation)orient;
+ (UIImage *)convertViewToImage:(UIView *)view;

+ (UIImage *)imageFromResourceBundle:(Class)bundleClass ImageName:(NSString *)imageName;
@end
