//
//  JMTextMessageCell.h
//  JMian
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMessageCell.h"
#import "JMMessageCellData.h"
#import "JMTextMessageCellData.h"
@import ImSDK;
NS_ASSUME_NONNULL_BEGIN

@interface JMTextMessageCell : JMMessageCell

@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UIImageView *bubble;
//@property (nonatomic, assign)BOOL isDominator;

//- (CGFloat)getHeight:(JMMessageCellData *)data;
- (void)setData:(JMTextMessageCellData *)data;
- (CGFloat)getHeight:(JMMessageCellData *)data;

//- (void)setupViews;
/**
 *  信息数据类。
 *  存储了该massageCell中所需的信息。包括发送者 ID，发送者头像、信息发送状态、信息气泡图标等。
 *  messageData 详细信息请参考：Section\Chat\CellData\TUIMessageCellData.h
 */
//@property (readonly) JMMessageCellData *messageData;


/**
 *  协议委托
 *  负责实现 TMessageCellDelegate 协议中的功能。
 */
//@property (nonatomic, weak) id<JMMessageCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
