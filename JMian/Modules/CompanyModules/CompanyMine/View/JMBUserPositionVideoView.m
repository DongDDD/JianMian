//
//  JMBUserPositionVideoView.m
//  JMian
//
//  Created by mac on 2019/6/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserPositionVideoView.h"
#import "DimensMacros.h"
@interface JMBUserPositionVideoView ()
@property (nonatomic, copy) NSString *myVideo_path;
@property (nonatomic, copy) NSString *myVideo_cover;

@end
@implementation JMBUserPositionVideoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
    }
    return self;
}
-(void)setVideo_path:(NSString *)video_path{
    _myVideo_path = video_path;
}

-(void)setVideo_cover:(NSString *)video_cover{
    _myVideo_cover = video_cover;
    [self.videoImg sd_setImageWithURL:[NSURL URLWithString:video_cover] placeholderImage:[UIImage imageNamed:@"default_avatar"]];

}

//-(void)setValusWithVideo_path:(NSString *)video_path video_cover:(NSString *)video_cover{
//    //本地获取链接播放，需要拼接
//    if (![video_path containsString:@"https://jmsp-videos"]) {
//        video_path = [NSString stringWithFormat:@"https://jmsp-videos-1257721067.cos.ap-guangzhou.myqcloud.com%@",video_path];
//    }else{
//        video_path = video_path;
//    }
//    _myVideo_path = video_path;
//    _myVideo_cover = video_cover;
//    [self.videoImg sd_setImageWithURL:[NSURL URLWithString:video_cover] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
//
//}


- (IBAction)leftBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(videoLeftBtnAction)]) {
        [_delegate videoLeftBtnAction];
    }
}

- (IBAction)rightBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(videoRightBtnAction)]) {
        [_delegate videoRightBtnAction];
    }
}

- (IBAction)playAction:(UIButton *)sender {
    if (![_myVideo_path containsString:@"https://jmsp-videos"]) {
        _myVideo_path = [NSString stringWithFormat:@"https://jmsp-videos-1257721067.cos.ap-guangzhou.myqcloud.com%@",_myVideo_path];
    }
//    else{
////        _myVideo_path = _myVideo_path;
//    }
    if (_delegate && [_delegate respondsToSelector:@selector(playBtnActionWithUrl:)]) {
        [_delegate playBtnActionWithUrl:_myVideo_path];
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
