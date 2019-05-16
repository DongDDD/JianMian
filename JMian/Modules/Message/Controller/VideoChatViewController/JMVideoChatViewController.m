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

@interface JMVideoChatViewController ()

@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;
@property (weak, nonatomic) IBOutlet UIView *localVideo;
@property (weak, nonatomic) IBOutlet UIView *remoteVideo;
@property (weak, nonatomic) IBOutlet UIView *controlButtons;
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
    [self joinChannel];
    //有两种种状态可以进入视频聊天

    [self initInfoView];
//    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];

    //发送自定义消息 videoChatDic不为空代表是从弹窗进来
    if (self.videoChatViewType == JMJMVideoChatViewFromInterview) {
        [self setVideoInvite];
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];

}



-(void)initInfoView
{
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];

    if ([userInfoModel.type isEqualToString:B_Type_UESR]) {
//        if (self.chatViewModel)//从聊天界面进来 【取消】
//        {
//            if ([self.chatViewModel.sender_user_id isEqualToString:userInfoModel.user_id]) {//逻辑和聊天界面一样
//                _imgUrl = self.chatViewModel.recipient_avatar;
//                _myTitle = self.chatViewModel.recipient_nickname;
//                _HRName = self.chatViewModel.sender_nickname;
//                _HRAvart = self.chatViewModel.sender_avatar;
//            }else
//            {
//                _imgUrl = self.chatViewModel.sender_avatar;
//                _myTitle = self.chatViewModel.sender_nickname;
//                _HRName = self.chatViewModel.recipient_nickname;
//                _HRAvart = self.chatViewModel.recipient_avatar;
//
//            }
//
//            _company_name = self.chatViewModel.workInfo_company_name;
//            _subTitle = self.chatViewModel.work_work_name;
//
//        }
        //------------B端从面试管理进来视频聊天---------------

        if (self.interviewModel)
        {
            _imgUrl = self.interviewModel.candidate_avatar;
            _myTitle = self.interviewModel.candidate_nickname;
            _subTitle = self.interviewModel.company_company_name;
            _sendSubTitle = self.interviewModel.company_company_name;
            _sendTitle = self.interviewModel.interviewer_nickname;
//            _sendMarkID = [NSString stringWithFormat:@"%@b",self.interviewModel.interviewer_id];
            self.receiverID =[NSString stringWithFormat:@"%@a",self.interviewModel.candidate_id];
            
        }
        
        
    
    }else if([userInfoModel.type isEqualToString:C_Type_USER]) {
//        if (self.chatViewModel)//C端从聊天界面进来
//        {
//            if ([self.chatViewModel.sender_user_id isEqualToString:userInfoModel.user_id]) {//逻辑和聊天界面一样
//                _imgUrl = self.chatViewModel.recipient_avatar;
//                _myTitle = self.chatViewModel.recipient_nickname;
//
//            }else
//            {
//                _imgUrl = self.chatViewModel.sender_avatar;
//                _myTitle = self.chatViewModel.sender_nickname;
//
//            }
//
//            _subTitle = self.chatViewModel.workInfo_company_name;
//
//
//        }
        //------------C端从面试管理进来视频聊天---------------
        if (self.interviewModel)
        {
            _imgUrl = self.interviewModel.interviewer_avatar;
            _myTitle = self.interviewModel.interviewer_nickname;
            _subTitle = self.interviewModel.company_company_name;
            //赋值用于发送自定义消息
            _sendSubTitle = self.interviewModel.work_work_name;
            _sendTitle = self.interviewModel.candidate_nickname;
//            _sendMarkID = [NSString stringWithFormat:@"%@a",self.interviewModel.candidate_id];
            self.receiverID = [NSString stringWithFormat:@"%@b",self.interviewModel.interviewer_id];

        }
        
        
    }
//------------B端或者C端从弹窗进来视频聊天-------------------
    if (self.videoChatDic) {
        _imgUrl = self.videoChatDic[Avatar_URL];
        _myTitle = self.videoChatDic[TITLE];
        _subTitle = self.videoChatDic[Sub_TITLE];
//        _receiverID = self.videoChatDic[ReceiverID];
    }

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
    [iconImg sd_setImageWithURL:[NSURL URLWithString:_imgUrl] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    [self.controlButtons addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(36);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(24);
        make.centerY.mas_equalTo(bgView);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.text = [NSString stringWithFormat:@"%@    %@",_myTitle,_subTitle];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:15];
    [self.controlButtons addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImg.mas_right).offset(12);
        make.centerY.mas_equalTo(bgView);
    }];
    
    
}

#pragma mark - 发送自定义视频面试消息

-(void)setVideoInvite{
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:self.receiverID];
    NSDictionary *dic;
        dic = @{
                TITLE:_sendTitle,
                Sub_TITLE:_sendSubTitle,
                Avatar_URL:_imgUrl,
                Channel_ID:_channel_Id
                };

    
    // 转换为 NSData
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    
    
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

- (void)joinChannel {
    //有两种状态可以进入视频聊天
    //    1： 在聊天界面进入，用chat_id做房间id
    if (self.chatViewModel) _channel_Id = self.chatViewModel.chat_id;
    //    2 ：在面试管理进入，时间到了就会有进入房间按钮 用面试interview_id做房间ID
    if (self.interviewModel) _channel_Id = self.interviewModel.interview_id;

   [self.agoraKit joinChannelByToken:nil channelId:_channel_Id info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
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

- (IBAction)hangUpButton:(UIButton *)sender {
    [self leaveChannel];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:754] removeFromSuperview];
//    self.didCloseVideo = ^{
//
//    };
}

- (void)leaveChannel {
    [self.navigationController popViewControllerAnimated:YES];
    [self.agoraKit leaveChannel:^(AgoraChannelStats *stat) {
        [self hideControlButtons];
        [UIApplication sharedApplication].idleTimerDisabled = NO;
        [self.remoteVideo removeFromSuperview];
        [self.localVideo removeFromSuperview];
    }];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason {
    self.remoteVideo.hidden = true;
}

- (void)setupButtons {
    [self performSelector:@selector(hideControlButtons) withObject:nil afterDelay:3];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remoteVideoTapped:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.view.userInteractionEnabled = true;
}

- (void)hideControlButtons {
    self.controlButtons.hidden = true;
}

- (void)remoteVideoTapped:(UITapGestureRecognizer *)recognizer {
    if (self.controlButtons.hidden) {
        self.controlButtons.hidden = false;
        [self performSelector:@selector(hideControlButtons) withObject:nil afterDelay:3];
    }
}

- (void)resetHideButtonsTimer {
    [JMVideoChatViewController cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideControlButtons) withObject:nil afterDelay:1000];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
