//
//  AppDelegate.m
//  JMian
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
//#import "ChooseIdentity.h"
//#import "BasicInformationViewController.h"
//#import "JobIntensionViewController.h"
//#import "JMJobExperienceViewController.h"

#import "NavigationViewController.h"
#import <ImSDK/TIMManager.h>
#import "VendorKeyMacros.h"
#import "JMUserInfoManager.h"
#import "JMUserInfoModel.h"
#import "JMBAndCTabBarViewController.h"
#import "JMHTTPManager+Login.h"
#import "JMJudgeViewController.h"
#import "JMVideoChatViewController.h"
#import "IQKeyboardManager.h"
#import "JMHTTPManager+InterView.h"
#import "LoginPhoneViewController.h"
#import "JMManageInterviewViewController.h"
#import "JMPlaySoundsManager.h"
#import "JMHTTPManager+FectchVersionInfo.h"
#import "JobDetailsViewController.h"
#import "JMPersonDetailsViewController.h"
#import "JMPersonInfoViewController.h"
#import "TUIKit.h"
#import "JMVideoPlayManager.h"
#import "JMBDetailViewController.h"
#import "JMCDetailViewController.h"
#import "iVersion.h"
#import "JMPushVCAction.h"
#import "JMServiceProtocolWebViewController.h"


@interface AppDelegate ()<TIMMessageListener,UIAlertViewDelegate,JMAnswerOrHangUpViewDelegate,JMVideoChatViewDelegate,JMFeedBackChooseViewControllerDelegate,TIMRefreshListener, TIMMessageListener, TIMMessageRevokeListener, TIMUploadProgressListener, TIMUserStatusListener, TIMConnListener, TIMMessageUpdateListener,iVersionDelegate>

@end

@implementation AppDelegate

- (void)initTimSDK {
    TIMSdkConfig *sdkConfig = [[TIMSdkConfig alloc] init];
    sdkConfig.sdkAppId = TIMSdkAppid.intValue;
//    sdkConfig.accountType = TIMSdkAccountType;
    sdkConfig.disableLogPrint = NO; // 是否允许log打印
    sdkConfig.logLevel = TIM_LOG_NONE; //Log输出级别（debug级别会很多）
    [[TIMManager sharedInstance] initSdk:sdkConfig];
    [[TUIKit sharedInstance] setupWithAppId:TIMSdkAppid.intValue];

}
#pragma mark -delegate

//- (void)iVersionDidDetectNewVersion:(NSString *)version details:(NSString *)versionDetails{
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *nowVersionStr = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    BOOL isNeedUpDate = [self compareVersion:version toVersion:nowVersionStr];
    //    if (isNeedUpDate) {
//    NSLog(@"versionDetails:%@ %@",version,versionDetails);
//    //        [_window addSubview:self.versionDetailsView];
//    JMVersionModel *versionModel = [[JMVersionModel alloc]init];
//    versionModel.version = version;
//    versionModel.updateDescription = versionDetails;
//    [JMVersionManager saveVersionInfo:versionModel];
//    [self getVersionData];
//    [self setUpdateDetailsView];
    //        [[UIApplication sharedApplication].keyWindow addSubview:self.versionDetailsView];
    //    }
    
//}

-(void)deleteAction{
    [self.versionDetailsView setHidden:YES];
    
}

-(void)updateAction{
    [[iVersion sharedInstance] openAppPageInAppStore];
    
}

//-(void)setUpdateDetailsView{
//    JMVersionModel *versionModel = [JMVersionManager getVersoinInfo];
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *nowVersionStr = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    BOOL isNeedUpDate = [self compareVersion:versionModel.version toVersion:nowVersionStr];
//    if (isNeedUpDate) {
//        NSLog(@"需要更新");
//        [[UIApplication sharedApplication].keyWindow addSubview:self.versionDetailsView];
////        [UIApplication sharedApplication].keyWindow.b
////        self.versionDetailsView.
//        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.versionDetailsView];
//        [self.versionDetailsView.versionDetailTextView setText:versionModel.updateDescription];
//
//
//    }
//    if (versionModel.enforce) {
//        [self.versionDetailsView.deleteBtn setHidden:YES];
//    }
//}


