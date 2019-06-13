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
#import "JMPersonTabBarViewController.h"
#import <TIMManager.h>
#import "VendorKeyMacros.h"
#import "JMUserInfoManager.h"
#import "JMUserInfoModel.h"
#import "JMCompanyTabBarViewController.h"
#import "JMHTTPManager+Login.h"
#import "JMJudgeViewController.h"
#import "JMVideoChatViewController.h"
#import "IQKeyboardManager.h"



@interface AppDelegate ()<TIMMessageListener,UIAlertViewDelegate,JMAnswerOrHangUpViewDelegate,JMVideoChatViewDelegate>



@end

@implementation AppDelegate
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
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}


// 微信支付成功或者失败回调
-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}




-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    //记录下 Apple 返回的 deviceToken
//    _deviceToken = deviceToken;
    NSLog(@"deviceTokendeviceToken---%@",deviceToken);
//    JMJudgeViewController *judgevc = [[JMJudgeViewController alloc]init];
//    judgevc.deviceToken = deviceToken;
//    NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:judgevc];
//    [_window setRootViewController:naVC];
//    [self.window makeKeyAndVisible];
    
}


- (void)initTimSDK {
    TIMSdkConfig *sdkConfig = [[TIMSdkConfig alloc] init];
    sdkConfig.sdkAppId = TIMSdkAppid.intValue;
    sdkConfig.accountType = TIMSdkAccountType;
    sdkConfig.disableLogPrint = NO; // 是否允许log打印
        sdkConfig.logLevel = TIM_LOG_NONE; //Log输出级别（debug级别会很多）
    [[TIMManager sharedInstance] initSdk:sdkConfig];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //向微信注册
    [WXApi registerApp:@"wx04f4e125be6826c5"];
    //高德地图
    [AMapServices sharedServices].apiKey = AMapAPIKey;
    [AMapServices sharedServices].enableHTTPS = YES;
    [[TIMManager sharedInstance] addMessageListener:self];
    //坚决键盘遮挡问题
//    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition]; //输入框自动上移
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;//不显示工具条
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 10.0f;
    [self registNotification];
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self initTimSDK];
    
    JMJudgeViewController *judgevc = [[JMJudgeViewController alloc]init];
    NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:judgevc];
    [_window setRootViewController:naVC];
    [self.window makeKeyAndVisible];//    JMJudgeViewController *judgevc = [[JMJudgeViewController alloc]init];
//    NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:judgevc];
//    [_window setRootViewController:naVC];
//    [self.window makeKeyAndVisible];

    
    return YES;
}


-(void)initLocalNotification_alertBody:(NSString *)alertBody{
    
    
    
    // 1.创建一个本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    
    // 1.1.设置通知发出的时间
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    
    // 1.2.设置通知内容
    localNote.alertBody = @"你有一条消息";
    
    // 1.3.设置锁屏时,字体下方显示的一个文字
    localNote.alertAction = @"你有一条消息";
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


- (void)onNewMessage:(NSArray *)msgs
{

 
    
    if (self.isBackgroundTask) {
        
//        [self initLocalNotification];
    }
    
      
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_JMMMessageListener object:msgs];

    NSLog(@"onNewMessage");

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
        if (self.videoChatDic && [custom_elem.desc isEqualToString:@"我发起了视频聊天"]) {
            [self.answerOrHangUpView setHidden:NO];
            [_window addSubview:self.answerOrHangUpView];
            [self initLocalNotification_alertBody:self.videoChatDic[@"content"]];

        }else if (self.videoChatDic && [custom_elem.desc isEqualToString:@"interviewMessage"]){
            [self initLocalNotification_alertBody:self.videoChatDic[@"content"]];
            
        }else if (self.videoChatDic && [custom_elem.desc isEqualToString:@"textMessage"]){
            //
            [self initLocalNotification_alertBody:self.videoChatDic[@"content"]];
        
        }
//        else if (self.videoChatDic){
//
//            NSString *str = self.videoChatDic[@"leaveAction"];
//            if ([str isEqualToString:@"leaveAction"]) {
//                [[[UIApplication sharedApplication].keyWindow viewWithTag:221] removeFromSuperview];
//                [[[UIApplication sharedApplication].keyWindow viewWithTag:222] removeFromSuperview];
//                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_JMMUHangUpListener object:nil];
//                NSLog(@"----leaveAction----Colse");
//
//            }
//        }
        
        if ([custom_elem.desc isEqualToString:@"leaveAction"]) {
            [[[UIApplication sharedApplication].keyWindow viewWithTag:221] removeFromSuperview];
            [[[UIApplication sharedApplication].keyWindow viewWithTag:222] removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_JMMUHangUpListener object:nil];
            NSLog(@"leaveActionleaveActionleaveAction");

        }
        
//        NSString *title = [NSString stringWithFormat:@" %@ 邀请你视频面试",self.videoChatDic[TITLE]];
//
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:self.videoChatDic[Sub_TITLE]
//                                                      delegate:self cancelButtonTitle:@"接受" otherButtonTitles: @"拒绝", nil];
//        [alert show];
    }
    
    
    
}




