//
//  LoginPhoneViewController.m
//  JMian
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LoginPhoneViewController.h"
#import "ChooseIdentity.h"
#import "JMHTTPManager+Login.h"
#import "JMHTTPManager+Captcha.h"
#import "VendorKeyMacros.h"
#import "JMJudgeViewController.h"
#import "NavigationViewController.h"
#import "JMServiceProtocolWebViewController.h"

@interface LoginPhoneViewController ()<UIActionSheetDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;
@property (weak, nonatomic) IBOutlet UITextField *captchaText;
@property (weak, nonatomic) IBOutlet UIButton *VerifyBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToView;//手机图片到父视图顶部约束距离，因为要上移动的控件受约束于手机图标，
@property (nonatomic, assign)CGFloat changeHeight;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

@property (weak, nonatomic) IBOutlet UIButton *youkeBtn;

@end

@implementation LoginPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:NO];
//    [self setIsHiddenBackBtn:YES];
    _phoneNumText.delegate = self;
    _phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    _captchaText.keyboardType = UIKeyboardTypeNumberPad;

    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


#pragma mark - 数据请求

- (IBAction)youkeLogin:(id)sender {
    [[JMHTTPManager sharedInstance]loginCaptchaWithPhone:@"13246841721" mode:@3 successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
   
        
        [[JMHTTPManager sharedInstance]loginWithMode:@"sms" phone:@"13246841721" captcha:@"123456" sign_id:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMUserInfoModel *model = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            
            [JMUserInfoManager saveUserInfo:model];
            
            NSLog(@"用户手机号：----%@",model.phone);
            
            kSaveMyDefault(@"usersig", model.usersig);
            
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
- (IBAction)loginPhoneBtn:(id)sender {
//    [self.view addSubview:self.progressHUD];
    [[JMHTTPManager sharedInstance]loginWithMode:@"sms" phone:self.phoneNumText.text captcha:self.captchaText.text sign_id:self.sign_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *model = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        
        [JMUserInfoManager saveUserInfo:model];
        
        NSLog(@"用户手机号：----%@",model.phone);
        
        kSaveMyDefault(@"usersig", model.usersig);
    
        JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];

        [self.navigationController pushViewController:vc animated:YES];
//        [self.progressHUD setHidden:YES];
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登陆成功"
//                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//       [alert show];
     
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
     
    }];
    
    
}




- (IBAction)verifyAction:(id)sender {
    [[JMHTTPManager sharedInstance]loginCaptchaWithPhone:self.phoneNumText.text mode:@3 successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送成功"
//                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//        [alert show];
//        
//        [self.view addSubview:self.progressHUD];
        [self.captchaText becomeFirstResponder];
        [self showAlertVCSucceesSingleWithMessage:@"验证码已发送到你手机" btnTitle:@"好的"];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];
    
    [self openCountdown];
}


- (IBAction)xieyiAction:(id)sender {
    JMServiceProtocolWebViewController *vc = [[JMServiceProtocolWebViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



//读秒效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.VerifyBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.VerifyBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
                self.VerifyBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{

                //设置按钮显示读秒效果
                [self.VerifyBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.VerifyBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
                self.VerifyBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


-(MBProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.progress = 0.4;
        _progressHUD.dimBackground = NO; //设置有遮罩
        _progressHUD.mode = MBProgressHUDModeText;
        _progressHUD.label.text = @"登录中..."; //设置进度框中的提示文字
//        [_progressHUD hideAnimated:YES afterDelay:1.5];
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
