//
//  JMBUserPostPositionViewController.m
//  JMian
//
//  Created by mac on 2019/6/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserPostSaleJobViewController.h"
#import "JMBUserPostPositionTableViewCell.h"
#import "JMBUserPositionDetailView.h"
#import "JMBUserPositionVideoView.h"
#import "Demo3ViewController.h"
#import "JMComfirmPostBottomView.h"
#import "JMCityListViewController.h"
#import "JMIndustryWebViewController.h"
#import "JMPartTimeJobTypeLabsViewController.h"
#import "JMHTTPManager+CreateTask.h"
#import "JMGoodsDescriptionViewController.h"
#import "JMVideoPlayManager.h"
#import "JMHTTPManager+Uploads.h"
#import "JMHTTPManager+FectchTaskInfo.h"
#import "JMTaskGoodsDetailModel.h"
#import "JMTaskPartTimejobDetailModel.h"
#import "JMHTTPManager+UpdateTask.h"
#import "JMHTTPManager+DeleteTask.h"
#import "JMHTTPManager+DeleteGoodsImage.h"
#import "JMPostGoodsImagesView.h"

#define RightTITLE_COLOR [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]

@interface JMBUserPostSaleJobViewController ()<JMBUserPositionDetailViewDelegate,JMCityListViewControllerDelegate,JMIndustryWebViewControllerDelegate,JMPartTimeJobTypeLabsViewControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,JMComfirmPostBottomViewDelegate,UIScrollViewDelegate,JMGoodsDescriptionViewControllerDelegate,JMBUserPositionVideoViewDelegate,UIImagePickerControllerDelegate,JMPostGoodsImagesViewDelegate,Demo3ViewControllerDelegate,UITextFieldDelegate>

@property (strong, nonatomic)UIScrollView *scrollView;

@property (strong, nonatomic)JMBUserPositionDetailView *detailView;
@property (strong, nonatomic)JMBUserPositionVideoView *videoView;
@property (strong, nonatomic)Demo3ViewController *demo3ViewVC;
@property (strong, nonatomic)JMPostGoodsImagesView *postGoodsImagesView;
@property (strong, nonatomic)JMComfirmPostBottomView *comfirmPostBottomView;
@property (nonatomic,strong)NSArray *quantityArray;
@property (nonatomic,strong)NSMutableArray *imageDataArr;;
@property (nonatomic,strong)UIDatePicker *dataPickerView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic ,assign)BOOL isChange;
@property (weak, nonatomic) IBOutlet UIButton *bottomLeftBtn;
@property (nonatomic, strong)JMTaskPartTimejobDetailModel *partTimeModel;

//---请求参数-------------------------------------------
@property (copy, nonatomic)NSString *task_title;//职位名称***
@property (copy, nonatomic)NSString *unit;//计价单位***
@property (copy, nonatomic)NSString *payment_money;//任务金额***
@property (copy, nonatomic)NSString *quantity_max;//招募人数***
@property (copy, nonatomic)NSMutableArray *industry_arr;//适合行业***
@property (copy, nonatomic)NSString *city_id;//地区***

@property (copy, nonatomic)NSString *goods_title;//商品标题
@property (copy, nonatomic)NSString *goods_price;//商品价格
@property (copy, nonatomic)NSString *goods_desc;//产品描述

@property (copy, nonatomic)NSString *deadline;//有效日期***
@property (copy, nonatomic)NSString *longitude;//经度
@property (copy, nonatomic)NSString *latitude;//纬度
@property (copy, nonatomic)NSString *address;//地址

@property (copy, nonatomic)NSString *video_path;
@property (copy, nonatomic)NSString *video_cover;
@property (copy, nonatomic)NSMutableArray *image_arr;

//--------------------------------------------------
@property (copy, nonatomic)NSString *cityName;//地区
@property (nonatomic,copy)NSString *labsJson;
@property (assign, nonatomic)BOOL isReadProtocol;//是否阅读了协议

