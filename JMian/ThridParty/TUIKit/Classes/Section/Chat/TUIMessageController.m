//
//  TUIMessageController.m
//  UIKit
//
//  Created by annidyfeng on 2019/7/1.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "TUIMessageController.h"
#import "TUITextMessageCell.h"
#import "JMPushMessageCell.h"
#import "TUISystemMessageCell.h"
#import "TUIVoiceMessageCell.h"
#import "TUIImageMessageCell.h"
#import "TUIFaceMessageCell.h"
#import "TUIVideoMessageCell.h"
#import "TUIFileMessageCell.h"
#import "TUIJoinGroupMessageCell.h"
#import "JMTransferTableViewCell.h"
#import "TUIKitConfig.h"
#import "TUIFaceView.h"
#import "THeader.h"
#import "TUIKit.h"
#import "THelper.h"
#import "TUIConversationCellData.h"
#import "TIMMessage+DataProvider.h"
#import "TUIImageViewController.h"
#import "TUIVideoViewController.h"
#import "TUIFileViewController.h"
#import "TUIConversationDataProviderService.h"
#import "NSString+Common.h"
#import "ReactiveObjC/ReactiveObjC.h"
#import "MMLayout/UIView+MMLayout.h"
#import "TIMMessage+DataProvider.h"
#import "TUIUserProfileControllerServiceProtocol.h"
#import <ImSDK/ImSDK.h>
#import "DimensMacros.h"
#import "JMChatDetailInfoTableViewCell.h"
#import "JMChatDetailPartTimeJobTableViewCell.h"
#import "JMChatViewSectionView.h"
#import "JMCDetailViewController.h"
#import "JMBDetailViewController.h"
#import "JobDetailsViewController.h"
#import "JMHomeWorkModel.h"
#import "JMHTTPManager+InterView.h"
#import "JMHTTPManager+CreateTaskOrder.h"
#import "JMVideoChatView.h"
#import "THDatePickerView.h"
#import "JMHTTPManager+UnReadNotice.h"
#import "JMPersonInfoViewController.h"
#import "JMPushVCAction.h"
#import "JMHTTPManager+Transfer.h"//转账
#import "JMMoneyDetailsViewController.h"
#define MAX_MESSAGE_SEP_DLAY (5 * 60)

static NSString *cellIdent = @"infoCellIdent";
static NSString *cellIdent2 = @"partTimeInfoCellIdent";


@interface TUIMessageController () <TIMMessageListener, TMessageCellDelegate,JMChatDetailPartTimeJobTableViewCellDelegate,JMChatDetailInfoTableViewCellDelegate,JMChatViewSectionViewDelegate,THDatePickerViewDelegate>
@property (nonatomic, strong) TIMConversation *conv;
@property (nonatomic, strong) NSMutableArray *uiMsgs;
@property (nonatomic, strong) NSMutableArray *heightCache;
@property (nonatomic, strong) TIMMessage *msgForDate;
@property (nonatomic, strong) TIMMessage *msgForGet;
@property (nonatomic, strong) TUIMessageCellData *menuUIMsg;
@property (nonatomic, strong) TUIMessageCellData *reSendUIMsg;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, assign) BOOL isScrollBottom;
@property (nonatomic, assign) BOOL isLoadingMsg;
@property (nonatomic, assign) BOOL noMoreMsg;
@property (nonatomic, assign) BOOL firstLoad;
@property (nonatomic, assign)BOOL isHiddenHeaderInfo;

@property (nonatomic, assign) NSInteger section;

@property (weak, nonatomic) THDatePickerView *dateView;
@property (strong, nonatomic) UIButton *BgBtn;//点击背景  隐藏时间选择器
@property (strong, nonatomic) JMVideoChatView *videoChatView;


@property id<TUIConversationDataProviderServiceProtocol> conversationDataProviderService;

@end

@implementation TUIMessageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [self initDatePickerView];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self readedReport];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self readedReport];
    [super viewWillDisappear:animated];
}

- (void)readedReport
{
    
    
    [self.conv setReadMessage:nil succ:nil fail:^(int code, NSString *msg) {
        
    }];
}

- (void)setupViews
{
    
    //    if ([self.myConvModel.data.convId isEqualToString:@"dominator"]) {
    //        _isDominator = YES;
    //    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNewMessage:) name:TUIKitNotification_TIMMessageListener object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onRevokeMessage:) name:TUIKitNotification_TIMMessageRevokeListener object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUploadMessage:) name:TUIKitNotification_TIMUploadProgressListener object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTransferActoin) name:Notification_Transfer object:nil];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSelectMessageNotification:) name:@"onSelectMessageNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLongPressNotification:) name:@"onLongPressNotification" object:nil];


    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapViewController)];
    [self.view addGestureRecognizer:tap];
    self.tableView.estimatedRowHeight = 0;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = TMessageController_Background_Color;
    
    [self.tableView registerClass:[TUITextMessageCell class] forCellReuseIdentifier:TTextMessageCell_ReuseId];
    [self.tableView registerClass:[JMPushMessageCell class] forCellReuseIdentifier:JMPushtMessageCell_ReuseId];
    [self.tableView registerClass:[TUIVoiceMessageCell class] forCellReuseIdentifier:TVoiceMessageCell_ReuseId];
    [self.tableView registerClass:[TUIImageMessageCell class] forCellReuseIdentifier:TImageMessageCell_ReuseId];
    [self.tableView registerClass:[TUISystemMessageCell class] forCellReuseIdentifier:TSystemMessageCell_ReuseId];
    [self.tableView registerClass:[TUIFaceMessageCell class] forCellReuseIdentifier:TFaceMessageCell_ReuseId];
    [self.tableView registerClass:[TUIVideoMessageCell class] forCellReuseIdentifier:TVideoMessageCell_ReuseId];
    [self.tableView registerClass:[TUIFileMessageCell class] forCellReuseIdentifier:TFileMessageCell_ReuseId];
    [self.tableView registerClass:[TUIJoinGroupMessageCell class] forCellReuseIdentifier:TJoinGroupMessageCell_ReuseId];
    [self.tableView registerClass:[JMTransferTableViewCell class] forCellReuseIdentifier:JMtransferMessageCell_ReuseId];

    [self.tableView registerNib:[UINib nibWithNibName:@"JMChatDetailInfoTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    [self.tableView registerNib:[UINib nibWithNibName:@"JMChatDetailPartTimeJobTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent2];
    
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, TMessageController_Header_Height)];
    _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.tableView.tableHeaderView = _indicatorView;
    
    _heightCache = [NSMutableArray array];
    _uiMsgs = [[NSMutableArray alloc] init];
    _firstLoad = YES;
    
    
}

