//
//  LoginViewController.m
//  JMian
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginPhoneViewController.h"
#import "WXApi.h"
#import "JMHTTPManager+Login.h"
//#import "JMLoginInfoModel.h"






@interface LoginViewController ()<UIGestureRecognizerDelegate>


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]
        && gestureRecognizer == self.navigationController.interactivePopGestureRecognizer
        && self.navigationController.visibleViewController == [self.navigationController.viewControllers objectAtIndex:0]) {
        NSLog(@"Gesture blocked$$$$$$$$$$$$");
        return NO;
    }
    NSLog(@"Gesture begin");
    return YES;
}


- (IBAction)wechatLoginAction:(id)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
    {
        NSLog(@"OK weixin://");
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]])
    {
        NSLog(@"OK wechat://");
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb290293790992170://"]])
    {
        NSLog(@"OK fb290293790992170://");
    }
    if([WXApi isWXAppInstalled]){//判断用户是否已安装微信App
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
        req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
       
        [WXApi sendReq:req];
    }else{
        
        NSLog(@"未安装微信应用或版本过低");
        
    }
    
    
}

- (void)onResp:(id)resp{
    
    if([resp isKindOfClass:[SendAuthResp class]]){//判断是否为授权登录类
        
        SendAuthResp *req = (SendAuthResp *)resp;
        
        if([req.state isEqualToString:@"wx_oauth_authorization_state"]){//微信授权成功
            
            NSLog(@"%@",req.code); //获得code
            
            [[JMHTTPManager sharedInstance]loginWithMode:@"wx" phone:@"" captcha:req.code sign_id:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
                
                
//                JMLoginInfoModel *model = [JMLoginInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
               
                
                LoginPhoneViewController *loginPhone = [[LoginPhoneViewController alloc]initWithNibName:@"LoginPhoneViewController" bundle:nil];
                
                [self.navigationController pushViewController:loginPhone animated:YES];
                
            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                
                
            }];
        }
    }
}

- (IBAction)phoneLogin:(id)sender {
    
    
    LoginPhoneViewController *loginPhone = [[LoginPhoneViewController alloc]initWithNibName:@"LoginPhoneViewController" bundle:nil];
    
    [self.navigationController pushViewController:loginPhone animated:YES];
    
    
    
}

-(void)loginRequest{


}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
