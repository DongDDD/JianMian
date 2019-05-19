//
//  JMVideoPlayManager.m
//  JMian
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVideoPlayManager.h"


@implementation JMVideoPlayManager

+ (instancetype)sharedInstance {
    static JMVideoPlayManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[JMVideoPlayManager alloc] init];
//        _manager.B_User_playArray = [NSMutableArray array];
//        _manager.C_User_playArray = [NSMutableArray array];
        [_manager setBackBtnImageViewName:@"icon_return" textName:@""];

//        [_manager initCloseBtn];
    });
    return _manager;
}

- (void)fanhui {
    [self.navigationController popViewControllerAnimated:YES];
    [self.player pause];
}

//-(void)closeAction{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(closeVideoAction)]) {
//        [self.delegate closeVideoAction];
//    }
//    
//}
- (void)setBackBtnImageViewName:(NSString *)imageName textName:(NSString *)textName{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 19)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 21);
    [leftBtn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(leftBtn.frame.origin.x+leftBtn.frame.size.width-5, 0, 100,leftBtn.frame.size.height)];
    leftLab.text = textName;
    leftLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    leftLab.font = [UIFont systemFontOfSize:13];
    
    [bgView addSubview:leftLab];
    [bgView addSubview:leftBtn];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

#pragma mark - Setup

- (void)setupPlayer_UrlStr:(NSString *)urlStr {
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"sdfasdf";
    self.showsPlaybackControls = YES;
    //        NSURL *url = [NSURL URLWithString:@"http://gedftnj8mkvfefuaefm.exp.bcevod.com/mda-hc2s2difdjz6c5y9/hd/mda-hc2s2difdjz6c5y9.mp4?playlist%3D%5B%22hd%22%5D&auth_key=1500559192-0-0-dcb501bf19beb0bd4e0f7ad30c380763&bcevod_channel=searchbox_feed&srchid=3ed366b1b0bf70e0&channel_id=2&d_t=2&b_v=9.1.0.0"];
    //        NSURL *url = [NSURL URLWithString:@"https://mvvideo5.meitudata.com/56a9e1389b9706520.mp4"];
    NSURL *url = [NSURL URLWithString:@"https://mvvideo5.meitudata.com/56ea0e90d6cb2653.mp4"];
    
    VIResourceLoaderManager *resourceLoaderManager = [VIResourceLoaderManager new];
    self.resourceLoaderManager = resourceLoaderManager;
    
    AVPlayerItem *playerItem = [resourceLoaderManager playerItemWithURL:url];
//    self.playerItem = playerItem;
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    //    AVPlayer *player = [AVPlayer playerWithURL:url];
    player.automaticallyWaitsToMinimizeStalling = NO;
    self.player = player;
    
    VICacheConfiguration *configuration = [VICacheManager cacheConfigurationForURL:url];
    if (configuration.progress >= 1.0) {
        NSLog(@"cache completed");
    }
    
    //    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //    [self.player addObserver:self forKeyPath:@"timeControlStatus" options:NSKeyValueObservingOptionNew context:nil];
    //
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlayerViewAction:)];
    //    [self.view addGestureRecognizer:tap];
}

-(void)play{
    
    [self.player play];
}


@end
