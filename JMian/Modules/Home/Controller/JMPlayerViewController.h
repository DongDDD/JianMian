//
//  JMPlayerViewController.h
//  JMian
//
//  Created by mac on 2019/5/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMCompanyHomeModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface JMPlayerViewController : BaseViewController

@property(nonatomic,copy)NSString *topTitle;
@property (strong, nonatomic) AVPlayer *player;

@end

NS_ASSUME_NONNULL_END
