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


@interface JMChatViewViewController () <JMInputTextViewDelegate>

@property (nonatomic ,strong) JMMessageTableViewController *messageController;
@property (nonatomic ,strong) JMInputController *inputController;
@property (nonatomic ,strong) JMInputTextView *inputView;

@property (nonatomic, strong) NSArray *childVCs;

//@property (nonatomic ,strong) JMGreetView *greetView;

@end

@implementation JMChatViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _myConvModel.sender_nickname;
    [self setupViews];
    
}


- (void)setupViews{
    //input
    
//    _inputView = [[JMInputTextView alloc]init];
//    _inputView.delegate = self;
//    //    _inputView.backgroundColor = [UIColor redColor];
//    //    _inputView.frame = CGRectMake(0,self.view.frame.size.height-200, self.view.frame.size.width, 49);
//    [self.view addSubview:_inputView];
//    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.view);
//        make.left.mas_equalTo(self.view);
//        make.right.mas_equalTo(self.view);
//        make.height.mas_equalTo(60);
//    }];
//
    //    //message
    _messageController = [[JMMessageTableViewController alloc] init];
//    _messageController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //    _messageController.delegate = self;
    [self addChildViewController:_messageController];
    [self.view addSubview:_messageController.view];
//    [_messageController setConversation:_conversation];
    [_messageController setMyConvModel:_myConvModel];
    [_messageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
    }];
    
    _inputController = [[JMInputController alloc] init];

    //    _inputController.delegate = self;
    [self addChildViewController:_inputController];
    [self.view addSubview:_inputController.view];

    [_inputController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(TTextView_Height + Bottom_SafeHeight);
    }];
}

-(void)sendMessageWithText:(NSString *)text{

    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:_myConvModel.sender_mark];
    
    TIMTextElem * text_elem = [[TIMTextElem alloc] init];
    
    [text_elem setText:text];
    
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
    textData.head = _myConvModel.recipient_avatar;
    textData.name = _myConvModel.recipient_nickname;
    textData.isSelf = YES;
    [_messageController.uiMsgs addObject:textData];
    
    [_messageController.tableView reloadData];
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