#pragma mark - 接听视频聊天

-(void)answerAction{
    [self.answerOrHangUpView setHidden:YES];
//    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    JMVideoChatViewController *vc = [[JMVideoChatViewController alloc]init];
//    vc.view.frame = self.answerOrHangUpView.bounds;
//    vc.videoChatDic = self.videoChatDic;
//    vc.view.tag = 754;
//    [self.answerOrHangUpView addSubview:vc.view];
//    [_window addSubview:vc.controlButtons];
    
//    [vc.controlButtons mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(_window);
//        make.height.mas_equalTo(200);
//        make.left.and.right.mas_equalTo(_window);
//    }];
//    [_window makeKeyAndVisible];
    [self.answerOrHangUpView.player stop];
    [_window addSubview:self.videoChatView];
    [self.videoChatView setVideoChatDic:self.videoChatDic];
    
    
}


#pragma mark - 关闭视频聊天界面
-(void)hangupAction_model:(JMInterViewModel *)model{
    //关闭自己的界面并向对方videoChatView丢出一个leaveAction 挂断命令
    [[[UIApplication sharedApplication].keyWindow viewWithTag:221] removeFromSuperview];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:222] removeFromSuperview];
//   JMUserInfoModel *
    //谁发出的就挂掉谁的视频界面
//    [self.answerOrHangUpView.player stop];
    [self setVideoInvite_receiverID:self.videoChatDic[SendMarkID] dic:nil title:@"leaveAction"];
}

//还没进入房间，弹窗的关闭
-(void)didClickClose{
    NSDictionary *dic;
    dic = @{
            @"leaveAction":@"leaveAction"
            };
    [self.answerOrHangUpView.player stop];

    [[[UIApplication sharedApplication].keyWindow viewWithTag:221] removeFromSuperview];
    [self setVideoInvite_receiverID:self.videoChatDic[SendMarkID] dic:nil title:@"leaveAction"];
//    [self setVideoCloseView_receiverID:self.videoChatDic[SendMarkID] dic:dic];

}

#pragma mark - 发送拒绝接听视频命令（自定义消息）

-(void)setVideoInvite_receiverID:(NSString *)receiverID dic:(NSDictionary *)dic title:(NSString *)title{
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:receiverID];
    
    // 转换为 NSData

    TIMCustomElem * custom_elem = [[TIMCustomElem alloc] init];
//    [custom_elem setData:data];
    if (dic) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        [custom_elem setData:data];
        
    }
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    
    [custom_elem setDesc:title];
    TIMMessage * msg = [[TIMMessage alloc] init];
    [conv sendMessage:msg succ:^(){
        NSLog(@"SendMsg Succ");
    }fail:^(int code, NSString * err) {
        NSLog(@"SendMsg Failed:%d->%@", code, err);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送失败"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }];
    
    
}


-(void)setVideoCloseView_receiverID:(NSString *)receiverID dic:(NSDictionary *)dic{
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:receiverID];
    
    // 转换为 NSData
    
    TIMCustomElem * custom_elem = [[TIMCustomElem alloc] init];
    //    [custom_elem setData:data];
    if (dic) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        [custom_elem setData:data];
        
    }
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    
    [custom_elem setDesc:@"tttttttttt"];
    TIMMessage * msg = [[TIMMessage alloc] init];
    [conv sendMessage:msg succ:^(){
        NSLog(@"SendMsg Succ");
    }fail:^(int code, NSString * err) {
        NSLog(@"SendMsg Failed:%d->%@", code, err);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送失败"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }];
    
}



//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
//    if ([btnTitle isEqualToString:@"不方便"]) {
//        NSLog(@"你点击了取消");
//    }else if ([btnTitle isEqualToString:@"接受"]) {
//        NSLog(@"你点击了接受");
//        JMVideoChatViewController *vc = [[JMVideoChatViewController alloc]init];
//        vc.view.frame = CGRectMake(0, 0, _window.frame.size.width, _window.frame.size.height);
//        vc.videoChatDic = self.videoChatDic;
//        vc.view.tag = 754;
//        [_window addSubview:vc.view];
//
////        NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:vc];
////        [_window setRootViewController:naVC];
//
//    }
//}

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
    [[TIMManager sharedInstance] doForeground:^() {
        NSLog(@"doForegroud Succ");
        self.isBackgroundTask = NO;
    } fail:^(int code, NSString * err) {
        NSLog(@"Fail: %d->%@", code, err);
    }];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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

@end
