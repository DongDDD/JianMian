//
//  JMVideoChatViewController.m
//  JMian
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVideoChatViewController.h"
#import "Masonry.h"
#import "JMUserInfoModel.h"
#import "JMUserInfoManager.h"
#import "JMWaitForAnswerView.h"
#import "JMAnswerOrHangUpView.h"

@interface JMVideoChatViewController ()<JMWaitForAnswerViewDelegate,JMAnswerOrHangUpViewDelegate>

@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;
@property (weak, nonatomic) IBOutlet UIView *localVideo;
@property (weak, nonatomic) IBOutlet UIView *remoteVideo;
//@property (weak, nonatomic) IBOutlet UIView *controlButtons;
@property (weak, nonatomic) IBOutlet UIImageView *remoteVideoMutedIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *localVideoMutedBg;
@property (weak, nonatomic) IBOutlet UIImageView *localVideoMutedIndicator;

@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *myTitle;
@property(nonatomic,copy)NSString *subTitle;

@property(nonatomic,copy)NSString *channel_Id;
@property(nonatomic,copy)NSString *HR_MarkId;
@property(nonatomic,copy)NSString *sendSubTitle;
@property(nonatomic,copy)NSString *sendTitle;
@property(nonatomic,copy)NSString *sendAvart;

@property(nonatomic,strong)JMWaitForAnswerView *waitForAnswerView;
@property(nonatomic,strong)JMAnswerOrHangUpView *answerOrHangUpView;

//@property(nonatomic,copy)NSString *sendMarkID;

@end

@implementation JMVideoChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupButtons];
    [self hideVideoMuted];
    [self initializeAgoraEngine];
    [self setupVideo];
    [self setupLocalVideo];
    
    
    
//    [self joinChannel];
    //有两种种状态可以进入视频聊天

//    [self initInfoView];
//    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];

    //发送自定义消息 videoChatDic不为空代表是从弹窗进来
  
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];

}



//-(void)initInfoView
//{
//    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];
//
//    if ([userInfoModel.type isEqualToString:B_Type_UESR]) {
////        if (self.chatViewModel)//从聊天界面进来 【取消】
////        {
////            if ([self.chatViewModel.sender_user_id isEqualToString:userInfoModel.user_id]) {//逻辑和聊天界面一样
////                _imgUrl = self.chatViewModel.recipient_avatar;
////                _myTitle = self.chatViewModel.recipient_nickname;
////                _HRName = self.chatViewModel.sender_nickname;
////                _HRAvart = self.chatViewModel.sender_avatar;
////            }else
////            {
////                _imgUrl = self.chatViewModel.sender_avatar;
////                _myTitle = self.chatViewModel.sender_nickname;
////                _HRName = self.chatViewModel.recipient_nickname;
////                _HRAvart = self.chatViewModel.recipient_avatar;
////
////            }
////
////            _company_name = self.chatViewModel.workInfo_company_name;
////            _subTitle = self.chatViewModel.work_work_name;
////
////        }
//        //------------B端从面试管理进来视频聊天---------------
//
//        if (self.interviewModel)
//        {
//            _imgUrl = self.interviewModel.candidate_avatar;
//            _myTitle = self.interviewModel.candidate_nickname;
//            _subTitle = self.interviewModel.company_company_name;
//            _sendSubTitle = self.interviewModel.company_company_name;
//            _sendTitle = self.interviewModel.interviewer_nickname;
////            _sendMarkID = [NSString stringWithFormat:@"%@b",self.interviewModel.interviewer_id];
//            self.receiverID =[NSString stringWithFormat:@"%@a",self.interviewModel.candidate_id];
//
//        }
//
//
//
//    }else if([userInfoModel.type isEqualToString:C_Type_USER]) {
////        if (self.chatViewModel)//C端从聊天界面进来
////        {
////            if ([self.chatViewModel.sender_user_id isEqualToString:userInfoModel.user_id]) {//逻辑和聊天界面一样
////                _imgUrl = self.chatViewModel.recipient_avatar;
////                _myTitle = self.chatViewModel.recipient_nickname;
////
////            }else
////            {
////                _imgUrl = self.chatViewModel.sender_avatar;
////                _myTitle = self.chatViewModel.sender_nickname;
////
////            }
////
////            _subTitle = self.chatViewModel.workInfo_company_name;
////
////
////        }
//        //------------C端从面试管理进来视频聊天---------------
//        if (self.interviewModel)
//        {
//            _imgUrl = self.interviewModel.interviewer_avatar;
//            _myTitle = self.interviewModel.interviewer_nickname;
//            _subTitle = self.interviewModel.company_company_name;
//            //赋值用于发送自定义消息
//            _sendSubTitle = self.interviewModel.work_work_name;
//            _sendTitle = self.interviewModel.candidate_nickname;
////            _sendMarkID = [NSString stringWithFormat:@"%@a",self.interviewModel.candidate_id];
//            self.receiverID = [NSString stringWithFormat:@"%@b",self.interviewModel.interviewer_id];
//
//        }
//
//
//    }
////------------B端或者C端从弹窗进来视频聊天-------------------
//    if (self.videoChatDic) {
//        _imgUrl = self.videoChatDic[Avatar_URL];
//        _myTitle = self.videoChatDic[TITLE];
//        _subTitle = self.videoChatDic[Sub_TITLE];
////        _receiverID = self.videoChatDic[ReceiverID];
//    }else if (self.receiverID){
//
//        [self setVideoInvite_receiverID:self.receiverID];
//
//    }
//
//
//
//
//}
//

