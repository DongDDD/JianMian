//
//  JMMessageTableViewController.m
//  JMian
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMessageTableViewController.h"
#import "JMMessageCell.h"
#import "DimensMacros.h"
#import "JMCompanyLikeTableViewCell.h"
#import "JMChatDetailInfoTableViewCell.h"
#import "JMChatViewSectionView.h"
#import "JMVideoChatViewController.h"

@interface JMMessageTableViewController ()<TIMMessageListener,JMChatViewSectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *uiMsgs;

@property (nonatomic, strong) JMMessageListModel *myModel;

@property (nonatomic, strong) TIMMessage *msgForGet;

@property (nonatomic, assign)BOOL isSelfIsSender;


@property (nonatomic, copy)NSString *receiverID;

@property (nonatomic, assign) BOOL isScrollBottom;
@property (nonatomic, assign)BOOL isDominator;


@end
static NSString *cellIdent = @"infoCellIdent";


@implementation JMMessageTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BG_COLOR;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMChatDetailInfoTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];

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
    [self readedReport];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self readedReport];
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setReadMessage:) name:Notification_JMRefreshListener object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNewMessage:) name:Notification_JMMMessageListener object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onRevokeMessage:) name:Notification_JMMMessageRevokeListener object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUploadMessage:) name:Notification_JMMUploadProgressListener object:nil];


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

- (void)onRefreshConversations:(NSArray *)conversations
{
    
        NSLog(@"onRefreshConversations-------");

}

- (void)onNewMessage:(NSArray *)msgs
{
    

    NSMutableArray *uiMsgs = [self transUIMsgFromIMMsg:msgs];
    [_uiMsgs addObjectsFromArray:uiMsgs];
    __weak typeof(self) ws = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [ws.tableView reloadData];
        [ws scrollToBottom:YES];
    });
    
    
}

- (void)scrollToBottom:(BOOL)animate
{
    if (_uiMsgs.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_uiMsgs.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animate];
    }
}

- (NSMutableArray *)extracted:(JMMessageTableViewController *const __weak)ws {
    return ws.uiMsgs;
}


- (void)readedReport
{
    [[TIMManager sharedInstance] addMessageListener:self];

    if (_myModel) {
        
        
        TIMConversation *conv = [[TIMManager sharedInstance]
                                 getConversation:(TIMConversationType)TIM_C2C
                                 receiver:_receiverID];
        
        [conv setReadMessage:nil succ:^{
            NSLog(@"");
        } fail:^(int code, NSString *msg) {
            NSLog(@"");
        }];
    }
}

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
- (void)loadMessage
{
    _uiMsgs = [NSMutableArray array];
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:_receiverID];
//    [conv setReadMessage:nil succ:^{
//        NSLog(@"已读上报");
//    } fail:^(int code, NSString *msg) {
//        NSLog(@"已读上报失败");
//
//    }];
    __weak typeof(self) ws = self;
    [conv getMessage:20 last:nil succ:^(NSArray *msgs) {
        if(msgs.count != 0){
            ws.msgForGet = msgs[msgs.count - 1];
            _uiMsgs =  [self transUIMsgFromIMMsg:msgs];
        }
    
        [self.tableView reloadData];
        
    } fail:^(int code, NSString *msg) {
        
    }];
    
}



