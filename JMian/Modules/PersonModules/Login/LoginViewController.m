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
#import "JMYoukeChooseTypeViewController.h"
#import "JMVersionDetailsView.h"
#import "iVersion.h"
#import "JMHTTPManager+FectchVersionInfo.h"

@interface LoginViewController ()<UIGestureRecognizerDelegate,WXApiDelegate>

@property (weak, nonatomic) IBOutlet UIButton *wechatLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneLoginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;

@property (weak, nonatomic) IBOutlet UIButton *youkeBtn;
@property (nonatomic, strong) JMVersionDetailsView *versionDetailsView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(![WXApi isWXAppInstalled]){
        [self.wechatLoginBtn setHidden:YES];
    }
    [self getVersionData];
    // Do any additional setup after loading the view from its nib.
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}

#pragma mark - 版本检测
-(void)getVersionData{
    [[JMHTTPManager sharedInstance] fectchVersionWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            JMVersionModel *model = [JMVersionModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMVersionManager saveVersionInfo:model];
            [self setUpdateDetailsView];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];

}
-(void)setUpdateDetailsView{
    JMVersionModel *versionModel = [JMVersionManager getVersoinInfo];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersionStr = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    BOOL isNeedUpDate = [self compareVersion:versionModel.version toVersion:nowVersionStr];
    if (isNeedUpDate) {
        NSLog(@"需要更新");
        [[UIApplication sharedApplication].keyWindow addSubview:self.versionDetailsView];
        [self.versionDetailsView.versionDetailTextView setText:versionModel.appDescription];
    }
    if (![versionModel.enforce isEqualToString:@"0"]) {
        [self.versionDetailsView.deleteBtn setHidden:YES];
    }

}

- (BOOL)compareVersion:(NSString *)version1 toVersion:(NSString *)version2
{
    NSArray *list1 = [version1 componentsSeparatedByString:@"."];
    NSArray *list2 = [version2 componentsSeparatedByString:@"."];
    for (int i = 0; i < list1.count || i < list2.count; i++)
    {
        NSInteger a = 0, b = 0;
        if (i < list1.count) {
            a = [list1[i] integerValue];
        }
        if (i < list2.count) {
            b = [list2[i] integerValue];
        }
        if (a > b) {
            return YES;//version1大于version2
        } else if (a < b) {
            return NO;//version1小于version2
        }
    }
    return NO;//version1等于version2
    
}

-(void)deleteAction{
    [self.versionDetailsView setHidden:YES];

}

-(void)updateAction{

    [[iVersion sharedInstance] openAppPageInAppStore];

}

- (IBAction)youkeLogin:(id)sender {
    JMYoukeChooseTypeViewController *vc = [[JMYoukeChooseTypeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
//    [[JMHTTPManager sharedInstance]loginCaptchaWithPhone:@"13246841721" mode:@3 successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        [[JMHTTPManager sharedInstance]loginWithMode:@"sms" phone:@"13246841721" captcha:@"123456" sign_id:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//
//            JMUserInfoModel *model = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
//            [JMUserInfoManager saveUserInfo:model];
//            NSLog(@"用户手机号：----%@",model.phone);
//
//            kSaveMyDefault(@"usersig", model.usersig);
//            kSaveMyDefault(@"youke", @"1");
//
//            JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
//
//            [self.navigationController pushViewController:vc animated:YES];
//
//            //        [self.progressHUD setHidden:YES];
//            //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登陆成功"
//            //                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//            //       [alert show];
//
//        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//        }];
//
//
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
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

-(JMVersionDetailsView *)versionDetailsView{
    if (_versionDetailsView == nil) {
        _versionDetailsView = [[JMVersionDetailsView alloc]init];
        _versionDetailsView.frame = [UIApplication sharedApplication].keyWindow.frame;
        _versionDetailsView.delegate = self;
    }
    return _versionDetailsView;
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
