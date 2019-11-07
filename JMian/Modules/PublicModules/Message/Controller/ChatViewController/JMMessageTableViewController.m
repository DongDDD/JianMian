//
//  JMMessageTableViewController.m
//  JMian
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMessageTableViewController.h"
#import "DimensMacros.h"
#import "JMChatDetailPartTimeJobTableViewCell.h"
#import "JMChatViewSectionView.h"
#import "JMVideoChatViewController.h"
#import "THDatePickerView.h"
#import "JMHTTPManager+InterView.h"
#import "JMHTTPManager+CreateTaskOrder.h"
#import "JMBDetailWebViewController.h"
#import "JMCDetailWebViewController.h"
#import "JMPersonDetailsViewController.h"
#import "JobDetailsViewController.h"
#import "JMCompanyLikeTableViewCell.h"
#import "JMChatDetailInfoTableViewCell.h"
#import "JMImageMessageCellData.h"
#import "JMImageMessageCell.h"
#import "JMMessageCell.h"
#import "JMTextMessageCell.h"
#import "JMTextMessageCellData.h"
#import "JMCustumMessageCellData.h"
@import ImSDK;
@interface JMMessageTableViewController ()<TIMMessageListener,JMChatViewSectionViewDelegate,THDatePickerViewDelegate,JMChatDetailPartTimeJobTableViewCellDelegate,JMChatDetailInfoTableViewCellDelegate>

@property (nonatomic, strong) TIMConversation *conv;

@property (nonatomic, strong) NSMutableArray *uiMsgs;

@property (nonatomic, strong) JMMessageListModel *myModel;

@property (nonatomic, strong) TIMMessage *msgForGet;



@property (nonatomic, copy)NSString *receiverID;

@property (nonatomic, assign) BOOL isScrollBottom;
@property (nonatomic, assign)BOOL isDominator;
//@property id<TUIConversationDataProviderServiceProtocol> conversationDataProviderService;

@end
static NSString *cellIdent = @"infoCellIdent";
static NSString *cellIdent2 = @"partTimeInfoCellIdent";


@implementation JMMessageTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BG_COLOR;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMChatDetailInfoTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"JMChatDetailPartTimeJobTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent2];
    [self.tableView registerClass:[JMTextMessageCell class] forCellReuseIdentifier:TTextMessageCell_ReuseId];
//    [self.tableView registerClass:[JMImageMessageCell class] forCellReuseIdentifier:TImageMessageCell_ReuseId];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapViewController)];
    [self.view addGestureRecognizer:tap];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    [self readedReport];
  
}


- (void)viewWillAppear:(BOOL)animated
{
//    [self readedReport];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
//    [self readedReport];
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onRefreshNotification:)
                                                 name:Notification_JMRefreshListener
                                               object:nil];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setReadMessage:) name:Notification_JMRefreshListener object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNewMessage:) name:Notification_JMMMessageListener object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onRevokeMessage:) name:Notification_JMMMessageRevokeListener object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUploadMessage:) name:Notification_JMMUploadProgressListener object:nil];


}

- (void)setConversation:(TIMConversation *)conversation
{
//    _conv = conversation;
    
//    self.conversationDataProviderService = [[TCServiceManager shareInstance] createService:@protocol(TUIConversationDataProviderServiceProtocol)];
//    [self loadMessage];
}

//-(void)onNewMessage:(NSArray *)msgs{
//
//    NSLog(@"onNewMessage接受消息成功-------");
//
//}
//- (void)onNewMessage:(NSNotification *)notification
//{
//
//    NSLog(@"onNewMessage接受消息成功-------");
//
//}
//
//- (void)onRevokeMessage:(NSNotification *)notification
//{
//
//    NSLog(@"onRevokeMessage接受消息成功-------");
//
//}
//
//- (void)onUploadMessage:(NSNotification *)notification
//{
//
//    NSLog(@"onUploadMessage接受消息成功-------");
//
//}