- (void)setConversation:(TIMConversation *)conversation
{
    _conv = conversation;
    //1 系统消息   2 客服  3 招客服Type = 3   三种情况隐藏头部信息
    if ([self.myConvModel.data.convId isEqualToString:@"dominator"] || self.myConvModel.viewType == JMMessageList_Type_Service || [self.myConvModel.type isEqualToString:@"3"] || self.myConvModel.viewType == JMMessageList_Type_Group || [self.myConvModel.type isEqualToString:@"4"]) {
        _isHiddenHeaderInfo = YES;
    }
    
    self.conversationDataProviderService = [[TCServiceManager shareInstance] createService:@protocol(TUIConversationDataProviderServiceProtocol)];
    [self loadMessage];
}

- (void)loadMessage
{
    if(_isLoadingMsg || _noMoreMsg){
        return;
    }
    _isLoadingMsg = YES;
    int msgCount = 20;
    
    @weakify(self)
    [self.conversationDataProviderService getMessage:self.conv count:msgCount last:_msgForGet succ:^(NSArray *msgs) {
        @strongify(self)
        if(msgs.count != 0){
            self.msgForGet = msgs[msgs.count - 1];
            self.section = 1;
        }
        NSMutableArray *uiMsgs = [self transUIMsgFromIMMsg:msgs];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(msgs.count < msgCount){
                self.section = 2;
                self.noMoreMsg = YES;
                self.indicatorView.mm_h = 0;
                [self.tableView reloadData];
            }
            if(uiMsgs.count != 0){
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, uiMsgs.count)];
                [self.uiMsgs insertObjects:uiMsgs atIndexes:indexSet];
                [self.heightCache removeAllObjects];
                [self.tableView reloadData];
                [self.tableView layoutIfNeeded];
                if(!self.firstLoad){
                    CGFloat visibleHeight = 0;
                    for (NSInteger i = 0; i < uiMsgs.count; ++i) {
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:self.section-1];
                        visibleHeight += [self tableView:self.tableView heightForRowAtIndexPath:indexPath];
                    }
                    if(self.noMoreMsg){
                        visibleHeight -= TMessageController_Header_Height;
                    }
                    [self.tableView scrollRectToVisible:CGRectMake(0, self.tableView.contentOffset.y + visibleHeight, self.tableView.frame.size.width, self.tableView.frame.size.height) animated:NO];
                }
            }
            self.isLoadingMsg = NO;
            [self.indicatorView stopAnimating];
            self.firstLoad = NO;
        });
    } fail:^(int code, NSString *msg) {
        @strongify(self)
        self.isLoadingMsg = NO;
        [THelper makeToastError:code msg:msg];
    }];
}

- (void)onNewMessage:(NSNotification *)notification
{
    NSArray *msgs = notification.object;
    NSMutableArray *uiMsgs = [self transUIMsgFromIMMsg:msgs];
    if (uiMsgs.count > 0) {
        [_uiMsgs addObjectsFromArray:uiMsgs];
        [self.tableView reloadData];
        [self scrollToBottom:YES];
    }
    
    
}

- (void)onRevokeMessage:(NSNotification *)notification
{
    TIMMessageLocator *locator = notification.object;
    TUIMessageCellData *uiMsg = nil;
    for (uiMsg in _uiMsgs) {
        TIMMessage *imMsg = uiMsg.innerMessage;
        if(imMsg){
            if([imMsg respondsToLocator:locator]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self revokeMsg:uiMsg];
                });
                break;
            }
        }
    }
}

- (void)onUploadMessage:(NSNotification *)notification
{
    NSDictionary *dic = notification.object;
    TIMMessage *msg = [dic objectForKey:@"message"];
    NSNumber *progress = [dic objectForKey:@"progress"];
    for (NSInteger i = 0; i < _uiMsgs.count; ++i) {
        TUIMessageCellData *uiMsg = _uiMsgs[i];
        TIMMessage *imMsg = uiMsg.innerMessage;
        if(imMsg){
            if([imMsg respondsToLocator:[msg locator]]){
                if([uiMsg isKindOfClass:[TUIImageMessageCellData class]]){
                    TUIImageMessageCellData *data = (TUIImageMessageCellData *)uiMsg;
                    data.uploadProgress = progress.intValue;
                }
                else if([uiMsg isKindOfClass:[TUIVideoMessageCellData class]]){
                    TUIVideoMessageCellData *data = (TUIVideoMessageCellData *)uiMsg;
                    data.uploadProgress = progress.intValue;
                }
                else if([uiMsg isKindOfClass:[TUIFileMessageCellData class]]){
                    TUIFileMessageCellData *data = (TUIFileMessageCellData *)uiMsg;
                    data.uploadProgress = progress.intValue;
                }
            }
        }
    }
}

