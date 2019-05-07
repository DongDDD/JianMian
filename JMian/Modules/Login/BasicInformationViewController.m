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



@interface BasicInformationViewController ()<UITextFieldDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)NSNumber *sex;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UIButton *headerImg;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *birtnDateBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *womanBtn;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;

@property (nonatomic, assign)CGRect keyboardRect;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToView;
@property (nonatomic, assign)CGFloat changeHeight;



@end

@implementation BasicInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.model) {
        [self setRightBtnTextName:@"保存"];
        self.nameText.text = self.model.nickname;
        [self.birtnDateBtn setTitle:self.model.card_birthday forState:UIControlStateNormal];
        self.emailText.text = self.model.email;
        [self.headerImg sd_setImageWithURL:[NSURL URLWithString:self.model.avatar] forState:UIControlStateNormal];
        if ([self.model.realSex isEqualToString:@"1"]) {
            [self.womanBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }else {
            [self.manBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }else {
        [self setRightBtnTextName:@"下一步"];
    }
    
    [self.navigationController setNavigationBarHidden:NO];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.emailText.delegate = self;
    self.emailText.keyboardType = UIKeyboardTypeEmailAddress;
    self.nameText.delegate = self;
    self.scrollView.delegate = self;

    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenDatePickerAction)];
    [self.view addGestureRecognizer:bgTap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//    self.birthDateText.inputView = self.datePicker;
    // Do any additional setup after loading the view from its nib.
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //从沙盒拿
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    [_headerImg setImage:savedImage forState:UIControlStateNormal];
    //    [imge setImage:savedImage];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _emailText.frame.origin.y+_emailText.frame.size.height+50);



}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    
    NSDictionary *userInfo = aNotification.userInfo;
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    _keyboardRect = aValue.CGRectValue;
    
    CGRect keyboardRect = aValue.CGRectValue;
    CGRect frame = self.emailText.frame;
    self.changeHeight = keyboardRect.size.height - (frame.origin.y+frame.size.height);
    CGRect rect= CGRectMake(0,_changeHeight+30,SCREEN_WIDTH,SCREEN_HEIGHT);
    [UIView animateWithDuration:0.3 animations:^ {
        self.view.frame = rect;
        
    }];
    
    
    /* 输入框上移 */
    //    CGFloat padding = 20;
//    CGRect frame = self.nameText.frame;
//    self.changeHeight = _keyboardRect.size.height - (frame.origin.y+frame.size.height);
//    if (self.changeHeight < 0) {
//        [UIView animateWithDuration:0.3 animations:^ {
//
//            self.topToView.constant += self.changeHeight-10;
//
//        }];
//    }
 
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    [UIView animateWithDuration:0.3 animations:^ {
        self.view.frame = CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT);
        
    }];

}
//
//
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    float width = SCREEN_WIDTH;
//    float height = SCREEN_HEIGHT;
//    self.scrollView.frame= CGRectMake(0,0,width,height);
//}
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    if (textField == _nameText) {
//        CGRect frame = self.nameText.frame;
//        self.changeHeight = _keyboardRect.size.height - (frame.origin.y+frame.size.height);
//        float width = SCREEN_WIDTH;
//        float height = SCREEN_HEIGHT;
//        //上移n个单位，按实际情况设置
//
//        CGRect rect= CGRectMake(0,_changeHeight,width,height);
//        [UIView animateWithDuration:0.3 animations:^ {
//            self.scrollView.frame = rect;
//
//        }];
//
//    }else if (textField == _emailText){
//
//        CGRect frame = _emailText.frame;
//        self.changeHeight = _keyboardRect.size.height - (frame.origin.y+frame.size.height);
//        float width = SCREEN_WIDTH;
//        float height = SCREEN_HEIGHT;
//        //上移n个单位，按实际情况设置
//
//        CGRect rect= CGRectMake(0,_changeHeight,width,height);
//        [UIView animateWithDuration:0.3 animations:^ {
//            self.scrollView.frame = rect;
//
//        }];
//
//    }
//
//
//    return YES;
//
//
//}
//
//

- (IBAction)datePickerViewChange:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 格式化日期格式
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *date = [formatter stringFromDate:self.datePicker.date];
    // 显示时间
    [self.birtnDateBtn setTitle:date forState:UIControlStateNormal];
    [self.birtnDateBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    
    
}

- (IBAction)showDatePeckerAction:(id)sender {
    self.datePicker.hidden = NO;

}


-(void)hiddenDatePickerAction{
    self.datePicker.hidden = YES;
    [_nameText resignFirstResponder];
    [_emailText resignFirstResponder];
    
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


#pragma mark -scrollView delegte
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.datePicker.hidden = YES;
    
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

//图频上传




#pragma mark - 保存图片至沙盒（应该是提交后再保存到沙盒,下次直接去沙盒取）
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
    
    
}

#pragma mark - 点击事件

- (IBAction)manBtn:(id)sender {
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



#pragma mark - 数据提交到服务器


-(void)rightAction{

   
        [[JMHTTPManager sharedInstance] updateUserInfoType:@(1) password:nil avatar:nil nickname:self.nameText.text email:self.emailText.text name:self.nameText.text sex:self.sex ethnic:nil birthday:self.birtnDateBtn.titleLabel.text address:nil number:nil image_front:nil image_behind:nil user_step:@"3" enterprise_step:nil real_status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            
            [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
                
                JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
                [JMUserInfoManager saveUserInfo:userInfo];
                
                
                if (self.model) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else {
                    JobIntensionViewController *jobIntension = [[JobIntensionViewController alloc]init];
                    [self.navigationController pushViewController:jobIntension animated:YES];
                }
            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                
            }];
            
            
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
