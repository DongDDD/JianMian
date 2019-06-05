//
//  JMCompanyInfoMineViewController.m
//  JMian
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyInfoMineViewController.h"
#import "JMHTTPManager+FetchCompanyInfo.h"
#import "JMCompanyInfoModel.h"
#import "JMHTTPManager+Uploads.h"
#import "JMCompanyDesciptionOfMineViewController.h"
#import "JMHTTPManager+CompanyInfoUpdate.h"
#import "DimensMacros.h"
#import "JMMyPictureViewController.h"
#import "Demo3ViewController.h"
#import "JMVideoPlayManager.h"
#import "JMHTTPManager+Uploads.h"


@interface JMCompanyInfoMineViewController ()<UIImagePickerControllerDelegate,UIPickerViewDelegate,JMCompanyDesciptionOfMineViewDelegate,Demo3ViewControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic,strong)JMCompanyInfoModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *videoImg;
@property(nonatomic,copy) NSString *videoURL;
@property(nonatomic,copy) NSString *imgURL;



@property (weak, nonatomic) IBOutlet UILabel *companyNameLab;
@property (nonatomic, strong) NSMutableArray *addImage_paths;//公司图片数组
@property (nonatomic, strong) NSMutableArray *filesModelArray;//用来提取公司图片的数组


@property (weak, nonatomic) IBOutlet UITextField *myPositionTextField;
@property (weak, nonatomic) IBOutlet UIButton *companyAdress;
@property (weak, nonatomic) IBOutlet UIButton *companyDecriptionBtn;
@property (weak, nonatomic) IBOutlet UILabel *abbrLab;
@property (weak, nonatomic) IBOutlet UIButton *industryBtn;
@property (weak, nonatomic) IBOutlet UIButton *employBtn;
@property (weak, nonatomic) IBOutlet UIButton *facingBtn;
@property (weak, nonatomic) IBOutlet UIView *facingView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property(nonatomic,strong) NSArray *pickerArray;
@property (nonatomic,strong)UIButton *selectedBtn;
@property (nonatomic, assign)NSUInteger pickerRow;
@property (weak, nonatomic) IBOutlet UIView *pickerBGView;

@property(nonatomic,strong)JMUserInfoModel *userInfoModel;

@property(nonatomic,assign)BOOL isChange;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property(nonatomic,assign)BOOL isVideoChange;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation JMCompanyInfoMineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"公司信息";
    [self getData];
    self.pickerView.delegate = self;
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerImgAction)];
    [self.topView addGestureRecognizer:tap];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.facingView.frame.origin.y+self.facingView.frame.size.height+50);
    
    
    
}



-(void)getData{
    _userInfoModel = [JMUserInfoManager getUserInfo];
    [self.progressHUD setHidden:NO];
    [[JMHTTPManager sharedInstance]fetchCompanyInfo_Id:_userInfoModel.company_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.model = [JMCompanyInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            
            [self initView];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


-(void)updateInfoData{
 
    [self.progressHUD setHidden:NO];
    [[JMHTTPManager sharedInstance]updateCompanyInfo_Id:_userInfoModel.company_id company_name:nil nickname:nil abbreviation:nil logo_path:_imgURL video_path:self.videoURL work_time:nil work_week:nil type_label_id:nil industry_label_id:nil financing:self.facingBtn.titleLabel.text employee:self.employBtn.titleLabel.text address:nil url:nil longitude:nil latitude:nil description:self.companyDecriptionBtn.titleLabel.text image_path:self.addImage_paths label_id:nil subway:nil corporate:nil reg_capital:nil reg_date:nil reg_address:nil unified_credit_code:nil business_scope:nil license_path:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"公司信息更新成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        if (_isVideoChange) {
            
            [self getData];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
    
}



//赋值
-(void)initView{
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:self.model.logo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.companyNameLab.text = self.model.company_name;
    //公司图片赋值
   //获取视频路径
    self.videoURL = [self getVideoPath];
    if (self.videoURL != nil) {
        NSURL *URL = [NSURL URLWithString:self.videoURL];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            UIImage *image = [self thumbnailImageForVideo:URL atTime:1];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.videoImg.image = image;
                //    self.headerView.playBtn.hidden = NO;
                
            });
        });
        
    }else{
        [self.playBtn setHidden:YES];
        self.videoImg.image = [UIImage imageNamed:@"break"];
        [self.leftBtn setTitle:@"拍摄视频" forState:UIControlStateNormal];
         [self.rightBtn setTitle:@"上传视频" forState:UIControlStateNormal];
    }
   
    [self.industryBtn setTitle:self.model.industry_name forState:UIControlStateNormal];
    [self.employBtn setTitle:self.model.employee forState:UIControlStateNormal];
    [self.facingBtn setTitle:self.model.financing forState:UIControlStateNormal];
    self.abbrLab.text = self.model.abbreviation;
    self.companyDecriptionBtn.titleLabel.text = self.model.comDescription;
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.facingView.frame.origin.y+self.facingView.frame.size.height);
    
    [self.progressHUD setHidden:YES];

}