@end
static NSString *cellIdent = @"BUserPostPositionCell";

@implementation JMBUserPostSaleJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
    [self initLayout];
    if (_viewType == JMBUserPostSaleJobViewTypeEdit) {
        [self setRightBtnTextName:@"删除"];
        self.title = @"编辑网络销售职位";
    }else if (_viewType == JMBUserPostSaleJobViewTypeAdd) {
        self.title = @"发布网络销售职位";
    
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePickView)];
    [self.view addGestureRecognizer:tap];
  
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.videoView layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.comfirmPostBottomView.frame.origin.y+self.comfirmPostBottomView.frame.size.height+100);
}

-(void)initView{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.detailView];
    [self.scrollView addSubview:self.videoView];
    [self.scrollView addSubview:self.postGoodsImagesView];
//    [self.scrollView addSubview:self.demo3ViewVC.view];
    [self.scrollView addSubview:self.comfirmPostBottomView];
    
    
    //编辑模式
    if (_viewType == JMBUserPostSaleJobViewTypeEdit) {
        //获取
        [self getData];
        self.bottomView.hidden = NO;
        [self.view addSubview:self.bottomView];
        [self.comfirmPostBottomView setHidden:YES];
    }
    
   
}

-(void)initLayout{

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.scrollView.mas_top);
        make.height.mas_equalTo(357);
    }];
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.detailView.mas_bottom).mas_offset(1);
        make.height.mas_equalTo(304);
    }];
//    self.demo3ViewVC.view.backgroundColor = [UIColor redColor];
//    [self.demo3ViewVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.videoView.mas_bottom).mas_offset(1);
//        make.height.mas_equalTo(408);
//    }];
    
    [self.postGoodsImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.videoView.mas_bottom).mas_offset(1);
        make.height.mas_equalTo(86);
    }];
    [self.comfirmPostBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.postGoodsImagesView.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(127);
    }];
    
}
#pragma mark - textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - myDelegate

