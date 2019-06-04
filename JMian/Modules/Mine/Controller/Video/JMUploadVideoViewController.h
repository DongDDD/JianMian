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
    JMUploadVideoViewTypePartTime,
} JMUploadVideoViewType;

@protocol JMUploadVideoViewDelegate <NSObject>

-(void)isUploadVideo:(BOOL)isUploadVideo;

@end

@interface JMUploadVideoViewController : BaseViewController

@property(nonatomic,assign)JMUploadVideoViewType viewType;
@property(nonatomic,strong)NSString *ability_id;//兼职简历主键
@property(nonatomic,weak)id<JMUploadVideoViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