- (void)onRefreshNotification:(NSNotification *)notifi
{
//    NSArray<TIMConversation *> *convs = notifi.object;
//    if ([convs isKindOfClass:[NSArray class]]) {
//        for (TIMConversation *conv in convs) {
//            if ([[conv getReceiver] isEqualToString:_receiverID]) {
//              
//        }
//    }
        
        NSLog(@"onRefreshConversations-------");

}

- (void)onNewMessage:(NSNotification *)notification
{
   
//    [self loadMessage];
//    NSArray *msgs = notification.object;
//
//    NSMutableArray *uiMsgs = [self transUIMsgFromIMMsg:msgs];
//    [_uiMsgs addObjectsFromArray:uiMsgs];
//    __weak typeof(self) ws = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [ws.tableView reloadData];
//        [ws scrollToBottom:NO];
//    });
    NSArray *msgs = notification.object;
    NSMutableArray *uiMsgs = [self transUIMsgFromIMMsg:msgs];
    if (uiMsgs.count > 0) {
        [_uiMsgs addObjectsFromArray:uiMsgs];
        [self.tableView reloadData];
        [self scrollToBottom:NO];
    }
    
}

- (void)scrollToBottom:(BOOL)animate
{
   
    if (_uiMsgs.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_uiMsgs.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animate];
    }
  
}

- (NSMutableArray *)extracted:(JMMessageTableViewController *const __weak)ws {
    return ws.uiMsgs;
}


//- (void)readedReport
//{
//    [[TIMManager sharedInstance] addMessageListener:self];
//
//    if (_myModel) {
//
//
//        TIMConversation *conv = [[TIMManager sharedInstance]
//                                 getConversation:(TIMConversationType)TIM_C2C
//                                 receiver:_receiverID];
//
//        [conv setReadMessage:nil succ:^{
//            NSLog(@"");
//        } fail:^(int code, NSString *msg) {
//            NSLog(@"");
//        }];
//    }
//}

-(void)setMyConvModel:(JMMessageListModel *)myConvModel
{

    _myModel = myConvModel;
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    _isSelfIsSender = [model.user_id isEqualToString: _myModel.sender_user_id];
    //判断系统消息
    if ([_myModel.data.convId isEqualToString:@"dominator"]) {
        _receiverID = _myModel.data.convId;
        _isDominator = YES;
        if (_delegate && [_delegate respondsToSelector:@selector(isDominatorController:)]) {
            [_delegate isDominatorController:self];
        }
        
    }else{
        
        //判断senderid是不是自己
        if (_isSelfIsSender) {
            
            _receiverID = _myModel.recipient_mark;
        }else{
            
            _receiverID = _myModel.sender_mark;
        }
    }
    [self loadMessage];

}



//消息解释
- (void) loadMessage
{
    
    _uiMsgs = [NSMutableArray array];
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:_receiverID];
    

    __weak typeof(self) ws = self;
    [conv getMessage:20 last:nil succ:^(NSArray *msgs) {
        if(msgs.count != 0){
            ws.msgForGet = msgs[msgs.count - 1];
            _uiMsgs =  [self transUIMsgFromIMMsg:msgs];
        }
    
        [self.tableView reloadData];
        
    } fail:^(int code, NSString *msg) {
        
    }];
//     [self.conversationDataProviderService getMessage:self.conv count:0 last:_msgForGet succ:^(NSArray *msgs) {
//
//     }fail:^(int code, NSString *msg) {
//
//     }];
}



