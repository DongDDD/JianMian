//
//  JMDiscoverCollectionViewCell.m
//  JMian
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMDiscoverCollectionViewCell.h"
#import "DimensMacros.h"
@interface JMDiscoverCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImagView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (nonatomic, strong) JMVideoListCellData *myData;
@end

@implementation JMDiscoverCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
  
        
    }
    return self;
}

-(void)setVideoImage:(UIImage *)videoImage{
    
    self.videoImageView.image = videoImage;

}

-(void)setData:(JMVideoListCellData *)data titleIndex:(NSInteger)titleIndex{
    _myData = data;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        if (titleIndex == 0) {
            self.nameLab.text = data.user_nickname;
            [self.iconImagView sd_setImageWithURL:[NSURL URLWithString:data.user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
            self.infoLab.text = data.work_name;
            //封面
            NSURL *url = [NSURL URLWithString:data.video_cover];
            [_videoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"break"]];
            
        }else if (titleIndex == 1){
            
            self.nameLab.text = data.company_name;
            [self.iconImagView sd_setImageWithURL:[NSURL URLWithString:data.logo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
            
            NSMutableArray *industryNameArray = [NSMutableArray array];
            for (JMCVideoLabsModel *LabsData in data.labels) {
                [industryNameArray addObject:LabsData.name];
            }
            NSString *industryStr = [industryNameArray componentsJoinedByString:@"/"];
            self.infoLab.text = industryStr;
            //封面
            JMCVideoModel *CVideoModel = data.video[0];
            if (CVideoModel.cover) {
                NSURL *url = [NSURL URLWithString:CVideoModel.cover];
                [_videoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"break"]];
                
            }
            
        }
//        [self videoImageWithvideoURL:url atTime:0.2];
        
    }else{
        if (titleIndex == 0) {
            self.nameLab.text = data.company_name;
            [self.iconImagView sd_setImageWithURL:[NSURL URLWithString:data.logo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
            
            NSMutableArray *industryNameArray = [NSMutableArray array];
            for (JMCVideoLabsModel *LabsData in data.labels) {
                [industryNameArray addObject:LabsData.name];
            }
            NSString *industryStr = [industryNameArray componentsJoinedByString:@"/"];
            self.infoLab.text = industryStr;
            //封面
            JMCVideoModel *CVideoModel = data.video[0];
            if (CVideoModel.cover) {
                NSURL *url = [NSURL URLWithString:CVideoModel.cover];
                [_videoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"break"]];
                
            }
        }else if (titleIndex == 1){
            
            self.nameLab.text = data.user_nickname;
            [self.iconImagView sd_setImageWithURL:[NSURL URLWithString:data.user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
            self.infoLab.text = data.work_name;
            //封面
            if (data.video_cover.length > 0) {
                NSURL *url = [NSURL URLWithString:data.video_cover];
                [_videoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"break"]];
                
            }
            
            
        }
        
        
        
//        self.nameLab.text = data.company_name;
//        [self.iconImagView sd_setImageWithURL:[NSURL URLWithString:data.logo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
//
//        NSMutableArray *industryNameArray = [NSMutableArray array];
//        for (JMCVideoLabsModel *LabsData in data.labels) {
//            [industryNameArray addObject:LabsData.name];
//        }
//        NSString *industryStr = [industryNameArray componentsJoinedByString:@"/"];
//        self.infoLab.text = industryStr;
//        //封面
//        JMCVideoModel *CVideoModel = data.video[0];
//        NSURL *url = [NSURL URLWithString:CVideoModel.cover];
//        [_videoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"break"]];
//        [self videoImageWithvideoURL:url atTime:0.2];
//
    }
    
 
}




- (IBAction)playAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickPlayAction_data:)]) {
        [_delegate didClickPlayAction_data:_myData];
    }
    
}

#pragma mark - 获取图片
//- (void)videoImageWithvideoURL:(NSURL *)videoURL atTime:(NSTimeInterval)time {
//
//    //先从缓存中找是否有图片
////    SDImageCache *cache =  [SDImageCache sharedImageCache];
////    UIImage *memoryImage =  [cache imageFromMemoryCacheForKey:videoURL.absoluteString];
////    if (memoryImage) {
////        self.videoImageView.image = memoryImage;
////        return;
////    }else{
////        UIImage *diskImage =  [cache imageFromDiskCacheForKey:videoURL.absoluteString];
////        if (diskImage) {
////            self.videoImageView.image = diskImage;
////            return;
////        }
////    }
//
//    if (!time) {
//        time = 1;
//    }
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
//        NSParameterAssert(asset);
//        AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
//        assetImageGenerator.appliesPreferredTrackTransform = YES;
//        assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
//        CGImageRef thumbnailImageRef = NULL;
//        CFTimeInterval thumbnailImageTime = time;
//        NSError *thumbnailImageGenerationError = nil;
//        thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
//        if(!thumbnailImageRef)
//            NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
//        UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
//
//        dispatch_async(dispatch_get_main_queue(), ^{
////            if (thumbnailImage == nil) {
////                self.playBtn.hidden = YES;
////                self.videoImageView.image = [UIImage imageNamed:@"NOvideos"];
////                self.videoImageView.backgroundColor = TITLE_COLOR;
////
////            }else{
////            }
//            self.playBtn.hidden = NO;
//
//            self.videoImageView.image  = thumbnailImage;
//            self.videoImageView.backgroundColor = [UIColor whiteColor];
//        });
//
//    });
//
//}



@end
