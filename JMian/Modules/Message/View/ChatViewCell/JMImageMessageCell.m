//
//  JMImageMessageCell.m
//  JMian
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMImageMessageCell.h"
#import "MMLayout/UIView+MMLayout.h"
#import "DimensMacros.h"
#import "ReactiveObjC/ReactiveObjC.h"


@implementation JMImageMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _thumb = [[UIImageView alloc] initWithFrame:CGRectMake(150, 0, 50, 50)];
        _thumb.layer.cornerRadius = 5.0;
        [_thumb.layer setMasksToBounds:YES];
        _thumb.contentMode = UIViewContentModeScaleAspectFit;
//        _thumb.backgroundColor = [UIColor whiteColor];
        [self addSubview:_thumb];
//        _thumb.mm_fill();
        
        _thumb.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//
//        _progress = [[UILabel alloc] init];
//        _progress.textColor = [UIColor whiteColor];
//        _progress.font = [UIFont systemFontOfSize:15];
//        _progress.textAlignment = NSTextAlignmentCenter;
//        _progress.layer.cornerRadius = 5.0;
//        _progress.hidden = YES;
//        _progress.backgroundColor = MASTER_COLOR;;
//        [_progress.layer setMasksToBounds:YES];
//        [self.container addSubview:_progress];
//        _progress.mm_fill();
//        _progress.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}



-(void)setData:(JMImageMessageCellData *)data{
    [super setData:data];
    self.imageData = data;
//     UIImage *image = [UIImage imageWithContentsOfFile:data.path];
//    NSData *data1 = [NSData dataWithContentsOfFile:data.path];
//
//    UIImage * printerImg = [UIImage imageWithData:data1];
    _thumb.image = nil;
    if(data.thumbImage == nil) {
        [data downloadImage:TImage_Type_Thumb];
    }
//
    @weakify(self)
    [[RACObserve(data, thumbImage) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(UIImage *thumbImage) {
        @strongify(self)
        if (thumbImage) {
            self.thumb.image = thumbImage;
        }
    }];
//    if (data.isSelf == YES) {
//        [[[RACObserve(data, thumbProgress) takeUntil:self.rac_prepareForReuseSignal] distinctUntilChanged] subscribeNext:^(NSNumber *x) {
////            @strongify(self)
//            int progress = [x intValue];
//            self.progress.text = [NSString stringWithFormat:@"%d%%", progress];
//            self.progress.hidden = (progress >= 100 || progress == 0);
//        }];
//    } else {
//        [[[RACObserve(data, uploadProgress) takeUntil:self.rac_prepareForReuseSignal] distinctUntilChanged] subscribeNext:^(NSNumber *x) {
////            @strongify(self)
//            int progress = [x intValue];
//            if (progress >= 100 || progress == 0) {
//                [self.indicator stopAnimating];
//            } else {
//                [self.indicator startAnimating];
//            }
//        }];
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
