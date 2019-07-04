//
//  JMIDCardIdentifyViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMIDCardIdentifyViewController.h"
#import "JMIDCardIdentifySecondViewController.h"
#import "JMHTTPManager+Uploads.h"
#import "JMHTTPManager+IDcard.h"
#import "JMIDCardModel.h"

@interface JMIDCardIdentifyViewController ()

@property (nonatomic,copy)NSString *imageUrl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property(nonatomic,assign)BOOL isFrontImage;

@property(nonatomic,strong)NSArray *imgUrlArrl;


@property(nonatomic,strong)JMIDCardModel *IDCardModel;

@property(nonatomic,strong)NSString *imagefontUrl;
@property(nonatomic,strong)NSString *imagebehindUrl;

@end

@implementation JMIDCardIdentifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"实名认证"];
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    // Do any additional setup after loading the view from its nib.
    
  

}
- (IBAction)tapBtnAction:(UIButton *)sender {
    if (sender.tag == 0) {
        _isFrontImage = YES;
        [self getImagePickeerUI];
        
    }else if(sender.tag == 1){
        _isFrontImage = NO;
        [self getImagePickeerUI];
        
    }
}


-(void)getImagePickeerUI{

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

- (IBAction)nextAction:(id)sender {
    if (_imagefontUrl && _imagebehindUrl) {
        JMIDCardIdentifySecondViewController *vc = [[JMIDCardIdentifySecondViewController alloc]init];
        vc.image_front = _imagefontUrl;
        vc.image_behind = _imagebehindUrl;
        //    [vc setImg1:_imageView1];
        //    [vc setImg2:_imageView2];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        [self showAlertSimpleTips:@"提示" message:@"请上传身份证" btnTitle:@"好的"];
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

// 图片选择结束之后，走这个方法，字典存放所有图片信息
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //应该在提交成功后再保存到沙盒，下次进来直接去沙盒路径取
    
    // 保存图片至本地，方法见下文
    
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //读取路径进行上传
    if (_isFrontImage==YES) {
        
        _imageView1.image = savedImage;
    
    }else{

        _imageView2.image = savedImage;
    }
   
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
//            _imgUrlArrl = @[_imageUrl];
            if (_isFrontImage) {
                _imagefontUrl = _imageUrl;
            }else{
                _imagebehindUrl = _imageUrl;
            }
            
        }
        
        
        //图片赋值显示
//        if (_isImage1==YES) {
//
//            [[JMHTTPManager sharedInstance]identifyIDcardWithFiles:_imgUrlArrl card_side:@"FRONT" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
////
//////                if (responsObject[@"data"]) {
//////                    self.IDCardModel =  [JMIDCardModel mj_objectWithKeyValues:responsObject[@"data"]];
//////                    _imagefontUrl = self.IDCardModel.file_path;
//////                }
////
//            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//            }];
//
//
//        }else{
        
//            [[JMHTTPManager sharedInstance]identifyIDcardWithFiles:_imgUrlArrl card_side:@"BACK" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//
//                if (responsObject[@"data"]) {
//                    self.IDCardModel =  [JMIDCardModel mj_objectWithKeyValues:responsObject[@"data"]];
//
//                    _imagebehindUrl = self.IDCardModel.file_path;
//                }
//
//            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//            }];
            
    
//        }
        
        
        
        
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
