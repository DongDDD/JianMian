//
//  JMTransferTableViewCell.h
//  JMian
//
//  Created by mac on 2019/12/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TUIMessageCell.h"
#import "JMTransferMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN
//@protocol JMTransferTableViewCellDelegate <NSObject>
//
//- (void)onSelectMessage:(TUIMessageCell *)cell;
//
//
//@end
@interface JMTransferTableViewCell : TUIMessageCell
@property(nonatomic,strong)UIImageView *transferImg;
@property(nonatomic,strong)UIImageView *symbolImg;

@property(nonatomic,strong)UIImageView *thumb;


@property(nonatomic,strong)UILabel *money;
@property(nonatomic,strong)UILabel *remark;
//@property(nonatomic,weak)id<JMTransferTableViewCellDelegate>delegate;
/**
 *
 *
 */
@property JMTransferMessageCellData *transferData;

/**
 *
 *
 *
 *  @param data 填充数据需要的数据源
 */
- (void)fillWithData:(JMTransferMessageCellData *)data;

@end

NS_ASSUME_NONNULL_END
