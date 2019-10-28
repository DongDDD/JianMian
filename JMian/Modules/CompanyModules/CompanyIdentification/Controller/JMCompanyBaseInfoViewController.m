//
//  JMCompanyBaseInfoViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyBaseInfoViewController.h"
#import "JMCompanyInfoViewController.h"
#import "JMHTTPManager+CompanyCreate.h"
#import "JMHTTPManager+Login.h"
#import "NavigationViewController.h"
#import "JMUserInfoModel.h"
#import "JMHTTPManager+Uploads.h"
#import "LoginViewController.h"
#import "JMJudgeViewController.h"
#import "JMCompanyInfoModel.h"
#import "JMUploadLicenseViewController.h"



@interface JMCompanyBaseInfoViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *headerImg;
@property (weak, nonatomic) IBOutlet UITextField *myNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *myPositionTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic, assign)BOOL isHaveHeader;

@property (nonatomic, assign)CGFloat changeHeight;
@property(nonatomic,strong)UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation JMCompanyBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    [self.navigationController setNavigationBarHidden:NO];
    [self setIsHiddenBackBtn:YES];
    self.myNameTextField.delegate = self;
    self.myPositionTextField.delegate = self;
    self.companyNameTextField.delegate = self;
    [self.scrollView addSubview:self.moreBtn];
    [self setRightBtnTextName:@"下一步"];
    [self getUserInfo];
    // Do any additional setup after loading the view from its nib.
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];//设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。tapGestureRecognizer.cancelsTouchesInView = NO;//将触摸事件添加到当前view
//    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//赋值
-(void)getUserInfo{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        if (userInfo.nickname.length > 0) {
            _myNameTextField.text = userInfo.nickname;
            [_myNameTextField setEnabled:NO];
        }
        if (userInfo.avatar.length > 0) {
            _isHaveHeader = YES;
            [_headerImg setImage:[self getImageFromURL:userInfo.avatar] forState:UIControlStateNormal];
            [_myNameTextField setEnabled:NO];

        }else{
            [_myNameTextField setEnabled:YES];

        }
        //1等待审核 2拒绝  3通过
        if ([userInfo.company_real_status isEqualToString:@"2"]) {
            [self showAlertOneBtnVCWithHeaderIcon:@"Failure" message:userInfo.company_real_denial_reason btnTitle:@"重新填写"];
            [self.myPositionTextField setText:userInfo.company_position];
            [self.companyNameTextField setText:userInfo.company_real_company_name];
        }
        
     
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}

//-(void)keyboardHide:(UITapGestureRecognizer*)tap{
//    [_myNameTextField resignFirstResponder];
//    [_myPositionTextField resignFirstResponder];
//    [_companyNameTextField resignFirstResponder];
//
//
//}

//
//- (void)keyboardWillShow:(NSNotification *)aNotification {
//
//    NSDictionary *userInfo = aNotification.userInfo;
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = aValue.CGRectValue;
//    CGRect frame = _companyNameTextField.frame;
//    self.changeHeight = keyboardRect.size.height - (frame.origin.y+frame.size.height);
//    CGRect rect= CGRectMake(0,_changeHeight-10,SCREEN_WIDTH,SCREEN_HEIGHT);
//    if (_changeHeight < 0) {
//
//        [UIView animateWithDuration:0.3 animations:^ {
//            self.view.frame = rect;
//
//        }];
//    }
//
//}
//
//- (void)keyboardWillHide:(NSNotification *)aNotification {
//    float width = SCREEN_WIDTH;
//    float height = SCREEN_HEIGHT;
//    //上移n个单位，按实际情况设置
//    if (_changeHeight < 0) {
//        CGRect rect=CGRectMake(0,0,width,height);
//        self.view.frame=rect;
//
//    }
//
//}

