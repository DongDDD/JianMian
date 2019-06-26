//
//  JMOrderStatusTableViewCell.h
//  JMian
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMOrderCellData.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMOrderStatusTableViewCellDelegate <NSObject>

-(void)didClickDetail_isSpread:(BOOL)isSpread indexPath:(NSIndexPath *)indexPath;
-(void)didClickDeliverGoodsWithData:(JMOrderCellData *)data;
@end


@interface JMOrderStatusTableViewCell : UITableViewCell
@property(nonatomic,weak)id<JMOrderStatusTableViewCellDelegate>delegate;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)JMOrderCellData *orderCellData;



@end

NS_ASSUME_NONNULL_END
