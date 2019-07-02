//
//  JMVideoChatView.m
//  JMian
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVideoChatView.h"
#import "Masonry.h"
#import "JMFeedBackChooseViewController.h"


@interface JMVideoChatView ()<JMWaitForAnswerViewDelegate>

@property(nonatomic,strong)UIView *localVideo;
@property(strong, nonatomic)UIView *remoteVideo;

@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *myTitle;
@property(nonatomic,copy)NSString *subTitle;
@property(nonatomic,copy)NSString *channel_Id;
@property(nonatomic,strong)JMInterViewModel *myInterviewModel;
@property(nonatomic,strong)JMMessageListModel *messageListModel;

@property(nonatomic,strong)JMWaitForAnswerView *waitForAnswerView;
@property(nonatomic,strong)JMFeedBackChooseViewController *feedBackChooseVC;
@end

@implementation JMVideoChatView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hangupMessage) name:Notification_JMMUHangUpListener object:nil];
        self.backgroundColor = [UIColor blackColor];
        [self initView];
        [self initializeAgoraEngine];
        [self setupVideo];
        [self setupLocalVideo];
    }
    return self;
}

-(void)initView{
    
    UILabel *waitLab = [[UILabel alloc]init];
    waitLab.text = @"等待对方接听...";
    waitLab.textColor = [UIColor whiteColor];
    [self addSubview:waitLab];
    
    [waitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.mas_equalTo(self);
    }];
    
    
    self.remoteVideo = [[UIView alloc]init];

    [self addSubview:self.remoteVideo];
    
    [self.remoteVideo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.top.mas_equalTo(self);
    }];
    
    self.localVideo = [[UIView alloc]init];
    [self addSubview:self.localVideo];
    
    [self.localVideo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-30);
        make.height.mas_equalTo(167);
        make.width.mas_equalTo(96);
        make.top.mas_equalTo(self).mas_offset(20);
    }];
    
    
    
    UILabel *lab = [[UILabel alloc]init];
//    lab.text = @"对方邀请你视频面试...";
    lab.textColor = [UIColor whiteColor];
    [self addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
    
    UIButton *swicthBtn = [[UIButton alloc]init];
    [swicthBtn setImage:[UIImage imageNamed:@"switchCameraButton"] forState:UIControlStateNormal];
    [swicthBtn setImage:[UIImage imageNamed:@"switchCameraButtonSelected"] forState:UIControlStateSelected];
    [swicthBtn addTarget: self action:@selector(swicthBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:swicthBtn];
    
    [swicthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(60);
        make.top.mas_equalTo(lab).mas_offset(220);
        make.centerX.mas_equalTo(self).offset(-90);
    }];
    
    UILabel *answerLab = [[UILabel alloc]init];
    answerLab.text = @"切换镜头";
    answerLab.textColor = [UIColor whiteColor];
    [self addSubview:answerLab];
    
    [answerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(swicthBtn);
        make.top.mas_equalTo(swicthBtn.mas_bottom).mas_offset(10);
    }];
    
    
    UIButton *hangupBtn = [[UIButton alloc]init];
    [hangupBtn setImage:[UIImage imageNamed:@"hangUpButton"] forState:UIControlStateNormal];
    [hangupBtn addTarget: self action:@selector(hangupBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hangupBtn];
    
    [hangupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(60);
        make.top.mas_equalTo(lab).mas_offset(220);
        make.centerX.mas_equalTo(self).offset(90);
    }];
    
    
    UILabel *hangupLab = [[UILabel alloc]init];
    hangupLab.text = @"挂断";
    hangupLab.textColor = [UIColor whiteColor];
    [self addSubview:hangupLab];
    
    [hangupLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(hangupBtn);
        make.top.mas_equalTo(hangupBtn.mas_bottom).mas_offset(10);
    }];
    
}

#pragma mark -点击事件
-(void)swicthBtnAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(swicthCameraAction)]) {
        [_delegate swicthCameraAction];
    }
    sender.selected = !sender.selected;
    [self.agoraKit switchCamera];

}
//
//

