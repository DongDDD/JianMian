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
#import <UIImageView+WebCache.h>
#import "JMUserInfoManager.h"
#import <TIMManager.h>


#define STATUS_BAR_HEIGHT 20
//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44


//状态栏 ＋ 导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))

//主色调
#define TEXT_GRAY_COLOR [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1.0]
#define TEXT_GRAYmin_COLOR [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]
#define TITLE_COLOR [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1.0]
#define MASTER_COLOR [UIColor colorWithRed:59/255.0 green:199/255.0 blue:255/255.0 alpha:1.0]
#define BG_COLOR [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]
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

#define GlobalFont(fontsize) [UIFont systemFontOfSize:fontsize]
//营业执照认证
#define Company_PassIdentify @"1"
#define Company_NOIdentify @"0"
//实名认证
#define Card_WaitIdentify @"1"
#define Card_NOIdentify @"0"
#define Card_PassIdentify @"3"
//用户状态type
#define NO_Type_USER @"0" //还没选择身份
#define C_Type_USER @"1" //C端
#define B_Type_UESR @"2" //B端

//职位状态
#define Position_Online @"1" //职位在线
#define Position_Downline @"0" //职位下线
//面试状态
#define Interview_WaitAgree @"0" //等待同意
#define Interview_Delete @"1" //已取消
#define Interview_Refuse @"2" //已拒绝
#define Interview_WaitInterview @"3" //待面试 （已同意，等待面试）
#define Interview_AlreadyInterview @"4" //已面试
#define Interview_Reflect @"5" //已反馈

//获取网络图片
#define GETImageFromURL(URL)  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:URL]]]


//cell
#define TMessageCell_Head_Size CGSizeMake(42, 42)
#define TMessageCell_Padding 20
#define TMessageCell_Margin 20
#define TMessageCell_Indicator_Size CGSizeMake(20, 20)
//#define MAXFLOAT    0x1.fffffep+127f
//text cell
#define TTextMessageCell_ReuseId @"TTextMessageCell"
#define TTextMessageCell_Height_Min (TMessageCell_Head_Size.height + 2 * TMessageCell_Padding)
#define TTextMessageCell_Margin 12
#define TTextView_Height (50)
#define JMMoreView_Height (100)
#define JMGreetView_Height (211)
//notification
#define Notification_JMRefreshListener @"Notification_JMRefreshListener"
#define Notification_JMMMessageListener @"Notification_JMMMessageListener"
#define Notification_JMMMessageRevokeListener @"Notification_JMMMessageRevokeListener"
#define Notification_JMMUploadProgressListener @"Notification_JMMUploadProgressListener"


#define AMapAPIKey @"3226a67b997e0c6d25b38614a86ff5e0"
#define VideoAgoraAPIKey @"a529ef85c7354d57aefd91a53325253b"

#define Is_Iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define Is_IPhoneX (SCREEN_WIDTH >=375.0f && SCREEN_HEIGHT >=812.0f && Is_Iphone)
#define Bottom_SafeHeight   (Is_IPhoneX ? (34.0):(0))

//存储userDefault
#define kSaveMyDefault(A,B) [[NSUserDefaults standardUserDefaults] setObject:B forKey:A]
//读取duserDefault
#define kFetchMyDefault(A) [[NSUserDefaults standardUserDefaults] objectForKey:A]

#define kRemoveMyDefault(A) [[NSUserDefaults standardUserDefaults] removeObjectForKey:A]

//判断设备类型
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

//video
#define RECORD_MAX_TIME 8.0           //最长录制时间
#define TIMER_INTERVAL 0.05         //计时器刷新频率
#define VIDEO_FOLDER @"videoFolder" //视频录制存放文件夹



#endif /* DimensMacros_h */
