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

@interface JMMessageTableViewController ()

@property (nonatomic, strong) JMAllMessageTableViewCellData *conv;
@property (nonatomic, strong) JMMessageListModel *myModel;

@property (nonatomic, strong) NSMutableArray *uiMsgs;
@property (nonatomic, strong) TIMMessage *msgForGet;


@end

@implementation JMMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

-(void)setConversation:(JMAllMessageTableViewCellData *)conversation{

    _conv = conversation;
//    [self loadMessage];


}



- (void)loadMessage
{
    _uiMsgs = [NSMutableArray array];
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:_myModel.recipient_mark];
    __weak typeof(self) ws = self;
    [conv getMessage:10 last:_msgForGet succ:^(NSArray *msgs) {
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
        
        if(![[[msg getConversation] getReceiver] isEqualToString:_myModel.recipient_mark]){
            continue;
        }
        if(msg.status == TIM_MSG_STATUS_HAS_DELETED){
            continue;
        }
        
        
        int cnt = [msg elemCount];
        for (int i = 0; i < cnt; i++) {
            TIMElem * elem = [msg getElem:i];
            JMMessageCellData *data = nil;
            if ([elem isKindOfClass:[TIMTextElem class]]) {
                TIMTextElem * text_elem = (TIMTextElem *)elem;
                JMMessageCellData *textData = [[JMMessageCellData alloc]init];
                textData.content = text_elem.text;
                data = textData;
                [uiMsgs addObject:data];
                
            }
            
        }
        
        
    }
    
    
    
    return uiMsgs;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _uiMsgs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
    NSObject *data = _uiMsgs[indexPath.row];
    JMMessageCell *cell = nil;
    if([data isKindOfClass:[JMMessageCellData class]]){
        cell = [tableView dequeueReusableCellWithIdentifier:TTextMessageCell_ReuseId];
        if(!cell){
            cell = [[JMMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TTextMessageCell_ReuseId];
//            cell.delegate = self;
        }
        [cell setData:_uiMsgs[indexPath.row]];
    }
    return cell;
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
