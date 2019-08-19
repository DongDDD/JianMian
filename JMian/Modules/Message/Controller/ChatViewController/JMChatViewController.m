//
//  JMChatViewController.m
//  JMian
//
//  Created by chitat on 2019/8/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMChatViewController.h"

@interface JMChatViewController ()<TUIChatControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate>

@property (nonatomic, strong) TUIChatController *chat;


@end

@implementation JMChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    NSString *receiverID;
    if (model.user_id == _myConvModel.sender_user_id) {
        self.title = _myConvModel.recipient_nickname;
        receiverID = self.myConvModel.recipient_mark;
    }else{
        self.title = _myConvModel.sender_nickname;
        receiverID = self.myConvModel.sender_mark;
    }
    
    TIMConversation *conv = [[TIMManager sharedInstance] getConversation:(TIMConversationType)TIM_C2C receiver:receiverID];
    _chat = [[TUIChatController alloc] initWithConversation:conv];
    _chat.delegate = self;
    _chat.myConvModel = self.myConvModel;
    [self addChildViewController:_chat];
//    _chat.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight);
    [self.view addSubview:_chat.view];

    
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