//- (BOOL)iVersionShouldDisplayNewVersion:(NSString *)version details:(NSString *)versionDetails{
//
//}
//
//- (BOOL)iVersionShouldDisplayCurrentVersionDetails:(NSString *)versionDetails{
//
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //高德地图
    [AMapServices sharedServices].apiKey = AMapAPIKey;
    [AMapServices sharedServices].enableHTTPS = YES;
    
    //向微信注册
    [WXApi registerApp:@"wxb42b10e7d84612a9"];
    [[TIMManager sharedInstance] addMessageListener:self];
     //用户状态变更
//    TIMUserConfig *userConfig = [[TIMUserConfig alloc] init];
//    userConfig.refreshListener = self;
//    userConfig.messageRevokeListener = self;
//    userConfig.uploadProgressListener = self;
//    userConfig.userStatusListener = self;
//    userConfig.friendshipListener = self;
//    userConfig.messageUpdateListener = self;
//    [[TIMManager sharedInstance] setUserConfig:userConfig];
//    [[TIMManager sharedInstance] addMessageListener:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserStatus:) name:TUIKitNotification_TIMUserStatusListener object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNewMessage:) name:TUIKitNotification_TIMMessageListener object:nil];
//    [iVersion sharedInstance].applicationBundleID = [[NSBundle mainBundle] bundleIdentifier];
//    [iVersion sharedInstance].updatePriority=iVersionUpdatePriorityMedium;
//      [iVersion sharedInstance].delegate = self;
    [iVersion sharedInstance].downloadButtonLabel = @"更新版本";
    [iVersion sharedInstance].remindButtonLabel = @"晚点提醒我";
    [iVersion sharedInstance].ignoreButtonLabel = @"忽略";
    [iVersion sharedInstance].updateAvailableTitle = @"更新内容";
    [iVersion sharedInstance].showOnFirstLaunch = NO;

  

   
    //MP3播放器
    [[JMPlaySoundsManager sharedInstance] setVideoSounds];
    [[JMPlaySoundsManager sharedInstance] setMoneySounds];

    //坚决键盘遮挡问题
    //    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition]; //输入框自动上移
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;//显示工具条
//    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemImage = [UIImage imageNamed:@"icon_return "];
    [IQKeyboardManager sharedManager].toolbarTintColor = MASTER_COLOR;;
//    [IQKeyboardManager sharedManager].toolbarNextBarButtonItemImage = [UIImage imageNamed:@"down"];
//    [IQKeyboardManager sharedManager].toolbarPreviousBarButtonItemImage = [UIImage imageNamed:@"up"];

    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 10.0f;
    [self registNotification];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self initTimSDK];
    
    JMJudgeViewController *judgevc = [[JMJudgeViewController alloc]init];
    NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:judgevc];
    [_window setRootViewController:naVC];
    [self.window makeKeyAndVisible];
//    [self  getVersionData];
//    [judgevc.view addSubview:self.versionDetailsView];

//    [self getServiceRequest];
 
    return YES;
}

- (BOOL)compareVersion:(NSString *)version1 toVersion:(NSString *)version2
{
    NSArray *list1 = [version1 componentsSeparatedByString:@"."];
    NSArray *list2 = [version2 componentsSeparatedByString:@"."];
    for (int i = 0; i < list1.count || i < list2.count; i++)
    {
        NSInteger a = 0, b = 0;
        if (i < list1.count) {
            a = [list1[i] integerValue];
        }
        if (i < list2.count) {
            b = [list2[i] integerValue];
        }
        if (a > b) {
            return YES;//version1大于version2
        } else if (a < b) {
            return NO;//version1小于version2
        }
    }
    return NO;//version1等于version2
    
}

