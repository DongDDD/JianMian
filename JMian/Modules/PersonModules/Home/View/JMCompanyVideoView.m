//
//  JMCompanyVideoView.m
//  JMian
//
//  Created by mac on 2019/5/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyVideoView.h"



@implementation JMCompanyVideoView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
    }
    return self;
}

-(void)setVideoUrl:(NSString *)videoUrl{
    if (videoUrl == nil) {
        self.videoImg.image = [UIImage imageNamed:@"break"];
        [self.playBtn setHidden:YES];
        self.titleLab.text = @"该公司暂时没有上传视频";
    }else{
        NSURL *URL = [NSURL URLWithString:videoUrl];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage *image = [self thumbnailImageForVideo:URL atTime:1];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.videoImg.image = image;
            });
        });
    }
}

#pragma mark - 获取视频图片

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
- (IBAction)playAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(playAction)]) {
        [_delegate playAction];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