-(void)hangupBtnAction{
    if (_delegate && [_delegate respondsToSelector:@selector(hangupAction_model:)]) {
        [_delegate hangupAction_model:_myInterviewModel];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(appDelegateLeaveChannelActoin)]) {
        [_delegate appDelegateLeaveChannelActoin];
    }
    
    [self leaveChannel];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:221] removeFromSuperview];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:222] removeFromSuperview];
    if (self.receiverID)
    {
        [self setVideoInvite_receiverID:self.receiverID dic:nil title:@"[视频已取消]"];
    }
 


}
- (void)leaveChannel {
    [self.agoraKit leaveChannel:^(AgoraChannelStats *stat) {
        [UIApplication sharedApplication].idleTimerDisabled = NO;
        [self.remoteVideo removeFromSuperview];
        [self.localVideo removeFromSuperview];

    }];
}
#pragma mark -创建聊天

-(void)createChatRequstWithForeign_key:(NSString *)foreign_key recipient:(NSString *)recipient chatType:(NSString *)chatType{
    
    [[JMHTTPManager sharedInstance]createChat_type:chatType recipient:recipient foreign_key:foreign_key successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
        //后期优化这个页面直接用messageListModel赋值,
        [self setMessageListModel:messageListModel];
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

#pragma mark - B端从兼职人才进来视频聊天
-(void)setMessageListModel:(JMMessageListModel *)messageListModel{
    //用于发送自定义消息
    NSString *sendSubTitle;
    NSString *sendTitle;
    NSString *sendMarkID;
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];
    //------------B端从兼职人才进来视频聊天---------------
    if ([userInfoModel.type isEqualToString:B_Type_UESR]) {
        if (userInfoModel.user_id == messageListModel.sender_user_id) {
            _imgUrl = messageListModel.sender_avatar;
            _myTitle = messageListModel.sender_nickname;
            _subTitle = messageListModel.workInfo_company_name;
            //赋值用于发送自定义消息
            sendSubTitle = _subTitle;
            sendTitle = _myTitle;
            sendMarkID = messageListModel.sender_mark;
            self.receiverID = messageListModel.recipient_mark;
        }else if (userInfoModel.user_id == messageListModel.recipient_user_id){
            _imgUrl = messageListModel.recipient_avatar;
            _myTitle = messageListModel.recipient_nickname;
            _subTitle = messageListModel.work_work_name;
            // 赋值用于发送自定义消息
            sendSubTitle = _subTitle;
            sendTitle = _myTitle;
            sendMarkID = messageListModel.recipient_mark;
            self.receiverID = messageListModel.sender_mark;
            
        }
       
    }
    _channel_Id = messageListModel.chat_id;
    NSDictionary *dic;
    dic = @{
            TITLE:sendTitle, //用户名称
            Sub_TITLE:sendSubTitle, //用户职位
            Avatar_URL:_imgUrl, //用户头像
            Channel_ID:_channel_Id, //房间ID
            SendMarkID:sendMarkID, //用户类型
            isPartTime:@(NO) //是否为兼职视频
            };
    
    //发送面试邀请1
    if ((self.receiverID)) {
        [self setVideoInvite_receiverID:self.receiverID dic:dic title:@"[邀请视频聊天]"];
    }
    //加入视频聊天频道
    if (_channel_Id) {
        [self joinChannel_channelId:_channel_Id];
    }

}


-(void)setInterviewModel:(JMInterViewModel *)interviewModel{
    _myInterviewModel = interviewModel;
    NSString *sendSubTitle;
    NSString *sendTitle;
    NSString *sendMarkID;
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];
    if ([userInfoModel.type isEqualToString:B_Type_UESR]) {
        //------------B端从面试管理进来视频聊天---------------
        _imgUrl = interviewModel.candidate_avatar;
        _myTitle = interviewModel.candidate_nickname;
        _subTitle = interviewModel.company_company_name;
        //赋值用于发送自定义消息
        sendSubTitle = interviewModel.company_company_name;
        sendTitle = interviewModel.interviewer_nickname;
        sendMarkID = [NSString stringWithFormat:@"%@b",interviewModel.interviewer_id];
        self.receiverID =[NSString stringWithFormat:@"%@a",interviewModel.candidate_id];
    }else if([userInfoModel.type isEqualToString:C_Type_USER]) {
        //------------C端从面试管理进来视频聊天---------------
        _imgUrl = interviewModel.interviewer_avatar;
        _myTitle = interviewModel.interviewer_nickname;
        _subTitle = interviewModel.company_company_name;
        //赋值用于发送自定义消息
        sendSubTitle = interviewModel.work_work_name;
        sendTitle = interviewModel.candidate_nickname;
        sendMarkID = [NSString stringWithFormat:@"%@a",interviewModel.candidate_id];
        self.receiverID = [NSString stringWithFormat:@"%@b",interviewModel.interviewer_id];
        
    }
    _channel_Id = interviewModel.interview_id;
    
    NSDictionary *dic;
    dic = @{
            TITLE:sendTitle,
            Sub_TITLE:sendSubTitle,
            Avatar_URL:_imgUrl,
            Channel_ID:_channel_Id,
            SendMarkID:sendMarkID,
            isPartTime:@(NO) //是否为兼职视频

            };
    
    //发送面试邀请1
    if ((self.receiverID)) {
        [self setVideoInvite_receiverID:self.receiverID dic:dic title:@"[邀请视频聊天]"];
    }
    //加入视频聊天频道
    [self joinChannel_channelId:interviewModel.interview_id];
    //布局UI+
    //    [self initInfoView_avart:_imgUrl myTitle:_myTitle subTitle:_subTitle];
    
}

