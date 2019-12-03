//
//  JMJudgeViewController.m
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMJudgeViewController.h"
#import "JMBAndCTabBarViewController.h"
#import "JMHTTPManager+Login.h"
#import "NavigationViewController.h"
#import "LoginViewController.h"
#import "JMPostPartTimeResumeViewController.h"
#import "BasicInformationViewController.h"
#import "LoginPhoneViewController.h"
#import <ImSDK/TIMFriendshipDefine.h>
#import "JMBAndCTabBarViewController.h"
#import "ChooseIdentity.h"
#import "VendorKeyMacros.h"
#import "JMHTTPManager+GetServiceID.h"

@interface JMJudgeViewController ()
@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation JMJudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication].keyWindow addSubview:self.progressHUD];
    self.view.backgroundColor = [UIColor whiteColor];
    if (kFetchMyDefault(@"token")){
        [self getUserInfo];
        [self getServiceRequest];
    }else{
        //token为空执行
        
        LoginViewController *login = [[LoginViewController alloc] init];
        NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:login];
        [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
        
    }
    
}
#pragma mark - data

-(void)getUserInfo{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        [self judeAction];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)getServiceRequest{
    [[JMHTTPManager sharedInstance]getServiceIdWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSString *serviceId = responsObject[@"data"][@"service_id"];
            JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
            NSString *service_id_B = [NSString stringWithFormat:@"%@b",serviceId];
            NSString *im_id_B = [NSString stringWithFormat:@"%@b",userModel.user_id];
            if (![serviceId isKindOfClass:[NSNull class]]) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    if (![im_id_B isEqualToString:service_id_B]) {
                        kSaveMyDefault(@"service_id", serviceId);
                        NSLog(@"ServiceId%@",serviceId);
                        
                    }
                    
                }else{
                    kSaveMyDefault(@"service_id", serviceId);
                    
                }
            }
            
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


-(void)judeAction{
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    model = [JMUserInfoManager getUserInfo];
    //腾讯云返回的usersig是否为空
    if (kFetchMyDefault(@"usersig") == nil) {
        //腾讯云的usersig为空执行，跳转登录界面获取
        LoginPhoneViewController *loginVc = [[LoginPhoneViewController alloc]init];
        
        NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:loginVc];
        [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
    }else{
        if ([model.email isEqualToString:@"379247111ffff@qq.com"] || [model.phone isEqualToString:@"17011116666"]|| [model.phone isEqualToString:@"13246841721"] || [model.phone isEqualToString:@"17817295362"] ) {
            [self jugdeStepToVCWithModel:model];
        }else{
            [self loginIM_tpye:model.type];
        
        }
        //根据用户类型登录腾讯云腾讯云登录。先登录腾讯云再登录账号
        
    }
    
}



-(void)jugdeStepToVCWithModel:(JMUserInfoModel *)model{
   
    BaseViewController *vc;
    NSString *vcStr;
    
    //用户还没选择身份
    if ([model.type isEqualToString:NO_Type_USER])
    {
        vcStr = [self getPersonStepWhereWitnUser_step:@"0"];
        
    }
    
    //用户已经选择了C端身份，user_step判断用户填写信息步骤
    if ([model.type isEqualToString:C_Type_USER])
    {
//        if ([model.ability_count isEqualToString:@"0"]) {
//            if (![model.user_step isEqualToString:@"1"]) {
//                 int stepInt = [model.user_step intValue];
//                if (stepInt > 1) {
//                     vcStr = [self getPersonStepWhereWitnUser_step:model.user_step];
//                }else{
//                    //走兼职简历步骤
//
//                    [self getPersonPartTimeJobStep];
//                }
//            }else{
//                //正在走全职简历注册步骤
//                vcStr = [self getPersonStepWhereWitnUser_step:model.user_step];
//
//            }
//
//
//        }else{
//            JMBAndCTabBarViewController *vc = [[JMBAndCTabBarViewController alloc]init];
//            [UIApplication sharedApplication].delegate.window.rootViewController = vc;
//
//        }
        
        if ([model.ability_count isEqualToString:@"0"]){
            if ([model.user_step isEqualToString:@"0"]) {
                ChooseIdentity *vc = [[ChooseIdentity alloc]init];
                NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:vc];
                [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
                return;
            }else{
                vcStr = [self getPersonStepWhereWitnUser_step:model.user_step];
            
            }
        }else{
            JMBAndCTabBarViewController *vc = [[JMBAndCTabBarViewController alloc]init];
            [UIApplication sharedApplication].delegate.window.rootViewController = vc;
            return;
        }
    }
    
    //用户选择了B端身份，enterprise_step判断用户填写信息步骤
    if ([model.type isEqualToString:B_Type_UESR])
    {
        vcStr = [self getCompanyStepWhereWitnEnterprise_step:model.enterprise_step];
    }
    
    if (vcStr) {
        vc = [[NSClassFromString(vcStr) alloc]init];
        if ([vc isKindOfClass:[JMBAndCTabBarViewController class]]) {

            [UIApplication sharedApplication].delegate.window.rootViewController = vc;
            
        }else
        {
            vc.loginViewType = JMJLoginViewTypeMemory;
            NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:vc];
            [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
        }
        
    }
    
}

#pragma mark - 判断注册到哪步

