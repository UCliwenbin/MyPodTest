//
//  macro_ui.h
//  UCarDriver
//
//  Created by 闫子阳 on 16/9/1.
//  Copyright © 2016年 szzc. All rights reserved.
//

#ifndef macro_ui_h
#define macro_ui_h

#pragma mark - screen size related

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define CAMERAMIN(A,B) (A < B ? A : B)
#define SCALE (CAMERAMIN(SCREEN_WIDTH,SCREEN_HEIGHT) / 414.0)

#define RATIO SCALE/3

#define REALITY_VALUE(value) ((value) * SCALE)


#define EDGING_GAP 15.0*SCALE

#define VERTICAL_GAP 18.0*SCALE


//pragma mark - Device macro

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ([[UIScreen mainScreen] currentMode].size.height == 1136) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ([[UIScreen mainScreen] currentMode].size.height == 1334) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ([[UIScreen mainScreen] currentMode].size.height == 2208) : NO)

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ([[UIScreen mainScreen] currentMode].size.height == 2436) : NO)

#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ([[UIScreen mainScreen] currentMode].size.height == 1624) : NO)

#define iPhoneXSERIES (iPhoneX)||(iPhoneXR)

//iphoneX bottom safe area gap
#define IPHONEXSERIES_SAFE_AREA_BOTTOM_HEIGHT 34
#define IPHONEXSERIES_SAFE_AREA_BOTTOM_GAP (iPhoneXSERIES ? IPHONEXSERIES_SAFE_AREA_BOTTOM_HEIGHT : 0)

//状态栏和导航栏
#define UI_STATUS_BAR_HEIGHT               (iPhoneXSERIES ? 44 : 20)
#define UI_NAVIGATION_BAR_HEIGHT           44
#define UI_NAVIGATION_STATUS_BAR_HEIGHT    (UI_NAVIGATION_BAR_HEIGHT + UI_STATUS_BAR_HEIGHT)

#define UI_CONTENT_HEIGHT (SCREEN_HEIGHT - UI_NAVIGATION_BAR_HEIGHT - UI_STATUS_BAR_HEIGHT)

#define FONT_SIZE_34            iPhone4||iPhone5 ? 30.0 : 34.0
#define FONT_SIZE_30            iPhone4||iPhone5 ? 26.0 : 30.0
#define FONT_SIZE_28            iPhone4||iPhone5 ? 27.0 : 28.0
#define FONT_SIZE_24            iPhone4||iPhone5 ? 23.0 : 24.0
#define FONT_SIZE_21            iPhone4||iPhone5 ? 20.0 : 21.0
#define FONT_SIZE_20            iPhone4||iPhone5 ? 19.0 : 20.0
#define FONT_SIZE_19            iPhone4||iPhone5 ? 18.0 : 19.0
#define FONT_SIZE_18            iPhone4||iPhone5 ? 17.0 : 18.0
#define FONT_SIZE_17            iPhone4||iPhone5 ? 16.0 : 17.0
#define FONT_SIZE_16            iPhone4||iPhone5 ? 15.0 : 16.0
#define FONT_SIZE_15            iPhone4||iPhone5 ? 14.0 : 15.0
#define FONT_SIZE_14            iPhone4||iPhone5 ? 13.0 : 14.0
#define FONT_SIZE_13            iPhone4||iPhone5 ? 12.0 : 13.0
#define FONT_SIZE_12            iPhone4||iPhone5 ? 11.0 : 12.0
#define FONT_SIZE_11            iPhone4||iPhone5 ? 10.0 : 11.0

//FONT_WITH_SCALE

#define FONT_SCALE_SIZE_30            (iPhone4||iPhone5 ? 26.0 : 30.0)*SCALE
#define FONT_SCALE_SIZE_24            (iPhone4||iPhone5 ? 23.0 : 24.0)*SCALE
#define FONT_SCALE_SIZE_21            (iPhone4||iPhone5 ? 20.0 : 21.0)*SCALE
#define FONT_SCALE_SIZE_19            (iPhone4||iPhone5 ? 18.0 : 19.0)*SCALE
#define FONT_SCALE_SIZE_18            (iPhone4||iPhone5 ? 17.0 : 18.0)*SCALE
#define FONT_SCALE_SIZE_17            (iPhone4||iPhone5 ? 16.0 : 17.0)*SCALE
#define FONT_SCALE_SIZE_16            (iPhone4||iPhone5 ? 15.0 : 16.0)*SCALE
#define FONT_SCALE_SIZE_15            (iPhone4||iPhone5 ? 14.0 : 15.0)*SCALE
#define FONT_SCALE_SIZE_14            (iPhone4||iPhone5 ? 13.0 : 14.0)*SCALE
#define FONT_SCALE_SIZE_13            (iPhone4||iPhone5 ? 12.0 : 13.0)*SCALE
#define FONT_SCALE_SIZE_12            (iPhone4||iPhone5 ? 11.0 : 12.0)*SCALE
#define FONT_SCALE_SIZE_11            (iPhone4||iPhone5 ? 10.0 : 11.0)*SCALE

#define UCAR_FONT_SIZE(x)   [UIFont systemFontOfSize:x*SCALE]
#define UCAR_BOLD_FONT_SIZE(x) [UIFont boldSystemFontOfSize:x*SCALE]
#define UCAR_MEDIUM_FONT_SIZE(x) [UIFont systemFontOfSize:x*SCALE weight:UIFontWeightMedium]

#define DoubleToString(x)       [NSString stringWithFormat:@"%f",x]     //double类型转string类型
#define IntToString(x)          [NSString stringWithFormat:@"%ld",(long)x]     //int类型转string类型
//#define ObjToString(obj)        ([Utility isEmptyObj:obj] ? @"" : [NSString stringWithFormat:@"%@",obj])   //id类型转string类型
// lineHieght || lineWidth
#define LINE_HEIGHT (iPhone6plus ? 1.0 / 3.0 : 0.5)
#define LINE_WIDTH LINE_HEIGHT

#ifdef DEBUG
#define NSLog(fmt, ...) { NSLog((fmt), ##__VA_ARGS__); }
#else
#define NSLog(...) {}
#endif

#endif /* macro_ui_h */