- (void)sendlabsWithJson:(nonnull NSString *)json {
    _isChange = YES;
    self.labsJson = json;
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arrayData = [self toArrayOrNSDictionary:data];
    NSLog(@"arrayData%@",arrayData);
    NSMutableArray *arrayName = [NSMutableArray array];//用于展示给用户
    _industry_arr = [NSMutableArray array];//用于提交服务器
    
    for (NSDictionary *dic in arrayData) {
        [arrayName addObject:dic[@"name"]];
        [_industry_arr addObject:dic[@"label_id"]];
    }
    NSLog(@"_industry_arr%@",_industry_arr);
    NSString *rightStr = [arrayName componentsJoinedByString:@","];
    [self.detailView.industryBtn setTitle:rightStr forState:UIControlStateNormal];
    [self.detailView.industryBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
    NSLog(@"_industry_arr%@",rightStr);
    
}

- (void)didSelectedCity_id:(nonnull NSString *)city_id city_name:(nonnull NSString *)city_name {
    _isChange = YES;
    _city_id = city_id;
    [self.detailView.cityBtn setTitle:city_name forState:UIControlStateNormal];
    [self.detailView.cityBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
}

-(void)didClickRightBtnWithTag:(NSInteger)tag{
 
    switch (tag) {
        case 1000:// 发布城市
            [self gotoCityListVC];
            break;
        case 1001:// 任务有效期
            [self showDataPickView];
            break;
        case 1002:// 适合行业
            [self gotoIndustryVC];
            break;
        case 1003:// 产品描述
            [self gotoGoodsdescVC];
            break;
        default:
            break;
    }
}

-(void)didWriteTextFieldWithTag:(NSInteger)tag text:(NSString *)text{
    _isChange = YES;
    switch (tag) {
        case 100:// 职位名称
            _task_title = text;
            break;
        case 101:// 佣金/每单
            _payment_money = text;
            break;
        case 102:// 招募人数
            _quantity_max = text;
            break;
        default:
            break;
    }

}


-(void)didWriteGoodsDescWithGoodsName:(NSString *)goodsName price:(NSString *)price goodsDetaolInfo:(NSString *)goodsDetaolInfo{
    _isChange = YES;
    _goods_title = goodsName;
    _goods_price = price;
    _goods_desc = goodsDetaolInfo;
    [self.detailView.goodsDescrptionBtn setTitle:@"已完善" forState:UIControlStateNormal];
    [self.detailView.goodsDescrptionBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];

}


- (void)sendArray_addImageUrls:(NSMutableArray *)addImageUrls {
    
    self.image_arr = addImageUrls;
    NSLog(@"addImageUrls%@",addImageUrls);
    [self.postGoodsImagesView.goodsImageBtn setTitle:@"已上传" forState:UIControlStateNormal];
    [self.postGoodsImagesView.goodsImageBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
}

//添加的图片
-(void)sendAddImgs:(NSMutableArray *)Imgs{
    [self updateTaskImagesRequest_images:Imgs.mutableCopy];
//    [self uploadCompanyWithImages:Imgs.mutableCopy];
}

//删除图片
-(void)deleteSalePositionImageWithIndex:(NSInteger)index{
    if (self.imageDataArr.count > 0) {
        JMImageModel *model = self.imageDataArr[index];
        if (index < self.imageDataArr.count) {
            [self deleteGoodsImageRequsetWithFile_id:model.file_id];
            [self.imageDataArr removeObject:model];
            //        [self.image_arr.mutableCopy removeObjectAtIndex:index];
        }

    }
}

-(void)gotoLabsVC{
    JMPartTimeJobTypeLabsViewController *vc =  [[JMPartTimeJobTypeLabsViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoIndustryVC{
    JMIndustryWebViewController *vc =  [[JMIndustryWebViewController alloc]init];
    vc.delegate = self;
    vc.labsJson = self.labsJson;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)gotoCityListVC{
    JMCityListViewController *vc =  [[JMCityListViewController alloc]init];
    vc.delegate = self;
    vc.viewType = JMCityListViewPartTime;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoGoodsdescVC{
    JMGoodsDescriptionViewController *vc =  [[JMGoodsDescriptionViewController alloc]init];
    vc.delegate = self;
    [vc setGoods_desc:_goods_desc];
    vc.goods_price = _goods_price;
    vc.goods_title = _goods_title;
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)gotoUploadImageAction{
 
    _demo3ViewVC = [[Demo3ViewController alloc]init];
    _demo3ViewVC.delegate = self;
    if (_viewType == JMBUserPostSaleJobViewTypeEdit) {
        //编辑状态
        _demo3ViewVC.task_id = self.task_id;//进入界面重新调用接口获得最新图片
        _demo3ViewVC.viewType = Demo3ViewPostGoodsPositionEdit;

    }else if (_viewType == JMBUserPostSaleJobViewTypeAdd) {
        //添加状态
        _demo3ViewVC.viewType = Demo3ViewPostGoodsPositionAdd;
    
    }
    if (_image_arr.count > 0) {
        //选好的图片_image_arr
        _demo3ViewVC.image_paths = _image_arr.mutableCopy;
    }
    [self.navigationController pushViewController:_demo3ViewVC animated:YES];
 
   

}

-(void)showDataPickView{
    [self.view addSubview:self.dataPickerView];
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.dataPickerView.frame = CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350);
    } completion:nil];
    
    
}

-(void)hidePickView{
    
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.dataPickerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350);
    } completion:nil];
    

}

- (void)dateChange:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    _deadline = dateStr;
    [self.detailView.deadLineBtn setTitle:dateStr forState:UIControlStateNormal];
    [self.detailView.deadLineBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
}



-(void)isReadProtocol:(BOOL)isRead{
    if (!isRead) {
        [self.comfirmPostBottomView.OKBtn setBackgroundColor:TEXT_GRAY_COLOR];
        self.isReadProtocol = NO;
        
    }else{
        [self.comfirmPostBottomView.OKBtn setBackgroundColor:MASTER_COLOR];
        self.isReadProtocol = YES;
    }

}

#pragma mark - 视频



-(void)videoLeftBtnAction{
    [self filmVideo];
}

-(void)videoRightBtnAction{
    [self uploadVideo];

}

-(void)playBtnAction{
    [self fetchmyVideo];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //应该在提交成功后再保存到沙盒，下次进来直接去沙盒路径取
    if (image) {
        
       
    }else{
        
        //会以MOV格式存储在tmp目录下
        NSURL *source = [info objectForKey:UIImagePickerControllerMediaURL];
        //计算视频大小
        CGFloat length = [self getVideoLength:source];
        CGFloat size = [self getFileSize:[source path]];
        NSLog(@"视频的时长为%lf s \n 视频的大小为%.2f M",length,size);
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        // 将图片写入文件
        [self showProgressHUD_view:self.view];
        //        压缩
        [self compressVideo:source];
    }
    
}


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
    NSString * path;
    if (![self.video_path containsString:@"https://jmsp-videos"]) {
        path = [NSString stringWithFormat:@"https://jmsp-videos-1257721067.cos.ap-guangzhou.myqcloud.com%@",self.video_path];
    }else{
        path = self.video_path;

    }
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
                             self.videoView.videoImg.image = image;
                             if (image) {
                                 [_videoView.playBtn setHidden:NO];
                                 [_videoView.videoLeftBtn setTitle:@"重新拍摄" forState:UIControlStateNormal];
                                 [_videoView.videoRightBtn setTitle:@"重新上传" forState:UIControlStateNormal];
                                 [self upload_Img:image];
                                 
                             }
                         }];
                     });
                 });
                 

                 //上传视频
                 [self uploadVideo:outputURL];
             }
                 
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
    
}

