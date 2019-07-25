//
//  ChooseIdentity.m
//  JMian
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ChooseIdentity.h"
#import "BasicInformationViewController.h"
#import "JMHTTPManager+UpdateInfo.h"
#import "JMCompanyBaseInfoViewController.h"
#import "JMCompanyHomeViewController.h"
#import "JMJudgeViewController.h"
#import "NavigationViewController.h"
#import "JMBAndCTabBarViewController.h"
#import "JMHTTPManager+Login.h"
#import "JMUserInfoModel.h"

@interface ChooseIdentity ()

@end

@implementation ChooseIdentity

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];

    // Do any additional setup after loading the view from its nib.
}

- (IBAction)isSearchJob:(id)sender {
//    [[JMHTTPManager sharedInstance]updateUserInfoWithCompany_position:nil type:@(1) password:nil avatar:nil nickname:nil email:nil name:nil sex:nil ethnic:nil birthday:nil address:nil number:nil image_front:nil image_behind:nil user_step:@"1" enterprise_step:nil real_status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//
//        [self getUserInfoToJudge];
//
//
////        BasicInformationViewController *vc = [[BasicInformationViewController alloc]init];
////
////        [self.navigationController pushViewController:vc animated:YES];
////        kSaveMyDefault(@"type", @"person");
//
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
    [self chooseTypeWithType:@"1" step:@"1"];

    
}

-(void)getUserInfoToJudge{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        kFetchMyDefault(@"usersig");
        NSLog(@"usersig-----:%@",kFetchMyDefault(@"usersig"));
        [JMUserInfoManager saveUserInfo:userInfo];
        JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}
- (IBAction)isCompanyBtn:(id)sender {
//    [[JMHTTPManager sharedInstance]updateUserInfoWithCompany_position:nil  type:@(2) password:nil avatar:nil nickname:nil email:nil name:nil sex:nil ethnic:nil birthday:nil address:nil number:nil image_front:nil image_behind:nil user_step:nil enterprise_step:@"1" real_status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
////
//        [self getUserInfoToJudge];
//
//
////        JMCompanyBaseInfoViewController *vc = [[JMCompanyBaseInfoViewController alloc] init];
////        NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:vc];
////        [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
    
    [self chooseTypeWithType:@"2" step:@"1"];
    NSLog(@"我要招人");
}


-(void)chooseTypeWithType:(NSString *)type step:(NSString *)step{
    
    [[JMHTTPManager sharedInstance]userChangeWithType:type step:step  successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        kSaveMyDefault(@"usersig", userInfo.usersig);
        NSLog(@"usersig-----:%@",userInfo.usersig);
        JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
//        [[TIMManager sharedInstance] logout:^() {
//            NSLog(@"logout succ");
//        } fail:^(int code, NSString * err) {
//            NSLog(@"logout fail: code=%d err=%@", code, err);
//        }];
        
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