- (NSMutableArray *)transUIMsgFromIMMsg:(NSArray *)msgs
{
    
    NSMutableArray *uiMsgs = [NSMutableArray array];
    for (NSInteger k = msgs.count - 1; k >= 0; --k) {
        TIMMessage *msg = msgs[k];
        if(![[[msg getConversation] getReceiver] isEqualToString:_receiverID]){
            continue;
        }
//        if(![[[msg getConversation] getReceiver] isEqualToString:_myModel.sender_mark]){
//            continue;
//        }
        //        if(msg.status == TIM_MSG_STATUS_HAS_DELETED){
        //            continue;
        //        }
        if (!msg.isSelf) {
            int cnt = [msg elemCount];
            for (int i = 0; i < cnt; i++) {
                TIMElem * elem = [msg getElem:i];
                JMMessageCellData *data = nil;
                if ([elem isKindOfClass:[TIMTextElem class]]) {
                    TIMTextElem * text_elem = (TIMTextElem *)elem;
                    JMTextMessageCellData *textData = [[JMTextMessageCellData alloc]init];
                    textData.content = text_elem.text;
                    if (_isSelfIsSender) {
                        
                        textData.head = _myModel.recipient_avatar;
                    }else{
                        textData.head = _myModel.sender_avatar;
                    }
                    textData.isSelf = NO;
                    data = textData;
                    [uiMsgs addObject:data];
                    
                }else if ([elem isKindOfClass:[TIMCustomElem class]]){

                    TIMCustomElem * custom_elem = (TIMCustomElem *)elem;
                    JMCustumMessageCellData *textData = [[JMCustumMessageCellData alloc]init];
//                    if ([custom_elem.desc isEqualToString:@"我发起了视频聊天"]){
//                        textData.content = @"发起了视频";
//                    }else{
//                        textData.content = @"结束了视频";
//
//
//                    }
                    textData.content = custom_elem.desc;
//                    else if ([custom_elem.desc isEqualToString:@"[我发起了视频聊天]"]){
//                        textData.content = @"对方发起了视频聊天";
//
//
//                    }
                    if (_isSelfIsSender) {

                        textData.head = _myModel.recipient_avatar;
                    }else{

                        textData.head = _myModel.sender_avatar;
                    }

                    textData.isSelf = NO;
                    data = textData;
                    [uiMsgs addObject:data];


                }else if ([elem isKindOfClass:[TIMImageElem class]]){
                    TIMImageElem *image = (TIMImageElem *)elem;

                    JMImageMessageCellData *imageData =  [[JMImageMessageCellData alloc]init];
                    
                     if (_isSelfIsSender) {
                        
                        imageData.head = _myModel.recipient_avatar;
                    }else{
                        imageData.head = _myModel.sender_avatar;
                    }
                    imageData.isSelf = NO;
                    
                    
                    
                    
                    
                    data = imageData;
                    [uiMsgs addObject:data];
                }

                
            }
            
        }else{
            int cnt = [msg elemCount];
            for (int i = 0; i < cnt; i++) {
                TIMElem * elem = [msg getElem:i];
                JMMessageCellData *data = nil;
                if ([elem isKindOfClass:[TIMTextElem class]]) {
                    TIMTextElem * text_elem = (TIMTextElem *)elem;
                    JMTextMessageCellData *textData = [[JMTextMessageCellData alloc]init];
                    textData.content = text_elem.text;
                    if (_isSelfIsSender) {
                        textData.head = _myModel.sender_avatar;
                    }else{
                        textData.head = _myModel.recipient_avatar;
                        
                    }
                    textData.isSelf = YES;
                    data = textData;
                    [uiMsgs addObject:data];
                    
                }
                else if ([elem isKindOfClass:[TIMCustomElem class]]){

                    TIMCustomElem * custom_elem = (TIMCustomElem *)elem;
                    JMCustumMessageCellData *textData = [[JMCustumMessageCellData alloc]init];
                    textData.content = custom_elem.desc;
                    
                    if (_isSelfIsSender) {

                        textData.head = _myModel.sender_avatar;
                    }else{
                        textData.head = _myModel.recipient_avatar;

                    }
                    textData.isSelf = YES;
                    data = textData;
                    [uiMsgs addObject:data];


                }
                else if ([elem isKindOfClass:[TIMImageElem class]]){
                    JMTextMessageCellData *textData = [[JMTextMessageCellData alloc]init];
                    textData.content = @"[图片]";
                    if (_isSelfIsSender) {
                        
                        textData.head = _myModel.recipient_avatar;
                    }else{
                        textData.head = _myModel.sender_avatar;
                    }
                    textData.isSelf = YES;
                    data = textData;
                    [uiMsgs addObject:data];
                }
                
            }
            
            
        }
        
        
    }

    return uiMsgs;
}

