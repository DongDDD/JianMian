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
    [self.navigationController setNavigationBarHidden:YES];
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:C_Type_USER]) {
        [self showJobChooseView];
    }
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - action

- (IBAction)isSearchJob:(id)sender {
    [self chooseTypeWithType:@"1" step:@"1"];
}

- (IBAction)isCompanyBtn:(id)sender {
    [self chooseTypeWithType:@"2" step:@"1"];
    NSLog(@"我要招人");
}

-(void)hideAction{
    [self.BGView setHidden:YES];
    [self.jobtypeChooseView setHidden:YES];
}

-(void)chooseTypeWithType:(NSString *)type step:(NSString *)step{
    
    [[JMHTTPManager sharedInstance]userChangeWithType:type step:step  successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        kSaveMyDefault(@"usersig", userInfo.usersig);
        NSLog(@"usersig-----:%@",userInfo.usersig);
        [self showJobChooseView];

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
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

-(void)showJobChooseView{
    [self loginIM_tpye:C_Type_USER];
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
//    [self chooseTypeWithType:@"1" step:@"1"];
    BasicInformationViewController *vc = [[BasicInformationViewController alloc]init];
    vc.viewType = BasicInformationViewTypeDefault;
    [self.navigationController pushViewController:vc animated:YES];
    [self hideAction];
}

-(void)partTimeJobActionDelegate{
    [self hideAction];
    //    [self chooseTypeWithType:@"1" step:@"1"];
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];
    
    if ([userInfoModel.ability_count isEqualToString:@"0"]) {
        if (userInfoModel.nickname && userInfoModel.avatar && userInfoModel.card_sex) {
            JMPostPartTimeResumeViewController *vc = [[JMPostPartTimeResumeViewController alloc]init];
            vc.viewType = JMPostPartTimeResumeViewAdd;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            BasicInformationViewController *vc = [[BasicInformationViewController alloc]init];
            vc.viewType = BasicInformationViewTypePartTimeJob;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else{
        JMBAndCTabBarViewController *vc = [[JMBAndCTabBarViewController alloc]init];
         [UIApplication sharedApplication].delegate.window.rootViewController = vc;
       
    
    }
}


-(void)loginIM_tpye:(NSString *)tpye{
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
//    if ([tpye isEqualToString:NO_Type_USER]){//还没选择身份不用其他判断直接跳选择身份界面
//        [self jugdeStepToVCWithModel:model];
//        return;
//    }
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
        login_param.appidAt3rd = @"1400193090";
        [[TIMManager sharedInstance] login: login_param succ:^(){
            NSLog(@"Login Succ");
//            [self.progressHUD setHidden:YES];
//            [self jugdeStepToVCWithModel:model];//根据step跳页面
//            [self upLoadDeviceToken];//申请离线推送
//
//            [[TIMFriendshipManager sharedInstance] modifySelfProfile:@{TIMProfileTypeKey_FaceUrl:model.avatar} succ:nil fail:nil];
            
        } fail:^(int code, NSString * err) {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请重新登录"
//                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//            [alert show];
//
//
//            NSLog(@"Login Failed: %d->%@", code, err);
//            [self gotoLoginViewVC];
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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAction)];
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
