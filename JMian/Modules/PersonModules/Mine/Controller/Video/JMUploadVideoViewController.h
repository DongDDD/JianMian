//
//  JMUploadVideoViewController.h
//  JMian
//
//  Created by mac on 2019/5/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    JMUploadVideoViewTypeDefault,
    JMUploadVideoViewTypeJobEdit,
    JMUploadVideoViewTypePartTimeEdit,
    JMUploadVideoViewTypePartTimeAdd,

} JMUploadVideoViewType;

@protocol JMUploadVideoViewDelegate <NSObject>

//-(void)isUploadVideo:(BOOL)isUploadVideo;
-(void)didPostVideoWithUrl:(NSString *)url video_cover:(NSString *)video_cover;
-(void)didGetVideoUrlToPlayWitnPlayUrl:(NSString *)playUrl;
@end

@interface JMUploadVideoViewController : BaseViewController

@property(nonatomic,assign)JMUploadVideoViewType viewType;
@property(nonatomic,strong)NSString *ability_id;//兼职简历主键
@property(nonatomic,weak)id<JMUploadVideoViewDelegate>delegate;
@property (nonatomic, copy)NSString *videoUrl;//用于代理回传 和播放

@end

NS_ASSUME_NONNULL_END