#pragma mark - C/B 从面试管理进来视频聊天

-(void)setInterviewModel:(JMInterViewModel *)interviewModel{
    
    [self.view addSubview:self.waitForAnswerView];
    
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];
    if ([userInfoModel.type isEqualToString:B_Type_UESR]) {
        //------------B端从面试管理进来视频聊天---------------
            _imgUrl = interviewModel.candidate_avatar;
            _myTitle = interviewModel.candidate_nickname;
            _subTitle = interviewModel.company_company_name;
            _sendSubTitle = interviewModel.company_company_name;
            _sendTitle = interviewModel.interviewer_nickname;
            //            _sendMarkID = [NSString stringWithFormat:@"%@b",self.interviewModel.interviewer_id];
            self.receiverID =[NSString stringWithFormat:@"%@a",interviewModel.candidate_id];
    }else if([userInfoModel.type isEqualToString:C_Type_USER]) {
        //------------C端从面试管理进来视频聊天---------------
            _imgUrl = interviewModel.interviewer_avatar;
            _myTitle = interviewModel.interviewer_nickname;
            _subTitle = interviewModel.company_company_name;
            //赋值用于发送自定义消息
            _sendSubTitle = interviewModel.work_work_name;
            _sendTitle = interviewModel.candidate_nickname;
            //            _sendMarkID = [NSString stringWithFormat:@"%@a",self.interviewModel.candidate_id];
            self.receiverID = [NSString stringWithFormat:@"%@b",interviewModel.interviewer_id];
        
    }
    _channel_Id = interviewModel.interview_id;
    
    NSDictionary *dic;
    dic = @{
            TITLE:_sendTitle,
            Sub_TITLE:_sendSubTitle,
            Avatar_URL:_imgUrl,
            Channel_ID:_channel_Id
            };
    
    //发送面试邀请1
    if ((self.receiverID)) {
        [self setVideoInvite_receiverID:self.receiverID dic:dic];
    }
    //加入视频聊天频道
    [self joinChannel_channelId:interviewModel.interview_id];
    //布局UI+
//    [self initInfoView_avart:_imgUrl myTitle:_myTitle subTitle:_subTitle];

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
    [self initInfoView_avart:_imgUrl myTitle:_myTitle subTitle:_subTitle];

}
#pragma mark - 布局UI

-(void)initWaitAnswerViewFotViewUI{
    self.waitForAnswerView = [[JMWaitForAnswerView alloc]init];
    self.waitForAnswerView.delegate = self;
    [self.view addSubview:self.waitForAnswerView];
    [self.waitForAnswerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.top.and.left.and.right.mas_equalTo(self.view);
    }];
    
}

-(void)initInfoView_avart:(NSString *)avart myTitle:(NSString *)myTitle subTitle:(NSString *)subTitle{
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];

    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.3;
    [self.controlButtons addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(36);
        if ([userInfoModel.type isEqualToString:B_Type_UESR]) {
            make.bottom.mas_equalTo(self.controlButtons.mas_bottom);
            
        }else {
            
            make.bottom.mas_equalTo(self.controlButtons.mas_top);
            
        }
    }];
    
    UIImageView *iconImg = [[UIImageView alloc]init];
    iconImg.layer.cornerRadius = 12.5;
    [iconImg sd_setImageWithURL:[NSURL URLWithString:avart] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    [self.controlButtons addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(36);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(24);
        make.centerY.mas_equalTo(bgView);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.text = [NSString stringWithFormat:@"%@    %@",myTitle,subTitle];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:15];
    [self.controlButtons addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImg.mas_right).offset(12);
        make.centerY.mas_equalTo(bgView);
    }];



}

#pragma mark - 发送自定义视频面试消息

-(void)setVideoInvite_receiverID:(NSString *)receiverID dic:(NSDictionary *)dic{
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:receiverID];
 

    
    // 转换为 NSData
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    
    
    TIMCustomElem * custom_elem = [[TIMCustomElem alloc] init];
    [custom_elem setData:data];
    [custom_elem setDesc:@"你有一个视频邀请"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeAgoraEngine {
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:VideoAgoraAPIKey delegate:self];
}

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
    //有两种状态可以进入视频聊天
    //    1： 在聊天界面进入，用chat_id做房间id
