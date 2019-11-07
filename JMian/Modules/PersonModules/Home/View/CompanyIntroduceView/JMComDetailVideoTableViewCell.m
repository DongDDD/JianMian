//
//  JMComDetailVideoTableViewCell.m
//  JMian
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMComDetailVideoTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMComDetailVideoTableViewCellIdentifier = @"JMComDetailVideoTableViewCellIdentifier";
@interface JMComDetailVideoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *videoImgView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) JMCompanyInfoModel *myModel;
@property (copy, nonatomic) NSString *videoPath;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;


@end
@implementation JMComDetailVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(JMCompanyInfoModel *)model{
    _myModel = model;
    if (model.video.count > 0) {
        JMFilesModel *filesModel = model.video[0];
        if ([filesModel.status isEqualToString:@"2"]) {
            _videoPath = filesModel.files_file_path;
        }
        
        //视频封面
        if (self.videoImgView.image == nil) {
            if (filesModel.file_cover.length > 0) {
                [self.videoImgView sd_setImageWithURL:[NSURL URLWithString:filesModel.file_cover] placeholderImage:[UIImage imageNamed:@"break"]];
            }else{
                [self centerFrameImageWithVideoURL:[NSURL URLWithString:filesModel.files_file_path ]completion:^(UIImage *image) {
                    self.videoImgView.image = image;
                }];
                
            }
        }
        //视频路径
        if (filesModel.files_file_path.length > 0) {
            [self.playBtn setHidden:NO];
        }else{
            [self.playBtn setHidden:YES];
        }
        self.titleLab.text = @"公司视频";

    }else{
        self.titleLab.text = @"公司暂未上传视频";
    }
}

- (IBAction)playAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(playVideoActionWithUrl:)]) {
        [_delegate playVideoActionWithUrl:_videoPath];
    }
}

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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
