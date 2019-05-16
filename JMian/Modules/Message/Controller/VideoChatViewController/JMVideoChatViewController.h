//
//  JMVideoChatViewController.h
//  JMian
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMMessageListModel.h"
#import "JMInterViewModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMVideoChatViewType) {
    JMJMVideoChatViewFromInterview,
    JMJMVideoChatViewFromWindow,
};
@interface JMVideoChatViewController : BaseViewController

@property(nonatomic, strong) void(^didCloseVideo)(void);
//@property (nonatomic, strong) void(^didLoadContentLab)(CGFloat);
@property(nonatomic, strong)JMMessageListModel *chatViewModel;
@property(nonatomic, strong)JMInterViewModel *interviewModel;
@property(nonatomic, strong)NSDictionary *videoChatDic;//弹窗进来
@property(nonatomic, assign)JMVideoChatViewType videoChatViewType;
@property (nonatomic, copy)NSString *receiverID;//此ID仅用于发送视频自定义消息

@end

NS_ASSUME_NONNULL_END
