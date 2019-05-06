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

@interface LoginPhoneViewController ()<UIActionSheetDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;
@property (weak, nonatomic) IBOutlet UITextField *captchaText;
@property (weak, nonatomic) IBOutlet UIButton *VerifyBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToView;//手机图片到父视图顶部约束距离，因为要上移动的控件受约束于手机图标，
@property (nonatomic, strong)NSLayoutConstraint *originalTopToView;
@property (nonatomic, assign)CGFloat changeHeight;


@end

@implementation LoginPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    _originalTopToView = _topToView;
    
    _phoneNumText.delegate = self;
    _phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    _captchaText.keyboardType = UIKeyboardTypeNumberPad;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)keyboardWillShow:(NSNotification *)aNotification {

    /* 获取键盘的高度 */
    NSDictionary *userInfo = aNotification.userInfo;
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = aValue.CGRectValue;
    /* 输入框上移 */
//    CGFloat padding = 20;
    CGRect frame = self.captchaText.frame;
    self.changeHeight = keyboardRect.size.height - (frame.origin.y+frame.size.height);
    if (self.changeHeight < 0) {
        [UIView animateWithDuration:0.3 animations:^ {
            
            self.topToView.constant += self.changeHeight-10;
                                        
        }];
    }
//    CGFloat height = SCREEN_HEIGHT - frame.origin.y - frame.size.height;
//    if (height < keyboardRect.size.height + padding) {
//
//        [UIView animateWithDuration:0.3 animations:^ {
//
//            CGRect frame = self.view.frame;
//            frame.origin.y = -(keyboardRect.size.height - height + padding);
//            self.view.frame = frame;
//        }];
//    }
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    if (self.changeHeight < 0) {
        [UIView animateWithDuration:0.3 animations:^ {
            self.topToView.constant -= self.changeHeight-10;
            
        }];
  
    }


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [_phoneNumText resignFirstResponder];
    [_captchaText resignFirstResponder];

}
#pragma mark - 数据请求

- (IBAction)loginPhoneBtn:(id)sender {
    
    [[JMHTTPManager sharedInstance]loginWithMode:@"sms" phone:self.phoneNumText.text captcha:self.captchaText.text sign_id:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *model = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        
        [JMUserInfoManager saveUserInfo:model];
        

        NSLog(@"用户手机号：----%@",model.phone);
        
      
        TIMLoginParam * login_param = [[TIMLoginParam alloc ]init];
        // identifier 为用户名，userSig 为用户登录凭证
        login_param.identifier = model.user_id;
        login_param.userSig = model.usersig;
        login_param.appidAt3rd = @"1400193090";
        [[TIMManager sharedInstance] login: login_param succ:^(){
           
            NSLog(@"Login Succ");
            
        } fail:^(int code, NSString * err) {
          
            NSLog(@"Login Failed: %d->%@", code, err);
            
        }];
        
        
        JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登陆成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
       [alert show];
        
        
        
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
    
}




- (IBAction)verifyAction:(id)sender {
    [[JMHTTPManager sharedInstance]loginCaptchaWithPhone:self.phoneNumText.text mode:@3 successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];
    
    [self openCountdown];
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


#pragma mark - image picker delegte
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:^{}];
//
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//
//    //01.21 应该在提交成功后再保存到沙盒，下次进来直接去沙盒路径取
//    // 保存图片至本地，方法见下文
//    [self saveImage:image withName:@"currentImage.png"];
//    //读取路径进行上传
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
//    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
//
//    isFullScreen = NO;
//    self.headImgV.tag = 100;
//    [self.headImgV setImage:savedImage];//图片赋值显示
//
//    //进到次方法时 调 UploadImage 方法上传服务端
//    **NSDictionary *dic = @{@"image":fullPath}; //重点再次 fullPath 为路径
//    [memberMan UploadImage:dic];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
