//
//  JMCSaleTypeDetailGoodsTableViewCell.h
//  JMian
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMGoodsData.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMCSaleTypeDetailGoodsTableViewCellIdentifier;
@protocol JMCSaleTypeDetailGoodsTableViewCellDelegate <NSObject>
-(void)didSelectedGoodsItemsWithModel:(JMGoodsData *)model;

@end
@interface JMCSaleTypeDetailGoodsTableViewCell : UITableViewCell
@property(nonatomic,strong)NSArray *goodsArray;
@property(nonatomic,assign)id<JMCSaleTypeDetailGoodsTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
