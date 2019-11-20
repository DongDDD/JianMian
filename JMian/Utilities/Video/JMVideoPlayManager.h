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
#import "JMVideoDetailInfoView.h"
#import "JMComVideoDetailInfoView.h"
#import "JMVideoListCellData.h"
#import "JMVitaDetailModel.h"
#import "JMCompanyInfoModel.h"
#import "JMShareView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMVideoPlayManagerDelegate <NSObject>

-(void)lookCActionDelegateWithUser_job_id:(NSString *)user_job_id;

@end

@interface JMVideoPlayManager : AVPlayerViewController<JMShareViewDelegate>

@property(nonatomic,strong)NSMutableArray *B_User_playArray;
@property(nonatomic,strong)NSMutableArray *C_User_playArray;
@property (strong, nonatomic) AVPlayer *player;
@property (nonatomic, strong) VIResourceLoaderManager *resourceLoaderManager;
- (void)setupPlayer_UrlStr:(NSString *)urlStr videoID:(NSString *)videoID;
- (void)play;
+ (instancetype)sharedInstance;

@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UIButton *shareBtn;
@property(nonatomic,strong)JMVideoDetailInfoView *videoDetailInfoView;
@property(nonatomic,strong)JMComVideoDetailInfoView *comVideoDetailInfoView;
@property(nonatomic,strong)JMShareView *shareView;//分享
@property(nonatomic,strong)UIView *shareBgView;//分享


@property(nonatomic,strong)JMVideoListCellData *videoListCellData;
@property (nonatomic, strong)JMVitaDetailModel *vitaModel;
@property (nonatomic, strong)JMCompanyInfoModel *companyInfoModel;
@property (nonatomic, weak)id<JMVideoPlayManagerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
