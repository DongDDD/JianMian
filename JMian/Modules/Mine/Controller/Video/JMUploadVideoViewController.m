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
//#import "JMUserInfoModel.h"
//#import "JMUserInfoManager.h"

//#import "FMImagePicker.h"

@interface JMUploadVideoViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,JMDidUploadVideoViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *bottomLab;
@property (weak, nonatomic) IBOutlet UIImageView *FrameImageView;
@property (strong, nonatomic) AVPlayerViewController *playerVC;
@property (nonatomic, strong) NSURL *finalURL;

@property (nonatomic, strong)JMDidUploadVideoView *didUploadVideoView;
@end

@implementation JMUploadVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频简历";
    [self didUploadVideoView];
    if (kFetchMyDefault(@"video_path")) {
//        //创建URL
//        NSURL *url = [NSURL URLWithString:@"https://jmsp-1258537318.picgz.myqcloud.com//storage//images//2019//05//13//K7xxhMIVfIbCgHGOHFqmIN8cGMh9QRw32luiKRJ3.mp4"];
//        //直接创建AVPlayer，它内部也是先创建AVPlayerItem，这个只是快捷方法
//        AVPlayer *player = [AVPlayer playerWithURL:url];
//        //创建AVPlayerViewController控制器
//        AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
//        playerVC.player = player;
//        playerVC.view.frame = self.view.frame;
//        [self.view addSubview:playerVC.view];
//        self.playerVC = playerVC;
//        //调用控制器的属性player的开始播放方法
//        [self.playerVC.player play];
        
    }
    // Do any additional setup after loading the view from its nib.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.bottomLab.frame.origin.y+self.bottomLab.frame.size.height+30);

}

#pragma mark - 点击事件
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
  
    [self convertVideoQuailtyWithInputURL:url outputURL:newVideoUrl completeHandler:nil];
    
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
                         self.bottomLab.text = [NSString stringWithFormat:@"%.2f s, 压缩后大小为：%.2f M",length,size];
                     });
                 });
                 
                 
                 //                 __weak __typeof(self) weakSelf = self;
                 // Get center frame image asyncly
                 [self centerFrameImageWithVideoURL:outputURL completion:^(UIImage *image) {
                  
//                     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"视频已保存在你的相册" preferredStyle:UIAlertControllerStyleAlert];
//                     UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//                     [alert addAction:cancel];
//                     [self presentViewController:alert animated:YES completion:nil];
                     
                     [self.didUploadVideoView setHidden:NO];
                     self.didUploadVideoView.imgView.image = image;
                     //                     weakSelf.FrameImageView.image = image;
                 }];
                 
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
                [[JMHTTPManager sharedInstance]updateVitaWith_work_status:nil education:nil work_start_date:nil description:nil video_path:url image_paths:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"视频上传成功！" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:cancel];
                    [self presentViewController:alert animated:YES completion:nil];
                    kSaveMyDefault(@"video_path",url);
//                    kSaveMyDefault(@"videoImg",self.didUploadVideoView.imgView);

                    
                } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                    
                }];
                
            }

        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

        }];
    
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //    上传成功可以选择删除
//        [[NSFileManager defaultManager] removeItemAtPath:[url path] error:nil];
    
    
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


// 异步获取帧图片，可以一次获取多帧图片
- (void)centerFrameImageWithVideoURL:(NSURL *)videoURL completion:(void (^)(UIImage *image))completion {
//    NSString *str = @"https://jmsp-1258537318.cos.ap-guangzhou.myqcloud.com//storage//images//2019//05//10//GUXrsshVLHgwdcu8QmwPdeyneFykEsKlFGaCq0bI.mp4";
//
//    NSURL *URL = [NSURL URLWithString:str];
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

//同步获取帧图片
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


/**
 //开始上传
 - (void)uploadNetWorkWithParam:(NSDictionary*)dict {
 
 AFHTTPRequestSerializer *ser=[[AFHTTPRequestSerializer alloc]init];
 NSMutableURLRequest *request =
 [ser multipartFormRequestWithMethod:@"POST"
 URLString:[NSString stringWithFormat:@"%@%@",kBaseUrl,kVideoUploadUrl]
 parameters:@{@"path":@"show",@"key":_key,@"discription":dict[@"discription"],@"isimage":@(_isImage)}
 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
 [formData appendPartWithFileURL:_filePathURL name:@"file" fileName:_fileName mimeType:dict[@"contenttype"] error:nil];
 if (!_isImage) {
 [formData appendPartWithFileURL:_path2Url name:@"tmp" fileName:@"tmp.PNG" mimeType:@"image/png" error:nil];
 }
 } error:nil];
 //@"image/png"   @"application/octet-stream"  mimeType
 AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
 NSProgress *progress = nil;
 NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
 if (error) {
 MyLog(@"request = %@", request );
 MyLog(@"response = %@", response );
 MyLog(@"Error: %@", error );
 [_hud hide:YES];
 CXAlertView *alert=[[CXAlertView alloc]initWithTitle:NSLocalizedString(@"Warning", nil)
 message:NSLocalizedString(@"Upload Failed",nil)
 cancelButtonTitle:NSLocalizedString(@"Iknow", nil)];
 alert.showBlurBackground = NO;
 [alert show];
 } else {
 MyLog(@"%@ %@", response, responseObject);
 NSDictionary *backDict=(NSDictionary *)responseObject;
 if ([backDict[@"success"] boolValue] != NO) {
 _hud.labelText = NSLocalizedString(@"Updating", nil);
 [self UpdateResxDateWithDict:backDict discription:dict[@"discription"]];
 [_hud hide:YES];
 }else{
 [_hud hide:YES];
 [MyHelper showAlertWith:nil txt:backDict[@"msg"]];
 }
 }
 [progress removeObserver:self
 forKeyPath:@"fractionCompleted"
 context:NULL];
 }];
 [progress addObserver:self
 forKeyPath:@"fractionCompleted"
 options:NSKeyValueObservingOptionNew
 context:NULL];
 [progress setUserInfoObject:@"someThing" forKey:@"Y.X."];
 [uploadTask resume];
 }
 **/



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
        [self.view addSubview:self.didUploadVideoView];
        
        [self.didUploadVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(self.view);
            make.top.and.bottom.mas_equalTo(self.view);
        }];
    }
    return _didUploadVideoView;
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
