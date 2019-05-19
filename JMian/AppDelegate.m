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




@interface AppDelegate ()<TIMMessageListener,UIAlertViewDelegate,JMAnswerOrHangUpViewDelegate,JMVideoChatViewDelegate>



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
        }
        if ([custom_elem.desc isEqualToString:@"leaveAction"]) {
            [[[UIApplication sharedApplication].keyWindow viewWithTag:221] removeFromSuperview];
            [[[UIApplication sharedApplication].keyWindow viewWithTag:222] removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_JMMUHangUpListener object:nil];

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
    [_window addSubview:self.videoChatView];
    [self.videoChatView setVideoChatDic:self.videoChatDic];
    
    
}


#pragma mark - 关闭视频聊天界面
-(void)hangupAction{
    //关闭自己的界面并向对方videoChatView丢出一个leaveAction 挂断命令
    [[[UIApplication sharedApplication].keyWindow viewWithTag:221] removeFromSuperview];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:222] removeFromSuperview];
//   JMUserInfoModel *
    //谁发出的就挂掉谁的视频界面
    [self setVideoInvite_receiverID:self.videoChatDic[SendMarkID] dic:nil title:@"leaveAction"];
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
