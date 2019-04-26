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
#import "JMTabBarViewController.h"
#import <TIMManager.h>
#import "VendorKeyMacros.h"
#import "JMUserInfoManager.h"
#import "JMUserInfoModel.h"
#import "JMCompanyTabBarViewController.h"
#import "JMHTTPManager+Login.h"




@interface AppDelegate ()

@end

@implementation AppDelegate

//获取个人用户填写信息步骤
- (NSString *)getPersonStepWhereWitnUser_step:(NSString *)user_step{
    //因为服务器的user_step不是按顺序，但是数组是按顺序取，所以用[NSNull null]占一个位置
    NSArray *vcArray = @[@"ChooseIdentity",
                         @"BasicInformationViewController", //当user_step=1
                         [NSNull null],
                         @"JobIntensionViewController",     //当user_step=3
                         @"JMJobExperienceViewController",  //当user_step=4
                         [NSNull null],
                         @"JMTabBarViewController"];        //当user_step=6
    
    int stepInt = [user_step intValue];
    if (stepInt < vcArray.count) return vcArray[stepInt];
    
    return nil;
}

//获取公司用户填写信息步骤
- (NSString *)getCompanyStepWhereWitnEnterprise_step:(NSString *)enterprise_step{
    
    NSArray *vcArray = @[@"ChooseIdentity",
                         @"JMCompanyBaseInfoViewController",//当enterprise_step=1
                         @"JMCompanyInfoViewController",    //当enterprise_step=2
                         @"JMUploadLicenseViewController",  //当enterprise_step=3
                         @"JMChangeIdentityViewController", //当enterprise_step=4
                         @"JMCompanyTabBarViewController"   //当enterprise_step=5
                         
                         ];
    
    int stepInt = [enterprise_step intValue];
    if (stepInt < vcArray.count) return vcArray[stepInt];
    
    return nil;
}


- (void)initTimSDK {
    TIMSdkConfig *sdkConfig = [[TIMSdkConfig alloc] init];
    sdkConfig.sdkAppId = TIMSdkAppid.intValue;
    sdkConfig.accountType = TIMSdkAccountType;
    sdkConfig.disableLogPrint = NO; // 是否允许log打印
    //    sdkConfig.logLevel = TIM_LOG_DEBUG; //Log输出级别（debug级别会很多）
    [[TIMManager sharedInstance] initSdk:sdkConfig];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self initTimSDK];
    if (kFetchMyDefault(@"token")) {
        
        [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMUserInfoManager saveUserInfo:userInfo];
            
            
            JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
            model = [JMUserInfoManager getUserInfo];
            int type = [model.type intValue];
            BaseViewController *vc;
            NSString *vcStr;
            
            //用户还没选择身份
            if (type==0) vcStr = [self getPersonStepWhereWitnUser_step:@"0"];
            
            //用户已经选择了C端身份，user_step判断用户填写信息步骤
            if (type==1) vcStr = [self getPersonStepWhereWitnUser_step:model.user_step];
            
            //用户选择了B端身份，enterprise_step判断用户填写信息步骤
            if (type==2)  vcStr = [self getCompanyStepWhereWitnEnterprise_step:model.enterprise_step];
            
            if (vcStr) {
                vc = [[NSClassFromString(vcStr) alloc]init];
                if (![vc isKindOfClass:[JMTabBarViewController class]]&&![vc isKindOfClass:[JMCompanyTabBarViewController class]]) {
                    vc.isHiddenBackBtn = YES;
                }
                NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:vc];
                [_window setRootViewController:naVC];
                [self.window makeKeyAndVisible];
            }
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        
            
        }];
        
    }else {
        
        LoginViewController *login = [[LoginViewController alloc] init];
        NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:login];
        [_window setRootViewController:naVC];//navigation加在window上
        
        [self.window makeKeyAndVisible];
        
        
    }
    

    
    // Override point for customization after application launch.
  
    //C端
//    JMTabBarViewController *tab = [[JMTabBarViewController alloc] init];
//    self.window.rootViewController = tab;
//    [self.window makeKeyAndVisible];
//    B端
//        JMCompanyTabBarViewController *tab = [[JMCompanyTabBarViewController alloc] init];
//        self.window.rootViewController = tab;
//        [self.window makeKeyAndVisible];
    
    
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