#pragma mark - 点击事件

-(void)videoInterviewAction
{

    if (_delegate && [_delegate respondsToSelector:@selector(videoInterviewController:)]) {
        [_delegate videoInterviewController:self];
    }
    
//    JMVideoChatViewController *vc = [[JMVideoChatViewController alloc]init];
////    vc.chatViewModel = self.myModel;
//    vc.receiverID = _receiverID;
//    [self.navigationController pushViewController:vc animated:YES];
//
}

- (void)sendImageMessage:(UIImage *)image;
{
    NSData *data = UIImageJPEGRepresentation(image, 0.75);
    NSString *path = [TUIKit_Image_Path stringByAppendingString:[self genImageName:nil]];
    [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
    
    //    JMImageMessageCellData *uiImage = [[JMImageMessageCellData alloc] initWithDirection:MsgDirectionOutgoing];
    JMImageMessageCellData *uiImage = [[JMImageMessageCellData alloc]init];
    uiImage.path = path;
    uiImage.length = data.length;
    uiImage.isSelf = YES;
    uiImage.thumbImage = image;
    [self sendMessage:uiImage];
}

- (void)sendMessage2:(JMMessageCellData *)msgData
{
    [self.tableView beginUpdates];
    TIMMessage *imMsg = msgData.innerMessage;
    JMMessageCellData *dateMsg = nil;
    if (msgData.status == Msg_Status_Init)
    {
        //新消息
        if (!imMsg) {
            imMsg = [self transIMMsgFromUIMsg:msgData];
        }
//        dateMsg = [self transSystemMsgFromDate:imMsg.timestamp];
        
    }
    //获取头像和昵称
    msgData.status = Msg_Status_Sending;
    msgData.isSelf = YES;
    
    if (_isSelfIsSender) {
        msgData.head = _myModel.sender_avatar;
        msgData.name = _myModel.sender_nickname;
        
    }else
    {
        msgData.head = _myModel.recipient_avatar;
        msgData.name = _myModel.recipient_nickname;
    }

    [self.uiMsgs addObject:msgData];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_uiMsgs.count  inSection:0]]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    [self scrollToBottom:YES];
    
    __weak typeof(self) ws = self;
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:_receiverID];
    [conv sendMessage:imMsg succ:^{
        dispatch_async(dispatch_get_main_queue(), ^{
//            [ws changeMsg:msgData status:Msg_Status_Succ];
        });
        NSLog(@"成功");

    } fail:^(int code, NSString *desc) {
        NSLog(@"失败====== %d",imMsg.status);
        dispatch_async(dispatch_get_main_queue(), ^{
//            [THelper makeToastError:code msg:desc];
//            [ws changeMsg:msg status:Msg_Status_Fail];
        });
    }];
    
    
}

- (void)changeMsg:(JMMessageCellData *)msg status:(TMsgStatus)status
{
    msg.status = status;
    NSInteger index = [_uiMsgs indexOfObject:msg];
    JMMessageCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index + 1 inSection:0]];
//    [cell setData:msg];
//    [cell fillWithData:msg];
}

