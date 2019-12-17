//
//  JMFriendTableViewCell.h
//  JMian
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMFriendListModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMFriendTableViewCellDelegate <NSObject>

-(void)addFriendActionWithModel:(JMFriendListModel *)model;

@end
@interface JMFriendTableViewCell : UITableViewCell

@property(nonatomic,strong)JMFriendListModel *model;
@property(nonatomic,weak)id<JMFriendTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