#pragma mark -发送视频自定义消息

-(void)setVideoInvite_receiverID:(NSString *)receiverID dic:(NSDictionary *)dic title:(NSString *)title{
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:receiverID];
    
    
    TIMCustomElem * custom_elem = [[TIMCustomElem alloc] init];
    
    // 转换为 NSData
    if (dic) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        [custom_elem setData:data];
        
    }
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    
    [custom_elem setDesc:title];
    TIMMessage * msg = [[TIMMessage alloc] init];
    
    [msg addElem:custom_elem];
    [conv sendMessage:msg succ:^(){
        NSLog(@"SendMsg Succ");
    }fail:^(int code, NSString * err) {
        NSLog(@"SendMsg Failed:%d->%@", code, err);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送失败"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }];
    
    
}

#pragma mark - B/C从弹窗进来视频聊天

-(void)setVideoChatDic:(NSDictionary *)videoChatDic{
    
    // 提取自定义消息传过来的数据，然后赋值
    _imgUrl = videoChatDic[Avatar_URL];
    _myTitle = videoChatDic[TITLE];
    _subTitle = videoChatDic[Sub_TITLE];
    _channel_Id = videoChatDic[Channel_ID];
    //加入视频聊天频道
    [self joinChannel_channelId:_channel_Id];
    //布局UI
//    [self initInfoView_avart:_imgUrl myTitle:_myTitle subTitle:_subTitle];
    
}


#pragma mark - 接入声网

- (void)setupVideo {
    [self.agoraKit enableVideo];
    // Default mode is disableVideo
    
    AgoraVideoEncoderConfiguration *encoderConfiguration =
    [[AgoraVideoEncoderConfiguration alloc] initWithSize:AgoraVideoDimension640x360
                                               frameRate:AgoraVideoFrameRateFps15
                                                 bitrate:AgoraVideoBitrateStandard
                                         orientationMode:AgoraVideoOutputOrientationModeAdaptative];
    [self.agoraKit setVideoEncoderConfiguration:encoderConfiguration];
}

- (void)setupLocalVideo {
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    // UID = 0 means we let Agora pick a UID for us
    
    videoCanvas.view = self.localVideo;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    [self.agoraKit setupLocalVideo:videoCanvas];
    // Bind local video stream to view
}

- (void)joinChannel_channelId:(NSString *)channelId{
    
    [self.agoraKit joinChannelByToken:nil channelId:channelId info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
        NSLog(@"成功进入房间");
        // Join channel "demoChannel1"
    }];
    

    [self.agoraKit setEnableSpeakerphone:YES];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}


