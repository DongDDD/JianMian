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
#import <ImSDK/TIMManager.h>
#import <ImSDK/TIMMessage.h>
#import <ImSDK/IMMessageExt.h>
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "VIMediaCache.h"
#import "Masonry.h"
#import <WebKit/WebKit.h>
#import "JMNoDataView.h"
#import "JMVersionManager.h"
#import "THeader.h"
#import "JMDataTransform.h"

#define STATUS_BAR_HEIGHT 20
//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44

#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \\
_Pragma("clang diagnostic push") \\
_Pragma("clang diagnostic ignored \\"-Wshadow\\"") \\
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \\
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \\
_Pragma("clang diagnostic push") \\
_Pragma("clang diagnostic ignored \\"-Wshadow\\"") \\
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \\
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \\
_Pragma("clang diagnostic push") \\
_Pragma("clang diagnostic ignored \\"-Wshadow\\"") \\
try{} @finally{} __typeof__(x) x = __weak_##x##__; \\
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \\
_Pragma("clang diagnostic push") \\
_Pragma("clang diagnostic ignored \\"-Wshadow\\"") \\
try{} @finally{} __typeof__(x) x = __block_##x##__; \\
_Pragma("clang diagnostic pop")

#endif
#endif


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
// 0:未认证 1:申请认证 2:拒绝认证 3:已认证
#define Card_NOIdentify @"0"
#define Card_WaitIdentify @"1"
#define Card_RefuseIdentify @"2"
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
#define Interview_AlreadyInterview @"4" //C端面试完还没反馈
#define Interview_Reflect @"5" //已反馈
//面试状态
#define Video_Pass @"1" //通过
#define Video_Wait @"0" //等待审核
//任务状态
#define Task_WaitDealWith @"0" //待处理
#define Task_Pass @"1" //已通过
#define Task_Refuse @"2" //已拒绝
#define Task_Finish @"3" //已完成
#define Task_DidComfirm @"4" //已经确认
//任务完成信用评分

#define Comment_SoBad @"1" //非常差
#define Comment_Bad @"2" //差
#define Comment_SoSo @"3" //一般
#define Comment_Good @"4" //好
#define Comment_VeryGood @"5" //非常好

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
//push cell (custum)
#define JMPushtMessageCell_ReuseId @"JMPushtMessageCell"

//image cell
#define TImageMessageCell_ReuseId @"TImageMessageCell"
#define TImageMessageCell_Image_Width_Max (SCREEN_WIDTH * 0.4)
#define TImageMessageCell_Image_Height_Max TImageMessageCell_Image_Width_Max
#define TImageMessageCell_Margin_2 8
#define TImageMessageCell_Margin_1 16
#define TImageMessageCell_Progress_Color  RGBA(0, 0, 0, 0.5)

//notification
#define Notification_JMRefreshListener @"Notification_JMRefreshListener"
#define Notification_JMMMessageListener @"Notification_JMMMessageListener"
#define Notification_JMMMessageRevokeListener @"Notification_JMMMessageRevokeListener"
#define Notification_JMMUploadProgressListener @"Notification_JMMUploadProgressListener"
#define Notification_JMMUHangUpListener @"Notification_JMMUHangUpListener"

//path
#define TUIKit_DB_Path [NSHomeDirectory() stringByAppendingString:@"/Documents/com_tencent_imsdk_data/"]
#define TUIKit_Image_Path [NSHomeDirectory() stringByAppendingString:@"/Documents/com_tencent_imsdk_data/image/"]
#define TUIKit_Video_Path [NSHomeDirectory() stringByAppendingString:@"/Documents/com_tencent_imsdk_data/video/"]
#define TUIKit_Voice_Path [NSHomeDirectory() stringByAppendingString:@"/Documents/com_tencent_imsdk_data/voice/"]
#define TUIKit_File_Path  [NSHomeDirectory() stringByAppendingString:@"/Documents/com_tencent_imsdk_data/file/"]

//支付结果
#define Notification_PaySucceed @"Notification_PaySucceed"
//任务
#define Notification_TaskListener @"Notification_TaskListener"
//订单
#define Notification_OrderListener @"Notification_OrderListener"

//发起视频
#define Channel_ID @"Channel_ID"
#define Mark_ID @"Mark_ID"
#define Avatar_URL @"Avatar_URL"
#define User_ID @"User_ID"
#define TITLE @"TITLE"
#define Sub_TITLE @"Sub_TITLE"
//#define SendMarkID @"SendMarkID"
#define isPartTime @"isPartTime"




#define MiniProgramUserName @"gh_13551d20d138"
#define AMapAPIKey @"38e2ca286abf181c06a69ebba0dc5d6f"
#define VideoAgoraAPIKey @"a046b14ce976410ab008d99924892a6a"
#define Is_Iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define Is_IPhoneX (SCREEN_WIDTH >=375.0f && SCREEN_HEIGHT >=812.0f && Is_Iphone)
#define Bottom_SafeHeight   (Is_IPhoneX ? (34.0):(0))
//存储字体样式
#define kBoldFont(x) [UIFont boldSystemFontOfSize:x]
#define kFont(x) [UIFont systemFontOfSize:x]
#define kNameFont(x) [UIFont fontWithName:@"Heiti SC" size:x]
#define kCOLOR_HEX(hexString) [UIColor colorWithRed:((float)((hexString &0xFF0000) >>16))/255.0green:((float)((hexString &0xFF00) >>8))/255.0blue:((float)(hexString &0xFF))/255.0alpha:1.0]

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