-(NSString *)getVideoPath{
    if (self.model.files.count > 0) {
        for (JMFilesModel *filesModel in self.model.files) {
            if ([filesModel.files_type isEqualToString:@"1"]) {
                return filesModel.files_file_path;
            }
        }
    }
    return nil;
}
#pragma mark - 点击事件
//- 保存资料
-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
    if(_isChange){
        _videoURL = nil;//不用上传视频了，选择完视频就上传完了
        [self updateInfoData];
    }
}


- (IBAction)videoLeftAction:(UIButton *)sender {
    [self filmVideo];
}

- (IBAction)videoRightAction:(UIButton *)sender {
    
    [self uploadVideo];
}
- (IBAction)chooseCompanyAdress:(UIButton *)sender {
    
    
    
}

//上传公司图片
- (IBAction)upLoadPicture:(UIButton *)sender {
    

//    JMMyPictureViewController *vc = [[JMMyPictureViewController alloc]init];
//
//    vc.delegate = self;
//    [self.navigationController pushViewController:vc animated:YES];
    
    Demo3ViewController *vc = [[Demo3ViewController alloc]init];
    vc.viewType = Demo3ViewDefault;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//JMMyPictureViewControllerDelegate
-(void)sendArray_image_paths:(NSMutableArray *)image_paths{
    //增加了图片上传
    if (image_paths.count > 0) {
        if (image_paths != self.addImage_paths) {
            _isChange = YES;
            self.addImage_paths = [NSMutableArray array];
            self.addImage_paths = image_paths;

        }
    }
}

- (IBAction)companyDescriptionAction:(UIButton *)sender {
    
    JMCompanyDesciptionOfMineViewController *vc = [[JMCompanyDesciptionOfMineViewController alloc]init];
    
    vc.delegate = self;
    vc.comDesc = self.companyDecriptionBtn.titleLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)sendTextView_textData:(NSString *)textData{
    if (![self.companyDecriptionBtn.titleLabel.text isEqualToString:textData]) {
        if (![self.companyDecriptionBtn.titleLabel.text isEqualToString:textData]) {
            self.isChange = YES;
            [self.companyDecriptionBtn setTitle:textData forState:UIControlStateNormal];
        }
        
    }
    
    
}

- (IBAction)playAction:(UIButton *)sender {
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:self.videoURL];
    [[JMVideoPlayManager sharedInstance] play];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:playVC animated:NO];

    
}

- (IBAction)industryAction:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"公司行业暂时不提供修改功能"
                                                  delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)employeeAction:(UIButton *)sender {
    [self.pickerBGView setHidden:NO];
    self.pickerArray = [NSArray arrayWithObjects:@"15人以下",@"15～50人",@"50～100人",@"500人以上",nil];
    [self.pickerView reloadAllComponents];
    self.selectedBtn = sender;
}


- (IBAction)financingStep:(UIButton *)sender {
    [self.pickerBGView setHidden:NO];
    self.pickerArray = [NSArray arrayWithObjects:@"天使轮",@"A轮",@"B轮",@"C轮",@"D轮",@"不需要融资",nil];
    [self.pickerView reloadAllComponents];
    self.selectedBtn = sender;
    
}

