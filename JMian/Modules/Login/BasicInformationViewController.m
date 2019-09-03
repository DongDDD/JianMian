//
//  BasicInformationViewController.m
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BasicInformationViewController.h"
#import "JobIntensionViewController.h"
#import "JMHTTPManager+UpdateInfo.h"
#import "JMHTTPManager+Uploads.h"
#import "JMHTTPManager+Login.h"
#import <UIButton+WebCache.h>
#import "Masonry.h"
#import "LoginViewController.h"
#import "NavigationViewController.h"
#import "JMJudgeViewController.h"
#import "IQKeyboardManager.h"
#import "STPickerDate.h"



@interface BasicInformationViewController ()<UITextFieldDelegate,UIScrollViewDelegate,STPickerDateDelegate>

@property(nonatomic,strong)NSNumber *sex;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (nonatomic,copy)NSString *imageUrl;
@property (weak, nonatomic) IBOutlet UIButton *headerImg;
//@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *birtnDateBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,copy)NSString *birtnDateStr;

@property (weak, nonatomic) IBOutlet UIButton *womanBtn;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;

@property (nonatomic, assign)CGRect keyboardRect;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToView;
@property (nonatomic, assign)CGFloat changeHeight;

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong)UIButton *moreBtn;
@property(nonatomic,strong)STPickerDate *pickerData;
@end

@implementation BasicInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.viewType == BasicInformationViewTypeEdit) {
        [self setIsHiddenBackBtn:NO];
    }else{
        [self setIsHiddenBackBtn:YES];
        [self.scrollView addSubview:self.moreBtn];
    }
    self.nameText.delegate = self;
  //  [self.view addSubview:_datePicker];
    self.sex = @(1);
    [self getNewUserInfo];
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];
    if ([userInfoModel.card_status isEqualToString:Card_PassIdentify]) {
        [self.nameText setEnabled:NO];
        [self.birtnDateBtn setEnabled:NO];

        
    }

 
//    self.birthDateText.inputView = self.datePicker;
    // Do any additional setup after loading the view from its nib.
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //从沙盒拿
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
//    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
//    
//    [_headerImg setImage:savedImage forState:UIControlStateNormal];
    //    [imge setImage:savedImage];
//    [IQKeyboardManager sharedManager].enable = NO;//试过用enable这个属性，但是没有效果；改成enableAutoToolbar就可以了
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*1.5);

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)getNewUserInfo{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        [self setValuesAction];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

#pragma mark - 赋值
-(void)setValuesAction{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if (userModel.card_name) {
        self.nameText.text = userModel.card_name;
        self.emailText.text = userModel.email;
        [self.birtnDateBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        [self.birtnDateBtn setTitle:userModel.card_birthday forState:UIControlStateNormal];
        [self.headerImg sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] forState:UIControlStateNormal];
        if ([self.model.card_sex isEqualToString:@"1"]) {
            [self.womanBtn setTitleColor:TEXT_GRAY_COLOR forState:UIControlStateNormal];
            self.womanBtn.layer.masksToBounds = YES;
            self.womanBtn.layer.borderColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0].CGColor;
            self.womanBtn.backgroundColor = [UIColor whiteColor];
            
            // 设置当前选中按钮的颜色
            [self.manBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
            self.manBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            self.manBtn.backgroundColor = MASTER_COLOR;
        }else if ([self.model.card_sex isEqualToString:@"2"]) {
            // 恢复上一个按钮颜色
            [self.manBtn setTitleColor:TEXT_GRAY_COLOR forState:UIControlStateNormal];
            self.manBtn.layer.masksToBounds = YES;
            self.manBtn.layer.borderColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0].CGColor;
            self.manBtn.backgroundColor = [UIColor whiteColor];
            
            // 设置当前选中按钮的颜色
            [self.womanBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
            self.womanBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            self.womanBtn.backgroundColor = MASTER_COLOR;
        }
        
    }
    
    if (_viewType == BasicInformationViewTypeEdit) {
        [self setRightBtnTextName:@"保存"];
        
    }else {
        [self setRightBtnTextName:@"下一步"];
    }
    
    
    
    [self.navigationController setNavigationBarHidden:NO];
   // self.datePicker.backgroundColor = [UIColor whiteColor];
    self.emailText.delegate = self;
    self.emailText.keyboardType = UIKeyboardTypeEmailAddress;
    self.nameText.delegate = self;
    self.scrollView.delegate = self;
    

}





- (IBAction)headerAction:(id)sender {
    
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





#pragma mark -textField delegte


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - mydelegte

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    NSString *title = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day];
    [self.birtnDateBtn setTitle:title forState:UIControlStateNormal];
    [self.birtnDateBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    _birtnDateStr = title;
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
    
    //进到次方法时 调 UploadImage 方法上传服务端
//    [[JMHTTPManager sharedInstance]uploadsImageWithFiles:fullPath successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        
//        
//        
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//        
//    }];
//    
    
}



#pragma mark - 保存图片至沙盒（应该是提交后再保存到沙盒,下次直接去沙盒取）
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
    
    NSArray *array = @[currentImage];
    [self showProgressHUD_view:[UIApplication sharedApplication].keyWindow];
    [[JMHTTPManager sharedInstance]uploadsWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            
            _imageUrl = responsObject[@"data"][0];
        }
        [self hiddenHUD];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

#pragma mark - 点击事件

- (IBAction)manBtn:(id)sender {
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];
    if ([userInfoModel.card_status isEqualToString:Card_PassIdentify]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"实名认证通过后不能修改性别"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        return;
    }
    self.sex = @(1);
    // 恢复上一个按钮颜色
    [self.womanBtn setTitleColor:TEXT_GRAY_COLOR forState:UIControlStateNormal];
    self.womanBtn.layer.masksToBounds = YES;
    self.womanBtn.layer.borderColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0].CGColor;
    self.womanBtn.backgroundColor = [UIColor whiteColor];

    // 设置当前选中按钮的颜色
    [self.manBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    self.manBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.manBtn.backgroundColor = MASTER_COLOR;

    
    
    
}

