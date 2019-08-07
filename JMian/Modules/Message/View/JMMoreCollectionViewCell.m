//
//  JMMoreCollectionViewCell.m
//  JMian
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMoreCollectionViewCell.h"
static TUIInputMoreCellData *TUI_Photo_MoreCell;
static TUIInputMoreCellData *TUI_Picture_MoreCell;
static TUIInputMoreCellData *TUI_Video_MoreCell;
static TUIInputMoreCellData *TUI_File_MoreCell;

@implementation TUIInputMoreCellData



+ (TUIInputMoreCellData *)pictureData
{
    if (!TUI_Picture_MoreCell) {
        TUI_Picture_MoreCell = [[TUIInputMoreCellData alloc] init];
        TUI_Picture_MoreCell.title = @"拍摄";
        TUI_Picture_MoreCell.image = [UIImage imageNamed:@"paizhao"];
        
    }
    return TUI_Picture_MoreCell;
}

+ (void)setPictureData:(TUIInputMoreCellData *)cameraData
{
    TUI_Picture_MoreCell = cameraData;
}

+ (TUIInputMoreCellData *)photoData
{
    if (!TUI_Photo_MoreCell) {
        TUI_Photo_MoreCell = [[TUIInputMoreCellData alloc] init];
        TUI_Photo_MoreCell.title = @"相册";
        TUI_Photo_MoreCell.image = [UIImage imageNamed:@"Photo"];
    }
    return TUI_Photo_MoreCell;
}

+ (void)setPhotoData:(TUIInputMoreCellData *)pictureData
{
    TUI_Photo_MoreCell = pictureData;
}

//+ (TUIInputMoreCellData *)videoData
//{
//    if (!TUI_Video_MoreCell) {
//        TUI_Video_MoreCell = [[TUIInputMoreCellData alloc] init];
//        TUI_Video_MoreCell.title = @"视频";
//        TUI_Video_MoreCell.image = [UIImage imageNamed:@"more_video"];
//    }
//    return TUI_Video_MoreCell;
//}

//+ (void)setVideoData:(TUIInputMoreCellData *)videoData
//{
//    TUI_Video_MoreCell = videoData;
//}

//+ (TUIInputMoreCellData *)fileData
//{
//    if (!TUI_File_MoreCell) {
//        TUI_File_MoreCell = [[TUIInputMoreCellData alloc] init];
//        TUI_File_MoreCell.title = @"文件";
//        TUI_File_MoreCell.image = [UIImage imageNamed:@"more_file"];
//    }
//    return TUI_File_MoreCell;
//}

//+ (void)setFileData:(TUIInputMoreCellData *)fileData
//{
//    TUI_File_MoreCell = fileData;
//}

@end

@implementation JMMoreCollectionViewCell

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

- (void)fillWithData:(TUIInputMoreCellData *)data
{
    //set data
    _data = data;
    _imageView.image = data.image;
    [_titleLabel setText:data.title];
}
@end
