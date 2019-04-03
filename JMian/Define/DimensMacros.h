//
//  DimensMacros.h
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#ifndef DimensMacros_h
#define DimensMacros_h

#import <MJExtension.h>



#define STATUS_BAR_HEIGHT 20
//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44


//状态栏 ＋ 导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))

//主色调

#define MASTER_COLOR [UIColor colorWithRed:59/255.0 green:199/255.0 blue:255/255.0 alpha:1.0]
//分割线颜色

#define XIAN_COLOR  [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]

//屏幕 rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

#define UIColorFromHEX(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SafeAreaBottomHeight (IPHONE_X ? 34 : 0)
#define SafeAreaTopHeight (IPHONE_X ? 88 : 64)
#define SafeAreaStatusHeight (IPHONE_X ? 44 : 20)


//存储userDefault
#define kSaveMyDefault(A,B) [[NSUserDefaults standardUserDefaults] setObject:B forKey:A]
//读取duserDefault
#define kFetchMyDefault(A) [[NSUserDefaults standardUserDefaults] objectForKey:A]


//判断设备类型
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})



#endif /* DimensMacros_h */