- (IBAction)womanBtn:(id)sender {
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];
    if ([userInfoModel.card_status isEqualToString:Card_PassIdentify]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"实名认证通过后不能修改性别"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        return;
    }
    self.sex = @(2);
    // 恢复上一个按钮颜色
    [self.manBtn setTitleColor:TEXT_GRAY_COLOR forState:UIControlStateNormal];
    self.manBtn.layer.masksToBounds = YES;
    self.manBtn.layer.borderColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0].CGColor;
    self.manBtn.backgroundColor = [UIColor whiteColor];
    
    // 设置当前选中按钮的颜色
    [self.womanBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    self.womanBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.womanBtn.backgroundColor = MASTER_COLOR;

 
    
}



- (IBAction)showDatePeckerAction:(id)sender {
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];
    if ([userInfoModel.card_status isEqualToString:Card_PassIdentify]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"实名认证通过后不能修改出生年月"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [self.view addSubview:self.pickerData];
    [self.pickerData show];

    [_nameText resignFirstResponder];
    [_emailText resignFirstResponder];
}

#pragma mark - 数据提交到服务器


-(void)rightAction{
    [self.nameText resignFirstResponder];
    [self.emailText resignFirstResponder];
    if (_imageUrl.length < 1) {
        [self showAlertSimpleTips:@"提示" message:@"请选择头像" btnTitle:@"好的"];
        return;
    }
    [[JMHTTPManager sharedInstance] updateUserInfoWithCompany_position:nil type:@(1) password:nil avatar:_imageUrl nickname:self.nameText.text email:self.emailText.text name:self.nameText.text sex:self.sex ethnic:nil birthday:_birtnDateStr address:nil number:nil image_front:nil image_behind:nil user_step:@"3" enterprise_step:nil real_status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
   
        [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMUserInfoManager saveUserInfo:userInfo];
         
            if (self.model) {
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                JobIntensionViewController *vc = [[JobIntensionViewController alloc]init];
                vc.loginViewType = JMLoginViewTypeNextStep;
                [self.navigationController pushViewController:vc animated:YES];
            }
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
  
}



#pragma mark - lazy

-(UIButton *)moreBtn{
    if (_moreBtn == nil) {
        _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,self.emailText.frame.origin.y+self.emailText.frame.size.height+20, SCREEN_WIDTH, 40)];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];

        [_moreBtn setTitle:@"更多操作" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}


-(STPickerDate *)pickerData{
    if (_pickerData == nil) {
        _pickerData = [[STPickerDate alloc]init];
        _pickerData.delegate = self;
        _pickerData.yearLeast = 1950;
        _pickerData.yearSum = 2018;
        _pickerData.heightPickerComponent = 28;

    }
    return _pickerData;
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
