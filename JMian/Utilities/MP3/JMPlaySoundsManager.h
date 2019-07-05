//
//  JMPlaySoundsManager.h
//  JMian
//
//  Created by mac on 2019/7/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DimensMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMPlaySoundsManager : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong) AVAudioPlayer *videoSoundsPlayer;
@property (nonatomic, strong) AVAudioPlayer *moneySoundsPlayer;

-(void)setVideoSounds;
-(void)setMoneySounds;
@end

NS_ASSUME_NONNULL_END
