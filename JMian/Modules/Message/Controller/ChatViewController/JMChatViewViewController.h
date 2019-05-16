//
//  JMChatViewViewController.h
//  JMian
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JMMessageListModel.h"
#import "JMAllMessageTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMChatViewViewControllerDelegate <NSObject>

-(void)sendUnReadNum_cell:(JMAllMessageTableViewCell *)cell;

@end


@interface JMChatViewViewController : BaseViewController

@property (nonatomic, strong)JMMessageListModel *myConvModel;
//@property (nonatomic, strong)JMAllMessageTableViewCellData *conversation;

@property (nonatomic, weak)id<JMChatViewViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
