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

@interface JMVideoChatViewController : BaseViewController

-(void)setInterviewModel:(JMInterViewModel *)interviewModel;
-(void)setVideoChatDic:(NSDictionary *)videoChatDic;
@property (nonatomic, copy)NSString *receiverID;//此ID仅用于发送视频自定义消息
//@property (weak, nonatomic) IBOutlet UIView *controlButtons;
@property (weak, nonatomic) IBOutlet UIView *controlButtons;

@end

NS_ASSUME_NONNULL_END
