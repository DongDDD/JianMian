//
//  JMMessageListViewController.m
//  JMian
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMessageListViewController.h"
#import "JMAllMessageTableViewCell.h"
#import <ImSDK/TIMManager.h>
#import <ImSDK/TIMMessage.h>
#import <ImSDK/IMMessageExt.h>
#import "JMHTTPManager+MessageList.h"
#import "JMMessageListModel.h"
#import "JMAllMessageTableViewCellData.h"
#import "JMChatViewViewController.h"
#import "JMHTTPManager+Login.h"
#import "JMHTTPManager+CreateConversation.h"

@interface JMMessageListViewController ()<UITableViewDelegate,UITableViewDataSource,JMChatViewViewControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *modelArray;
//@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong)JMMessageListModel *dominatorModel;

@end


static NSString *cellIdent = @"allMessageCellIdent";


@implementation JMMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"聊出好机会";
    [self setIsHiddenBackBtn:YES];
    [self initView];
    //    [self initRefresh];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self loginOut];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [self getMsgList];    //获取自己服务器数据
    [self setupHeaderRefresh];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNewMessage:) name:Notification_JMMMessageListener object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)initView{
    [self.view addSubview:self.tableView];

}

-(void)setupHeaderRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}




-(void)loadNewData{
    [self getMsgList];    //获取自己服务器数据
    
}

- (void)onNewMessage:(NSNotification *)notification
{
    [self getMsgList];    //获取自己服务器数据
}

#pragma mark - data

-(void)getMsgList{
    
    self.title = @"收取中...";
    [[JMHTTPManager sharedInstance]fecthMessageList_mode:@"array" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            
            self.modelArray = [JMMessageListModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self updateConversations]; //获取腾讯云数据
        }
        self.title = @"聊出好机会";
//        [self.progressHUD setHidden:YES];
        [self.tableView.mj_header endRefreshing];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
    
}
//创建聊天
-(void)createChatRequstWithType:(NSString *)type foreign_key:(NSString *)foreign_key recipient:(NSString *)recipient{
    if (recipient || foreign_key) {
        [[JMHTTPManager sharedInstance]createChat_type:type recipient:recipient foreign_key:foreign_key successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
            //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"创建对话成功"
            //                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            //        [alert show];
            JMChatViewViewController *vc = [[JMChatViewViewController alloc]init];
            vc.myConvModel = messageListModel;
            [self.navigationController pushViewController:vc animated:YES];
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

        }];

    }
}

- (void)updateConversations {
    JMUserInfoModel *userInfomodel = [JMUserInfoManager getUserInfo];
    
    _dataArray = [NSMutableArray array];
    NSMutableArray *converArray = [NSMutableArray array];
    self.unReadNum = 0;
    TIMManager *manager = [TIMManager sharedInstance];
    NSArray *convs = [manager getConversationList];
    NSLog(@"腾讯云数据%@",convs);
    for (TIMConversation *conv in convs) {
        if([conv getType] == TIM_SYSTEM){
            continue;
        }
        TIMMessage *msg = [conv getLastMsg];
        NSLog(@"%@",msg);
        for (JMMessageListModel *model in self.modelArray) {
            if (model.sender_user_id == userInfomodel.user_id) {
                //判断sender是不是自己,是自己的话，拿recipient_mark去跟腾讯云的ID配对接收者
                if ([model.recipient_mark isEqualToString:[conv getReceiver]]) {
                    JMAllMessageTableViewCellData *data = [[JMAllMessageTableViewCellData alloc] init];
                    data.unRead = [conv getUnReadMessageNum];
                    _unReadNum += [conv getUnReadMessageNum];
                    data.convId = [conv getReceiver];
                    model.data = data;
                    data.time = [self getDateDisplayString:msg.timestamp];
                    data.subTitle = [self getLastDisplayString:conv];
                    
                    model.data = data;
                    [converArray addObject:model];
                    NSLog(@" %@未读消息 :%d",data.convId,[conv getUnReadMessageNum]);

                    
                }
                
            }else if(model.recipient_user_id == userInfomodel.user_id){
                //判断recipient是自己的话，拿sender_mark去跟腾讯云的ReceiverID配对接收者
                
                if ([model.sender_mark isEqualToString:[conv getReceiver]]) {
                    
                    JMAllMessageTableViewCellData *data = [[JMAllMessageTableViewCellData alloc] init];
                    data.convId = [conv getReceiver];
                    data.unRead = [conv getUnReadMessageNum];
                    _unReadNum += [conv getUnReadMessageNum];
                    model.data = data;
                    data.time = [self getDateDisplayString:msg.timestamp];
                    data.subTitle = [self getLastDisplayString:conv];
                    
                    model.data = data;
                    [converArray addObject:model];
                    NSLog(@" %@未读消息 :%d",data.convId,[conv getUnReadMessageNum]);

                    
                }
                
            }
            
            
        }
        
        if ([[conv getReceiver] isEqualToString:@"dominator"]) {
            JMMessageListModel *model = [[JMMessageListModel alloc]init];
            JMAllMessageTableViewCellData *data = [[JMAllMessageTableViewCellData alloc] init];
            data.convId = [conv getReceiver];
            data.unRead = [conv getUnReadMessageNum];
            _unReadNum += [conv getUnReadMessageNum];
            data.time = [self getDateDisplayString:msg.timestamp];
            data.subTitle = [self getLastDisplayString:conv];
            
            model.data = data;
            self.dominatorModel = model;
            NSLog(@" %@未读消息 :%d",data.convId,[conv getUnReadMessageNum]);

        }
        
    }
    //把系统消息置顶
    if (self.dominatorModel) {
        
        [self.dataArray addObject:self.dominatorModel];
    }
    if (converArray) {
        [self.dataArray addObjectsFromArray:converArray];
        
    }
    
    //    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
    NSLog(@"未读消息数量%d",_unReadNum);
    if (_unReadNum > 0) {
        if (_unReadNum > 99) {
            self.tabBarItem.badgeValue = @"99+";
            
        }else{
            self.unReadNum = _unReadNum;
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",self.unReadNum];
            
        }
    }else{
        self.tabBarItem.badgeValue = nil;
    }
}