-(void)initLocalNotification_alertBody:(NSString *)alertBody{
    // 1.创建一个本地通知

    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    
    // 1.1.设置通知发出的时间
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    
    // 1.2.设置通知内容
    localNote.alertBody = alertBody;
    
    // 1.3.设置锁屏时,字体下方显示的一个文字
    localNote.alertAction = alertBody;
    localNote.hasAction = YES;
    
    // 1.4.设置启动图片(通过通知打开的)
    localNote.alertLaunchImage = @"notification";
    
    // 1.5.设置通过到来的声音
    localNote.soundName = UILocalNotificationDefaultSoundName;
    
    //获取未读计数
    int unReadCount = 0;
    NSArray *convs = [[TIMManager sharedInstance] getConversationList];
    for (TIMConversation *conv in convs) {
        if([conv getType] == TIM_SYSTEM){
            continue;
        }
        unReadCount += [conv getUnReadMessageNum];
    }
    
    
    // 1.6.设置应用图标左上角显示的数字
    localNote.applicationIconBadgeNumber = unReadCount;
    
    // 1.7.设置一些额外的信息
    //    localNote.userInfo = @{@"qq" : @"704711253", @"msg" : @"success"};
    
    // 2.执行通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    
}


- (void)registNotification
{
    self.window.backgroundColor = [UIColor whiteColor];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"userInfouserInfo%@", userInfo);
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error{
    
    NSLog(@"%@",error);
    
    
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    //记录下 Apple 返回的 deviceToken
//    _deviceToken = deviceToken;
    NSLog(@"deviceTokendeviceToken---%@",deviceToken);
    kSaveMyDefault(@"deviceToken", deviceToken);
//    __weak typeof(self) ws = self;
//    TIMTokenParam *param = [[TIMTokenParam alloc] init];
//    /* 用户自己到苹果注册开发者证书，在开发者帐号中下载并生成证书(p12 文件)，将生成的 p12 文件传到腾讯证书管理控制台，控制台会自动生成一个证书 ID，将证书 ID 传入一下 busiId 参数中。*/
//#if kAppStoreVersion
//    // App Store 版本
//#if DEBUG
//    param.busiId = 13888;
//#else
//    param.busiId = 13888;
//#endif
//#else
//    //企业证书 ID
//    param.busiId = 13888;
//#endif
//    [param setToken:deviceToken];
//    //            [UIApplication sharedApplication]
//    [[TIMManager sharedInstance] setToken:param succ:^{
//        NSLog(@"-----> 上传 deviceToken 成功 ");
//    } fail:^(int code, NSString *msg) {
//        NSLog(@"-----> 上传 deviceToken 失败 ");
//    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //
    __block UIBackgroundTaskIdentifier bgTaskID;
    bgTaskID = [application beginBackgroundTaskWithExpirationHandler:^ {
        //不管有没有完成，结束 background_task 任务
        [application endBackgroundTask: bgTaskID];
        bgTaskID = UIBackgroundTaskInvalid;
    }];
    //获取未读计数
    int unReadCount = 0;
    NSArray *convs = [[TIMManager sharedInstance] getConversationList];
    for (TIMConversation *conv in convs) {
        if([conv getType] == TIM_SYSTEM){
            continue;
        }
        unReadCount += [conv getUnReadMessageNum];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = unReadCount;
    
    //doBackground
    TIMBackgroundParam  *param = [[TIMBackgroundParam alloc] init];
    [param setC2cUnread:unReadCount];
    [[TIMManager sharedInstance] doBackground:param succ:^() {
        NSLog(@"doBackgroud Succ");
        self.isBackgroundTask = YES;
    } fail:^(int code, NSString * err) {
        NSLog(@"Fail: %d->%@", code, err);
    }];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    [[TIMManager sharedInstance] doForeground:^() {
//        NSLog(@"doForegroud Succ");
//        self.isBackgroundTask = NO;
//    } fail:^(int code, NSString * err) {
//        NSLog(@"Fail: %d->%@", code, err);
//    }];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[TIMManager sharedInstance] doForeground:^() {
        NSLog(@"doForegroud Succ");
    } fail:^(int code, NSString * err) {
        NSLog(@"Fail: %d->%@", code, err);
    }];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - H5打开APP

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    //获取Window当前显示的ViewController
    //    NSLog(@"sourceApplication: %@", sourceApplication);
    if ([url.scheme isEqualToString:@"iosdemi"]) {
        NSLog(@"URL scheme:%@", url);
        NSLog(@"URL query: %@", [url query]);
        NSString *string = [url query];
        NSArray *array = [string componentsSeparatedByString:@":"]; //从字符A中分隔成2个元素的数组
        NSString *string2 = array[0];
        NSArray *array2 = [string2 componentsSeparatedByString:@"="];
        NSString *typeStr = array2[1];
        NSString *typeId = array[1];
        [JMPushVCAction gotoMyVCWithtypeStr:typeStr typeId:typeId];
    }else{
        return  [WXApi handleOpenURL:url delegate:self];
    }
    
    return YES;
}


#pragma mark - 请求
-(void)loginRequestWithCode:(NSString *)code{
    [[JMHTTPManager sharedInstance] loginWithMode:@"wx" phone:@"" captcha:code sign_id:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSString *sign_id = responsObject[@"data"][@"sign_id"];
            if (sign_id) {
                LoginPhoneViewController *vc = [[LoginPhoneViewController alloc]init];
                vc.sign_id = sign_id;
                [vc setIsHiddenBackBtn:NO];
                NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:vc];
                [_window setRootViewController:naVC];
                [self.window makeKeyAndVisible];

            }else{
                //返回用户信息
                
                JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
                [JMUserInfoManager saveUserInfo:userInfo];
                kSaveMyDefault(@"usersig", userInfo.usersig);
                JMJudgeViewController *judgevc = [[JMJudgeViewController alloc]init];
                NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:judgevc];
                [_window setRootViewController:naVC];
                [self.window makeKeyAndVisible];
            }
        }
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
}

