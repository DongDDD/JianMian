//
//  JMBUserInfoViewController.m
//  JMian
//
//  Created by mac on 2019/5/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserInfoViewController.h"
#import "JMUserInfoModel.h"
#import "JMUserInfoManager.h"
#import "JMHTTPManager+Uploads.h"
#import "JMHTTPManager+UpdateInfo.h"
#import "JMHTTPManager+Login.h"


@interface JMBUserInfoViewController ()<UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (nonatomic, copy) NSString *imagUrl;
@property (weak, nonatomic) IBOutlet UITextField *positionText;

@end

@implementation JMBUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基本信息";
    [self setRightBtnTextName:@"保存"];
    [self getUserInfo];
    // Do any additional setup after loading the view from its nib.
}

-(void)getUserInfo{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        self.nameText.text = userModel.nickname;
        self.positionText.text = userModel.company_position;
        NSURL *url = [NSURL URLWithString:userModel.avatar];
        [self.headerImg sd_setImageWithURL:url];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
- (IBAction)headerAction:(UIButton *)sender {


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
            
            _imagUrl = responsObject[@"data"][0];
        }
   
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)rightAction{
    [self.nameText resignFirstResponder];
    [self.positionText resignFirstResponder];
    [[JMHTTPManager sharedInstance]updateUserInfoWithCompany_position:_positionText.text type:@2 password:nil avatar:_imagUrl nickname:self.nameText.text email:nil name:self.nameText.text sex:nil ethnic:nil birthday:nil address:nil number:nil image_front:nil image_behind:nil user_step:nil enterprise_step:nil real_status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
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