//-(void)getDominator{
//
//
//
//}

- (NSString *)getLastDisplayString:(TIMConversation *)conv
{
    NSString *str = @"";
    TIMMessageDraft *draft = [conv getDraft];
    if(draft){
        for (int i = 0; i < draft.elemCount; ++i) {
            TIMElem *elem = [draft getElem:i];
            if([elem isKindOfClass:[TIMTextElem class]]){
                TIMTextElem *text = (TIMTextElem *)elem;
                str = [NSString stringWithFormat:@"[草稿]%@", text.text];
                break;
            }
            else{
                continue;
            }
        }
        return str;
    }
    
    TIMMessage *msg = [conv getLastMsg];
    if(msg.status == TIM_MSG_STATUS_LOCAL_REVOKED){
        if(msg.isSelf){
            return @"你撤回了一条消息";
        }
        else{
            return [NSString stringWithFormat:@"\"%@\"撤回了一条消息", msg.sender];
        }
    }
    for (int i = 0; i < msg.elemCount; ++i) {
        TIMElem *elem = [msg getElem:i];
        if([elem isKindOfClass:[TIMTextElem class]]){
            TIMTextElem *text = (TIMTextElem *)elem;
            str = text.text;
            break;
        }
        else if([elem isKindOfClass:[TIMCustomElem class]]){
            TIMCustomElem *custom = (TIMCustomElem *)elem;
            str = custom.desc;
            
            break;
        }
        else if([elem isKindOfClass:[TIMImageElem class]]){
            str = @"[图片]";
            break;
        }
        else if([elem isKindOfClass:[TIMSoundElem class]]){
            str = @"[语音]";
            break;
        }
        else if([elem isKindOfClass:[TIMVideoElem class]]){
            str = @"[视频]";
            break;
        }
        else if([elem isKindOfClass:[TIMFaceElem class]]){
            str = @"[动画表情]";
            break;
        }
        else if([elem isKindOfClass:[TIMFileElem class]]){
            str = @"[文件]";
            break;
        }
        else if([elem isKindOfClass:[TIMGroupTipsElem class]]){
            TIMGroupTipsElem *tips = (TIMGroupTipsElem *)elem;
            switch (tips.type) {
                case TIM_GROUP_TIPS_TYPE_INFO_CHANGE:
                {
                    for (TIMGroupTipsElemGroupInfo *info in tips.groupChangeList) {
                        switch (info.type) {
                            case TIM_GROUP_INFO_CHANGE_GROUP_NAME:
                            {
                                str = [NSString stringWithFormat:@"\"%@\"修改群名为\"%@\"", tips.opUser, info.value];
                            }
                                break;
                            case TIM_GROUP_INFO_CHANGE_GROUP_INTRODUCTION:
                            {
                                str = [NSString stringWithFormat:@"\"%@\"修改群简介为\"%@\"", tips.opUser, info.value];
                            }
                                break;
                            case TIM_GROUP_INFO_CHANGE_GROUP_NOTIFICATION:
                            {
                                str = [NSString stringWithFormat:@"\"%@\"修改群公告为\"%@\"", tips.opUser, info.value];
                            }
                                break;
                            case TIM_GROUP_INFO_CHANGE_GROUP_OWNER:
                            {
                                str = [NSString stringWithFormat:@"\"%@\"修改群主为\"%@\"", tips.opUser, info.value];
                            }
                                break;
                            default:
                                break;
                        }
                    }
                }
                    break;
                case TIM_GROUP_TIPS_TYPE_KICKED:
                {
                    NSString *users = [tips.userList componentsJoinedByString:@"、"];
                    str = [NSString stringWithFormat:@"\"%@\"将\"%@\"剔出群组", tips.opUser, users];
                }
                    break;
                case TIM_GROUP_TIPS_TYPE_INVITE:
                {
                    NSString *users = [tips.userList componentsJoinedByString:@"、"];
                    str = [NSString stringWithFormat:@"\"%@\"邀请\"%@\"加入群组", tips.opUser, users];
                }
                    break;
                default:
                    break;
            }
        }
        else{
            continue;
        }
    }
    return str;
}