//把自己发出的消息数据源转化成IM可以接收的类型
- (TIMMessage *)transIMMsgFromUIMsg:(JMMessageCellData *)data
{
    TIMMessage *msg = [[TIMMessage alloc] init];
    if([data isKindOfClass:[JMTextMessageCellData class]]){
        TIMTextElem *imText = [[TIMTextElem alloc] init];
        JMTextMessageCellData *text = (JMTextMessageCellData *)data;
        imText.text = text.content;
        [msg addElem:imText];
    }
    else if([data isKindOfClass:[JMImageMessageCellData class]]){
        TIMImageElem *imImage = [[TIMImageElem alloc] init];
        JMImageMessageCellData *uiImage = (JMImageMessageCellData *)data;
        imImage.path = uiImage.path;
        [msg addElem:imImage];
    }
    return msg;

//    else if([data isKindOfClass:[TUIFaceMessageCellData class]]){
//        TIMFaceElem *imImage = [[TIMFaceElem alloc] init];
//        TUIFaceMessageCellData *image = (TUIFaceMessageCellData *)data;
//        imImage.index = (int)image.groupIndex;
//        imImage.data = [image.faceName dataUsingEncoding:NSUTF8StringEncoding];
//        [msg addElem:imImage];
//    }
//    else if([data isKindOfClass:[TUIImageMessageCellData class]]){
//        TIMImageElem *imImage = [[TIMImageElem alloc] init];
//        TUIImageMessageCellData *uiImage = (TUIImageMessageCellData *)data;
//        imImage.path = uiImage.path;
//        [msg addElem:imImage];
//    }
//    else if([data isKindOfClass:[TUIVideoMessageCellData class]]){
//        TIMVideoElem *imVideo = [[TIMVideoElem alloc] init];
//        TUIVideoMessageCellData *uiVideo = (TUIVideoMessageCellData *)data;
//        imVideo.videoPath = uiVideo.videoPath;
//        imVideo.snapshotPath = uiVideo.snapshotPath;
//        imVideo.snapshot = [[TIMSnapshot alloc] init];
//        imVideo.snapshot.width = uiVideo.snapshotItem.size.width;
//        imVideo.snapshot.height = uiVideo.snapshotItem.size.height;
//        imVideo.video = [[TIMVideo alloc] init];
//        imVideo.video.duration = (int)uiVideo.videoItem.duration;
//        imVideo.video.type = uiVideo.videoItem.type;
//        [msg addElem:imVideo];
//    }
//    else if([data isKindOfClass:[TUIVoiceMessageCellData class]]){
//        TIMSoundElem *imSound = [[TIMSoundElem alloc] init];
//        TUIVoiceMessageCellData *uiSound = (TUIVoiceMessageCellData *)data;
//        imSound.path = uiSound.path;
//        imSound.second = uiSound.duration;
//        imSound.dataSize = uiSound.length;
//        [msg addElem:imSound];
//    }
//    else if([data isKindOfClass:[TUIFileMessageCellData class]]){
//        TIMFileElem *imFile = [[TIMFileElem alloc] init];
//        TUIFileMessageCellData *uiFile = (TUIFileMessageCellData *)data;
//        imFile.path = uiFile.path;
//        imFile.fileSize = uiFile.length;
//        imFile.filename = uiFile.fileName;
//        [msg addElem:imFile];
//    }
//    data.innerMessage = msg;
    
}

-(void)sendMessage:(JMMessageCellData *)data{
    [self.tableView beginUpdates];
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:_receiverID];
    TIMMessage *msg = [self transIMMsgFromUIMsg:data];

//    TIMMessage * msg = [[TIMMessage alloc] init];
//    /**
//     *  构造图片内容
//     */
//    TIMImageElem * image_elem = [[TIMImageElem alloc] init];
//    JMImageMessageCellData *uiImage = (JMImageMessageCellData *)data;
//    image_elem.path = uiImage.path;
//    /**
//     *  将图片内容添加到消息容器中
//     */
//    NSLog(@"%@",image_elem.path);
//    [msg addElem:image_elem];
    [conv sendMessage:msg succ:^(){
        NSLog(@"SendMsg Succ");
    }fail:^(int code, NSString * err) {
        NSLog(@"SendMsg Failed:%d->%@", code, err);
    }];
    
    
