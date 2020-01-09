//
//  JMPushVCAction.m
//  JMian
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPushVCAction.h"
#import "JMBDetailViewController.h"
#import "JMCDetailViewController.h"
#import "JMPersonInfoViewController.h"
#import "JobDetailsViewController.h"
#import "DimensMacros.h"

@implementation JMPushVCAction

+(void)gotoMyVCWithtypeStr:(NSString *)typeStr typeId:(NSString *)typeId{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([typeStr isEqualToString:@"work_id"]) {
        NSLog(@"typeId: %@", typeId);
        if ([userModel.type isEqualToString:C_Type_USER]) {
            JobDetailsViewController *vc = [[JobDetailsViewController alloc]init];
            vc.work_id = typeId;
            [[self currentViewController].navigationController pushViewController:vc animated:YES];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先切换身份：我的-右上角设置-切换身份"delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        }
    }else if ([typeStr isEqualToString:@"user_job_id"]) {
        NSLog(@"typeId: %@", typeId);
        if ([userModel.type isEqualToString:B_Type_UESR]) {
            JMPersonInfoViewController *vc = [[JMPersonInfoViewController alloc]init];
            vc.user_job_id = typeId;
            [[self currentViewController].navigationController pushViewController:vc animated:YES];
          
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先切换身份：我的-右上角设置-切换身份" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        }
    }else if ([typeStr isEqualToString:@"ability_id"]) {
        if ([userModel.type isEqualToString:B_Type_UESR]) {
            JMBDetailViewController *vc = [[JMBDetailViewController alloc]init];
            vc.ability_id = typeId;
            [[self currentViewController].navigationController pushViewController:vc animated:YES];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先切换身份：我的-右上角设置-切换身份" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        }
    }else if ([typeStr isEqualToString:@"task_id"]) {
        if ([userModel.type isEqualToString:C_Type_USER]) {
            JMCDetailViewController *vc = [[JMCDetailViewController alloc]init];
            vc.task_id = typeId;
            [[self currentViewController].navigationController pushViewController:vc animated:YES];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先切换身份：我的-右上角设置-切换身份" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    
}


//获取Window当前显示的ViewController
+ (UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}


@end
