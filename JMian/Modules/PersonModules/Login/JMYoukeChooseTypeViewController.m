//
//  JMYoukeChooseTypeViewController.m
//  JMian
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMYoukeChooseTypeViewController.h"
#import "JMHTTPManager+Login.h"
#import "JMHTTPManager+Login.h"
#import "JMHTTPManager+Captcha.h"
#import "JMJudgeViewController.h"
@interface JMYoukeChooseTypeViewController ()

@end

@implementation JMYoukeChooseTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;

    // Do any additional setup after loading the view from its nib.
}

- (IBAction)chooseC_Action:(id)sender {
    [self showProgressHUD_view:self.view];
    [[JMHTTPManager sharedInstance]loginCaptchaWithPhone:@"13246841721" mode:@3 successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [[JMHTTPManager sharedInstance]loginWithMode:@"sms" phone:@"13246841721" captcha:@"123456" sign_id:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMUserInfoModel *model = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMUserInfoManager saveUserInfo:model];
            NSLog(@"用户手机号：----%@",model.phone);
            
            kSaveMyDefault(@"usersig", model.usersig);
            kSaveMyDefault(@"youke", @"1");
            [self hiddenHUD];
            JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
            [UIApplication sharedApplication].delegate.window.rootViewController = vc;

        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

- (IBAction)chooseB_Action:(id)sender {
    [self showProgressHUD_view:self.view];

    [[JMHTTPManager sharedInstance]loginCaptchaWithPhone:@"17011116666" mode:@3 successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        [[JMHTTPManager sharedInstance]loginWithMode:@"sms" phone:@"17011116666" captcha:@"123456" sign_id:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            JMUserInfoModel *model = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMUserInfoManager saveUserInfo:model];
            NSLog(@"用户手机号：----%@",model.phone);
            
            kSaveMyDefault(@"usersig", model.usersig);
            kSaveMyDefault(@"youke", @"1");
            [self hiddenHUD];
            JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
            [UIApplication sharedApplication].delegate.window.rootViewController = vc;

        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
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
