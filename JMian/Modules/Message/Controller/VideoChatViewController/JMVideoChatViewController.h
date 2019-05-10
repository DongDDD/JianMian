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

@property(nonatomic, strong)JMMessageListModel *model;
@property(nonatomic, strong)JMInterViewModel *interviewModel;

@end

NS_ASSUME_NONNULL_END
