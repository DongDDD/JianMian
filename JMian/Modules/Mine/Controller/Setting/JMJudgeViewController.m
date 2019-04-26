//
//  JMJudgeViewController.m
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMJudgeViewController.h"
#import "JMCompanyTabBarViewController.h"
#import "JMTabBarViewController.h"
#import "JMHTTPManager+Login.h"
#import "NavigationViewController.h"
#import "LoginViewController.h"

@interface JMJudgeViewController ()

@end

@implementation JMJudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[JMHTTPManager sharedInstance]userChangeWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        
        if (kFetchMyDefault(@"token")){
            
            JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
            model = [JMUserInfoManager getUserInfo];
            int type = [model.type intValue];
            BaseViewController *vc;
            NSString *vcStr;
            
            //用户还没选择身份
            if (type==0) vcStr = [self getPersonStepWhereWitnUser_step:@"0"];
            
            //用户已经选择了C端身份，user_step判断用户填写信息步骤
            if (type==1) vcStr = [self getPersonStepWhereWitnUser_step:model.user_step];
            
            //用户选择了B端身份，enterprise_step判断用户填写信息步骤
            if (type==2)  vcStr = [self getCompanyStepWhereWitnEnterprise_step:model.enterprise_step];
            
            if (vcStr) {
                vc = [[NSClassFromString(vcStr) alloc]init];
                if (![vc isKindOfClass:[JMTabBarViewController class]]&&![vc isKindOfClass:[JMCompanyTabBarViewController class]]) {
                    vc.isHiddenBackBtn = YES;
                }
                NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:vc];
                [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
        
            }
        }else{
            //token为空执行
            
            LoginViewController *login = [[LoginViewController alloc] init];
            NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:login];
            [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
            
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
    
}

- (NSString *)getCompanyStepWhereWitnEnterprise_step:(NSString *)enterprise_step{
    
    NSArray *vcArray = @[@"ChooseIdentity",
                         @"JMCompanyBaseInfoViewController",//当enterprise_step=1
                         @"JMCompanyInfoViewController",    //当enterprise_step=2
                         @"JMUploadLicenseViewController",  //当enterprise_step=3
                         @"JMChangeIdentityViewController", //当enterprise_step=4
                         @"JMCompanyTabBarViewController"   //当enterprise_step=5
                         
                         ];
    
    int stepInt = [enterprise_step intValue];
    if (stepInt < vcArray.count) return vcArray[stepInt];
    
    return nil;
}


//获取个人用户填写信息步骤
- (NSString *)getPersonStepWhereWitnUser_step:(NSString *)user_step{
    //因为服务器的user_step不是按顺序，但是数组是按顺序取，所以用[NSNull null]占一个位置
    NSArray *vcArray = @[@"ChooseIdentity",
                         @"BasicInformationViewController", //当user_step=1
                         [NSNull null],
                         @"JobIntensionViewController",     //当user_step=3
                         @"JMJobExperienceViewController",  //当user_step=4
                         [NSNull null],
                         @"JMTabBarViewController"];        //当user_step=6
    
    int stepInt = [user_step intValue];
    if (stepInt < vcArray.count) return vcArray[stepInt];
    
    return nil;
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
