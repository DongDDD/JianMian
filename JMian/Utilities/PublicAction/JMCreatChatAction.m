//
//  JMCreatChatAction.m
//  JMian
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMCreatChatAction.h"
#import "JMHTTPManager+CreateConversation.h"
#import "JMMessageListModel.h"
#import "JMChatViewController.h"

@implementation JMCreatChatAction
//创建聊天
+(void)createC2CTypeChatRequstWithChat_type:(NSString *)chat_type
                                foreign_key:(NSString *)foreign_key
                                    user_id:(NSString *)user_id
                                sender_mark:(nullable NSString *)sender_mark
                             recipient_mark:(nullable NSString *)recipient_mark {
    
    [[JMHTTPManager sharedInstance]createChat_type:chat_type recipient:user_id foreign_key:foreign_key sender_mark:sender_mark recipient_mark:recipient_mark successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
        JMAllMessageTableViewCellData *data = [[JMAllMessageTableViewCellData alloc]init];
        data.convType = TConv_Type_C2C;
        messageListModel.data =data;
        messageListModel.viewType = JMMessageList_Type_C2C;
        JMChatViewController *vc = [[JMChatViewController alloc]init];
        vc.myConvModel = messageListModel;
        [[self currentViewController].navigationController pushViewController:vc animated:YES];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

+(void)create4TypeChatRequstWithAccount:(NSString *)account{
    [[JMHTTPManager sharedInstance]createFriendChatWithType:@"4" account:account successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
            JMAllMessageTableViewCellData *data = [[JMAllMessageTableViewCellData alloc]init];
            data.convType = TConv_Type_C2C;
            messageListModel.data =data;
            messageListModel.viewType = JMMessageList_Type_C2C;
            JMChatViewController *vc = [[JMChatViewController alloc]init];
            vc.myConvModel = messageListModel;
            [[self currentViewController].navigationController pushViewController:vc animated:YES];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}

//获取Window当前显示的ViewController
+ (UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}
@end
