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
#import "JMHTTPManager+CreateConversation.h"
#import "JMMessageListModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMVideoChatViewDelegate <NSObject>

-(void)swicthCameraAction;//切换镜头
-(void)hangupAction_model:(JMInterViewModel *)model;
-(void)appDelegateLeaveChannelActoin; //对方离开了房间（对方挂断了）
-(void)appDelegateHangupAction; //挂断

@end


@interface JMVideoChatView : UIView
@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;

-(void)setInterviewModel:(JMInterViewModel *)interviewModel;
-(void)setVideoChatDic:(NSDictionary *)videoChatDic;
@property (nonatomic, copy)NSString *receiverID;//此ID仅用于发送视频自定义消息

@property(nonatomic,weak)id<JMVideoChatViewDelegate>delegate;

// ---------创建聊天需要的参数---------
//对话类型 1:求职招聘 2:灵活就业
@property(nonatomic,copy)NSString *chatType;
// type=1时:(work_label_id|job_label_id)  type=2时 ability_id |  task_order_id
@property(nonatomic,copy)NSString *foreign_key;

@property(nonatomic,copy)NSString *recipient;
//创建聊天
-(void)createChatRequstWithForeign_key:(NSString *)foreign_key recipient:(NSString *)recipient chatType:(NSString *)chatType;
@end

NS_ASSUME_NONNULL_END