- (NSString *)getCompanyStepWhereWitnEnterprise_step:(NSString *)enterprise_step{
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];

    NSArray *vcArray = @[@"ChooseIdentity",
                         @"JMCompanyBaseInfoViewController",//当enterprise_step=1
                         @"JMCompanyInfoViewController",    //当enterprise_step=2
                         @"JMUploadLicenseViewController",  //当enterprise_step=3
                         @"JMChangeIdentityViewController", //当enterprise_step=4
                         @"JMBAndCTabBarViewController"   //当enterprise_step=5
                         ];
    
    int BstepInt = [enterprise_step intValue];
    int CstepInt = [userInfoModel.user_step intValue];

    if (BstepInt > vcArray.count ) {
        return vcArray[5];
    }
    
    //判断C端是否已经填了信息，是的话B端跳去填写基本信息第一步，不用选择身份
    if (CstepInt > 0 && BstepInt == 0) {
        return vcArray[1];
    }else if (BstepInt < vcArray.count) {
        return vcArray[BstepInt];
    }
    return nil;
}


//获取个人用户全职填写信息步骤
- (NSString *)getPersonStepWhereWitnUser_step:(NSString *)user_step{
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];

    //因为服务器的user_step不是按顺序，但是数组是按顺序取，所以用[NSNull null]占一个位置
    NSArray *vcArray = @[@"ChooseIdentity",
                         @"BasicInformationViewController", //当user_step=1
                         [NSNull null],
                         @"JobIntensionViewController",     //当user_step=3
                         @"JMJobExperienceViewController",  //当user_step=4
                         [NSNull null],
                         @"JMBAndCTabBarViewController"];        //当user_step=6
    int BstepInt = [userInfoModel.enterprise_step intValue];
    int CstepInt = [user_step intValue];
    if (CstepInt > vcArray.count ) {
        return vcArray[6];
    }
    //判断C端是否已经填了信息，是的话B端跳去填写基本信息第一步，不用选择身份
    if (BstepInt > 0 && CstepInt == 0) {
        return vcArray[1];
    }else if (CstepInt < vcArray.count) {
        //正常判断步骤
        return vcArray[CstepInt];
    }
    
    return nil;
}

//获取个人用户兼职任务填写信息步骤
- (void)getPersonPartTimeJobStep{
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];
    if (userInfoModel.nickname.length > 0 && userInfoModel.avatar.length > 0 && userInfoModel.card_sex.length > 0) {
        JMPostPartTimeResumeViewController *vc = [[JMPostPartTimeResumeViewController alloc]init];
        vc.viewType = JMPostPartTimeResumeViewLogin;
        vc.isHideBackBtn = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        BasicInformationViewController *vc = [[BasicInformationViewController alloc]init];
        vc.viewType = BasicInformationViewTypePartTimeJob;
        vc.isHideBackBtn = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }

  
}



#pragma mark - 登录腾讯云

-(void)loginIM_tpye:(NSString *)tpye{
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    if ([tpye isEqualToString:NO_Type_USER]){//还没选择身份不用其他判断直接跳选择身份界面
        [self jugdeStepToVCWithModel:model];
        return;
    }
//
    TIMLoginParam * login_param = [[TIMLoginParam alloc ]init];
    
    NSString *userIDstr;
    if ([tpye isEqualToString:C_Type_USER]) {
        userIDstr = [NSString stringWithFormat:@"%@a",model.user_id];
    }else if ([tpye isEqualToString:B_Type_UESR]){
        userIDstr = [NSString stringWithFormat:@"%@b",model.user_id];
    }
    
    if (userIDstr) {
        // identifier 为用户名，userSig 为用户登录凭证
        login_param.identifier = userIDstr;
        login_param.userSig = kFetchMyDefault(@"usersig");
        login_param.appidAt3rd = TIMSdkAppid;
        [[TIMManager sharedInstance] login: login_param succ:^(){
            NSLog(@"Login Succ");
            [self.progressHUD setHidden:YES];
            [self jugdeStepToVCWithModel:model];//根据step跳页面
            [self upLoadDeviceToken];//申请离线推送
            [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{TIMProfileTypeKey_FaceUrl:model.avatar} succ:nil fail:nil];
        } fail:^(int code, NSString * err) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请重新登录"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
            NSLog(@"Login Failed: %d->%@", code, err);
            [self gotoLoginViewVC];
        }];
        
    }
    
    
}

-(void)gotoLoginViewVC{

    LoginViewController *loginVc = [[LoginViewController alloc]init];
    
    NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:loginVc];
    [UIApplication sharedApplication].delegate.window.rootViewController = naVC;

}

#pragma mark - 申请离线推送

-(void)upLoadDeviceToken{
    TIMTokenParam *param = [[TIMTokenParam alloc] init];
    /* 用户自己到苹果注册开发者证书，在开发者帐号中下载并生成证书(p12 文件)，将生成的 p12 文件传到腾讯证书管理控制台，控制台会自动生成一个证书 ID，将证书 ID 传入一下 busiId 参数中。*/
#if kAppStoreVersion
    // App Store 版本
#if DEBUG
    param.busiId = 13888;
#else
    param.busiId = 13888;
#endif
#else
    //企业证书 ID
    param.busiId = 13888;
#endif
    self.deviceToken = kFetchMyDefault(@"deviceToken");
    [param setToken:self.deviceToken];
    //            [UIApplication sharedApplication]
    [[TIMManager sharedInstance] setToken:param succ:^{
        NSLog(@"-----> 上传 token 成功 ");
    } fail:^(int code, NSString *msg) {
        NSLog(@"-----> 上传 token 失败 ");
    }];



}

-(MBProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.progress = 0.6;
        _progressHUD.dimBackground = YES; //设置有遮罩
        [_progressHUD showAnimated:YES]; //显示进度框
    }
    return _progressHUD;
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
