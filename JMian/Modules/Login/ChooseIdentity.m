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
#import "JMJobTypeChooseView.h"
#import "JMPostPartTimeResumeViewController.h"
#import "JMBAndCTabBarViewController.h"



@interface ChooseIdentity ()<JMJobTypeChooseViewDelegate>

@property(nonatomic,strong)JMJobTypeChooseView *jobtypeChooseView;
@property(nonatomic,strong)UIView *BGView;
@end

@implementation ChooseIdentity

- (void)viewDidLoad {
    [super viewDidLoad];
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:C_Type_USER]) {
        [self showJobChooseView];
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    [[TIMManager sharedInstance] logout:^() {
        NSLog(@"logout succ");
    } fail:^(int code, NSString * err) {
        NSLog(@"logout fail: code=%d err=%@", code, err);
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];

}
#pragma mark - action

- (IBAction)isSearchJob:(id)sender {
    [self showJobChooseView];

}

- (IBAction)isCompanyBtn:(id)sender {
//    [self chooseTypeWithType:@"2" step:@"1"];
    NSString *type;
    NSString *step;
    if (_isChangeType) {
        type = @"";
        step = @"";
     
    }else{
        type = @"2";
        step = @"1";
    }
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    
    if (![userModel.enterprise_step isEqualToString:@"0"] && [userModel.type isEqualToString:B_Type_UESR]) {
        JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([userModel.type isEqualToString:C_Type_USER]){
        if ( [userModel.enterprise_step isEqualToString:@"0"]) {
            //当前为C端，需切换身份，选择C端类型后后退会出现这种情况
            [[JMHTTPManager sharedInstance]userChangeWithType:type step:step  successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
                
                JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
                [JMUserInfoManager saveUserInfo:userInfo];
                kSaveMyDefault(@"usersig", userInfo.usersig);
                NSLog(@"usersig-----:%@",userInfo.usersig);
                JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                
            }];
            
        }else{
            [[JMHTTPManager sharedInstance]userChangeWithType:@"" step:@""  successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
                
                JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
                [JMUserInfoManager saveUserInfo:userInfo];
                kSaveMyDefault(@"usersig", userInfo.usersig);
                NSLog(@"usersig-----:%@",userInfo.usersig);
                JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                
            }];
        }
    
    }else{
        [[JMHTTPManager sharedInstance]userChangeWithType:type step:step  successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMUserInfoManager saveUserInfo:userInfo];
            kSaveMyDefault(@"usersig", userInfo.usersig);
            NSLog(@"usersig-----:%@",userInfo.usersig);
            JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
    }
        NSLog(@"我要招人");
    
   
}

-(void)hideJobTypeViewAction{
    [self.BGView setHidden:YES];
    [self.jobtypeChooseView setHidden:YES];
}

//-(void)chooseTypeWithType:(NSString *)type step:(NSString *)step{
//
//    [[JMHTTPManager sharedInstance]userChangeWithType:type step:step  successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//
//        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
//        [JMUserInfoManager saveUserInfo:userInfo];
//        kSaveMyDefault(@"usersig", userInfo.usersig);
//        NSLog(@"usersig-----:%@",userInfo.usersig);
//
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//
//}

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

-(void)showJobChooseView{
//    [self loginIM_tpye:C_Type_USER];
    [self.jobtypeChooseView setHidden:NO];
    [self.BGView setHidden:NO];
    [[UIApplication sharedApplication].keyWindow addSubview:self.BGView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.jobtypeChooseView];
    [self.jobtypeChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo([UIApplication sharedApplication].keyWindow).mas_offset(20);
        make.right.mas_equalTo([UIApplication sharedApplication].keyWindow).mas_offset(-20);
        make.centerX.centerY.mas_equalTo([UIApplication sharedApplication].keyWindow);
        make.height.mas_equalTo(220);
    }];
}

#pragma mark - myDelegate
-(void)jobActionDelegate{
    [self loginIM];
    [self hideJobTypeViewAction];
    [[JMHTTPManager sharedInstance]userChangeWithType:@"1" step:@"1"  successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        kSaveMyDefault(@"usersig", userInfo.usersig);
        NSLog(@"usersig-----:%@",userInfo.usersig);
        BasicInformationViewController *vc = [[BasicInformationViewController alloc]init];
        vc.viewType = BasicInformationViewTypeDefault;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)partTimeJobActionDelegate{
    [self loginIM];
    [self hideJobTypeViewAction];
    [[JMHTTPManager sharedInstance]userChangeWithType:@"1" step:nil  successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        kSaveMyDefault(@"usersig", userInfo.usersig);
        NSLog(@"usersig-----:%@",userInfo.usersig);
        JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];        
        if ([userInfoModel.ability_count isEqualToString:@"0"]) {
            //无兼职简历
            if (userInfoModel.nickname.length > 0 && userInfoModel.avatar.length > 0 && userInfoModel.card_sex.length > 0) {
                JMPostPartTimeResumeViewController *vc = [[JMPostPartTimeResumeViewController alloc]init];
                vc.viewType = JMPostPartTimeResumeViewAdd;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                BasicInformationViewController *vc = [[BasicInformationViewController alloc]init];
                vc.viewType = BasicInformationViewTypePartTimeJob;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }else{
            //有兼职简历直接跳首页
            JMBAndCTabBarViewController *vc = [[JMBAndCTabBarViewController alloc]init];
            [UIApplication sharedApplication].delegate.window.rootViewController = vc;
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


//登录IM
-(void)loginIM{
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    TIMLoginParam * login_param = [[TIMLoginParam alloc ]init];
    
    NSString *userIDstr;
    if ([model.type isEqualToString:C_Type_USER]) {
        userIDstr = [NSString stringWithFormat:@"%@a",model.user_id];
    }else if ([model.type isEqualToString:B_Type_UESR]){
        userIDstr = [NSString stringWithFormat:@"%@b",model.user_id];
    }
    
    if (userIDstr) {
        // identifier 为用户名，userSig 为用户登录凭证
        login_param.identifier = userIDstr;
        login_param.userSig = kFetchMyDefault(@"usersig");
        login_param.appidAt3rd = @"1400193090";
        [[TIMManager sharedInstance] login: login_param succ:^(){
            NSLog(@"Login Succ");
            
        } fail:^(int code, NSString * err) {
            [self loginOut];
        }];
        
    }
    
    
}
#pragma mark - getter

-(JMJobTypeChooseView *)jobtypeChooseView{
    if (!_jobtypeChooseView) {
        _jobtypeChooseView = [[JMJobTypeChooseView alloc]init];
        _jobtypeChooseView.delegate = self;
    }
    return  _jobtypeChooseView;
}

-(UIView *)BGView{
    if (!_BGView) {
        _BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _BGView.backgroundColor = [UIColor blackColor];
        _BGView.alpha = 0.3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideJobTypeViewAction)];
        [_BGView addGestureRecognizer:tap];
        _BGView.userInteractionEnabled = YES;
    }
    return _BGView;
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