#pragma mark -delegate

- (void)initializeAgoraEngine {
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:VideoAgoraAPIKey delegate:self];
}



- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstRemoteVideoDecodedOfUid:(NSUInteger)uid size: (CGSize)size elapsed:(NSInteger)elapsed {
//    if (self.remoteVideo.hidden) {
//        self.remoteVideo.hidden = NO;
//    }
//
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    // Since we are making a simple 1:1 video chat app, for simplicity sake, we are not storing the UIDs. You could use a mechanism such as an array to store the UIDs in a channel.
    
    videoCanvas.view = self.remoteVideo;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    [self.agoraKit setupRemoteVideo:videoCanvas];
    // Bind remote video stream to view
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didVideoMuted:(BOOL)muted byUid:(NSUInteger)uid {
    self.remoteVideo.hidden = muted;
//    self.remoteVideoMutedIndicator.hidden = !muted;
}

//对方挂断离开房间
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason {
    //接受方
    if (_delegate && [_delegate respondsToSelector:@selector(appDelegateLeaveChannelActoin)]) {
        [_delegate appDelegateLeaveChannelActoin];
    
    } 
    //发出邀请方
    if (_delegate && [_delegate respondsToSelector:@selector(hangupAction_model:)]) {
        [_delegate hangupAction_model:_myInterviewModel];
    }
    [self leaveChannel];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:221] removeFromSuperview];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:222] removeFromSuperview];

    NSLog(@"对方挂断离开房间");

}


- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    
    NSLog(@"有人进入");
//    [self.waitForAnswerView removeFromSuperview];

//    [self.waitForAnswerView setHidden:YES];
    
}
#pragma mark -接收对方丢出的挂断命令
-(void)hangupMessage{

    if (_delegate && [_delegate respondsToSelector:@selector(hangupAction_model:)]) {
        [_delegate hangupAction_model:_myInterviewModel];
    }
    
    [self leaveChannel];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:221] removeFromSuperview];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:222] removeFromSuperview];
//    JMFeedBackChooseViewController *vc = [[JMFeedBackChooseViewController alloc]init];
//    vc.interview_id = self.
    
}

-(JMFeedBackChooseViewController *)feedBackChooseVC{
    if (_feedBackChooseVC == nil) {
        _feedBackChooseVC = [[JMFeedBackChooseViewController alloc]init];
        _feedBackChooseVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }
    return _feedBackChooseVC;
}


//- (void)onNewMessage:(NSNotification *)notification
//{
//    NSArray *msgs = notification.object;
//    for (TIMMessage *msg in msgs) {
//        int cnt = [msg elemCount];
//        for (int i = 0; i < cnt; i++) {
//            TIMElem * elem = [msg getElem:i];
//            if ([elem isKindOfClass:[TIMCustomElem class]]) {
//                TIMCustomElem * custom_elem = (TIMCustomElem *)elem;
//                if ([custom_elem.desc isEqualToString:@"leaveAction"]){
//                    if (_delegate && [_delegate respondsToSelector:@selector(hangupAction)]) {
//                        [_delegate hangupAction];
//                        [self leaveChannel];
//                    }
//                }
//            }
//
//
//        }
//
////    }
//    NSArray *msgs = notification.object;
//    TIMMessage *msg = msgs[0];
//    TIMElem * elem = [msg getElem:0];
//    if ([elem isKindOfClass:[TIMCustomElem class]]) {
//        TIMCustomElem * custom_elem = (TIMCustomElem *)elem;
//        if ([custom_elem.desc isEqualToString:@"结束了视频"]) {
//            NSLog(@"6leaveActionleaveActionleaveAction");
//        }
//    }
//
//
//
//
//    NSLog(@"onNewMessage接受消息成功-------");
//
//}
//等待对方接听 只有关闭按钮
//-(JMWaitForAnswerView *)waitForAnswerView{
//    if (_waitForAnswerView == nil) {
//        _waitForAnswerView = [[JMWaitForAnswerView alloc]initWithFrame:self.bounds];
//        _waitForAnswerView.delegate = self;
//
//    }
//    return _waitForAnswerView;
//
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
