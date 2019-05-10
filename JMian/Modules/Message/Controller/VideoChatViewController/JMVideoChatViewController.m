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
    //有两种状态可以进入视频聊天

    [self initInfoView];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];

}

-(void)initInfoView
{
    JMUserInfoModel *userInfoModel = [JMUserInfoManager getUserInfo];
    
    NSString *imgUrl;
    NSString *title;
    NSString *subTitle;
    if ([userInfoModel.type isEqualToString:B_Type_UESR]) {
        if (self.model)//从聊天界面进来
        {
            if ([self.model.sender_user_id isEqualToString:userInfoModel.user_id]) {//逻辑和聊天界面一样
                imgUrl = self.model.recipient_avatar;
                title = self.model.recipient_nickname;
          
            }else
            {
                imgUrl = self.model.sender_avatar;
                title = self.model.sender_nickname;
            
            }
            
            subTitle = self.model.work_work_name;
            
            
        }
        if (self.interviewModel)//从面试管理进来
        {
            imgUrl = self.interviewModel.candidate_avatar;
            title = self.interviewModel.candidate_nickname;
            subTitle = self.interviewModel.work_work_name;
            
        }
    }else if([userInfoModel.type isEqualToString:C_Type_USER]) {
        if (self.model)//从聊天界面进来
        {
            if ([self.model.sender_user_id isEqualToString:userInfoModel.user_id]) {//逻辑和聊天界面一样
                imgUrl = self.model.recipient_avatar;
                title = self.model.recipient_nickname;
                
            }else
            {
                imgUrl = self.model.sender_avatar;
                title = self.model.sender_nickname;
                
            }
            
            subTitle = self.model.work_work_name;
            
            
        }
        if (self.interviewModel)//从面试管理进来
        {
            imgUrl = self.interviewModel.interviewer_avatar;
            title = self.interviewModel.interviewer_nickname;
            subTitle = self.interviewModel.work_work_name;
            
        }
        
        
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
    [iconImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    [self.controlButtons addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(36);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(24);
        make.centerY.mas_equalTo(bgView);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.text = [NSString stringWithFormat:@"%@    %@",title,subTitle];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:15];
    [self.controlButtons addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImg.mas_right).offset(12);
        make.centerY.mas_equalTo(bgView);
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
    NSString *channelId;
    //    1： 在聊天界面进入，用chat_id做房间id
    if (self.model) channelId = self.model.chat_id;
    //    2 ：在面试管理进入，时间到了就会有进入房间按钮 用面试interview_id做房间ID
    if (self.interviewModel) channelId = self.interviewModel.interview_id;

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

- (IBAction)hangUpButton:(UIButton *)sender {
    [self leaveChannel];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