//- 版本检测


//-(void)getVersionData{
//    [[JMHTTPManager sharedInstance] fectchVersionWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        if (responsObject[@"data"]) {
//            JMVersionModel *model = [JMVersionModel mj_objectWithKeyValues:responsObject[@"data"]];
//            [JMVersionManager saveVersionInfo:model];
////            [self setUpdateDetailsView];
//        }
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//
//}

#pragma mark - 网络回调
//小程序打开APP
-(void) onReq:(BaseReq*)reqonReq{
    if ([reqonReq isKindOfClass:[LaunchFromWXReq class]]) {
        LaunchFromWXReq *smallProgram = (LaunchFromWXReq *)reqonReq;
        WXMediaMessage *message = smallProgram.message;
        NSLog(@"messageExt %@",message.messageExt);
        NSString *string = message.messageExt;
        if ([string containsString:@":"] || string.length > 0) {
            NSArray *array = [string componentsSeparatedByString:@":"]; //从字符A中分隔成2个元素的数组
            NSString *typeStr = array[0];
            NSString *typeId = array[1];
            [JMPushVCAction gotoMyVCWithtypeStr:typeStr typeId:typeId];
            
        }
    }

}

// 微信支付成功或者失败回调
-(void) onResp:(BaseResp*)resp
{
    //    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendAuthResp class]]){//判断是否为授权登录类
        
        SendAuthResp *req = (SendAuthResp *)resp;
        
        if([req.state isEqualToString:@"wx_oauth_authorization_state"]){//微信授权成功
            strTitle = @"微信授权成功";
            NSLog(@"%@",req.code); //获得code
            [self loginRequestWithCode:req.code];
            
        }
    }else if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }else if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        
        switch (resp.errCode) {
            case WXSuccess:
                
                strTitle = [NSString stringWithFormat:@"支付成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_PaySucceed object:nil];
                
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strTitle = [NSString stringWithFormat:@"支付失败"];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:@"" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//    [alert show];
    
}

//IM被踢下线
-(void)onUserStatus:(NSNotification *)notification{
    NSLog(@"---被踢");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你的账号在别处登录，你被强制下线" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
    
    LoginViewController *loginVc = [[LoginViewController alloc]init];
    NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:loginVc];
    [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
    
}


//接收消息回调
- (void)onNewMessage:(NSArray *)msgs
{
//    [_window addSubview:self.feedBackChooseVC.view];
    if (self.isBackgroundTask) {
        
//        [self initLocalNotification];
    }
    
    NSLog(@"onNewMessage");
    if (msgs.count == 0) {
        return;
    }
    TIMMessage *msg = msgs[0];
    TIMElem * elem = [msg getElem:0];
    if ([elem isKindOfClass:[TIMCustomElem class]]) {
    
        TIMCustomElem * custom_elem = (TIMCustomElem *)elem;
        self.videoChatDic = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:custom_elem.data];
        if (self.videoChatDic == nil) {
            self.videoChatDic =[NSJSONSerialization JSONObjectWithData:custom_elem.data options:NSJSONReadingMutableLeaves error:nil];
            
        }
        if (self.videoChatDic == nil) {
            self.videoChatDic = [NSJSONSerialization JSONObjectWithData:custom_elem.data options:NSJSONReadingMutableLeaves error:nil];
            
        }
        if (self.videoChatDic == nil) {
            self.videoChatDic = [NSJSONSerialization JSONObjectWithData:custom_elem.data options:NSJSONReadingMutableContainers error:nil];
        }
        
        if (self.videoChatDic == nil) {
            self.videoChatDic = [NSJSONSerialization JSONObjectWithData:custom_elem.data options:NSJSONReadingAllowFragments error:nil];
        }
        
        if (self.videoChatDic == nil) {
            NSString *receiveStr = [[NSString alloc]initWithData:custom_elem.data encoding:NSUTF8StringEncoding];
            NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
            self.videoChatDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        }
        
        NSLog(@"视频自定义消息%@",self.videoChatDic);
        if (self.videoChatDic && [custom_elem.desc isEqualToString:@"[邀请视频聊天]"]) {
            [self.answerOrHangUpView setHidden:NO];
            [[JMPlaySoundsManager sharedInstance].videoSoundsPlayer play];
            [_window addSubview:self.answerOrHangUpView];
            [self initLocalNotification_alertBody:self.videoChatDic[@"content"]];
        }else if ([custom_elem.desc isEqualToString:@"[视频已取消]"]) {
            [[[UIApplication sharedApplication].keyWindow viewWithTag:221] removeFromSuperview];
            [[[UIApplication sharedApplication].keyWindow viewWithTag:222] removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_JMMUHangUpListener object:nil];
//            [self updateInterviewStatus_interviewID:self.videoChatDic[Channel_ID] status:@"4"];
//            [self.answerOrHangUpView.player stop];
            [[JMPlaySoundsManager sharedInstance].videoSoundsPlayer stop];

            NSLog(@"[视频已取消]");

        }else if ([custom_elem.desc containsString:@"任务"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_TaskListener object:msgs];
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            AudioServicesPlaySystemSound(1007);
             [self initLocalNotification_alertBody:@"任务状态更新"];
        }else if ([custom_elem.desc containsString:@"得米快找"]){
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            AudioServicesPlaySystemSound(1007);
            [self initLocalNotification_alertBody:@"收到得米推荐消息"];

        }
        
        if ([custom_elem.ext containsString:@"createOrder"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_OrderListener object:msgs];
            [[JMPlaySoundsManager sharedInstance].moneySoundsPlayer play];
        }
//        NSString *title = [NSString stringWithFormat:@" %@ 邀请你视频面试",self.videoChatDic[TITLE]];
//
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:self.videoChatDic[Sub_TITLE]
//                                                      delegate:self cancelButtonTitle:@"接受" otherButtonTitles: @"拒绝", nil];
//        [alert show];
    }else if ([elem isKindOfClass:[TIMTextElem class]]) {

        [self initLocalNotification_alertBody:@"你有一条消息"];

    }
    
    
}