- (NSMutableArray *)transUIMsgFromIMMsg:(NSArray *)msgs
{
    NSMutableArray *uiMsgs = [NSMutableArray array];
    for (NSInteger k = msgs.count - 1; k >= 0; --k) {
        TIMMessage *msg = msgs[k];
        if(msg.status == TIM_MSG_STATUS_HAS_DELETED){
            continue;
        }
        
        //判断有没要展示的 elem
        bool hasShowElem = false;
        for (int i = 0; i < msg.elemCount; ++i) {
            TIMElem *elem = [msg getElem:i];
            if ([elem isKindOfClass:[TIMSNSSystemElem class]] || [elem isKindOfClass:[TIMProfileSystemElem class]]) {
                //资料关系链消息不往列表里面抛
                continue;
            }
            if ([elem isKindOfClass:[TIMGroupTipsElem class]]) {
                TIMGroupTipsElem *gt = (TIMGroupTipsElem *)elem;
                if (![[gt group] isEqualToString:[_conv getReceiver]]) {
                    continue;
                }
            } else if ([elem isKindOfClass:[TIMGroupSystemElem class]]) {
                TIMGroupSystemElem *gs = (TIMGroupSystemElem *)elem;
                if (![[gs group] isEqualToString:[_conv getReceiver]]) {
                    continue;
                }
            } else if(![[[msg getConversation] getReceiver] isEqualToString:[_conv getReceiver]]){
                continue;
            }
            hasShowElem =true;
        }
        if (hasShowElem == false) {
            continue;
        }
        
        TUISystemMessageCellData *dateMsg = [self transSystemMsgFromDate:msg.timestamp];
        if (dateMsg) {
            _msgForDate = msg;
            [uiMsgs addObject:dateMsg];
        }
        if(msg.status == TIM_MSG_STATUS_LOCAL_REVOKED){
            TUISystemMessageCellData *revoke = [msg revokeCellData];
            [uiMsgs addObject:revoke];
            continue;
        }
        for (int i = 0; i < msg.elemCount; ++i) {
            TIMElem *elem = [msg getElem:i];
            if ([elem isKindOfClass:[TIMSNSSystemElem class]] || [elem isKindOfClass:[TIMProfileSystemElem class]]) {
                //资料关系链消息不往列表里面抛
                continue;
            }
            //目前此处已经实现了一步到位，但为了暂时的查阅方便，仍保留了其判断逻辑，
            TUIMessageCellData *data = nil;
            if([elem isKindOfClass:[TIMTextElem class]] || [elem isKindOfClass:[TIMFaceElem class]] || [elem isKindOfClass:[TIMImageElem class]] || [elem isKindOfClass:[TIMSoundElem class]] || [elem isKindOfClass:[TIMVideoElem class]] || [elem isKindOfClass:[TIMFileElem class]]){
                
                data = [msg cellDataFromElem:elem];
                
            } else if ([elem isKindOfClass:[TIMCustomElem class]]) {
                
                data = [msg cellDataFromElem:elem];
                
            } else {
                
                data = [msg cellDataFromElem:elem];
                
            }
            
            if([[msg getConversation] getType] == TIM_GROUP && !msg.isSelf
               && ![data isKindOfClass:[TUISystemMessageCellData class]]){
                data.showName = YES;
            }
            
            if(data) {
                data.direction = msg.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming;
                data.identifier = [msg sender];
                
                NSString *nameCard;
                if([[msg getConversation] getType] == TIM_GROUP){
                    nameCard = [msg getSenderGroupMemberProfile].nameCard;
                }
                
                void (^block)(TIMUserProfile *) = ^(TIMUserProfile *profile)  {
                    if([[msg getConversation] getType] == TIM_GROUP){
                        data.name = [msg getSenderGroupMemberProfile].nameCard;
                    }
                    //更新 profile
                    if (nameCard.length == 0)
                        data.name = [profile showName];
                    if (profile.faceURL)
                        data.avatarUrl = [NSURL URLWithString:[profile faceURL]];
                };
                
                [msg getSenderProfile:block];
                
                
                //此处改为 群名片>昵称>ID。当高优先级为空时在使用低优先级变量。
                TIMUserProfile *userProfile = [[TIMFriendshipManager sharedInstance] queryUserProfile:msg.sender];
                //data.name = nameCard.length ? nameCard : userProfile.showName;
                
                switch (msg.status) {
                    case TIM_MSG_STATUS_SEND_SUCC:
                        data.status = Msg_Status_Succ;
                        break;
                    case TIM_MSG_STATUS_SEND_FAIL:
                        data.status = Msg_Status_Fail;
                        break;
                    case TIM_MSG_STATUS_SENDING:
                        data.status = Msg_Status_Sending_2;
                        break;
                    default:
                        break;
                }
                //客服
//                if (self.myConvModel.service_id.length > 0) {
//                    data.avatarImage = [UIImage imageNamed:@"kf"];
//                }else{
                
                    if (data.direction == MsgDirectionIncoming) {
                        //消息接收方
                        if (self.myConvModel.service_id.length > 0) {
//                            data.avatarImage = [UIImage imageNamed:@"kf"];
                            data.avatarUrl = [NSURL URLWithString:@"http://produce.jmzhipin.com/h5/images/customer.png"];
//                            data.name = @"在线客服";
                        }else{
//                            NSString *avartStr = [self getAvartUrlWithConvModel:self.myConvModel];
                            data.avatarUrl = [NSURL URLWithString:userProfile.faceURL];
                        }
                    }else if (data.direction == MsgDirectionOutgoing) {
                        //自己
                        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
                        NSString *avartStr =  userModel.avatar;
                        data.avatarUrl = [NSURL URLWithString:avartStr];
                    }
                    
//                }
                
                //系统消息
                if ([self.myConvModel.data.convId isEqualToString:@"dominator"]) {
                    data.avatarImage = [UIImage imageNamed:@"notification"];
                }
                data.innerMessage = msg;
                [uiMsgs addObject:data];
            }
//            if ([self.delegate respondsToSelector:@selector(messageController:onNewMessage:)]) {
//                TUIMessageCellData *data = [self.delegate messageController:self onNewMessage:msg];
//                if (data) {
//                    [uiMsgs addObject:data];
//                    continue;
//                }
//            }
        }
    }
    return uiMsgs;
}

-(void)initDatePickerView
{
    self.BgBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
    self.BgBtn.backgroundColor = [UIColor blackColor];
    self.BgBtn.hidden = YES;
    self.BgBtn.alpha = 0.3;
    [self.view addSubview:self.BgBtn];
    
    THDatePickerView *dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 300)];
    dateView.delegate = self;
    dateView.title = @"请选择时间";
    //    dateView.isSlide = NO;
    //    dateView.date = @"2017-03-23 12:43";
    //    dateView.minuteInterval = 1;
    
    [[UIApplication sharedApplication].keyWindow addSubview:dateView];
    self.dateView = dateView;
    [self.dateView setHidden:YES];
    
}

-(NSString *)getAvartUrlWithConvModel:(JMMessageListModel *)convModel{
    
    if([self.conv.getReceiver isEqualToString: _myConvModel.sender_mark]) {
        return _myConvModel.sender_avatar;
        
    }else {

        return _myConvModel.recipient_avatar;
    }
        
}