//    if (self.chatViewModel) _channel_Id = self.chatViewModel.chat_id;
    //    2 ：在面试管理进入，时间到了就会有进入房间按钮 用面试interview_id做房间ID
//    if (self.interviewModel) _channel_Id = self.interviewModel.interview_id;

   [self.agoraKit joinChannelByToken:nil channelId:channelId info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
        // Join channel "demoChannel1"
    }];
    
    // The UID database is maintained by your app to track which users joined which channels. If not assigned (or set to 0), the SDK will allocate one and returns it in joinSuccessBlock callback. The App needs to record and maintain the returned value as the SDK does not maintain it.
    
    [self.agoraKit setEnableSpeakerphone:YES];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}


- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstRemoteVideoDecodedOfUid:(NSUInteger)uid size: (CGSize)size elapsed:(NSInteger)elapsed {
    if (self.remoteVideo.hidden) {
        self.remoteVideo.hidden = NO;
    }
    
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    // Since we are making a simple 1:1 video chat app, for simplicity sake, we are not storing the UIDs. You could use a mechanism such as an array to store the UIDs in a channel.
    
    videoCanvas.view = self.remoteVideo;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    [self.agoraKit setupRemoteVideo:videoCanvas];
    // Bind remote video stream to view
}
#pragma mark - 点击事件
//--等待对方接听界面的关闭按钮--
-(void)waitforAnswerViewHangupAction{
    
    [self leaveChannel];
//    [[[UIApplication sharedApplication].keyWindow viewWithTag:754] removeFromSuperview];


}

-(void)answerAction{

    
}

-(void)hangupAction{


}

- (IBAction)hangUpButton:(UIButton *)sender {
    [self leaveChannel];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:754] removeFromSuperview];

}

- (void)leaveChannel {
    [self.navigationController popViewControllerAnimated:NO];
    [self.agoraKit leaveChannel:^(AgoraChannelStats *stat) {
        [self hideControlButtons];
        [UIApplication sharedApplication].idleTimerDisabled = NO;
        [self.remoteVideo removeFromSuperview];
        [self.localVideo removeFromSuperview];
    }];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason {
    self.remoteVideo.hidden = true;
    [self leaveChannel];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:754] removeFromSuperview];

}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {

    NSLog(@"有人进入");
    [self.waitForAnswerView setHidden:YES];

}

- (void)setupButtons {
    [self performSelector:@selector(hideControlButtons) withObject:nil afterDelay:3];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remoteVideoTapped:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.view.userInteractionEnabled = true;
}

- (void)hideControlButtons {
//    self.controlButtons.hidden = true;
}

- (void)remoteVideoTapped:(UITapGestureRecognizer *)recognizer {
    if (self.controlButtons.hidden) {
        self.controlButtons.hidden = false;
        [self performSelector:@selector(hideControlButtons) withObject:nil afterDelay:3];
    }
    
}

- (void)resetHideButtonsTimer {
    [JMVideoChatViewController cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideControlButtons) withObject:nil afterDelay:3];
}

- (IBAction)didClickMuteButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.agoraKit muteLocalAudioStream:sender.selected];
    [self resetHideButtonsTimer];
}

- (IBAction)didClickVideoMuteButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.agoraKit muteLocalVideoStream:sender.selected];
    self.localVideo.hidden = sender.selected;
    self.localVideoMutedBg.hidden = !sender.selected;
    self.localVideoMutedIndicator.hidden = !sender.selected;
    [self resetHideButtonsTimer];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didVideoMuted:(BOOL)muted byUid:(NSUInteger)uid {
    self.remoteVideo.hidden = muted;
    self.remoteVideoMutedIndicator.hidden = !muted;
}

- (void) hideVideoMuted {
    self.remoteVideoMutedIndicator.hidden = true;
    self.localVideoMutedBg.hidden = true;
    self.localVideoMutedIndicator.hidden = true;
}

- (IBAction)didClickSwitchCameraButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.agoraKit switchCamera];
    [self resetHideButtonsTimer];
}

#pragma mark - lazy

//对方邀请你视频，可以接听或者挂断
-(JMAnswerOrHangUpView *)answerOrHangUpView{
    if (_answerOrHangUpView == nil) {
        _answerOrHangUpView = [[JMAnswerOrHangUpView alloc]initWithFrame:self.view.bounds];
        _answerOrHangUpView.delegate = self;
        
    }
    return _answerOrHangUpView;
}

//等待对方接听 只有关闭按钮
-(JMWaitForAnswerView *)waitForAnswerView{
    if (_waitForAnswerView == nil) {
        _waitForAnswerView = [[JMWaitForAnswerView alloc]initWithFrame:self.view.bounds];
        _waitForAnswerView.delegate = self;
        
    }
    return _waitForAnswerView;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
