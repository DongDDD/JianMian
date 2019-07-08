//
//  JMVideoSingleViewController.m
//  JMian
//
//  Created by mac on 2019/7/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVideoSingleViewController.h"
#import "SJVideoPlayer.h"
#import <SJVideoPlayer/SJVideoPlayer.h>

@interface JMVideoSingleViewController ()
@property (nonatomic, strong, nullable) SJVideoPlayer *player;

@end

@implementation JMVideoSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHTMLPath:@"SecondModulesHTML/B/video.html"];
    _player = [SJVideoPlayer player];
    _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:@"https://jmsp-videos-1257721067.cos.ap-guangzhou.myqcloud.com/storage/videos/2019/07/04/sVjYyXuM2flMbqFsTIoRVgLSMirHHL9XNTSGAYHi.mp4"]];
    [self.view addSubview:_player.view];
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    
//    SJVideoPlayer *_videoPlayer = [SJVideoPlayer player];
//    _videoPlayer.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT); // 可以使用AutoLayout, 这里为了简便设置的Frame.
//    [self.view addSubview:_videoPlayer.view];
//    // 初始化资源
//    _videoPlayer.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:@"https://jmsp-videos-1257721067.cos.ap-guangzhou.myqcloud.com/storage/videos/2019/07/04/sVjYyXuM2flMbqFsTIoRVgLSMirHHL9XNTSGAYHi.mp4"]];
//    [_videoPlayer play];
    
    // Do any additional setup after loading the view from its nib.
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