-(void)onTransferActoin{
    [self.navigationController pushViewController:[[JMMoneyDetailsViewController alloc]init] animated:YES];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if (!_isHiddenHeaderInfo && [userModel.type isEqualToString:B_Type_UESR]) {
        
        if (section == self.section - 2) {
            
            return 43;
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == self.section - 2 && ![self.myConvModel.type isEqualToString:@"3"]) {
        JMChatViewSectionView *view=[[JMChatViewSectionView alloc] init];
        view.delegate = self;
        return view ;
    }
    return nil;
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == self.section - 1) {
        
        if (_isScrollBottom == NO) {
            [self scrollToBottom:NO];
            if (indexPath.row == _uiMsgs.count-1) {
                _isScrollBottom = YES;
            }
        }
        
    }
    //    if (_isScrollBottom == NO) {
    //        [self scrollToBottom:NO];
    //        if (indexPath.row == _uiMsgs.count-1) {
    //            _isScrollBottom = YES;
    //        }
    //    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == self.section - 1) ? _uiMsgs.count : 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.section;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    CGFloat height = 0;
    //    if(_heightCache.count > indexPath.row){
    //        return [_heightCache[indexPath.row] floatValue];
    //    }
    //    TUIMessageCellData *data = _uiMsgs[indexPath.row];
    //    height = [data heightOfWidth:Screen_Width];
    //    [_heightCache insertObject:[NSNumber numberWithFloat:height] atIndex:indexPath.row];
    if (indexPath.section == self.section - 2) {
        
        if (_isHiddenHeaderInfo) {
            return 0;
        }
        if ([self.myConvModel.type isEqualToString:@"2"]) {
            //兼职对话类型
            JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
            if ([userModel.type isEqualToString:B_Type_UESR]) {
                //兼职对话，兼职简历为空
                if (!self.myConvModel.job_ability_id) {
                    return 0;
                }
            }else{
                //兼职对话，招聘信息为空
                if (!self.myConvModel.work_task_id) {
                    return 0;
                }
            }
            
        }
        return 200;
        
        
    }else {
        
        CGFloat height = 0;
        if(_heightCache.count > indexPath.row){
            return [_heightCache[indexPath.row] floatValue];
        }
        TUIMessageCellData *data = _uiMsgs[indexPath.row];
//        if ([data isKindOfClass:JMTransferMessageCellData cla]) {
//            return 110;
//        }
        if ([data isKindOfClass:[JMTransferMessageCellData class]]) {
            height = 110;
        }else{
            height = [data heightOfWidth:Screen_Width];
            
        }
        [_heightCache insertObject:[NSNumber numberWithFloat:height] atIndex:indexPath.row];
        return height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.section - 2) {
        
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        //兼职类型对话且招聘信息不为空，且是C端用户
        if ([self.myConvModel.type isEqualToString:@" 2"] && self.myConvModel.work_task_id && [userModel.type isEqualToString:C_Type_USER] && !_isHiddenHeaderInfo) {
            JMChatDetailPartTimeJobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent2 forIndexPath:indexPath];
            if(cell == nil)
            {
                cell = [[JMChatDetailPartTimeJobTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent2];
            }
            cell.delegate = self;
            [cell setMyConModel:self.myConvModel];
  
            return cell;
        }
        
        JMChatDetailInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
        
        if(cell == nil)
        {
            cell = [[JMChatDetailInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
        }
        cell.delegate = self;
    
        
        //兼职对话类型
        if ([self.myConvModel.type isEqualToString:@"2"]) {
            JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
            if ([userModel.type isEqualToString:B_Type_UESR]) {
                //兼职对话，兼职简历为空
                if (!self.myConvModel.job_ability_id) {
                    [cell setHidden:YES];
                }else{
                    [cell setHidden:NO];
                    [cell setMyConModel:self.myConvModel];
                }
            }else{
                //兼职对话，招聘信息为空
                if (!self.myConvModel.work_task_id) {
                    [cell setHidden:YES];
                }else{
                    [cell setHidden:NO];
                    [cell setMyConModel:self.myConvModel];
                }
            }
            
            
            
        }else if([self.myConvModel.type isEqualToString:@"1"]){
            [cell setMyConModel:self.myConvModel];
        }
        //管理员隐藏头部对话信息详情
        if (_isHiddenHeaderInfo) {
            [cell setHidden:YES];
        }
        cell.backgroundColor = TMessageController_Background_Color;
        return cell;
        
        
    } else {
        
        TUIMessageCellData *data = _uiMsgs[indexPath.row];
        TUIMessageCell *cell = nil;
//        if ([self.delegate respondsToSelector:@selector(messageController:onShowMessageData:)]) {
//            cell = [self.delegate messageController:self onShowMessageData:data];
//            if (cell) {
//                return cell;
//            }
//        }
        if (!data.reuseId) {
            if([data isKindOfClass:[JMPushMessageCellData class]]) {
                data.reuseId = JMPushtMessageCell_ReuseId;
            }
            else if([data isKindOfClass:[TUITextMessageCellData class]]) {
                data.reuseId = TTextMessageCell_ReuseId;
            }
            else if([data isKindOfClass:[TUIFaceMessageCellData class]]) {
                data.reuseId = TFaceMessageCell_ReuseId;
            }
            else if([data isKindOfClass:[TUIImageMessageCellData class]]) {
                data.reuseId = TImageMessageCell_ReuseId;
            }
            else if([data isKindOfClass:[TUIVideoMessageCellData class]]) {
                data.reuseId = TVideoMessageCell_ReuseId;
            }
            else if([data isKindOfClass:[TUIVoiceMessageCellData class]]) {
                data.reuseId = TVoiceMessageCell_ReuseId;
            }
            else if([data isKindOfClass:[TUIFileMessageCellData class]]) {
                data.reuseId = TFileMessageCell_ReuseId;
            }
            else if([data isKindOfClass:[TUIJoinGroupMessageCellData class]]){//入群小灰条对应的数据源
                data.reuseId = TJoinGroupMessageCell_ReuseId;
            }
            else if([data isKindOfClass:[TUISystemMessageCellData class]]) {
                data.reuseId = TSystemMessageCell_ReuseId;
            }
            else if([data isKindOfClass:[JMTransferMessageCellData class]]) {
                data.reuseId = JMtransferMessageCell_ReuseId;
            }
            
            else {
                return nil;
            }
        }
        cell = [tableView dequeueReusableCellWithIdentifier:data.reuseId forIndexPath:indexPath];
        //对于入群小灰条，需要进一步设置其委托。
        if([cell isKindOfClass:[TUIJoinGroupMessageCell class]]){
            TUIJoinGroupMessageCell *joinCell = (TUIJoinGroupMessageCell *)cell;
            joinCell.joinGroupDelegate = self;
            cell = joinCell;
        }
        cell.delegate = self;
        TUIMessageCellData *cellData = _uiMsgs[indexPath.row];
        [cell fillWithData:cellData];
//        if ([self.conv.getReceiver isEqualToString:@"dominator"]) {
//            cell.avatarView.image = [UIImage imageNamed:@"notification"];
//        }

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)scrollToBottom:(BOOL)animate
{
    if (_uiMsgs.count > 0 && self.section > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_uiMsgs.count - 1 inSection:self.section-1] atScrollPosition:UITableViewScrollPositionBottom animated:animate];
    }
}

- (void)didTapViewController
{
    if(_delegate && [_delegate respondsToSelector:@selector(didTapInMessageController:)]){
        [_delegate didTapInMessageController:self];
    }
}

- (void)sendMessage:(TUIMessageCellData *)msg
{
    [self.tableView beginUpdates];
    TIMMessage *imMsg = msg.innerMessage;
    TUIMessageCellData *dateMsg = nil;
    
    if (msg.status == Msg_Status_Init)
    {
        //新消息
        if (!imMsg) {
            imMsg = [self transIMMsgFromUIMsg:msg];
        }
        dateMsg = [self transSystemMsgFromDate:imMsg.timestamp];
        
    } else if (imMsg) {
        //重发
        dateMsg = [self transSystemMsgFromDate:[NSDate date]];
        NSInteger row = [_uiMsgs indexOfObject:msg];
        [_heightCache removeObjectAtIndex:row];
        [_uiMsgs removeObjectAtIndex:row];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:self.section-1]]
                              withRowAnimation:UITableViewRowAnimationFade];
    } else {
        [self.tableView endUpdates];
        NSLog(@"Unknown message state");
        return;
    }
    TIMUserProfile *selfProfile = [[TIMFriendshipManager sharedInstance] querySelfProfile];
    
    msg.status = Msg_Status_Sending;
    msg.name = [selfProfile showName];
    msg.avatarUrl = [NSURL URLWithString:selfProfile.faceURL];
    
    if(dateMsg){
        _msgForDate = imMsg;
        [_uiMsgs addObject:dateMsg];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_uiMsgs.count - 1 inSection:self.section-1]]
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    [_uiMsgs addObject:msg];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_uiMsgs.count - 1 inSection:self.section-1]]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    [self scrollToBottom:YES];
    
    __weak typeof(self) ws = self;
    [self.conv sendMessage:imMsg succ:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [ws changeMsg:msg status:Msg_Status_Succ];
        });
        if (self.myConvModel.viewType == JMMessageList_Type_C2C) {
            // 小程序推送
            [self  unReadNoticeRequestWithData:msg];

        }
        
    } fail:^(int code, NSString *desc) {
        NSLog(@"====== %ld",(long)imMsg.status);
        dispatch_async(dispatch_get_main_queue(), ^{
            [THelper makeToastError:code msg:desc];
            [ws changeMsg:msg status:Msg_Status_Fail];
        });
    }];
    
    int delay = 1;
    if([msg isKindOfClass:[TUIImageMessageCellData class]]){
        delay = 0;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(msg.status == Msg_Status_Sending){
            [ws changeMsg:msg status:Msg_Status_Sending_2];
        }
    });
}