- (NSMutableArray *)transUIMsgFromIMMsg:(NSArray *)msgs
{
    NSMutableArray *uiMsgs = [NSMutableArray array];
    for (NSInteger k = msgs.count - 1; k >= 0; --k) {
        TIMMessage *msg = msgs[k];
    
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
                    JMMessageCellData *textData = [[JMMessageCellData alloc]init];
                    textData.content = text_elem.text;
                    if (_isSelfIsSender) {
                        
                        textData.head = _myModel.recipient_avatar;
                    }else{
                    
                        textData.head = _myModel.sender_avatar;
                    }
                    textData.isSelf = NO;
                    data = textData;
                    [uiMsgs addObject:data];
                    
                }
                else if ([elem isKindOfClass:[TIMCustomElem class]]){

                    TIMCustomElem * custom_elem = (TIMCustomElem *)elem;
                    JMMessageCellData *textData = [[JMMessageCellData alloc]init];
                    if ([custom_elem.desc isEqualToString:@"我发起了视频聊天"]){
                        textData.content = @"对方发起了视频聊天";
                    }else{
                        textData.content = @"对方拒绝了你的视频邀请";

                    
                    }
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


                }
                
            }
            
        }else{
            int cnt = [msg elemCount];
            for (int i = 0; i < cnt; i++) {
                TIMElem * elem = [msg getElem:i];
                JMMessageCellData *data = nil;
                if ([elem isKindOfClass:[TIMTextElem class]]) {
                    TIMTextElem * text_elem = (TIMTextElem *)elem;
                    JMMessageCellData *textData = [[JMMessageCellData alloc]init];
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
                    JMMessageCellData *textData = [[JMMessageCellData alloc]init];
                    if ([custom_elem.desc isEqualToString:@"我发起了视频聊天"]){
                        textData.content = @"我发起了视频聊天";
                    }else{
                        textData.content = @"我拒绝了对方的视频邀请";
                        
                        
                    }

                    if (_isSelfIsSender) {

                        textData.head = _myModel.sender_avatar;
                    }else{
                        textData.head = _myModel.recipient_avatar;

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
//    JMVideoChatViewController *vc = [[JMVideoChatViewController alloc]init];
////    vc.chatViewModel = self.myModel;
//    vc.receiverID = _receiverID;
//    [self.navigationController pushViewController:vc animated:YES];
//
}


-(void)sendMessage:(JMMessageCellData *)data{
  
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:_receiverID];
    
    TIMTextElem * text_elem = [[TIMTextElem alloc] init];
    
    [text_elem setText:data.content];
    
    TIMMessage * msg = [[TIMMessage alloc] init];
    [msg addElem:text_elem];
    
    [conv sendMessage:msg succ:^(){
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"测试提示" message:@"发送成功"
//                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//        [alert show];
        NSLog(@"SendMsg Succ");
    }fail:^(int code, NSString * err) {
        NSLog(@"SendMsg Failed:%d->%@", code, err);
    }];
    
    
    JMMessageCellData *textData = [[JMMessageCellData alloc]init];
    textData.content = text_elem.text;
    if (_isSelfIsSender) {
        textData.head = _myModel.sender_avatar;
        textData.name = _myModel.sender_nickname;
        
    }else
    {
        textData.head = _myModel.recipient_avatar;
        textData.name = _myModel.recipient_nickname;
    }
    textData.isSelf = YES;
    [self.uiMsgs addObject:textData];
    
    [self.tableView reloadData];
    
    [self scrollToBottom:YES];

}

- (void)didTapViewController
{
    if(_delegate && [_delegate respondsToSelector:@selector(didTapInMessageController:)]){
        [_delegate didTapInMessageController:self];
    }
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
    if (indexPath.row == 0) {
        JMChatDetailInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];

        if(cell == nil)
        {
            cell = [[JMChatDetailInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
        }
        if (_isDominator) {
            [cell setHidden:YES];
        }
        
        [cell setMyConModel:_myModel];
        return cell;

    }else if (indexPath.row > 0 ) {
    
        NSObject *data = _uiMsgs[indexPath.row-1];
        JMMessageCell *cell = nil;
        if([data isKindOfClass:[JMMessageCellData class]]){
            cell = [tableView dequeueReusableCellWithIdentifier:TTextMessageCell_ReuseId];
            
            if(cell == nil){
                cell = [[JMMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TTextMessageCell_ReuseId];
                //            cell.delegate = self;
            }
            cell.backgroundColor = BG_COLOR;
            [cell setData:_uiMsgs[indexPath.row-1]];
            [cell setIsDominator:_isDominator];//系统消息
        }
    
        return cell;

    
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        if (_isDominator) {
            return 0;
            
        }else{
            return 200;
        }
    }else{
        CGFloat height = 0;
        NSObject *data = _uiMsgs[indexPath.row-1];
        if([data isKindOfClass:[JMMessageCellData class]]){
            JMMessageCellData *data = _uiMsgs[indexPath.row-1];
            JMMessageCell *cell = [[JMMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TTextMessageCell_ReuseId];
            height = [cell getHeight:data];
        }
        return height;

    }
    return 0;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

        [[UIApplication sharedApplication]sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];


}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [[UIApplication sharedApplication]sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
//
//}


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