- (IBAction)pickerOKAction:(UIButton *)sender {
    
    _isChange = YES;
    switch (_selectedBtn.tag) {
        case 1:
            [self.employBtn setTitle:self.pickerArray[_pickerRow] forState:UIControlStateNormal];
            [self.employBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
            break;
            
        case 2:
            [self.facingBtn setTitle:self.pickerArray[_pickerRow] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    [self.pickerBGView setHidden:YES];
    
}

- (IBAction)pickerViewDeleteAction:(id)sender {
    [self.pickerBGView setHidden:YES];
}


#pragma mark - pickerViewDelegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _pickerRow = row;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}

//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    return [self.pickerArray count];
    
}
//
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [self.pickerArray objectAtIndex:row];
    
    return str;
    
}

#pragma mark - 获取图片


- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

#pragma mark - 上传图片

- (void)headerImgAction {
    
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
#pragma mark - image picker delegte - 处理视频/图片

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //应该在提交成功后再保存到沙盒，下次进来直接去沙盒路径取
    if (image) {
        
        // 保存图片至本地，方法见下文
        [self saveImage:image withName:@"currentImage.png"];
        //读取路径进行上传
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
        
        //图片赋值显示
        self.headerImg.image = savedImage;
    }else{
        
        //会以MOV格式存储在tmp目录下
        NSURL *source = [info objectForKey:UIImagePickerControllerMediaURL];
        //计算视频大小
        CGFloat length = [self getVideoLength:source];
        CGFloat size = [self getFileSize:[source path]];
        NSLog(@"视频的时长为%lf s \n 视频的大小为%.2f M",length,size);
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self.progressHUD setHidden:NO];
        // 将图片写入文件
        
        //        压缩
        [self compressVideo:source];
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
            _imgURL = responsObject[@"data"][0];
            
        }
        
        
        //        if(responsObject[@"data"]){
        //            NSArray *urlArray = responsObject[@"data"];
        //            _imageUrl = urlArray[0];
        //        }
        
        
        _isChange = YES;
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

#pragma mark - 上传视频

-(void)uploadVideo{
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    //    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    //    if (availableMedia.count) {
    //        ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    //    }
    ipc.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.delegate = self;//设置委托
    
    
    
}


-(void)filmVideo{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //检测是否开通权限
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂无拍摄视频权限" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    //使用UIImagePickerController视频录制
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    //mediaTypes设置摄影还是拍照
    //kUTTypeImage 对应拍照
    //kUTTypeMovie  对应摄像
    //    NSString *requiredMediaType = ( NSString *)kUTTypeImage;
    NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
    NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType1,nil];
    picker.mediaTypes = arrMediaTypes;
    //    picker.videoQuality = UIImagePickerControllerQualityTypeHigh;默认是中等
    picker.videoMaximumDuration = 60.; //60秒
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
    
}



/**
 获取文件大小
 
 @param path 路径
 @return M
 */
- (CGFloat)getFileSize:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}


/**
 获取视频时长
 
 @param url url
 @return s
 */
- (CGFloat)getVideoLength:(NSURL *)url{
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:url];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}


/**
 视频压缩
 */
- (void)compressVideo:(NSURL *)url{
    
    NSURL *newVideoUrl ; //一般.mp4
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    
    newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉，减少空间。

    [self convertVideoQuailtyWithInputURL:url outputURL:newVideoUrl completeHandler:nil];
    
}


-(void)fetchmyVideo{
    
    NSString * path = [NSString stringWithFormat:@"%@", self.videoURL ];
    //直接创建AVPlayer，它内部也是先创建AVPlayerItem，这个只是快捷方法
    //        AVPlayer *player = [AVPlayer playerWithURL:url];
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:path];
    [[JMVideoPlayManager sharedInstance] play];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:playVC animated:NO];
    
    
    
}

/**
 压缩完成调用上传
 
 @param inputURL 输入url
 @param outputURL 输出url
 @param handler AVAssetExportSession转码
 */
- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:{
                 //                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 //UISaveVideoAtPathToSavedPhotosAlbum([outputURL path], self, nil, NULL);//这个是保存到手机相册
                 
                 dispatch_async(dispatch_get_global_queue(0, 0), ^{
                     CGFloat length = [self getVideoLength:outputURL];
                     CGFloat size = [self getFileSize:[outputURL path]];
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         //                         self.bottomLab.text = [NSString stringWithFormat:@"%.2f s, 压缩后大小为：%.2f M",length,size];
                         NSLog(@"%.2f s %.2f M",length,size);
                         [self centerFrameImageWithVideoURL:outputURL completion:^(UIImage *image) {
                             self.videoImg.image = image;
                             
                         }];
                     });
                 });
                 
                 
                 //                 __weak __typeof(self) weakSelf = self;
                 // Get center frame image asyncly
                 
//                 self.finalURL = outputURL;
                 [self uploadVideo:outputURL];
             }
                 
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
    
}



#pragma mark - 异步获取帧图片

