//
//  LoginViewController.m
//  JMian
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginPhoneViewController.h"
#import "JMHTTPManager+Login.h"
#import "JMServiceProtocolWebViewController.h"
#import "JMHTTPManager+Login.h"
#import "JMHTTPManager+Captcha.h"
#import "JMJudgeViewController.h"

@interface LoginViewController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *wechatLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneLoginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;

@property (weak, nonatomic) IBOutlet UIButton *youkeBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self.wechatLoginBtn setHidden:YES];

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

  
    
    
}

- (IBAction)xieyiAction:(id)sender {
    JMServiceProtocolWebViewController *vc = [[JMServiceProtocolWebViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
