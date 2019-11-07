//
//  JMChatViewController.h
//  JMian
//
//  Created by chitat on 2019/8/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "TUIChatController.h"
#import "TUnReadView.h"
#import "JMMessageListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JMChatViewController : BaseViewController

@property (nonatomic, strong) TUIConversationCellData *conversationData;
@property (nonatomic, strong) TUnReadView *unRead;
@property (nonatomic, strong) JMMessageListModel *myConvModel;


@end

NS_ASSUME_NONNULL_END