// 异步获取帧图片，可以一次获取多帧图片
- (void)centerFrameImageWithVideoURL:(NSURL *)videoURL completion:(void (^)(UIImage *image))completion {
    //    NSString *str = @"https://jmsp-1258537318.cos.ap-guangzhou.myqcloud.com/storage/images/2019/05/14/CQhHejm8wgtV9HK1uBjjJiwmp1knQdpmAvtcKP3X.mp4";
    //
    //    NSURL *URL = [NSURL URLWithString:str];
    //    // AVAssetImageGenerator
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    
    // calculate the midpoint time of video
    Float64 duration = CMTimeGetSeconds([asset duration]);
    // 取某个帧的时间，参数一表示哪个时间（秒），参数二表示每秒多少帧
    // 通常来说，600是一个常用的公共参数，苹果有说明:
    // 24 frames per second (fps) for film, 30 fps for NTSC (used for TV in North America and
    // Japan), and 25 fps for PAL (used for TV in Europe).
    // Using a timescale of 600, you can exactly represent any number of frames in these systems
    CMTime midpoint = CMTimeMakeWithSeconds(duration / 2.0, 600);
    
    // 异步获取多帧图片
    NSValue *midTime = [NSValue valueWithCMTime:midpoint];
    [imageGenerator generateCGImagesAsynchronouslyForTimes:@[midTime] completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        if (result == AVAssetImageGeneratorSucceeded && image != NULL) {
            UIImage *centerFrameImage = [[UIImage alloc] initWithCGImage:image];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(centerFrameImage);
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(nil);
                }
            });
        }
    }];
}
#pragma mark -同步获取帧图片
// Get the video's center frame as video poster image
- (UIImage *)frameImageFromVideoURL:(NSURL *)videoURL {
    // result
    UIImage *image = nil;
    
    // AVAssetImageGenerator
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    
    // calculate the midpoint time of video
    Float64 duration = CMTimeGetSeconds([asset duration]);
    // 取某个帧的时间，参数一表示哪个时间（秒），参数二表示每秒多少帧
    // 通常来说，600是一个常用的公共参数，苹果有说明:
    // 24 frames per second (fps) for film, 30 fps for NTSC (used for TV in North America and
    // Japan), and 25 fps for PAL (used for TV in Europe).
    // Using a timescale of 600, you can exactly represent any number of frames in these systems
    CMTime midpoint = CMTimeMakeWithSeconds(duration / 2.0, 600);
    
    // get the image from
    NSError *error = nil;
    CMTime actualTime;
    // Returns a CFRetained CGImageRef for an asset at or near the specified time.
    // So we should mannully release it
    CGImageRef centerFrameImage = [imageGenerator copyCGImageAtTime:midpoint
                                                         actualTime:&actualTime
                                                              error:&error];
    
    if (centerFrameImage != NULL) {
        image = [[UIImage alloc] initWithCGImage:centerFrameImage];
        // Release the CFRetained image
        CGImageRelease(centerFrameImage);
    }
    
    return image;
}



//清除documents中.mp4视频
-(void)clearMovieFromDoucments{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [self clearFiles:documentsDirectory];
}

//清除tmp中.mov
- (void)clearMovFromTmp{
    NSString *tempDirectory = NSTemporaryDirectory();  //tmp目录缓存了转化之前的mov
    [self clearFiles:tempDirectory];
}

- (void)clearFiles:(NSString *)directory{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:directory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        NSLog(@"%@",filename);
        if ([filename isEqualToString:@"tmp.PNG"]) {
            NSLog(@"删除%@",filename);
            [fileManager removeItemAtPath:[directory stringByAppendingPathComponent:filename] error:NULL];
            continue;
        }
        if ([[[filename pathExtension] lowercaseString] isEqualToString:@"mp4"]||
            [[[filename pathExtension] lowercaseString] isEqualToString:@"mov"]||
            [[[filename pathExtension] lowercaseString] isEqualToString:@"png"]) {
            NSLog(@"删除%@",filename);
            [fileManager removeItemAtPath:[directory stringByAppendingPathComponent:filename] error:NULL];
        }
    }
}



/*
**
视频上传

@param url url
*/
- (void)uploadVideo:(NSURL *)url{
    //        上传data

    NSArray *array = @[url];
    [[JMHTTPManager sharedInstance]uploadsWithMP4Files:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            //            _imageUrl = responsObject[@"data"][0];
            NSLog(@"%@",responsObject[@"data"][0]);
            NSString *url = responsObject[@"data"][0];
            NSLog(@"urlurlurlurl--%@",url);
//            kSaveMyDefault(@"videoPath", url);
            self.videoURL = url;
            _isVideoChange = YES;
     
            [self updateInfoData];
            
//            [[JMHTTPManager sharedInstance]updateVitaWith_work_status:nil education:nil work_start_date:nil description:nil video_path:url image_paths:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"视频上传成功！" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//                [alert addAction:cancel];
//                [self presentViewController:alert animated:YES completion:nil];
//                //                    kSaveMyDefault(@"videoImg",self.didUploadVideoView.imgView);
//                [self.progressHUD setHidden:YES];
//
//
//            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//            }];
            
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //    上传成功可以选择删除
    //        [[NSFileManager defaultManager] removeItemAtPath:[url path] error:nil];
    
    
}


#pragma mark - lazy

- (NSMutableArray *)filesModelArray {
    if (!_filesModelArray) {
        _filesModelArray = [NSMutableArray array];
    }
    return _filesModelArray;
}

-(MBProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.progress = 0.6;
        _progressHUD.dimBackground = YES; //设置有遮罩
        [_progressHUD showAnimated:NO]; //显示进度框
        [_progressHUD setHidden:YES];
        [self.view addSubview:_progressHUD];
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
