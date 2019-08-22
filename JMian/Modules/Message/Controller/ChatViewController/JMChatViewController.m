//
//  JMChatViewController.m
//  JMian
//
//  Created by chitat on 2019/8/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMChatViewController.h"
#import "TUITextMessageCellData.h"
#import "TUITextMessageCell.h"

@interface JMChatViewController ()<TUIChatControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate>

@property (nonatomic, strong) TUIChatController *chat;


@end

@implementation JMChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    NSString *receiverID;
    NSString *titleStr;
    NSString *subTitle;
    if (_myConvModel.work_work_name) {
        //全职对话
        subTitle = [NSString stringWithFormat:@"/%@",_myConvModel.work_work_name];
    }else if (_myConvModel.job_type_label_name) {
        //兼职对话
        subTitle = [NSString stringWithFormat:@"/%@",_myConvModel.job_type_label_name];
    }else{
        subTitle = @"";
    }
    if ([self.myConvModel.data.convId isEqualToString:@"dominator"]) {
        receiverID = @"dominator";
        self.title = @"系统消息";
    }else if (model.user_id == _myConvModel.sender_user_id) {
        if (_myConvModel.recipient_nickname.length > 0) {
           
            titleStr = [NSString stringWithFormat:@"%@%@",_myConvModel.recipient_nickname,subTitle];
        }else{
            titleStr = [NSString stringWithFormat:@"%@",_myConvModel.recipient_phone];
        }
        receiverID = self.myConvModel.recipient_mark;
    }else{
        if (_myConvModel.sender_nickname.length > 0) {
           
            titleStr = [NSString stringWithFormat:@"%@%@",_myConvModel.sender_nickname,subTitle];
        }else{
            titleStr = [NSString stringWithFormat:@"%@",_myConvModel.sender_phone];
        }
        receiverID = self.myConvModel.sender_mark;
    }
    self.title = titleStr;
    
    TIMConversation *conv = [[TIMManager sharedInstance] getConversation:(TIMConversationType)TIM_C2C receiver:receiverID];
    _chat = [[TUIChatController alloc] initWithConversation:conv];
    _chat.delegate = self;
    _chat.myConvModel = self.myConvModel;
    [self addChildViewController:_chat];
//    _chat.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight);
    [self.view addSubview:_chat.view];

    
}

- (TUIMessageCellData *)chatController:(TUIChatController *)controller onNewMessage:(TIMMessage *)msg
{
    TIMElem *elem = [msg getElem:0];
    if([elem isKindOfClass:[TIMCustomElem class]]){
        
//        TUIMessageCellData *cellData = [[TUIMessageCellData alloc] initWithDirection:msg.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming];
        TUITextMessageCellData *cellData =[[TUITextMessageCellData alloc] initWithDirection:msg.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming];
        cellData.content = [(TIMCustomElem *)elem desc];
        
        if ([msg.getConversation.getReceiver isEqualToString:@"dominator"]) {
            cellData.avatarImage = [UIImage imageNamed:@"notification"];
            
        }else if([msg.getConversation.getReceiver isEqualToString: _myConvModel.sender_mark]) { //消息接收
            
            if (cellData.direction == MsgDirectionIncoming) {
                if(self.myConvModel.sender_avatar && ![self.myConvModel.sender_avatar isEqualToString:@""]) {
                  cellData.avatarUrl =  [NSURL URLWithString:self.myConvModel.sender_avatar];
                }else {
                    cellData.avatarImage = [UIImage imageNamed:@"default_avatar"];
                }
            }else{
                if(self.myConvModel.recipient_avatar && ![self.myConvModel.recipient_avatar isEqualToString:@""]) {
                    cellData.avatarUrl =  [NSURL URLWithString:self.myConvModel.recipient_avatar];
                }else {
                    cellData.avatarImage = [UIImage imageNamed:@"default_avatar"];
                }
            }
            
        }else {
            
            if (cellData.direction == MsgDirectionIncoming) {
                if(self.myConvModel.recipient_avatar && ![self.myConvModel.recipient_avatar isEqualToString:@""]) {
                    cellData.avatarUrl =  [NSURL URLWithString:self.myConvModel.recipient_avatar];
                }else {
                    cellData.avatarImage = [UIImage imageNamed:@"default_avatar"];
                }
                
            }else{
                if(self.myConvModel.sender_avatar && ![self.myConvModel.sender_avatar isEqualToString:@""]) {
                    cellData.avatarUrl =  [NSURL URLWithString:self.myConvModel.sender_avatar];
                }else {
                    cellData.avatarImage = [UIImage imageNamed:@"default_avatar"];
                }
            }
            
        }

        return cellData;
    }
    return nil;
}

- (TUIMessageCell *)chatController:(TUIChatController *)controller onShowMessageData:(TUIMessageCellData *)data
{
    if ([data isKindOfClass:[TUITextMessageCellData class]]) {
        TUITextMessageCell *myCell = [[TUITextMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        [myCell fillWithData:(TUITextMessageCellData *)data];
        return myCell;
    }
    return nil;
}


@end