-(void)upload_Img:(UIImage *)img{
    NSArray *array = @[img];
    [[JMHTTPManager sharedInstance]uploadsWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            _video_cover = responsObject[@"data"][0];
            
        }
        
        
        //        if(responsObject[@"data"]){
        //            NSArray *urlArray = responsObject[@"data"];
        //            _imageUrl = urlArray[0];
        //        }
        
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
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

- (void)uploadVideo:(NSURL *)url{
    //        上传data
    NSArray *array = @[url];
    [[JMHTTPManager sharedInstance]uploadsWithMP4Files:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            NSLog(@"%@",responsObject[@"data"][0]);
            NSString *url = responsObject[@"data"][0];
            NSLog(@"urlurlurlurl--%@",url);
            self.video_path = url;
            _isChange = YES;
            
//            [self updateInfoData];
            [self hiddenHUD];
 
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //    上传成功可以选择删除
    //        [[NSFileManager defaultManager] removeItemAtPath:[url path] error:nil];
    
    
}

#pragma mark - 赋值
-(void)setRightBtnValues_model:(JMTaskPartTimejobDetailModel *)model{
    [self.detailView.positionNameTextField setText:model.task_title];
    [self.detailView.paymentMoneyTextField setText:model.payment_money];
    [self.detailView.cityBtn setTitle:model.cityName forState:UIControlStateNormal];
    [self.detailView.cityBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];

    [self.detailView.deadLineBtn setTitle:model.deadline forState:UIControlStateNormal];
    [self.detailView.deadLineBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];

    [self.detailView.quantityMaxTextField setText:model.quantity_max];
 
    
    NSMutableArray *industryNameArray = [NSMutableArray array];
    for (JMTaskIndustryModel *industryModel in model.industry) {
        [industryNameArray addObject:industryModel.name];
    }
    NSString *industry = [industryNameArray componentsJoinedByString:@","];
    [self.detailView.industryBtn setTitle:industry forState:UIControlStateNormal];
    [self.detailView.industryBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
    _goods_price = model.goodsPrice;
    _goods_title = model.goodsTitle;
    _goods_desc = model.goodsDescription;
    if (_goods_price && _goods_title && _goods_desc) {
        [self.detailView.goodsDescrptionBtn setTitle:@"已完善" forState:UIControlStateNormal];
        [self.detailView.goodsDescrptionBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
        
    }
    
    _video_path = model.video_file_path;
    _video_cover = model.video_cover;
    NSURL *url = [NSURL URLWithString:model.video_cover];
    [self.videoView.videoImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"NoVideos"]];
    
    if (model.images.count > 0) {
        [self.postGoodsImagesView.goodsImageBtn setTitle:@"已上传" forState:UIControlStateNormal];
        [self.postGoodsImagesView.goodsImageBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
        
        
    }
    
    if (model.video_file_path == nil) {
        self.videoView.videoImg.image = [UIImage imageNamed:@"Novideos"];
        [_videoView.videoLeftBtn setTitle:@"拍摄视频" forState:UIControlStateNormal];
        [_videoView.videoRightBtn setTitle:@"上传视频" forState:UIControlStateNormal];
        [_videoView.playBtn setHidden:YES];
    }else{
        [_videoView.videoLeftBtn setTitle:@"重新拍摄" forState:UIControlStateNormal];
        [_videoView.videoRightBtn setTitle:@"重新上传" forState:UIControlStateNormal];
        [_videoView.playBtn setHidden:NO];

    }
    
}


#pragma mark -  提交数据

-(void)rightAction{
 //删除任务
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除吗，删除后数据将不可恢复！" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteTaskRequest];

        [self.navigationController popViewControllerAnimated:YES];
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }])];
    [self presentViewController:alertController animated:YES completion:nil];



}

