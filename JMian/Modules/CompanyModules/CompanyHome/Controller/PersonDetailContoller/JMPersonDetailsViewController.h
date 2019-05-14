//
//  JMPersonDetailsViewController.h
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMCompanyHomeModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface JMPersonDetailsViewController : BaseViewController

@property(nonatomic,strong)JMCompanyHomeModel *companyModel;
@property (strong, nonatomic) AVPlayer *player;
@property(nonatomic,strong)NSNumber *user_job_id;
@end

NS_ASSUME_NONNULL_END
