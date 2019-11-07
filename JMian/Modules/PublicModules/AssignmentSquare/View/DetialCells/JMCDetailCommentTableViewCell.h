//
//  JMCDetailCommentTableViewCell.h
//  JMian
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCommentCellData.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMCDetailCommentTableViewCellIdentifier;

@interface JMCDetailCommentTableViewCell : UITableViewCell

@property(nonatomic,strong)JMCommentCellData *data;

@end

NS_ASSUME_NONNULL_END