-(void)OKAction{
    if (self.isReadProtocol == YES) {
        [self.detailView.quantityMaxTextField resignFirstResponder];
        [self.detailView.paymentMoneyTextField resignFirstResponder];
        [self.detailView.positionNameTextField resignFirstResponder];

        if (self.task_id) {
            [self updateTaskInfoRequest_status:@"1"];//更新
        }else{
        
            [self sendRequest];//创建
        }
        
        
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请阅读并同意《平台服务协议》" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
}
//下线任务
- (IBAction)bottomLeftBtnAction:(UIButton *)sender {
    if ([_partTimeModel.status isEqualToString:Position_Online]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你要确认下线该职位吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"确认下线" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self downLineTaskInfoRequest_status:Position_Downline];
        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else if ([_partTimeModel.status isEqualToString:Position_Downline]) {
        
        [self onLineTaskInfoRequest_status:Position_Online];
        
        
    }
    


}
//保存编辑
- (IBAction)saveUpdateAction:(UIButton *)sender {
    [self.detailView.quantityMaxTextField resignFirstResponder];
    [self.detailView.paymentMoneyTextField resignFirstResponder];
    [self.detailView.positionNameTextField resignFirstResponder];
    if (_isChange) {
        //保留当前status状态，修改编辑
        [self updateTaskInfoRequest_status:_partTimeModel.status];
        
    }
}

-(void)sendRequest{
    NSMutableArray *imageArr = [NSMutableArray array];
    for (NSString *url in _image_arr) {
        if ([url containsString:@"https://jmsp-images-1257721067.picgz.myqcloud.com"]) {
            NSString *strUrl = [url stringByReplacingOccurrencesOfString:@"https://jmsp-images-1257721067.picgz.myqcloud.com" withString:@""];
            [imageArr addObject:strUrl];
            
        }
    }
    
    [[JMHTTPManager sharedInstance]createTask_task_title:_task_title type_label_id:@"1086" payment_method:@"1" unit:@"元" payment_money:_payment_money front_money:nil quantity_max:_quantity_max myDescription:_goods_desc industry_arr:_industry_arr city_id:_city_id longitude:nil latitude:nil address:nil goods_title:_goods_title goods_price:_goods_price goods_desc:_goods_desc video_path:_video_path video_cover:_video_cover image_arr:imageArr deadline:_deadline status:nil is_invoice:nil invoice_title:nil invoice_tax_number:nil invoice_email:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }])];
        [self presentViewController:alertController animated:YES completion:nil];

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}



