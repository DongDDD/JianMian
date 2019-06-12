//
//  JMTaskManageTableViewCell.h
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMTaskOrderListCellData.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMTaskManageTableViewCellDelegate <NSObject>

-(void)leftActionWithData:(JMTaskOrderListCellData *)data;
-(void)rightActionWithData:(JMTaskOrderListCellData *)data;

@end


@interface JMTaskManageTableViewCell : UITableViewCell

@property(nonatomic,strong)JMTaskOrderListCellData *data;

@property(nonatomic,weak)id<JMTaskManageTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