//    JMMessageCellData *textData = [[JMMessageCellData alloc]init];
    if (_isSelfIsSender) {
        data.head = _myModel.sender_avatar;
        data.name = _myModel.sender_nickname;
        
    }else
    {
        data.head = _myModel.recipient_avatar;
        data.name = _myModel.recipient_nickname;
    }
    data.isSelf = YES;
    [self.uiMsgs addObject:data];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_uiMsgs.count  inSection:0]]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    [self scrollToBottom:YES];
//    [self.tableView reloadData];
    

}



- (NSString *)genImageName:(NSString *)uuid
{
    int sdkAppId = [[TIMManager sharedInstance] getGlobalConfig].sdkAppId;
    NSString *identifier = [[TIMManager sharedInstance] getLoginUser];
    if(uuid == nil){
        uuid = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    }
    NSString *name = [NSString stringWithFormat:@"%d_%@_image_%@", sdkAppId, identifier, uuid];
    return name;
}
- (void)didTapViewController
{
    if(_delegate && [_delegate respondsToSelector:@selector(didTapInMessageController:)]){
        [_delegate didTapInMessageController:self];
    }
}

#pragma mark - Mydelegate
-(void)applyForAction_model:(JMMessageListModel *)model{
    [self sendCreateTaskOrderResquest_task_id:model.work_task_id];
}