- (void)onRefresh
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:TUIKitNotification_TIMRefreshListener object:nil];
}

- (void)onRefreshConversations:(NSArray *)conversations
{
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_JMRefreshListener object:conversations];
}

#pragma mark - 视频界面事件

// 接听视频聊天
-(void)answerAction{
    [[[UIApplication sharedApplication].keyWindow viewWithTag:221] removeFromSuperview];
    [[JMPlaySoundsManager sharedInstance].videoSoundsPlayer stop];
    [_window addSubview:self.videoChatView];
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    NSString *myMarkId;
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        myMarkId = [NSString stringWithFormat:@"%@b",userModel.user_id];
    }else{
        myMarkId = [NSString stringWithFormat:@"%@a",userModel.user_id];
    }
    NSDictionary *dic;
    dic = @{
            User_ID:myMarkId,
            Channel_ID:self.videoChatDic[Channel_ID], //用户类型
            isPartTime:self.videoChatDic[isPartTime] //是否为兼职视频
            };
    
    
    [self.videoChatView setVideoChatDic:dic];
    
    
}

//还没进入房间，拒绝接听，关闭弹窗
-(void)didClickClose{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    NSString *myMarkId;
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        myMarkId = [NSString stringWithFormat:@"%@b",userModel.user_id];
    }else{
        myMarkId = [NSString stringWithFormat:@"%@a",userModel.user_id];
    }
    NSDictionary *dic;
    dic = @{
            User_ID:myMarkId,
            Channel_ID:self.videoChatDic[Channel_ID], //用户类型
            isPartTime:self.videoChatDic[isPartTime] //是否为兼职视频
            };
    [[JMPlaySoundsManager sharedInstance].videoSoundsPlayer stop];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:221] removeFromSuperview];
    NSNumber * boolNum = self.videoChatDic[isPartTime];
    BOOL isPT = [boolNum boolValue];
    if (!isPT) {
        [self updateInterviewStatus_interviewID:self.videoChatDic[Channel_ID] status:@"4"];
        
    }
    if (self.videoChatDic[User_ID]) {
        [self setVideoInvite_receiverID:self.videoChatDic[User_ID] dic:dic title:@"[视频已取消]"];
    }
    
}


