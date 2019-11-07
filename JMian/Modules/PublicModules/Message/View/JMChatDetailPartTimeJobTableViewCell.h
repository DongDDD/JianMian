//
//  JMChatDetailPartTimeJobTableViewCell.h
//  JMian
//
//  Created by mac on 2019/6/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMMessageListModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMChatDetailPartTimeJobTableViewCellDelegate <NSObject>

-(void)applyForAction_model:(JMMessageListModel *)model;
-(void)didClickPartTimeInfoAction;
@end

@interface JMChatDetailPartTimeJobTableViewCell : UITableViewCell
@property (nonatomic, strong) JMMessageListModel *myConModel;
@property (nonatomic, weak)id<JMChatDetailPartTimeJobTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