-(void)deleteTaskRequest{
    [[JMHTTPManager sharedInstance]deleteTask_Id:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"已删除" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}


//上传图片请求
-(void)updateTaskImagesRequest_images:(NSArray *)images{
    [[JMHTTPManager sharedInstance]updateTaskWithId:self.task_id payment_method:@"1" unit:@"元" payment_money:nil front_money:nil quantity_max:nil myDescription:nil industry_arr:nil city_id:nil longitude:nil latitude:nil address:nil goods_title:nil goods_price:nil goods_desc:nil video_path:nil video_cover:nil image_arr:images is_invoice:nil invoice_title:nil invoice_tax_number:nil invoice_email:nil status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"成功添加图片" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)deleteGoodsImageRequsetWithFile_id:(NSString *)file_id{
    [[JMHTTPManager sharedInstance]deleteGoodsImageWithFile_id:file_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];


}

//更新任务请求
-(void)updateTaskInfoRequest_status:(NSString *)status{
    
//    if ([_video_path containsString:@"https://jmsp-images-1257721067.picgz.myqcloud.com"]) {
//        _video_path = [_video_path stringByReplacingOccurrencesOfString:@"https://jmsp-images-1257721067.picgz.myqcloud.com" withString:@""];
//
//    }
    //没更改
    if ([_video_path isEqualToString:_partTimeModel.video_file_path]) {
        _video_path = nil;
    }
    //没更改
    if ([_video_cover isEqualToString:_partTimeModel.video_cover]) {
        _video_cover = nil;

    }
    
        [[JMHTTPManager sharedInstance]updateTaskWithId:self.task_id payment_method:@"1" unit:@"元" payment_money:_payment_money front_money:nil quantity_max:_quantity_max myDescription:_goods_desc industry_arr:_industry_arr city_id:_city_id longitude:_longitude latitude:_latitude address:_address goods_title:_goods_title goods_price:_goods_price goods_desc:_goods_desc video_path:_video_path video_cover:_video_cover image_arr:_image_arr is_invoice:nil invoice_title:nil invoice_tax_number:nil invoice_email:nil status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }])];
            [self presentViewController:alertController animated:YES completion:nil];
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
    
}
//任务请求
-(void)downLineTaskInfoRequest_status:(NSString *)status{
    [[JMHTTPManager sharedInstance]updateTaskWithId:self.task_id payment_method:nil unit:nil payment_money:nil front_money:nil quantity_max:nil myDescription:nil industry_arr:nil city_id:nil longitude:nil latitude:nil address:nil goods_title:nil goods_price:nil goods_desc:nil video_path:nil video_cover:nil image_arr:nil is_invoice:nil invoice_title:nil invoice_tax_number:nil invoice_email:nil status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"下线成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
//重新上线任务请求
-(void)onLineTaskInfoRequest_status:(NSString *)status{
    [[JMHTTPManager sharedInstance]updateTaskWithId:self.task_id payment_method:nil unit:nil payment_money:nil front_money:nil quantity_max:nil myDescription:nil industry_arr:nil city_id:nil longitude:nil latitude:nil address:nil goods_title:nil goods_price:nil goods_desc:nil video_path:nil video_cover:nil image_arr:nil is_invoice:nil invoice_title:nil invoice_tax_number:nil invoice_email:nil status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"上线成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
#pragma mark - 获取数据
-(void)getData{
    [self showProgressHUD_view:self.view];
    [[JMHTTPManager sharedInstance]fectchTaskInfo_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            _partTimeModel = [JMTaskPartTimejobDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
            if ([_partTimeModel.status isEqualToString:Position_Downline]) {
                [self.bottomLeftBtn setTitle:@"重新上线" forState:UIControlStateNormal];

            }else if ([_partTimeModel.status isEqualToString:Position_Online]) {
                [self.bottomLeftBtn setTitle:@"下线" forState:UIControlStateNormal];

            }
            self.imageDataArr = _partTimeModel.images.mutableCopy;
            
            //赋值
            [self setRightBtnValues_model:_partTimeModel];
            
        }
        [self hiddenHUD];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];

}



#pragma mark - scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.detailView.paymentMoneyTextField resignFirstResponder];
    [self.detailView.quantityMaxTextField resignFirstResponder];
    [self.detailView.positionNameTextField resignFirstResponder];
    [self hidePickView];

}

#pragma mark - Getter
-(NSMutableArray *)image_arr{
    if (_image_arr == nil) {
        _image_arr = [NSMutableArray array];
 
    }
    return _image_arr;
}


-(JMBUserPositionDetailView *)detailView{
    if (_detailView == nil) {
        _detailView = [[JMBUserPositionDetailView alloc]init];
        _detailView.positionNameTextField.delegate = self;
        _detailView.paymentMoneyTextField.delegate = self;
        _detailView.quantityMaxTextField.delegate = self;
        _detailView.delegate = self;
        
    }
    return _detailView;
}

-(JMBUserPositionVideoView *)videoView{
    if (_videoView == nil) {
        _videoView = [[JMBUserPositionVideoView alloc]init];
        _videoView.delegate = self;
        if (!self.task_id) {
            [_videoView.videoLeftBtn setTitle:@"拍摄视频" forState:UIControlStateNormal];
            [_videoView.videoRightBtn setTitle:@"上传视频" forState:UIControlStateNormal];
        }
    }
    return _videoView;
}
//-(Demo3ViewController *)demo3ViewVC{
//    if (!_demo3ViewVC) {
//        _demo3ViewVC = [[Demo3ViewController alloc]init];
//        _demo3ViewVC.viewType = Demo3ViewPostGoodsPosition;
//        [self addChildViewController:_demo3ViewVC];
//    }
//    return _demo3ViewVC;
//}

-(JMPostGoodsImagesView *)postGoodsImagesView{
    if (!_postGoodsImagesView) {
        _postGoodsImagesView = [[JMPostGoodsImagesView alloc]init];
        _postGoodsImagesView.delegate = self;
    }
    return _postGoodsImagesView;
}


-(JMComfirmPostBottomView *)comfirmPostBottomView{
    if (_comfirmPostBottomView == nil) {
        _comfirmPostBottomView = [[JMComfirmPostBottomView alloc]init];
        _comfirmPostBottomView.delegate = self;
    }
    return _comfirmPostBottomView;
}


-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(NSMutableArray *)imageDataArr{
    if (_imageDataArr == nil) {
        _imageDataArr = [NSMutableArray array];
    }
    return _imageDataArr;

}
-(UIDatePicker *)dataPickerView{
    if (!_dataPickerView) {
        _dataPickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350)];
        _dataPickerView.backgroundColor = BG_COLOR;
        //设置地区: zh-中国
        _dataPickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        
        //设置日期模式(Displays month, day, and year depending on the locale setting)
        _dataPickerView.datePickerMode = UIDatePickerModeDate;
        // 设置当前显示时间
        [_dataPickerView setDate:[NSDate date] animated:YES];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        //        [comps setYear:0];
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        //设置最小时间为：
        [_dataPickerView setMinimumDate:minDate];
        //设置时间格式
        
        //监听DataPicker的滚动
        [_dataPickerView addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _dataPickerView;
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
