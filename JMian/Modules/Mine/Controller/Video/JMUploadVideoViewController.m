//
//  JMUploadVideoViewController.m
//  JMian
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUploadVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVKit/AVKit.h>
#import "JMHTTPManager+Uploads.h"
#import "JMDidUploadVideoView.h"
#import "JMHTTPManager+Vita.h"
#import "JMPlayerViewController.h"
#import "JMVideoPlayManager.h"
#import "JMVitaDetailModel.h"
#import "JMHTTPManager+UpdateAbility.h"
#import "JMHTTPManager+FectchAbilityInfo.h"
#import "JMAbilityCellData.h"
//#import "JMUserInfoModel.h"
//#import "JMUserInfoManager.h"

//#import "FMImagePicker.h"

@interface JMUploadVideoViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,JMDidUploadVideoViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *bottomLab;
@property (weak, nonatomic) IBOutlet UIImageView *FrameImageView;
@property (strong, nonatomic) AVPlayerViewController *playerVC;
@property (nonatomic, strong) NSURL *finalURL;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, copy)NSString *myVideoUrl;//用于播放，获取帧图片和回传
@property (nonatomic, copy)NSString *video_cover;//封面图片


@property (nonatomic, strong)JMDidUploadVideoView *didUploadVideoView;//有视频数据就显示
@property (nonatomic, strong)JMVitaDetailModel *model;//全职
@property (nonatomic, strong)JMAbilityCellData *partTimeJobModel;//兼职
@end

@implementation JMUploadVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频简历";
    [self.view addSubview:self.didUploadVideoView];
    [self.didUploadVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.and.bottom.mas_equalTo(self.view);
    }];
    
 
    if (_viewType == JMUploadVideoViewTypePartTimeEdit) {
        //获取兼职视频
        [self getPartTimeInfoData];
    }else if (_viewType == JMUploadVideoViewTypeJobEdit){
        //获取全职视频
        [self getJobData];
    }
   
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.bottomLab.frame.origin.y+self.bottomLab.frame.size.height+30);

}



//第二版：C端 获取个人兼职简历
-(void)getPartTimeInfoData{
    [[JMHTTPManager sharedInstance]fectchAbilityDetailInfo_Id:self.ability_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.partTimeJobModel = [JMAbilityCellData mj_objectWithKeyValues:responsObject[@"data"]];
            if (self.partTimeJobModel.video_file_path!=nil) {
                //用于回传和播放
                [self setVideoUrl:self.partTimeJobModel.video_file_path];

//                _myVideoUrl = self.partTimeJobModel.video_file_path;
                [self.didUploadVideoView setHidden:NO];
                
                NSURL *url = [NSURL URLWithString:self.partTimeJobModel.video_file_path];
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self centerFrameImageWithVideoURL:url completion:^(UIImage *image) {
                            self.didUploadVideoView.imgView.image = image;
                            
                        }];
                    });
                });
                
            }
            
            
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


//第一版：C端 获取个人全职简历
-(void)getJobData{
   
        //        int jobId = [responsObject[@"data"][0][@"user_job_id"] intValue];
        [[JMHTTPManager sharedInstance] fetchVitaInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            if (responsObject[@"data"]) {
                self.model = [JMVitaDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
                if (self.model.video_file_path!=nil) {
                    //拼接前缀 用于播放
                    [self setVideoUrl:self.model.video_file_path];
                    [self.didUploadVideoView setHidden:NO];
                    if ([self.model.video_status isEqualToString:@"0"]) {
                        self.title = @"视频审核中";
                        [_didUploadVideoView.leftBtn setHidden:YES];
                        [_didUploadVideoView.rightBtn setHidden:YES];
                        
                    }else if ([self.model.video_status isEqualToString:@"1"]){
                        self.title = @"视频审核不通过";
                        [_didUploadVideoView.leftBtn setHidden:YES];
                        [_didUploadVideoView.rightBtn setHidden:YES];
                    }else if ([self.model.video_status isEqualToString:@"2"]){
                        self.title = @"视频审核已通过";
   
                    }
                    
                    NSURL *url = [NSURL URLWithString:self.model.video_file_path];
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [self centerFrameImageWithVideoURL:url completion:^(UIImage *image) {
                                self.didUploadVideoView.imgView.image = image;
                                
                            }];
                        });
                    });

                }
                
                
            }
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
  
    

}

