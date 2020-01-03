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
#import "JMHTTPManager+CreateConversation.h"
#import "JMGroupInfoViewController.h"

@interface JMChatViewController ()<TUIChatControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate>

@property (nonatomic, strong) TUIChatController *chat;


@end

@implementation JMChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    NSString *receiverID;
    NSString *titleStr;
    NSString *subTitle = @"";

//    if ([_myConvModel.type isEqualToString:@"1"]) {
//        subTitle = [NSString stringWithFormat:@"/%@",_myConvModel.work_work_name];
//    }else{
//        subTitle = [NSString stringWithFormat:@"/%@",_myConvModel.job_type_label_name];
//    }
//

    if([model.type isEqualToString:B_Type_UESR]){
        
        if ([_myConvModel.type isEqualToString:@"1"]) {
            if (_myConvModel.job_work_name) {
                subTitle = [NSString stringWithFormat:@"/%@",_myConvModel.job_work_name];
            }
        }else{
            if (_myConvModel.job_type_label_name) {
                subTitle = [NSString stringWithFormat:@"/%@",_myConvModel.job_type_label_name];
            }
        }
        
    }else if ([model.type isEqualToString:C_Type_USER]) {
        //判断自己是不是sender
        if ([_myConvModel.type isEqualToString:@"2"]) {
            //兼职类型
            NSString *position;
            if (model.user_id == _myConvModel.sender_user_id) {
                position = _myConvModel.recipient_company_position;
            }else{
                position = _myConvModel.sender_company_position;
            }
            if (_myConvModel.work_task_title.length > 0) {
                subTitle = [NSString stringWithFormat:@"|%@|%@",_myConvModel.work_task_title,position];

            }else{
                subTitle = [NSString stringWithFormat:@"|%@",position];
                
            }
        }else if ([_myConvModel.type isEqualToString:@"1"]) {
            //全职类型
            subTitle = [NSString stringWithFormat:@"|%@",_myConvModel.work_work_name];
        }
    }


    
    if (self.myConvModel.viewType == JMMessageList_Type_System) {
        receiverID = @"dominator";
        titleStr = @"系统消息";
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
    
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    //B端客服用户情况，这种业务情况是唯一的
    NSString *str1 = [NSString stringWithFormat:@"%@b",userModel.user_id];
    if ([receiverID isEqualToString:str1]) {
        receiverID = [NSString stringWithFormat:@"%@a",userModel.user_id];
    }
    
    if (_myConvModel.viewType == JMMessageList_Type_Service) {
        receiverID = [NSString stringWithFormat:@"%@b",_myConvModel.service_id];
        titleStr = @"得米客服";
    }else  if (_myConvModel.viewType == JMMessageList_Type_Group) {
        receiverID = _myConvModel.data.convId;
        titleStr = _myConvModel.data.title;
        [self setRightBtnImageViewName:@"icon-top3-more"  imageNameRight2:@""];
    }
    
    _myConvModel.data.convId = receiverID;
    self.title = titleStr;
    TIMConversation *conv = [[TIMManager sharedInstance] getConversation:_myConvModel.data.convType receiver:receiverID];
    _chat = [[TUIChatController alloc] initWithConversation:conv];
    _chat.delegate = self;
    _chat.myConvModel = self.myConvModel;
    [self addChildViewController:_chat];
//    _chat.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight);
    [self.view addSubview:_chat.view];
    
}

-(void)rightAction{
    JMGroupInfoViewController *vc = [[JMGroupInfoViewController alloc]init];
    vc.groupId = _myConvModel.data.convId;
    [self.navigationController pushViewController:vc animated:YES];
}

//-(void)createChatRequstWithForeign_key:(NSString *)foreign_key recipient:(NSString *)recipient chatType:(NSString *)chatType{
//
//    [[JMHTTPManager sharedInstance]createChat_type:chatType recipient:recipient foreign_key:foreign_key sender_mark:@"" recipient_mark:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
////        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
//
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//}


//- (TUIMessageCellData *)chatController:(TUIChatController *)controller onNewMessage:(TIMMessage *)msg
//{
//    TIMElem *elem = [msg getElem:0];
//    if([elem isKindOfClass:[TIMCustomElem class]]){
//
////        TUIMessageCellData *cellData = [[TUIMessageCellData alloc] initWithDirection:msg.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming];
//        TUITextMessageCellData *cellData =[[TUITextMessageCellData alloc] initWithDirection:msg.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming];
//        cellData.content = [(TIMCustomElem *)elem desc];
//
//        if ([msg.getConversation.getReceiver isEqualToString:@"dominator"]) {
//            cellData.avatarImage = [UIImage imageNamed:@"notification"];
//
//        }else if([msg.getConversation.getReceiver isEqualToString: _myConvModel.sender_mark]) { //消息接收
//
//            if (cellData.direction == MsgDirectionIncoming) {
//                if(self.myConvModel.sender_avatar && ![self.myConvModel.sender_avatar isEqualToString:@""]) {
//                  cellData.avatarUrl =  [NSURL URLWithString:self.myConvModel.sender_avatar];
//                }else {
//                    cellData.avatarImage = [UIImage imageNamed:@"default_avatar"];
//                }
//            }else{
//                if(self.myConvModel.recipient_avatar && ![self.myConvModel.recipient_avatar isEqualToString:@""]) {
//                    cellData.avatarUrl =  [NSURL URLWithString:self.myConvModel.recipient_avatar];
//                }else {
//                    cellData.avatarImage = [UIImage imageNamed:@"default_avatar"];
//                }
//            }
//
//        }else {
//
//            if (cellData.direction == MsgDirectionIncoming) {
//                if(self.myConvModel.recipient_avatar && ![self.myConvModel.recipient_avatar isEqualToString:@""]) {
//                    cellData.avatarUrl =  [NSURL URLWithString:self.myConvModel.recipient_avatar];
//                }else {
//                    cellData.avatarImage = [UIImage imageNamed:@"default_avatar"];
//                }
//
//            }else{
//                if(self.myConvModel.sender_avatar && ![self.myConvModel.sender_avatar isEqualToString:@""]) {
//                    cellData.avatarUrl =  [NSURL URLWithString:self.myConvModel.sender_avatar];
//                }else {
//                    cellData.avatarImage = [UIImage imageNamed:@"default_avatar"];
//                }
//            }
//
//        }
//
//        return cellData;
//    }
//    return nil;
//}

//- (TUIMessageCell *)chatController:(TUIChatController *)controller onShowMessageData:(TUIMessageCellData *)data
//{
//    if ([data isKindOfClass:[TUITextMessageCellData class]]) {
//        TUITextMessageCell *myCell = [[TUITextMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
//        [myCell fillWithData:(TUITextMessageCellData *)data];
//        return myCell;
//    }
//    return nil;
//}


@end
