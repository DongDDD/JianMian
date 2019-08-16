//
//  JMUploadLicenseViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUploadLicenseViewController.h"
#import "JMChangeIdentityViewController.h"
#import "JMHTTPManager+CompanyCreate.h"
#import "JMHTTPManager+Login.h"
#import "JMHTTPManager+Uploads.h"
#import "JMUserInfoModel.h"

@interface JMUploadLicenseViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (nonatomic,copy)NSString *imageLicenseUrl;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
@property(nonatomic,strong)UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation JMUploadLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//        self.navigationController.navigationBar.translucent = NO;
//
//        self.extendedLayoutIncludesOpaqueBars = YES;
    [self setIsHiddenBackBtn:YES];
    [self getUserInfo];
    [self.scrollView addSubview:self.moreBtn];
    // Do any additional setup after loading the view from its nib.
    
}

-(void)getUserInfo{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


#pragma mark - 点击事件

- (IBAction)doneAction:(id)sender {
    
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if (_imageLicenseUrl) {
        
        [[JMHTTPManager sharedInstance]createCompanyWithCompany_name:userModel.company_real_company_name company_position:userModel.company_real_company_position nickname:nil avatar:nil enterprise_step:@"4" abbreviation:nil logo_path:nil video_path:nil work_time:nil work_week:nil type_label_id:nil industry_label_id:nil financing:nil employee:nil city_id:nil address:nil url:nil longitude:nil latitude:nil description:nil image_path:nil label_id:nil subway:nil line:nil station:nil corporate:nil reg_capital:nil reg_date:nil reg_address:nil unified_credit_code:nil business_scope:nil license_path:_imageLicenseUrl status:@"1" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
                
                JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
                [JMUserInfoManager saveUserInfo:userInfo];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功"
                                                              delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
                [alert show];
                JMChangeIdentityViewController *vc = [[JMChangeIdentityViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                
            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                
            }];
            
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
            
        }];
    }else{
        [self showAlertSimpleTips:@"提示" message:@"请选择营业执照" btnTitle:@"好的"];
    
    }
    
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
        
        imagePickerController.allowsEditing = NO;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
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
    _headerImg.image = savedImage;
    [self.cameraBtn setHidden:YES];
//    [_headerImg setImage:savedImage forState:UIControlStateNormal];

    
    
}



#pragma mark - 保存图片至沙盒 调用接口获取链接
//（应该是提交后再保存到沙盒,下次直接去沙盒取）
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSArray *array = @[currentImage];
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
    
    [[JMHTTPManager sharedInstance]uploadsWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        _imageLicenseUrl = array[0];
        if (responsObject[@"data"]) {
            
            _imageLicenseUrl = responsObject[@"data"][0];
        }
        
       
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}

-(UIButton *)moreBtn{
    if (_moreBtn == nil) {
        _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,self.doneBtn.frame.origin.y+self.doneBtn.frame.size.height+20, SCREEN_WIDTH, 40)];
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