#pragma mark - 点击事件
-(void)fanhui{
    [super fanhui];
    if (_delegate && [_delegate respondsToSelector:@selector(didPostVideoWithUrl:video_cover:)]) {
        [_delegate didPostVideoWithUrl:self.myVideoUrl video_cover:_video_cover];
    }
}

//选择视频上传
- (IBAction)chooseVideoFromPhoto:(UIButton *)sender {
//    FMImagePicker *picker = [[FMImagePicker alloc] init];
//    [self presentViewController:picker animated:YES completion:nil];
    [self uploadVideo];
}

/**
 视频录制
 
 @param sender btn
 */
- (IBAction)recordVideo:(id)sender {
    [self filmVideo];
}
//重新上传
-(void)leftAction{
    [self uploadVideo];

    
}
//重新拍摄
-(void)rightAction{
    [self filmVideo];


}
-(void)playAction{
    
    [self fetchmyVideo];

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

#pragma mark - 处理视频

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image) {
        //        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        
        //会以MOV格式存储在tmp目录下
        NSURL *source = [info objectForKey:UIImagePickerControllerMediaURL];
        //计算视频大小
        CGFloat length = [self getVideoLength:source];
        CGFloat size = [self getFileSize:[source path]];
        NSLog(@"视频的时长为%lf s \n 视频的大小为%.2f M",length,size);
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self.didUploadVideoView setHidden:NO];
        [self.progressHUD setHidden:NO];
        
        // 将图片写入文件
        
        //        压缩
        [self compressVideo:source];
    }
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
//    NSString *path = [NSString stringWithFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
//    kSaveMyDefault(@"videoPath", path);
    [self convertVideoQuailtyWithInputURL:url outputURL:newVideoUrl completeHandler:nil];
    
}

//拼接字符串，才能播放或者获取第一帧，此方法在获取服务器地址后和传值进来后都要用到
-(void)setVideoUrl:(NSString *)videoUrl{
    if (videoUrl) {
        [self.didUploadVideoView setHidden:NO];
        if (![videoUrl containsString:@"https://jmsp-videos"]) {
            _myVideoUrl = [NSString stringWithFormat:@"https://jmsp-videos-1257721067.cos.ap-guangzhou.myqcloud.com%@",videoUrl];
        }else{
            _myVideoUrl = videoUrl;
        }
        
        NSURL *url = [NSURL URLWithString:_myVideoUrl];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self centerFrameImageWithVideoURL:url completion:^(UIImage *image) {
                    self.didUploadVideoView.imgView.image = image;
                    
                }];
            });
        });
    }
}


-(void)fetchmyVideo{

        //直接创建AVPlayer，它内部也是先创建AVPlayerItem，这个只是快捷方法
//        AVPlayer *player = [AVPlayer playerWithURL:url];
        [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:_myVideoUrl];
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
//                     CGFloat length = [self getVideoLength:outputURL];
//                     CGFloat size = [self getFileSize:[outputURL path]];
//
                     dispatch_async(dispatch_get_main_queue(), ^{
//                         self.bottomLab.text = [NSString stringWithFormat:@"%.2f s, 压缩后大小为：%.2f M",length,size];
                         [self centerFrameImageWithVideoURL:outputURL completion:^(UIImage *image) {
                             self.didUploadVideoView.imgView.image = image;
                             [self upload_Img:image];
                             
                         }];
                     });
                 });
                 
                 
                 //                 __weak __typeof(self) weakSelf = self;
                 // Get center frame image asyncly
                 
                 self.finalURL = outputURL;
                 [self uploadVideo:outputURL];
             }
                 
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
    
}

