//
//  JMChatViewViewController.m
//  JMian
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMChatViewViewController.h"
#import <TIMManager.h>
#import <TIMMessage.h>
#import <IMMessageExt.h>
#import "JMMessageTableViewController.h"
#import "JMInputTextView.h"
#import "JMMessageCell.h"
#import "JMGreetView.h"
#import "JMGreetTableViewController.h"
#import "JMInputController.h"
#import "DimensMacros.h"


@interface JMChatViewViewController () <JMInputTextViewDelegate,JMMessageTableViewControllerDelegate,JMInputControllerDelegate>

@property (nonatomic ,strong) JMMessageTableViewController *messageController;
@property (nonatomic ,strong) JMInputController *inputController;
@property (nonatomic ,strong) JMInputTextView *inputView;

@property (nonatomic, strong) NSArray *childVCs;

//@property (nonatomic ,strong) JMGreetView *greetView;

@end

@implementation JMChatViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    if (model.user_id == _myConvModel.sender_user_id) {
        self.title = _myConvModel.recipient_nickname;
        
    }else{
        self.title = _myConvModel.sender_nickname;

    
    }
    [self setupViews];

//
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];


}
- (void)setupViews{
    //input
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNewMessage:) name:Notification_JMMMessageListener object:nil];
    
    _messageController = [[JMMessageTableViewController alloc] init];
    _messageController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - TTextView_Height - Bottom_SafeHeight);;
    _messageController.delegate = self;

    [self addChildViewController:_messageController];
    [self.view addSubview:_messageController.view];
    [_messageController setMyConvModel:_myConvModel];

    _inputController = [[JMInputController alloc] init];
    _inputController.view.frame = CGRectMake(0, _messageController.view.frame.size.height - TTextView_Height - Bottom_SafeHeight-55, self.view.frame.size.width,_messageController.view.frame.size.height - TTextView_Height - Bottom_SafeHeight);
    _inputController.delegate = self;
    NSLog(@"*******%f",Bottom_SafeHeight);
    [self addChildViewController:_inputController];
    [self.view addSubview:_inputController.view];

//    [_inputController.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.mas_equalTo(_messageController.view);
//        make.height.mas_equalTo(TTextView_Height);
//        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-Bottom_SafeHeight);
//    }];

}






//-(void)sendMessageWithText:(NSString *)text{
//
//    TIMConversation *conv = [[TIMManager sharedInstance]
//                             getConversation:(TIMConversationType)TIM_C2C
//                             receiver:_myConvModel.recipient_mark];
//
//    TIMTextElem * text_elem = [[TIMTextElem alloc] init];
//
//    [text_elem setText:text];
//
//    TIMMessage * msg = [[TIMMessage alloc] init];
//    [msg addElem:text_elem];
//
//    [conv sendMessage:msg succ:^(){
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"测试提示" message:@"发送成功"
//                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//        [alert show];
//        NSLog(@"SendMsg Succ");
//    }fail:^(int code, NSString * err) {
//        NSLog(@"SendMsg Failed:%d->%@", code, err);
//    }];
//
//
//    JMMessageCellData *textData = [[JMMessageCellData alloc]init];
//    textData.content = text_elem.text;
//    textData.head = _myConvModel.recipient_avatar;
//    textData.name = _myConvModel.recipient_nickname;
//    textData.isSelf = YES;
//    [_messageController.uiMsgs addObject:textData];
//
//    [_messageController.tableView reloadData];
//}

- (void)inputController:(JMInputController *)inputController didSendMessage:(JMMessageCellData *)msg
{
   
    [_messageController sendMessage:msg];

}

- (void)inputController:(JMInputController *)inputController didChangeHeight:(CGFloat)height
{
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect msgFrame = ws.messageController.view.frame;
        msgFrame.size.height = ws.view.frame.size.height - height;
        ws.messageController.view.frame = msgFrame;
        CGRect inputFrame = ws.inputController.view.frame;
        inputFrame.origin.y = msgFrame.origin.y + msgFrame.size.height;
        inputFrame.size.height = height;
        ws.inputController.view.frame = inputFrame;
//
//        [ws.inputController.view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-height);
//            make.left.and.right.mas_equalTo(self.view);
//            make.height.mas_equalTo(TTextView_Height + Bottom_SafeHeight);
//        }];
        
        
//        [ws.messageController scrollToBottom:NO];
    } completion:nil];
    
}

- (void)didTapInMessageController:(JMMessageTableViewController *)controller
{

    [_inputController reset];
}

- (void)sendGreetAction:(NSInteger *)index{
  
//    [_inputView setChildVC:self.childVCs];

//    [_inputView setCurrentIndex:0];


//    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.view).offset(-211);
//        make.left.mas_equalTo(self.view);
//        make.right.mas_equalTo(self.view);
//        make.height.mas_equalTo(60);
//    }];

    
}

//- (NSArray *)childVCs {
//
//    JMGreetTableViewController *vc1 = [[JMGreetTableViewController alloc] init];
//
//    [self addChildViewController:vc1];
//
//    _childVCs = @[vc1];
//
//    return _childVCs;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
