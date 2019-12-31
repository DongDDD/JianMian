//
//  JMFriendTableViewCell.h
//  JMian
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMAddFriendModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMFriendTableViewCellDelegate <NSObject>

-(void)addFriendActionWithModel:(JMAddFriendModel *)model;

@end
@interface JMFriendTableViewCell : UITableViewCell

@property(nonatomic,strong)JMAddFriendModel *model;
@property(nonatomic,weak)id<JMFriendTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
