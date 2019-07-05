//
//  JMPlaySoundsManager.m
//  JMian
//
//  Created by mac on 2019/7/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPlaySoundsManager.h"

@implementation JMPlaySoundsManager

+ (instancetype)sharedInstance {
    static JMPlaySoundsManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[JMPlaySoundsManager alloc] init];
        [_manager setMoneySounds];
        [_manager setVideoSounds];
    });
    return _manager;
}


-(void)setMoneySounds{
    NSError *err;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"money" withExtension:@"mp3"];
    //    初始化播放器
    _moneySoundsPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
    //    设置播放器声音
    //    设置播放速率
    _moneySoundsPlayer.rate = 1.0;
    //    设置播放次数 负数代表无限循环
    _moneySoundsPlayer.numberOfLoops = 1;
    //    准备播放
    [_moneySoundsPlayer prepareToPlay];
    
    
    
}

-(void)setVideoSounds{
    NSError *err;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"videoMeet" withExtension:@"mp3"];
    //    初始化播放器
    _videoSoundsPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
    //    设置播放器声音
    //    设置播放速率
    _videoSoundsPlayer.rate = 1.0;
    //    设置播放次数 负数代表无限循环
    _videoSoundsPlayer.numberOfLoops = -1;
    //    准备播放
    [_videoSoundsPlayer prepareToPlay];
    
}

@end
