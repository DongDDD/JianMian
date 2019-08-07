//
//  JMMessageCell.h
//  JMian
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMMessageCellData.h"
@import ImSDK;
NS_ASSUME_NONNULL_BEGIN

@class JMMessageCell;

//TMessageCellDelegate

@protocol JMMessageCellDelegate <NSObject>

/**
 *  长按消息回调
 *  您可以通过该回调实现：在被长按的消息上方弹出删除、撤回（消息发送者长按自己消息时）等二级操作。
 *
 *  @param cell 委托者，消息单元
 */
- (void)onLongPressMessage:(JMMessageCell *)cell;

/**
 *  重发消息点击回调。
 *  在您点击重发图像（retryView）时执行的回调。
 *  您可以通过该回调实现：对相应的消息单元对应的消息进行重发。
 *
 *  @param cell 委托者，消息单元
 */
- (void)onRetryMessage:(JMMessageCell *)cell;

/**
 *  点击消息回调
 *  通常情况下：点击声音消息 - 播放；点击文件消息 - 打开文件；点击图片消息 - 展示大图；点击视频消息 - 播放视频。
 *  通常情况仅对函数实现提供参考作用，您可以根据需求个性化实现该委托函数。
 *
 *  @param cell 委托者，消息单元
 */
- (void)onSelectMessage:(JMMessageCell *)cell;

/**
 *  点击消息单元中消息头像的回调
 *  您可以通过该回调实现：响应用户点击，跳转到相应用户的详细信息界面。
 *
 *  @param cell 委托者，消息单元
 */
- (void)onSelectMessageAvatar:(JMMessageCell *)cell;
@end


@interface JMMessageCell : UITableViewCell
@property (nonatomic, strong) UIImageView *head;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) UIImageView *error;

@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UIImageView *bubble;
@property (nonatomic, assign)BOOL isDominator;

- (CGFloat)getHeight:(JMMessageCellData *)data;
- (void)setData:(JMMessageCellData *)data;
- (void)setupViews;
/**
 *  信息数据类。
 *  存储了该massageCell中所需的信息。包括发送者 ID，发送者头像、信息发送状态、信息气泡图标等。
 *  messageData 详细信息请参考：Section\Chat\CellData\TUIMessageCellData.h
 */
@property (readonly) JMMessageCellData *messageData;


/**
 *  协议委托
 *  负责实现 TMessageCellDelegate 协议中的功能。
 */
@property (nonatomic, weak) id<JMMessageCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