- (void)changeMsg:(TUIMessageCellData *)msg status:(TMsgStatus)status
{
    msg.status = status;
    NSInteger index = [_uiMsgs indexOfObject:msg];
    TUIMessageCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:self.section-1]];
    [cell fillWithData:msg];
}

//消息发送
- (TIMMessage *)transIMMsgFromUIMsg:(TUIMessageCellData *)data
{
    TIMMessage *msg = [[TIMMessage alloc] init];
    if([data isKindOfClass:[TUITextMessageCellData class]]){
        TIMTextElem *imText = [[TIMTextElem alloc] init];
        TUITextMessageCellData *text = (TUITextMessageCellData *)data;
        imText.text = text.content;
        [msg addElem:imText];
    }
    else if([data isKindOfClass:[TUIFaceMessageCellData class]]){
        TIMFaceElem *imImage = [[TIMFaceElem alloc] init];
        TUIFaceMessageCellData *image = (TUIFaceMessageCellData *)data;
        imImage.index = (int)image.groupIndex;
        imImage.data = [image.faceName dataUsingEncoding:NSUTF8StringEncoding];
        [msg addElem:imImage];
    }
    else if([data isKindOfClass:[TUIImageMessageCellData class]]){
        TIMImageElem *imImage = [[TIMImageElem alloc] init];
        TUIImageMessageCellData *uiImage = (TUIImageMessageCellData *)data;
        imImage.path = uiImage.path;
        [msg addElem:imImage];
    }
    else if([data isKindOfClass:[TUIVideoMessageCellData class]]){
        TIMVideoElem *imVideo = [[TIMVideoElem alloc] init];
        TUIVideoMessageCellData *uiVideo = (TUIVideoMessageCellData *)data;
        imVideo.videoPath = uiVideo.videoPath;
        imVideo.snapshotPath = uiVideo.snapshotPath;
        imVideo.snapshot = [[TIMSnapshot alloc] init];
        imVideo.snapshot.width = uiVideo.snapshotItem.size.width;
        imVideo.snapshot.height = uiVideo.snapshotItem.size.height;
        imVideo.video = [[TIMVideo alloc] init];
        imVideo.video.duration = (int)uiVideo.videoItem.duration;
        imVideo.video.type = uiVideo.videoItem.type;
        [msg addElem:imVideo];
    }
    else if([data isKindOfClass:[TUIVoiceMessageCellData class]]){
        TIMSoundElem *imSound = [[TIMSoundElem alloc] init];
        TUIVoiceMessageCellData *uiSound = (TUIVoiceMessageCellData *)data;
        imSound.path = uiSound.path;
        imSound.second = uiSound.duration;
        imSound.dataSize = uiSound.length;
        [msg addElem:imSound];
    }
    else if([data isKindOfClass:[TUIFileMessageCellData class]]){
        TIMFileElem *imFile = [[TIMFileElem alloc] init];
        TUIFileMessageCellData *uiFile = (TUIFileMessageCellData *)data;
        imFile.path = uiFile.path;
        imFile.fileSize = uiFile.length;
        imFile.filename = uiFile.fileName;
        [msg addElem:imFile];
    }
    else if([data isKindOfClass:[JMTransferMessageCellData class]]){
        TIMCustomElem *imCustom = [[TIMCustomElem alloc] init];
        JMTransferMessageCellData *uiTransfer = (JMTransferMessageCellData *)data;
        imCustom.data = uiTransfer.data;
        imCustom.desc = uiTransfer.desc;
        [msg addElem:imCustom];
    }
    data.innerMessage = msg;
    return msg;
    
}

