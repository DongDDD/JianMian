//
//  JMMessageTableViewController.h
//  JMian
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMAllMessageTableViewCell.h"
#import "JMMessageListModel.h"
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMMessageTableViewController : UITableViewController

//- (void)setConversation:(JMAllMessageTableViewCellData *)conversation;
- (void)setMyConvModel:(JMMessageListModel *)myConvModel;

@property (nonatomic, strong) NSMutableArray *uiMsgs;


@end

NS_ASSUME_NONNULL_END
