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
#import "JMServiceProtocolWebViewController.h"
#import "JMHTTPManager+Login.h"
#import "JMHTTPManager+Captcha.h"
#import "JMJudgeViewController.h"

@interface LoginViewController ()<UIGestureRecognizerDelegate,WXApiDelegate>

@property (weak, nonatomic) IBOutlet UIButton *wechatLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneLoginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;

@property (weak, nonatomic) IBOutlet UIButton *youkeBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(![WXApi isWXAppInstalled]){
        [self.wechatLoginBtn setHidden:YES];
    }

    // Do any additional setup after loading the view from its nib.
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]
//        && gestureRecognizer == self.navigationController.interactivePopGestureRecognizer
//        && self.navigationController.visibleViewController == [self.navigationController.viewControllers objectAtIndex:0]) {
//        NSLog(@"Gesture blocked$$$$$$$$$$$$");
//        return NO;
//    }
//    NSLog(@"Gesture begin");
//    return YES;
//}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}
- (IBAction)youkeLogin:(id)sender {
    
    [[JMHTTPManager sharedInstance]loginCaptchaWithPhone:@"13246841721" mode:@3 successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        
        [[JMHTTPManager sharedInstance]loginWithMode:@"sms" phone:@"13246841721" captcha:@"123456" sign_id:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMUserInfoModel *model = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            
            [JMUserInfoManager saveUserInfo:model];
            
            NSLog(@"用户手机号：----%@",model.phone);
            
            kSaveMyDefault(@"usersig", model.usersig);
            kSaveMyDefault(@"youke", @"1");

            JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            //        [self.progressHUD setHidden:YES];
            //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登陆成功"
            //                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            //       [alert show];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}


- (IBAction)wechatLoginAction:(id)sender {
    kRemoveMyDefault(@"youke");

    if([WXApi isWXAppInstalled])
    {
        NSLog(@"wechat is install");
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
        req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息

        [WXApi sendReq:req];
    }else{
        [self showAlertSimpleTips:@"提示" message:@"未安装微信" btnTitle:@"好的"];
    }
    
    
    
}

- (IBAction)xieyiAction:(id)sender {
    JMServiceProtocolWebViewController *vc = [[JMServiceProtocolWebViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)onResp:(id)resp{
    
    if([resp isKindOfClass:[SendAuthResp class]]){//判断是否为授权登录类
        
        SendAuthResp *req = (SendAuthResp *)resp;
        
        if([req.state isEqualToString:@"wx_oauth_authorization_state"]){//微信授权成功
            
            NSLog(@"%@",req.code); //获得code
            
            [[JMHTTPManager sharedInstance] loginWithMode:@"wx" phone:@"" captcha:req.code sign_id:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
              
                LoginPhoneViewController *loginPhone = [[LoginPhoneViewController alloc]initWithNibName:@"LoginPhoneViewController" bundle:nil];
                
                [self.navigationController pushViewController:loginPhone animated:YES];
                
            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                
                
            }];
        }
    }
}

- (IBAction)phoneLogin:(id)sender {
    kRemoveMyDefault(@"youke");
    
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