////关闭视频聊天界面
//-(void)hangupAction_model:(JMInterViewModel *)model{
//    //关闭自己的界面并向对方videoChatView丢出一个leaveAction 挂断命令
//    [[[UIApplication sharedApplication].keyWindow viewWithTag:221] removeFromSuperview];
//    [[[UIApplication sharedApplication].keyWindow viewWithTag:222] removeFromSuperview];
////   JMUserInfoModel *
//    //谁发出的就挂掉谁的视频界面
////    [self.answerOrHangUpView.player stop];
////    [self setVideoInvite_receiverID:self.videoChatDic[SendMarkID] dic:nil title:@"结束了视频"];
//
//}

// 对方挂断了 离开房间了
-(void)appDelegateLeaveChannelActoin{
    NSNumber *boolNum = self.videoChatDic[isPartTime];
    BOOL isPT = [boolNum boolValue];
    if (!isPT) {
        //改状态成4 这个状态才可以评价
        [self updateInterviewStatus_interviewID:self.videoChatDic[Channel_ID] status:@"4"];
    }

}



-(void)didCommitActionWithInterview_id:(NSString *)interview_id{
    //改状态成4 这个状态才可以评价
//    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
//    if ([userModel.type isEqualToString:C_Type_USER]) {
        [self.feedBackChooseVC.view removeFromSuperview];

//    }
}

