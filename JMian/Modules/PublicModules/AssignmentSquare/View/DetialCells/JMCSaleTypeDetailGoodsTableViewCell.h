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
typedef enum : NSUInteger {
    JMCSaleTypeDetailGoodsDefaultType,
    JMCSaleTypeDetailGoodsSnapshootType,
}  JMCSaleTypeDetailGoodsType;

extern NSString *const JMCSaleTypeDetailGoodsTableViewCellIdentifier;
@protocol JMCSaleTypeDetailGoodsTableViewCellDelegate <NSObject>
-(void)didSelectedGoodsItemsWithModel:(JMGoodsData *)model;
-(void)didSelectedGoodsShareActionWithModel:(JMGoodsData *)model;
@end
@interface JMCSaleTypeDetailGoodsTableViewCell : UITableViewCell
@property(nonatomic,strong)NSArray *goodsArray;
@property(nonatomic,assign)id<JMCSaleTypeDetailGoodsTableViewCellDelegate>delegate;
@property(nonatomic,assign)JMCSaleTypeDetailGoodsType viewType;

@end

NS_ASSUME_NONNULL_END
