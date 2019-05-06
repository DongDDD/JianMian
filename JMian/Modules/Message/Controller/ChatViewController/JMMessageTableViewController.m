//
//  JMMessageTableViewController.m
//  JMian
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMessageTableViewController.h"
#import <TIMManager.h>
#import <TIMMessage.h>
#import <IMMessageExt.h>
#import "JMMessageCell.h"
#import "DimensMacros.h"
#import "JMCompanyLikeTableViewCell.h"
#import "JMChatDetailInfoTableViewCell.h"
#import "JMChatViewSectionView.h"

@interface JMMessageTableViewController ()

@property (nonatomic, strong) JMMessageListModel *myModel;

@property (nonatomic, strong) TIMMessage *msgForGet;



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



}


- (NSMutableArray *)extracted:(JMMessageTableViewController *const __weak)ws {
    return ws.uiMsgs;
}


- (void)readedReport
{
    if (_myModel) {
        
        TIMConversation *conv = [[TIMManager sharedInstance]
                                 getConversation:(TIMConversationType)TIM_C2C
                                 receiver:_myModel.recipient_mark];
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
    [self loadMessage];


}



//消息解释
- (void)loadMessage
{
    _uiMsgs = [NSMutableArray array];
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:_myModel.recipient_mark];
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
                    textData.head = _myModel.sender_avatar;
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
                    textData.head = _myModel.recipient_avatar;
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

-(void)sendMessage:(JMMessageCellData *)data{
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:_myModel.recipient_mark];
    
    TIMTextElem * text_elem = [[TIMTextElem alloc] init];
    
    [text_elem setText:data.content];
    
    TIMMessage * msg = [[TIMMessage alloc] init];
    [msg addElem:text_elem];
    
    [conv sendMessage:msg succ:^(){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"测试提示" message:@"发送成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        NSLog(@"SendMsg Succ");
    }fail:^(int code, NSString * err) {
        NSLog(@"SendMsg Failed:%d->%@", code, err);
    }];
    
    
    JMMessageCellData *textData = [[JMMessageCellData alloc]init];
    textData.content = text_elem.text;
    textData.head = _myModel.recipient_avatar;
    textData.name = _myModel.recipient_nickname;
    textData.isSelf = YES;
    [self.uiMsgs addObject:textData];
    
    [self.tableView reloadData];
}

- (void)didTapViewController
{
    if(_delegate && [_delegate respondsToSelector:@selector(didTapInMessageController:)]){
        [_delegate didTapInMessageController:self];
    }
}

#pragma mark - Table view data source
//section
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 43;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        JMChatViewSectionView *view=[[JMChatViewSectionView alloc] init];
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
        }
    
        return cell;

    
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        return 200;
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
