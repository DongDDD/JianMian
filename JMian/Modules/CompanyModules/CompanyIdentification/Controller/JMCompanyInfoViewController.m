//
//  JMCompanyInfoViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyInfoViewController.h"
#import "JMUploadLicenseViewController.h"
#import "JMHTTPManager+CompanyCreate.h"
#import "JMHTTPManager+Login.h"
#import "JMUserInfoModel.h"
#import "JMHTTPManager+Uploads.h"


@interface JMCompanyInfoViewController ()<UIPickerViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *headerImg;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLab;
@property (weak, nonatomic) IBOutlet UITextField *abbreviationTextField;
@property (weak, nonatomic) IBOutlet UIButton *industryBtn;
@property (weak, nonatomic) IBOutlet UIButton *employeeBtn;
@property (weak, nonatomic) IBOutlet UIButton *financingBtn;

@property(nonatomic,strong) NSArray *pickerArray;

@property(nonatomic,strong) UIButton *selectedBtn;

@property (nonatomic,copy)NSString *imageUrl;


@end

@implementation JMCompanyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;    
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self setRightBtnTextName:@"下一步"];
    self.pickerView.delegate = self;
    
    self.companyNameLab.text = kFetchMyDefault(@"company_name");
        
    self.scrollView.delegate = self;
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 点击事件

- (IBAction)industryAction:(UIButton *)sender {
    NSLog(@"后台暂时没数据");
    
    
}

- (IBAction)employeeAction:(UIButton *)sender {
    [self.pickerView setHidden:NO];
    self.pickerArray = [NSArray arrayWithObjects:@"15人以下",@"15～50人",@"50～100人",@"500人以上",nil];
    [self.pickerView reloadAllComponents];
    self.selectedBtn = sender;
}


- (IBAction)financingStep:(UIButton *)sender {
    [self.pickerView setHidden:NO];
    self.pickerArray = [NSArray arrayWithObjects:@"天使轮",@"A轮",@"B轮",@"C轮",@"D轮",@"不需要融资",nil];
    [self.pickerView reloadAllComponents];
    self.selectedBtn = sender;

}
#pragma mark - PickerViewDelegate

//返回有几列

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    return [self.pickerArray count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [self.pickerArray objectAtIndex:row];
    
    return str;
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (self.selectedBtn.tag == 1) {
        [self.employeeBtn setTitle:[self.pickerArray objectAtIndex:row] forState:UIControlStateNormal];
        [self.employeeBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        
    }else if(self.selectedBtn.tag == 2){
        [self.financingBtn setTitle:[self.pickerArray objectAtIndex:row] forState:UIControlStateNormal];
        [self.financingBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];

    }
    
    
}


#pragma mark - 数据提交
-(void)rightAction{
    
    [[JMHTTPManager sharedInstance]createCompanyWithCompany_name:kFetchMyDefault(@"company_name") company_position:kFetchMyDefault(@"company_position") nickname:nil avatar:nil enterprise_step:@"3" abbreviation:self.abbreviationTextField.text logo_path:nil video_path:nil work_time:nil work_week:nil type_label_id:nil industry_label_id:@"1" financing:nil employee:self.employeeBtn.titleLabel.text      city_id:nil address:nil url:nil longitude:nil latitude:nil description:nil image_path:nil label_id:nil subway:nil line:nil station:nil corporate:nil reg_capital:nil reg_date:nil reg_address:nil unified_credit_code:nil business_scope:nil license_path:nil status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMUserInfoManager saveUserInfo:userInfo];
    
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
            JMUploadLicenseViewController *vc = [[JMUploadLicenseViewController alloc]init];
      
            [self.navigationController pushViewController:vc animated:YES];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {


    }];



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

    self.pickerView.hidden = YES;

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
    [[JMHTTPManager sharedInstance]uploadsImageWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        _imageUrl = array[0];
        
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
