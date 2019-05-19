//
//  JMPlayerViewController.m
//  JMian
//
//  Created by mac on 2019/5/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPlayerViewController.h"

@interface JMPlayerViewController ()<AVPlayerViewControllerDelegate>
@property (strong, nonatomic) AVPlayerViewController *playerVC;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation JMPlayerViewController
- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
////    [self.player removeTimeObserver:self.timeObserver];
////    self.timeObserver = nil;
//    [self.playerItem removeObserver:self forKeyPath:@"status"];
//    [self.player removeObserver:self forKeyPath:@"timeControlStatus"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.topTitle;
    self.view.backgroundColor = MASTER_COLOR;
//    [self.view addSubview:self.progressHUD];
//    [self cleanCache];

    [self setupPlayer];
    [self initPlayerView];
    // Do any additional setup after loading the view.
}

-(void)initPlayerView{
    //创建AVPlayerViewController控制器
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
    playerVC.delegate = self;
    playerVC.player = self.player;
    playerVC.view.frame = self.view.frame;
    [self.view addSubview:playerVC.view];
    self.playerVC = playerVC;
    //调用控制器的属性player的开始播放方法
    [self.playerVC.player play];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self.player play];
//    [self initPlayerView];
}



#pragma mark - Setup

- (void)setupPlayer {
    
    //        NSURL *url = [NSURL URLWithString:@"http://gedftnj8mkvfefuaefm.exp.bcevod.com/mda-hc2s2difdjz6c5y9/hd/mda-hc2s2difdjz6c5y9.mp4?playlist%3D%5B%22hd%22%5D&auth_key=1500559192-0-0-dcb501bf19beb0bd4e0f7ad30c380763&bcevod_channel=searchbox_feed&srchid=3ed366b1b0bf70e0&channel_id=2&d_t=2&b_v=9.1.0.0"];
    //        NSURL *url = [NSURL URLWithString:@"https://mvvideo5.meitudata.com/56a9e1389b9706520.mp4"];
    NSURL *url = [NSURL URLWithString:@"https://mvvideo5.meitudata.com/56ea0e90d6cb2653.mp4"];
    
    VIResourceLoaderManager *resourceLoaderManager = [VIResourceLoaderManager new];
    self.resourceLoaderManager = resourceLoaderManager;
    
    AVPlayerItem *playerItem = [resourceLoaderManager playerItemWithURL:url];
    self.playerItem = playerItem;
    
    VICacheConfiguration *configuration = [VICacheManager cacheConfigurationForURL:url];
    if (configuration.progress >= 1.0) {
        NSLog(@"cache completed");
    }
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    //    AVPlayer *player = [AVPlayer playerWithURL:url];
    player.automaticallyWaitsToMinimizeStalling = NO;
    self.player = player;
    
    
//    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
//    [self.player addObserver:self forKeyPath:@"timeControlStatus" options:NSKeyValueObservingOptionNew context:nil];
//
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlayerViewAction:)];
//    [self.view addGestureRecognizer:tap];
}
#pragma mark - 清理缓存

- (void)cleanCache {
    unsigned long long fileSize = [VICacheManager calculateCachedSizeWithError:nil];
    NSLog(@"file cache size: %@", @(fileSize));
    NSError *error;
    [VICacheManager cleanAllCacheWithError:&error];
    if (error) {
        NSLog(@"clean cache failure: %@", error);
    }
    
    [VICacheManager cleanAllCacheWithError:&error];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (object == self.playerItem && [keyPath isEqualToString:@"status"]) {
        NSLog(@"player status %@, rate %@, error: %@", @(self.playerItem.status), @(self.player.rate), self.playerItem.error);
        if (self.playerItem.status == AVPlayerItemStatusReadyToPlay) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                CGFloat duration = CMTimeGetSeconds(self.playerItem.duration);
                self.title = [NSString stringWithFormat:@"%.f", duration];
            });
        } else if (self.playerItem.status == AVPlayerItemStatusFailed) {
            // something went wrong. player.error should contain some information
            NSLog(@"player error %@", self.playerItem.error);
        }
    } else if (object == self.player && [keyPath isEqualToString:@"timeControlStatus"]) {
        NSLog(@"timeControlStatus: %@, reason: %@, rate: %@", @(self.player.timeControlStatus), self.player.reasonForWaitingToPlay, @(self.player.rate));
    }
}



-(void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController{
    [self.progressHUD setHidden:YES];


}




-(void)fanhui
{
    [super fanhui];

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