- (TUISystemMessageCellData *)transSystemMsgFromDate:(NSDate *)date
{
    if(_msgForDate == nil || fabs([date timeIntervalSinceDate:_msgForDate.timestamp]) > MAX_MESSAGE_SEP_DLAY){
        TUISystemMessageCellData *system = [[TUISystemMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
        system.content = [date tk_messageString];
        system.reuseId = TSystemMessageCell_ReuseId;
        return system;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!_noMoreMsg && scrollView.contentOffset.y <= TMessageController_Header_Height){
        if(!_indicatorView.isAnimating){
            [_indicatorView startAnimating];
        }
    }
    else{
        if(_indicatorView.isAnimating){
            [_indicatorView stopAnimating];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.y <= TMessageController_Header_Height){
        [self loadMessage];
    }
}

#pragma mark - Mydelegate
-(void)applyForAction_model:(JMMessageListModel *)model{
    [self sendCreateTaskOrderResquest_task_id:model.work_task_id];
}

-(void)didClickPartTimeInfoAction{
    //兼职
    JMCDetailViewController *vc = [[JMCDetailViewController alloc]init];
    vc.task_id = self.myConvModel.work_task_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)didClickHeaderInfoActionWithModel:(JMMessageListModel *)model{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        if ([self.myConvModel.type isEqualToString:@"1"]) {
            //全职
            JMPersonInfoViewController *vc = [[JMPersonInfoViewController alloc] init];
            vc.user_job_id = self.myConvModel.job_user_job_id;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([self.myConvModel.type isEqualToString:@"2"]) {
            //兼职
            JMBDetailViewController *vc = [[JMBDetailViewController alloc]init];
            vc.ability_id = self.myConvModel.job_ability_id;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }else{
        if ([model.type isEqualToString:@"1"]) {
            //全职
            JobDetailsViewController *vc = [[JobDetailsViewController alloc] init];
            vc.work_id = self.myConvModel.work_work_id;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        //        else if ([model.type isEqualToString:@"2"]) {
        //            //兼职
        //            JMBDetailWebViewController *vc = [[JMBDetailWebViewController alloc]init];
        //            vc.ability_id = _myModel.job_ability_id;
        //            [self.navigationController pushViewController:vc animated:YES];
        //
        //        }
        
    }
    
}

- (void)videoInterviewAction {
    if (_myConvModel.type) {
        
        [self gotoVideoChatViewWithForeign_key:_myConvModel.work_task_id recipient:_myConvModel.job_user_user_id chatType:_myConvModel.type];
        
    }else if ([_myConvModel.type isEqualToString:@"1"]) {
        
        self.BgBtn.hidden = NO;
        [self.dateView setHidden:NO];
        [UIView animateWithDuration:0.3 animations:^{
            self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
            [self.dateView show];
        }];
        
    }
    
}
-(void)gotoVideoChatViewWithForeign_key:(NSString *)foreign_key
                              recipient:(NSString *)recipient
                               chatType:(NSString *)chatType{
    _videoChatView = [[JMVideoChatView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    _videoChatView.delegate = self;
    _videoChatView.tag = 222;
//    [_videoChatView createChatRequstWithForeign_key:foreign_key recipient:recipient chatType:chatType];//先隐藏
    [[UIApplication sharedApplication].keyWindow addSubview:_videoChatView];
    [self.navigationController setNavigationBarHidden:YES];
}
//JMVideoChatViewDelegate 挂断
-(void)hangupAction_model:(JMInterViewModel *)model{
    [_videoChatView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:NO];
    
}
//@param timer 选择的数据

- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    //    self.timerLbl.text = timer;
    
    self.BgBtn.hidden = YES;
    [self.dateView setHidden:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
    //    NSString *userId;
    //    if (self.messageController.isSelfIsSender) {
    //        userId = self.myConvModel.recipient_user_id;
    //    }else{
    //        userId = self.myConvModel.sender_user_id;
    //    }
    [[JMHTTPManager sharedInstance]createInterViewWith_user_job_id:self.myConvModel.job_user_job_id time:timer successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邀请成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
/**
 时间选择取消
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    self.BgBtn.hidden = YES;
    [self.dateView setHidden:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, SCREEN_HEIGHT, self.view.frame.size.width, 300);
    }];
}

#pragma mark - 发送请求

-(void)sendCreateTaskOrderResquest_task_id:(NSString *)task_id{
    [[JMHTTPManager sharedInstance]createTaskOrder_taskID:task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"申请成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

//小程序推送消息用
-(void)unReadNoticeRequestWithData:(TUIMessageCellData *)data{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    NSString *receiver;
    if ([userModel.user_id isEqualToString:self.myConvModel.sender_user_id]) {
        receiver = self.myConvModel.recipient_user_id;
        
    }else{
        receiver = self.myConvModel.sender_user_id;
        
        
    }
    NSString *message;
    if([data isKindOfClass:[TUITextMessageCellData class]]){
        //        TIMTextElem *imText = [[TIMTextElem alloc] init];
        TUITextMessageCellData *text = (TUITextMessageCellData *)data;
        message = text.content;
    }else{
        message = @"当前端口暂不支持查看此消息，请在得米APP上查看。";
    }
    
    [[JMHTTPManager sharedInstance]unreadNoticeCardWithUser_id:receiver message:message successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
#pragma mark - message cell delegate

- (void)onSelectMessage:(TUIMessageCell *)cell
{
    NSLog(@"onSelectMessage");
    if ([self.delegate respondsToSelector:@selector(messageController:onSelectMessageContent:)]) {
        [self.delegate messageController:self onSelectMessageContent:cell];
    }
    if([cell isKindOfClass:[TUIVoiceMessageCell class]]){
        [self playVoiceMessage:(TUIVoiceMessageCell *)cell];
    }
    if ([cell isKindOfClass:[TUIImageMessageCell class]]) {
        [self showImageMessage:(TUIImageMessageCell *)cell];
    }
    if ([cell isKindOfClass:[TUIVideoMessageCell class]]) {
        [self showVideoMessage:(TUIVideoMessageCell *)cell];
    }
    if ([cell isKindOfClass:[TUIFileMessageCell class]]) {
        [self showFileMessage:(TUIFileMessageCell *)cell];
    }
    if ([cell isKindOfClass:[JMPushMessageCell class]]) {
        JMPushMessageCell *pushCell = (JMPushMessageCell *)cell;
        NSString *string = [[NSString alloc]initWithData:pushCell.pushData.data encoding:NSUTF8StringEncoding];
        if ([string isEqualToString:@"message"]) {
            return;
        }else if ([string containsString:@":"] || string.length > 0) {
            NSArray *array = [string componentsSeparatedByString:@":"]; //从字符A中分隔成2个元素的数组
            NSString *typeStr = array[0];
            NSString *typeId = array[1];
            [JMPushVCAction gotoMyVCWithtypeStr:typeStr typeId:typeId];
            
        }
        NSLog(@"onSelectMessage_JMPushMessageCell");
    }
    
    if ([cell isKindOfClass:[JMTransferTableViewCell class]]) {
         
        NSLog(@"JMTransferTableViewCell");

        
    }
    
}

//-(void)onSelectMessageNotification:(NSNotification *)notification{
//    NSLog(@"onSelectMessageNotification");
//    TUIMessageCell *cell = notification.object;
//    [self onSelectMessage:cell];
//}


//-(void)onLongPressNotification:(NSNotification *)notification{
//    NSLog(@"onLongPressNotification");
//    TUIMessageCell *cell = notification.object;
//    [self onLongPressMessage:cell];
//}


- (void)onLongPressMessage:(TUIMessageCell *)cell
{
    NSLog(@"onLongPressMessage");
    TUIMessageCellData *data = cell.messageData;
    if ([data isKindOfClass:[TUISystemMessageCellData class]])
        return; // 系统消息不响应
    
    NSMutableArray *items = [NSMutableArray array];
    if ([data isKindOfClass:[TUITextMessageCellData class]]) {
        [items addObject:[[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(onCopyMsg:)]];
    }
    
    [items addObject:[[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(onDelete:)]];
    TIMMessage *imMsg = data.innerMessage;
    if(imMsg){
        if([imMsg isSelf] && [[NSDate date] timeIntervalSinceDate:imMsg.timestamp] < 2 * 60){
            [items addObject:[[UIMenuItem alloc] initWithTitle:@"撤回" action:@selector(onRevoke:)]];
        }
    }
    if(imMsg.status == TIM_MSG_STATUS_SEND_FAIL){
        [items addObject:[[UIMenuItem alloc] initWithTitle:@"重发" action:@selector(onReSend:)]];
    }
    
    
    BOOL isFirstResponder = NO;
    if(_delegate && [_delegate respondsToSelector:@selector(messageController:willShowMenuInCell:)]){
        isFirstResponder = [_delegate messageController:self willShowMenuInCell:cell];
    }
    if(isFirstResponder){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidHide:) name:UIMenuControllerDidHideMenuNotification object:nil];
    }
    else{
        [self becomeFirstResponder];
    }
    UIMenuController *controller = [UIMenuController sharedMenuController];
    controller.menuItems = items;
    _menuUIMsg = data;
    [controller setTargetRect:cell.container.bounds inView:cell.container];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [controller setMenuVisible:YES animated:YES];
    });
}

- (void)onRetryMessage:(TUIMessageCell *)cell
{
    _reSendUIMsg = cell.messageData;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定重发此消息吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"重发" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sendMessage:self.reSendUIMsg];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)onSelectMessageAvatar:(TUIMessageCell *)cell
{
    if ([self.delegate respondsToSelector:@selector(messageController:onSelectMessageAvatar:)]) {
        [self.delegate messageController:self onSelectMessageAvatar:cell];
    }
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(onDelete:) ||
        action == @selector(onRevoke:) ||
        action == @selector(onReSend:) ||
        action == @selector(onCopyMsg:)){
        return YES;
    }
    return NO;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)onDelete:(id)sender
{
    TIMMessage *imMsg = _menuUIMsg.innerMessage;
    if(imMsg == nil){
        return;
    }
    if([imMsg remove]){
        [self.tableView beginUpdates];
        NSInteger index = [_uiMsgs indexOfObject:_menuUIMsg];
        [_uiMsgs removeObjectAtIndex:index];
        [_heightCache removeObjectAtIndex:index];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:self.section-1]] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView endUpdates];
    }
}

- (void)menuDidHide:(NSNotification*)notification
{
    if(_delegate && [_delegate respondsToSelector:@selector(didHideMenuInMessageController:)]){
        [_delegate didHideMenuInMessageController:self];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerDidHideMenuNotification object:nil];
}

- (void)onCopyMsg:(id)sender
{
    if ([_menuUIMsg isKindOfClass:[TUITextMessageCellData class]]) {
        TUITextMessageCellData *txtMsg = (TUITextMessageCellData *)_menuUIMsg;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = txtMsg.content;
    }
}

- (void)onRevoke:(id)sender
{
    __weak typeof(self) ws = self;
    [self.conv revokeMessage:_menuUIMsg.innerMessage succ:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [ws revokeMsg:ws.menuUIMsg];
        });
    } fail:^(int code, NSString *msg) {
        NSLog(@"");
    }];
}

- (void)onReSend:(id)sender
{
    [self sendMessage:_menuUIMsg];
}

- (void)revokeMsg:(TUIMessageCellData *)msg
{
    TIMMessage *imMsg = msg.innerMessage;
    if(imMsg == nil){
        return;
    }
    NSInteger index = [_uiMsgs indexOfObject:msg];
    if (index == NSNotFound)
        return;
    [_uiMsgs removeObject:msg];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:self.section-1]] withRowAnimation:UITableViewRowAnimationFade];
    TUISystemMessageCellData *data = [imMsg revokeCellData];
    [_uiMsgs insertObject:data atIndex:index];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:self.section-1]] withRowAnimation:UITableViewRowAnimationFade];
    [self.heightCache removeObjectAtIndex:index];
    [self.tableView endUpdates];
    [self scrollToBottom:YES];
}


- (void)sendImageMessage:(UIImage *)image;
{
    
    NSData *data = UIImageJPEGRepresentation(image, 0.75);
    NSString *path = [TUIKit_Image_Path stringByAppendingString:[THelper genImageName:nil]];
    [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
    
    TUIImageMessageCellData *uiImage = [[TUIImageMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
    uiImage.path = path;
    uiImage.length = data.length;
    
    [self sendMessage:uiImage];
}

- (void)sendVideoMessage:(NSURL *)url
{
    NSData *videoData = [NSData dataWithContentsOfURL:url];
    NSString *videoPath = [NSString stringWithFormat:@"%@%@.%@", TUIKit_Video_Path, [THelper genVideoName:nil], url.pathExtension];
    [[NSFileManager defaultManager] createFileAtPath:videoPath contents:videoData attributes:nil];
    
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    NSInteger duration = (NSInteger)urlAsset.duration.value / urlAsset.duration.timescale;
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:urlAsset];
    gen.appliesPreferredTrackTransform = YES;
    gen.maximumSize = CGSizeMake(192, 192);
    NSError *error = nil;
    CMTime actualTime;
    CMTime time = CMTimeMakeWithSeconds(0.0, 10);
    CGImageRef imageRef = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *imagePath = [TUIKit_Video_Path stringByAppendingString:[THelper genSnapshotName:nil]];
    [[NSFileManager defaultManager] createFileAtPath:imagePath contents:imageData attributes:nil];
    
    TUIVideoMessageCellData *uiVideo = [[TUIVideoMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
    uiVideo.snapshotPath = imagePath;
    uiVideo.snapshotItem = [[TUISnapshotItem alloc] init];
    UIImage *snapshot = [UIImage imageWithContentsOfFile:imagePath];
    uiVideo.snapshotItem.size = snapshot.size;
    uiVideo.snapshotItem.length = imageData.length;
    uiVideo.videoPath = videoPath;
    uiVideo.videoItem = [[TUIVideoItem alloc] init];
    uiVideo.videoItem.duration = duration;
    uiVideo.videoItem.length = videoData.length;
    uiVideo.videoItem.type = url.pathExtension;
    uiVideo.uploadProgress = 0;
    [self sendMessage:uiVideo];
}

- (void)sendFileMessage:(NSURL *)url
{
    [url startAccessingSecurityScopedResource];
    NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] init];
    NSError *error;
    __weak typeof(self) ws = self;
    [coordinator coordinateReadingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
        NSData *fileData = [NSData dataWithContentsOfURL:url];
        NSString *fileName = [url lastPathComponent];
        NSString *filePath = [TUIKit_File_Path stringByAppendingString:fileName];
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileData attributes:nil];
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
            TUIFileMessageCellData *uiFile = [[TUIFileMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
            uiFile.path = filePath;
            uiFile.fileName = fileName;
            uiFile.length = (int)fileSize;
            uiFile.uploadProgress = 0;
            [ws sendMessage:uiFile];
        }
    }];
    [url stopAccessingSecurityScopedResource];
}

-(void)sendTransferMessage:(NSString *)money remark:(NSString *)remark{
    [[JMHTTPManager sharedInstance]transferWithAccount:_myConvModel.data.convId amount:money remark:remark successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
 

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];
    
    
}

- (void)playVoiceMessage:(TUIVoiceMessageCell *)cell
{
    for (NSInteger index = 0; index < _uiMsgs.count; ++index) {
        if(![_uiMsgs[index] isKindOfClass:[TUIVoiceMessageCellData class]]){
            continue;
        }
        TUIVoiceMessageCellData *uiMsg = _uiMsgs[index];
        if(uiMsg == cell.voiceData){
            [uiMsg playVoiceMessage];
        }
        else{
            [uiMsg stopVoiceMessage];
        }
    }
}

- (void)showImageMessage:(TUIImageMessageCell *)cell
{
    TUIImageViewController *image = [[TUIImageViewController alloc] init];
    image.data = [cell imageData];
    [self.navigationController pushViewController:image animated:YES];
}

- (void)showVideoMessage:(TUIVideoMessageCell *)cell
{
    TUIVideoViewController *video = [[TUIVideoViewController alloc] init];
    video.data = [cell videoData];
    [self.navigationController pushViewController:video animated:YES];
}

- (void)showFileMessage:(TUIFileMessageCell *)cell
{
    TUIFileViewController *file = [[TUIFileViewController alloc] init];
    file.data = [cell fileData];
    [self.navigationController pushViewController:file animated:YES];
}

- (void)didTapOnNameLabel:(TUIJoinGroupMessageCell *)cell{
    if(cell.joinData.memberId != nil){
        [self jumpToProfileController:cell.joinData.memberId];
    }
}

- (void)didTapOnRestNameLabel:(TUIJoinGroupMessageCell *)cell withIndex:(NSInteger)index{
    [self jumpToProfileController:cell.joinData.userID[index]];
}
- (void)jumpToProfileController:(NSString *)memberId{
    //此处实现点击入群的姓名 Label 后，跳转到对应的消息界面。此处的跳转逻辑和点击头像的跳转逻辑相同。
    @weakify(self)
    TIMFriend *friend = [[TIMFriendshipManager sharedInstance] queryFriend:memberId];
    if (friend) {
        id<TUIFriendProfileControllerServiceProtocol> vc = [[TCServiceManager shareInstance] createService:@protocol(TUIFriendProfileControllerServiceProtocol)];
        if ([vc isKindOfClass:[UIViewController class]]) {
            vc.friendProfile = friend;
            [self.navigationController pushViewController:(UIViewController *)vc animated:YES];
            return;
        }
    }
    
    [[TIMFriendshipManager sharedInstance] getUsersProfile:@[memberId] forceUpdate:YES succ:^(NSArray<TIMUserProfile *> *profiles) {
        @strongify(self)
        if (profiles.count > 0) {
            id<TUIUserProfileControllerServiceProtocol> vc = [[TCServiceManager shareInstance] createService:@protocol(TUIUserProfileControllerServiceProtocol)];
            if ([vc isKindOfClass:[UIViewController class]]) {
                vc.userProfile = profiles[0];
                vc.actionType = PCA_ADD_FRIEND;
                [self.navigationController pushViewController:(UIViewController *)vc animated:YES];
                return;
            }
        }
    } fail:^(int code, NSString *msg) {
        [THelper makeToastError:code msg:msg];
    }];
}

@end