-(void)updateInterviewStatus_interviewID:(NSString *)interviewID status:(NSString *)status{
    [[JMHTTPManager sharedInstance]updateInterViewWith_Id:interviewID status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        NSString *str;
        NSNumber * boolNum = self.videoChatDic[isPartTime];
        BOOL isPT = [boolNum boolValue];
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        if ([status isEqualToString:@"4"] && [userModel.type isEqualToString:C_Type_USER]) {
            //C端在这个状态才可以去反馈
            if(isPT){
                str = @"视频结束了！";
            }else{
                [_window addSubview:self.feedBackChooseVC.view];
                str = @"面试结束了，请进行面试反馈吧！";
            }
        }else if ([status isEqualToString:@"4"] && [userModel.type isEqualToString:B_Type_UESR]){
            if(isPT){
                str = @"视频结束了！";
            }else{
                str = @"面试结束了，可以去面试管理录用人才";
            }

        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

#pragma mark - 发送拒绝接听视频命令（自定义消息）

-(void)setVideoInvite_receiverID:(NSString *)receiverID dic:(NSDictionary *)dic title:(NSString *)title{

    
    
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:receiverID];
    
    
    TIMCustomElem * custom_elem = [[TIMCustomElem alloc] init];
    
    // 转换为 NSData
    if (dic) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        [custom_elem setData:data];
        
    }
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    
    [custom_elem setDesc:title];
    TIMMessage * msg = [[TIMMessage alloc] init];
    
    [msg addElem:custom_elem];
    [conv sendMessage:msg succ:^(){
        NSLog(@"SendMsg Succ");
    }fail:^(int code, NSString * err) {
        NSLog(@"SendMsg Failed:%d->%@", code, err);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送失败"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }];
    
    
    
    
}




-(MBProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.window];
        _progressHUD.progress = 0.6;
        _progressHUD.dimBackground = NO; //设置有遮罩
        _progressHUD.label.text = @"加载中..."; //设置进度框中的提示文字
        [_progressHUD showAnimated:YES]; //显示进度框
    }
    return _progressHUD;
}

#pragma mark - lazy

//对方邀请你视频，可以接听或者挂断
-(JMAnswerOrHangUpView *)answerOrHangUpView{
    if (_answerOrHangUpView == nil) {
        _answerOrHangUpView = [[JMAnswerOrHangUpView alloc]initWithFrame:_window.bounds];
        _answerOrHangUpView.delegate = self;
        _answerOrHangUpView.tag = 221;
        
    }
    return _answerOrHangUpView;
}

-(JMVideoChatView *)videoChatView{
    if (_videoChatView== nil) {
        _videoChatView = [[JMVideoChatView alloc]initWithFrame:_window.bounds];
        _videoChatView.delegate = self;
        _videoChatView.tag = 222;
        
        
    }
    return _videoChatView;
}


-(JMFeedBackChooseViewController *)feedBackChooseVC{
    if (_feedBackChooseVC == nil) {
        _feedBackChooseVC = [[JMFeedBackChooseViewController alloc]init];
        _feedBackChooseVC.interview_id = self.videoChatDic[Channel_ID];
        _feedBackChooseVC.view.frame = _window.bounds;
        _feedBackChooseVC.delegate = self;
        _feedBackChooseVC.viewType = JMFeedBackChooseViewAppdelegate;
    }
    return _feedBackChooseVC;
}


-(JMVersionDetailsView *)versionDetailsView{
    if (_versionDetailsView == nil) {
        _versionDetailsView = [[JMVersionDetailsView alloc]init];
        _versionDetailsView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    }
    return _versionDetailsView;
}
@end
