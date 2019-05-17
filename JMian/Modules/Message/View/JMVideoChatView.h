//
//  JMVideoChatView.h
//  JMian
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"
#import "JMInterViewModel.h"
#import "JMWaitForAnswerView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMVideoChatViewDelegate <NSObject>

-(void)swicthCameraAction;//切换镜头
-(void)hangupAction;
@end


@interface JMVideoChatView : UIView
@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;

-(void)setInterviewModel:(JMInterViewModel *)interviewModel;
-(void)setVideoChatDic:(NSDictionary *)videoChatDic;
@property (nonatomic, copy)NSString *receiverID;//此ID仅用于发送视频自定义消息

@property(nonatomic,weak)id<JMVideoChatViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
