//
//  JMYoukeAction.m
//  JMian
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMYoukeAction.h"
#import "DimensMacros.h"
#import "LoginViewController.h"
#import "NavigationViewController.h"

@implementation JMYoukeAction


+(BOOL)youkelimit{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            kRemoveMyDefault(@"token");
            kRemoveMyDefault(@"usersig");
            kRemoveMyDefault(@"youke");
 
            LoginViewController *login = [[LoginViewController alloc] init];
            NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:login];
            
            [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
//            [UIApplication sharedApplication].delegate.window.rootViewController = login;
         }]];
        UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [vc presentViewController:alert animated:YES completion:nil];
        return YES;
    }else{
         return NO;
    }
}

 
@end