#pragma mark - 视频上传

/**
 视频上传,获得服务器地址
 
 @param url url
 */
- (void)uploadVideo:(NSURL *)url{
//        上传data
        NSArray *array = @[url];
        [[JMHTTPManager sharedInstance]uploadsWithMP4Files:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

            if (responsObject[@"data"]) {
                NSLog(@"%@",responsObject[@"data"][0]);
                NSString *url = responsObject[@"data"][0];
                NSLog(@"urlurlurlurl--%@",url);
//                kSaveMyDefault(@"videoPath", url);
                //拼接字符串
//                if (_delegate && [_delegate respondsToSelector:@selector(didGetVideoUrlToPlayWitnPlayUrl:)]) {
//                    [_delegate didGetVideoUrlToPlayWitnPlayUrl:<#(nonnull NSString *)#>];
//                }
                [self setVideoUrl:url];
                
                if (_viewType == JMUploadVideoViewTypePartTimeEdit) {
                    [self postPartTimeVideo_url:url];
                    
                }else if (_viewType == JMUploadVideoViewTypeJobEdit) {
                
                    [self postVideo_url:url];
                }else if (_viewType == JMUploadVideoViewTypePartTimeAdd) {
                    
                    [self.progressHUD setHidden:YES];
                    [self showAlertSimpleTips:@"提示" message:@"已保存" btnTitle:@"好的"];
                }
                
                
            }

        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

        }];
    
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //    上传成功可以选择删除
//        [[NSFileManager defaultManager] removeItemAtPath:[url path] error:nil];
    
    
}
-(void)upload_Img:(UIImage *)img{
    NSArray *array = @[img];
    [[JMHTTPManager sharedInstance]uploadsWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            _video_cover = responsObject[@"data"][0];
            
        }
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
//第二版兼职上传视频
-(void)postPartTimeVideo_url:(NSString *)url{
    [[JMHTTPManager sharedInstance]updateAbility_Id:self.ability_id city_id:nil type_label_id:nil industry_arr:nil myDescription:nil video_path:nil video_cover:nil image_arr:nil status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"视频上传成功！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        [self.progressHUD setHidden:YES];

//        if (_delegate && [_delegate respondsToSelector:@selector(isUploadVideo:)]) {
//            [_delegate isUploadVideo:YES];
//        }
//
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];


}

//第一版个人上传全职视频
-(void)postVideo_url:(NSString *)url{
    
    [[JMHTTPManager sharedInstance]updateVitaWith_work_status:nil education:nil work_start_date:nil description:nil video_path:url image_paths:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"视频上传成功！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        //                    kSaveMyDefault(@"videoImg",self.didUploadVideoView.imgView);
        [self.progressHUD setHidden:YES];
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

/**
 从相册选择视频
 
 @param sender btn
 */
- (IBAction)chooseVideo:(id)sender {
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
    CMTime midpoint = CMTimeMakeWithSeconds(duration / 3.0, 600);
    
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

#pragma mark - lazy
-(JMDidUploadVideoView *)didUploadVideoView
{
    if (_didUploadVideoView == nil) {
        _didUploadVideoView = [[JMDidUploadVideoView alloc]init];
        _didUploadVideoView.hidden = YES;
        _didUploadVideoView.delegate = self;

    }
    return _didUploadVideoView;
}

#pragma mark - 菊花
-(MBProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.progress = 0.6;
        _progressHUD.dimBackground = YES; //设置有遮罩
        _progressHUD.label.text = @"视频上传中"; //设置进度框中的提示文字
        _progressHUD.detailsLabel.text = @"请耐心等待...";
        [_progressHUD showAnimated:YES]; //显示进度框
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
