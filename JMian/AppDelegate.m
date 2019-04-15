//
//  AppDelegate.m
//  JMian
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ChooseIdentity.h"
#import "BasicInformationViewController.h"
#import "JobIntensionViewController.h"
#import "JMJobExperienceViewController.h"

#import "NavigationViewController.h"
#import "JMTabBarViewController.h"
#import <TIMManager.h>
#import "VendorKeyMacros.h"
#import "JMUserInfoManager.h"
#import "JMUserInfoModel.h"



@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)initTimSDK {
    TIMSdkConfig *sdkConfig = [[TIMSdkConfig alloc] init];
    sdkConfig.sdkAppId = TIMSdkAppid.intValue;
    sdkConfig.accountType = TIMSdkAccountType;
    sdkConfig.disableLogPrint = NO; // 是否允许log打印
    sdkConfig.logLevel = TIM_LOG_DEBUG; //Log输出级别（debug级别会很多）
    [[TIMManager sharedInstance] initSdk:sdkConfig];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self initTimSDK];

    
    if(kFetchMyDefault(@"token")){
        
        JMTabBarViewController *tab = [[JMTabBarViewController alloc] init];
        self.window.rootViewController = tab;
        [self.window makeKeyAndVisible];
//        JMUserInfoModel *model = [[JMUserInfoModel alloc]init];
//        model = [JMUserInfoManager getUserInfo];
//        NSString *str = model.user_step;
//        NSInteger step = [str integerValue];
//        if (step==0) {
//            ChooseIdentity *vc = [[ChooseIdentity alloc]init];
//            NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:vc];
//            [_window setRootViewController:naVC];//navigation加在window上
//
//            [self.window makeKeyAndVisible];
//
//        }else if (step == 1){
//            BasicInformationViewController *vc = [[BasicInformationViewController alloc]init];
//            vc.isHiddenBackBtn = YES;
//            NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:vc];
//            [_window setRootViewController:naVC];//navigation加在window上
//
//            [self.window makeKeyAndVisible];
//
//
//        }else if(step == 2){
//            JobIntensionViewController *vc = [[JobIntensionViewController alloc]init];
//            vc.isHiddenBackBtn = YES;
//            NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:vc];
//            [_window setRootViewController:naVC];//navigation加在window上
//
//            [self.window makeKeyAndVisible];
//
//
//        }else if(step == 3){
//            JMJobExperienceViewController *vc = [[JMJobExperienceViewController alloc]init];
//            NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:vc];
//            vc.isHiddenBackBtn = YES;
//
//            [_window setRootViewController:naVC];//navigation加在window上
//
//            [self.window makeKeyAndVisible];
//
//        }
//
//
        
    }else{
        LoginViewController *login = [[LoginViewController alloc] init];
        NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:login];
        [_window setRootViewController:naVC];//navigation加在window上

        [self.window makeKeyAndVisible];
        
        
    }
    
    
    
    return YES;
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


@end