- (NSString *)getDateDisplayString:(NSDate *)date
{
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[ NSDate date ]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:date];
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init ];
    
    NSDateComponents *comp =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
    
    if (nowCmps.year != myCmps.year) {
        dateFmt.dateFormat = @"yyyy/MM/dd";
    }
    else{
        if (nowCmps.day==myCmps.day) {
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"aaa hh:mm";
        } else if((nowCmps.day-myCmps.day)==1) {
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"昨天";
        } else {
            if ((nowCmps.day-myCmps.day) <=7) {
                switch (comp.weekday) {
                    case 1:
                        dateFmt.dateFormat = @"星期日";
                        break;
                    case 2:
                        dateFmt.dateFormat = @"星期一";
                        break;
                    case 3:
                        dateFmt.dateFormat = @"星期二";
                        break;
                    case 4:
                        dateFmt.dateFormat = @"星期三";
                        break;
                    case 5:
                        dateFmt.dateFormat = @"星期四";
                        break;
                    case 6:
                        dateFmt.dateFormat = @"星期五";
                        break;
                    case 7:
                        dateFmt.dateFormat = @"星期六";
                        break;
                    default:
                        break;
                }
            }else {
                dateFmt.dateFormat = @"yyyy/MM/dd";
            }
        }
    }
    return [dateFmt stringFromDate:date];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMAllMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    [cell setData:[_dataArray objectAtIndex:indexPath.row]];
    JMMessageListModel *model = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([model.data.convId isEqualToString:@"dominator"]) {
        
        cell.backgroundColor = BG_COLOR;
    }
    NSLog(@"用户ID：-----%@",model.data.convId);
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self loginOut];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    NSString *recipient_id;
    NSString *foreign_key;
    JMMessageListModel *messagelistModel = [_dataArray objectAtIndex:indexPath.row];
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        if ([messagelistModel.data.convId isEqualToString:@"dominator"] && foreign_key == nil) {
            JMChatViewViewController *vc = [[JMChatViewViewController alloc]init];
            vc.myConvModel = messagelistModel;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            if (userModel.user_id == messagelistModel.sender_user_id) {
                recipient_id = messagelistModel.recipient_user_id;
            }else{
                recipient_id = messagelistModel.sender_user_id;
            }
            if ([messagelistModel.type isEqualToString:@"1"]) {
                foreign_key = messagelistModel.work_work_id;
            }else if ([messagelistModel.type isEqualToString:@"2"]) {
                foreign_key = messagelistModel.job_ability_id;
                
            }
        
        
        }
        
        [self createChatRequstWithType:messagelistModel.type foreign_key:foreign_key recipient:recipient_id];
    }else{
        
    JMChatViewViewController *vc = [[JMChatViewViewController alloc]init];
    vc.myConvModel = messagelistModel;
    vc.delegate = self;
//    [self setReadMessageAction_model:[_dataArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)getUserInfo{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)setReadMessageAction_model:(JMMessageListModel *)_myModel{
    
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    //判断senderid是不是自己
    BOOL _isSelfIsSender = [model.user_id isEqualToString: _myModel.sender_user_id];
    NSString *_receiverID;
    //先判断是否系统消息
    if ([_myModel.data.convId isEqualToString:@"dominator"]) {
        _receiverID = @"dominator";
    }else{
        //    17817295362
        if (_isSelfIsSender) {
            
            _receiverID = _myModel.recipient_mark;
        }else{
            
            _receiverID = _myModel.sender_mark;
        }
    }
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:_receiverID];
    [conv setReadMessage:nil succ:^{
        NSLog(@"已读上报");
//        if (_myModel.data.unRead > 0) {
//
//            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",self.unReadNum];
//        }else{
//            self.tabBarItem.badgeValue = nil;
//        }
        [self getMsgList];
        //            !_didReadMessage ? : _didReadMessage(_myModel.data.unRead);
        
    } fail:^(int code, NSString *msg) {
        NSLog(@"已读上报失败");
        
    }];
    
    
}
#pragma mark - MyDelegate
//-(void)didReadActionWithData:(JMMessageListModel *)data{
//        [self setReadMessageAction_model:data];
//    
//}


#pragma mark - lazy

//-(MBProgressHUD *)progressHUD{
//    if (!_progressHUD) {
//        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//        _progressHUD.progress = 0.6;
//        _progressHUD.dimBackground = NO; //设置有遮罩
//        [_progressHUD showAnimated:YES]; //显示进度框
//    }
//    return _progressHUD;
//}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.tableView registerNib:[UINib nibWithNibName:@"JMAllMessageTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
        self.tableView.rowHeight = 79;
        self.tableView.separatorStyle = UITableViewCellAccessoryNone;
        
        
    }
    return _tableView;
}

/*
 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }
 */

/*
 #pragma mark - Navigation

#pragma mark - Getter


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
