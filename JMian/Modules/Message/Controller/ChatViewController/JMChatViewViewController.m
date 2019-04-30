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



@interface JMChatViewViewController () 

@property (nonatomic ,strong) JMMessageTableViewController *messageController;

@end

@implementation JMChatViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupViews];
    
}


- (void)setupViews{
    
    //    //message
    _messageController = [[JMMessageTableViewController alloc] init];
    _messageController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    //    _messageController.delegate = self;
    [self addChildViewController:_messageController];
    [self.view addSubview:_messageController.view];
    [_messageController setConversation:_conversation];
    [_messageController setMyConvModel:_myConvModel];
    //    [_messageController setConversation:_conversation];



}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
