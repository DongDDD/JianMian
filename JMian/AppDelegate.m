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




@interface AppDelegate ()<TIMMessageListener,UIAlertViewDelegate>

@end

@implementation AppDelegate


- (void)initTimSDK {
    TIMSdkConfig *sdkConfig = [[TIMSdkConfig alloc] init];
    sdkConfig.sdkAppId = TIMSdkAppid.intValue;
    sdkConfig.accountType = TIMSdkAccountType;
    sdkConfig.disableLogPrint = NO; // 是否允许log打印
        sdkConfig.logLevel = TIM_LOG_NONE; //Log输出级别（debug级别会很多）
    [[TIMManager sharedInstance] initSdk:sdkConfig];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AMapServices sharedServices].apiKey = AMapAPIKey;
    [AMapServices sharedServices].enableHTTPS = YES;
    
    [[TIMManager sharedInstance] addMessageListener:self];
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self initTimSDK];

    JMJudgeViewController *judgevc = [[JMJudgeViewController alloc]init];
    NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:judgevc];
    [_window setRootViewController:naVC];
    [self.window makeKeyAndVisible];

    
    return YES;
}

- (void)onNewMessage:(NSArray *)msgs
{
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_JMMMessageListener object:msgs];

    NSLog(@"onNewMessage");

    TIMMessage *msg = msgs[0];
    TIMElem * elem = [msg getElem:0];
    if ([elem isKindOfClass:[TIMCustomElem class]]) {
        TIMCustomElem * custom_elem = (TIMCustomElem *)elem;
        self.videoChatDic = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:custom_elem.data];
        NSLog(@"视频自定义消息%@",self.videoChatDic);
        NSString *title = [NSString stringWithFormat:@" %@ 邀请你视频面试",self.videoChatDic[TITLE]];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:self.videoChatDic[Sub_TITLE]
                                                      delegate:self cancelButtonTitle:@"接受" otherButtonTitles: @"拒绝", nil];
        [alert show];
    }
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"不方便"]) {
        NSLog(@"你点击了取消");
    }else if ([btnTitle isEqualToString:@"接受"] ) {
        NSLog(@"你点击了确定");
        JMVideoChatViewController *vc = [[JMVideoChatViewController alloc]init];
        vc.view.frame = CGRectMake(0, 0, _window.frame.size.width, _window.frame.size.height);
        vc.videoChatDic = self.videoChatDic;
        vc.view.tag = 754;
        [_window addSubview:vc.view];
    
//        NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:vc];
//        [_window setRootViewController:naVC];

    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
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

@end
