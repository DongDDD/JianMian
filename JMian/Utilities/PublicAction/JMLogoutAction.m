//
//  JMLogoutAction.m
//  JMian
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMLogoutAction.h"
#import "JMHTTPManager+Login.h"
#import "DimensMacros.h"
#import "LoginViewController.h"
#import "NavigationViewController.h"
@implementation JMLogoutAction

+(void)loginOut{
    [[JMHTTPManager sharedInstance] logoutWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        kRemoveMyDefault(@"token");
        kRemoveMyDefault(@"usersig");
        kRemoveMyDefault(@"youke");
        //token为空执行
        
        [[TIMManager sharedInstance] logout:^() {
            NSLog(@"logout succ");
        } fail:^(int code, NSString * err) {
            NSLog(@"logout fail: code=%d err=%@", code, err);
        }];
        LoginViewController *login = [[LoginViewController alloc] init];
        NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:login];
        [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
}
@end