#pragma mark - 数据提交
-(void)rightAction{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if (userModel.avatar.length > 0 && _imageUrl == nil) {
        if ([userModel.avatar containsString:@"https://jmsp-images-1257721067.picgz.myqcloud.com"]) {
            _imageUrl = [userModel.avatar stringByReplacingOccurrencesOfString:@"https://jmsp-images-1257721067.picgz.myqcloud.com" withString:@""];
            _isHaveHeader = YES;
        }
    }
    if (_isHaveHeader == NO) {
        [self showAlertSimpleTips:@"提示" message:@"请上传头像" btnTitle:@"好的"];
        return;
    }
    [[JMHTTPManager sharedInstance]createCompanyWithCompany_name:self.companyNameTextField.text company_position:self.myPositionTextField.text nickname:self.myNameTextField.text avatar:_imageUrl enterprise_step:@"2" abbreviation:nil logo_path:nil video_path:nil work_time:nil work_week:nil type_label_id:nil industry_label_id:nil financing:nil employee:nil city_id:nil address:nil url:nil longitude:nil latitude:nil description:nil image_path:nil label_id:nil subway:nil line:nil station:nil corporate:nil reg_capital:nil reg_date:nil reg_address:nil unified_credit_code:nil business_scope:nil license_path:nil status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
          JMCompanyInfoModel *companyInfoModel = [JMCompanyInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMUserInfoManager saveUserInfo:userInfo];
            if ([companyInfoModel.user_id isEqualToString:userInfo.user_id]) {
                kSaveMyDefault(@"company_name", self.companyNameTextField.text);
                kSaveMyDefault(@"company_position", self.myPositionTextField.text);
                
                JMCompanyInfoViewController *vc = [[JMCompanyInfoViewController alloc]init];
                vc.loginViewType = JMLoginViewTypeNextStep;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                JMUploadLicenseViewController *vc = [[JMUploadLicenseViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            
            }
        
          
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    

}


- (IBAction)headerAtion:(id)sender {
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    //个人信息的头像
    if (userModel.avatar.length > 0) {
        return;
    }else{
        
        //选取照片上传
        UIActionSheet *sheet;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            
        {
            sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
            
        }else {
            
            sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
            
        }
        
        sheet.tag = 255;
        
        [sheet showInView:self.view];
    }
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
    

}
//#pragma mark -scrollView delegte
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    self.datePicker.hidden = YES;
//
//}
#pragma mark - textFielddelegte
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;

}

// 图片选择结束之后，走这个方法，字典存放所有图片信息
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //应该在提交成功后再保存到沙盒，下次进来直接去沙盒路径取
    
    // 保存图片至本地，方法见下文
    [self saveImage:image withName:@"currentImage.png"];
    //读取路径进行上传
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    
    //图片赋值显示
    [_headerImg setImage:savedImage forState:UIControlStateNormal];

    
}

//图频上传

#pragma mark - 保存图片至沙盒（应该是提交后再保存到沙盒,下次直接去沙盒取）
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
    
    NSArray *array = @[currentImage];
    [[JMHTTPManager sharedInstance]uploadsWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
          
            _imageUrl = responsObject[@"data"][0];
            _isHaveHeader = YES;
        }
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


//-(void)changeIdentify{
//    [[JMHTTPManager sharedInstance]userChangeWithType:@"" step:@""  successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//
//        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
//        [JMUserInfoManager saveUserInfo:userInfo];
//        kSaveMyDefault(@"usersig", userInfo.usersig);
//        NSLog(@"usersig-----:%@",userInfo.usersig);
//        JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//
//        [[TIMManager sharedInstance] logout:^() {
//            NSLog(@"logout succ");
//        } fail:^(int code, NSString * err) {
//            NSLog(@"logout fail: code=%d err=%@", code, err);
//        }];
//
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//
//}
//
//-(void)logout{
//    [[JMHTTPManager sharedInstance] logoutWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//
//        kRemoveMyDefault(@"token");
//        kRemoveMyDefault(@"usersig");
//        //token为空执行
//
//        [[TIMManager sharedInstance] logout:^() {
//            NSLog(@"logout succ");
//        } fail:^(int code, NSString * err) {
//            NSLog(@"logout fail: code=%d err=%@", code, err);
//        }];
//        LoginViewController *login = [[LoginViewController alloc] init];
//        NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:login];
//        [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//
//    }];
//
//
//}
//


//-(void)moreAction{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
//    [alert addAction:[UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        [self logout];
//
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"切换身份" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        [self changeIdentify];
//
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }]];
//    [self presentViewController:alert animated:YES completion:nil];
//
//
//}


-(UIButton *)moreBtn{
    if (_moreBtn == nil) {
        _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,self.companyNameTextField.frame.origin.y+self.companyNameTextField.frame.size.height+20, SCREEN_WIDTH, 40)];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];

        [_moreBtn setTitle:@"更多操作" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
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
