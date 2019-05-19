//
//  JMVideoPlayManager.h
//  JMian
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "DimensMacros.h"

NS_ASSUME_NONNULL_BEGIN


@interface JMVideoPlayManager : AVPlayerViewController

@property(nonatomic,strong)NSMutableArray *B_User_playArray;
@property(nonatomic,strong)NSMutableArray *C_User_playArray;
@property (strong, nonatomic) AVPlayer *player;
@property (nonatomic, strong) VIResourceLoaderManager *resourceLoaderManager;
- (void)setupPlayer_UrlStr:(NSString *)urlStr;
-(void)play;
+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
