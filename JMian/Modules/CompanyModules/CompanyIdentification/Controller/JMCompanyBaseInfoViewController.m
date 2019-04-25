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
#import "JMUserInfoModel.h"


@interface JMCompanyBaseInfoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *headerImg;
@property (weak, nonatomic) IBOutlet UITextField *myNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *myPositionTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyNameTextField;

@end

@implementation JMCompanyBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.navigationController setNavigationBarHidden:NO];
 
    [self setRightBtnTextName:@"下一步"];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 数据提交
-(void)rightAction{
    [[JMHTTPManager sharedInstance]createCompanyWithCompany_name:self.companyNameTextField.text company_position:self.myPositionTextField.text nickname:self.myNameTextField.text avatar:nil enterprise_step:@"2" abbreviation:nil logo_path:nil video_path:nil work_time:nil work_week:nil type_label_id:nil industry_label_id:nil financing:nil employee:nil city_id:nil address:nil url:nil longitude:nil latitude:nil description:nil image_path:nil label_id:nil subway:nil line:nil station:nil corporate:nil reg_capital:nil reg_date:nil reg_address:nil unified_credit_code:nil business_scope:nil license_path:nil status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMUserInfoManager saveUserInfo:userInfo];
            kSaveMyDefault(@"company_name", self.companyNameTextField.text);
            kSaveMyDefault(@"company_position", self.myPositionTextField.text);
            
            JMCompanyInfoViewController *vc = [[JMCompanyInfoViewController alloc]init];

            [self.navigationController pushViewController:vc animated:YES];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
          
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    

}

- (IBAction)headerAtion:(id)sender {
    
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
//#pragma mark -scrollView delegte
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    self.datePicker.hidden = YES;
//
//}

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