-(void)didClickPartTimeInfoAction{

    //兼职
    JMCDetailWebViewController *vc = [[JMCDetailWebViewController alloc]init];
    vc.task_id = _myModel.work_task_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)didClickHeaderInfoActionWithModel:(JMMessageListModel *)model{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        if ([_myModel.type isEqualToString:@"1"]) {
            //全职
            JMPersonDetailsViewController *vc = [[JMPersonDetailsViewController alloc] init];
            JMCompanyHomeModel *model2 = [[JMCompanyHomeModel alloc]init];
            model2.user_job_id = _myModel.job_user_job_id;
            vc.companyModel = model2;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([_myModel.type isEqualToString:@"2"]) {
            //兼职
            JMBDetailWebViewController *vc = [[JMBDetailWebViewController alloc]init];
            vc.ability_id = _myModel.job_ability_id;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }else{
        if ([model.type isEqualToString:@"1"]) {
            //全职
            JobDetailsViewController *vc = [[JobDetailsViewController alloc] init];
            JMHomeWorkModel *model2 = [[JMHomeWorkModel alloc]init];
            model2.work_id = _myModel.work_work_id;
            vc.homeworkModel = model2;
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
#pragma mark - 申请兼职职位

-(void)sendCreateTaskOrderResquest_task_id:(NSString *)task_id{
    [[JMHTTPManager sharedInstance]createTaskOrder_taskID:task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"申请成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isScrollBottom == NO) {
        [self scrollToBottom:NO];
        if (indexPath.row == _uiMsgs.count-1) {
            _isScrollBottom = YES;
        }
    }
}

//section
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if (!_isDominator && [userModel.type isEqualToString:B_Type_UESR]) {
        
        if (section == 0) {
            
            return 43;
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        JMChatViewSectionView *view=[[JMChatViewSectionView alloc] init];
        view.delegate = self;
        return view ;
    }
    return nil;
}

//cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _uiMsgs.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if (indexPath.row == 0) {
        //兼职类型对话且招聘信息不为空，且是C端用户
        if ([_myModel.type isEqualToString:@"2"] && _myModel.work_task_id && [userModel.type isEqualToString:C_Type_USER]) {
            JMChatDetailPartTimeJobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent2 forIndexPath:indexPath];
            if(cell == nil)
            {
                cell = [[JMChatDetailPartTimeJobTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent2];
            }
            cell.delegate = self;
            [cell setMyConModel:_myModel];
            return cell;
        }
  
        
        JMChatDetailInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];

        if(cell == nil)
        {
            cell = [[JMChatDetailInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
        }
        cell.delegate = self;
        //管理员隐藏头部对话信息详情
        if (_isDominator) {
            [cell setHidden:YES];
        }
        
        //兼职对话类型
        if ([_myModel.type isEqualToString:@"2"]) {
            if (!_myModel.job_ability_id) {
                //兼职简历为空
                [cell setHidden:YES];
            }else{
                [cell setHidden:NO];
                [cell setMyConModel:_myModel];
            
            }
            
        }else if([_myModel.type isEqualToString:@"1"]){
        
            [cell setMyConModel:_myModel];
        }
        
        return cell;

    }else if (indexPath.row > 0 ) {
        
        JMMessageCellData *data = _uiMsgs[indexPath.row-1];
        JMMessageCell *cell = nil;
//        if (!data.reuseId) {
        if([data isKindOfClass:[JMTextMessageCellData class]]){
            data.reuseId = TTextMessageCell_ReuseId;
            cell = [tableView dequeueReusableCellWithIdentifier:data.reuseId];
            
            if(cell == nil){
                cell = [[JMTextMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:data.reuseId];
                //            cell.delegate = self;
            }
            
        }else if ([data isKindOfClass:[JMImageMessageCellData class]]){
            data.reuseId = TImageMessageCell_ReuseId;
            cell = [tableView dequeueReusableCellWithIdentifier:data.reuseId];
            
            if(cell == nil){
                cell = [[JMImageMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:data.reuseId];
                //            cell.delegate = self;
            }
            
        }else if ([data isKindOfClass:[JMCustumMessageCellData class]]){
            data.reuseId = TTextMessageCell_ReuseId;
            cell = [tableView dequeueReusableCellWithIdentifier:data.reuseId];
            
            if(cell == nil){
                cell = [[JMTextMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:data.reuseId];
                //            cell.delegate = self;
            }
        }else {
            return nil;
        }
//        }
    
        cell.backgroundColor = BG_COLOR;
        [cell setData:_uiMsgs[indexPath.row-1]];
        [cell setIsDominator:_isDominator];//系统消息
        return cell;

    
    }
    
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        if (_isDominator) {
            return 0;
        }
        if ([_myModel.type isEqualToString:@"2"]) {
            //兼职对话类型
            JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
            if ([userModel.type isEqualToString:B_Type_UESR]) {
                //兼职对话，兼职简历为空
                if (!_myModel.job_ability_id) {
                    return 0;
                }
            }else{
                //兼职对话，招聘信息为空
                if (!_myModel.work_task_id) {
                    return 0;
                }
            }
            
        }
        return 200;
        
    }else if (indexPath.row > 0) {
        CGFloat height = 0;
        NSObject *data = _uiMsgs[indexPath.row-1];
        if([data isKindOfClass:[JMTextMessageCellData class]]){
            JMTextMessageCellData *data = _uiMsgs[indexPath.row-1];
            JMTextMessageCell *cell = [[JMTextMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TTextMessageCell_ReuseId];
            height = [cell getHeight:data];
        }else  if([data isKindOfClass:[JMImageMessageCellData class]]){
//            JMImageMessageCellData *data = _uiMsgs[indexPath.row-1];
//            JMImageMessageCell *cell = [[JMImageMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TImageMessageCell_ReuseId];
            height = 150;
        }else  if([data isKindOfClass:[JMCustumMessageCellData class]]){
            //            JMImageMessageCellData *data = _uiMsgs[indexPath.row-1];
            //            JMImageMessageCell *cell = [[JMImageMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TImageMessageCell_ReuseId];
            height = 80;
        }
        return height;
        
    }
    return 0;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

        [[UIApplication sharedApplication]sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];


}

//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [[UIApplication sharedApplication]sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if (indexPath.row == 0) {
    
        
    }
    

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
