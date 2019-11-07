//
//  JMMessageTableViewController.h
//  JMian
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMAllMessageTableViewCell.h"
#import "JMMessageListModel.h"
#import "BaseViewController.h"
#import "JMMessageCell.h"

NS_ASSUME_NONNULL_BEGIN
@class TIMConversation;
@protocol TUIConversationDataProviderServiceProtocol <NSObject>

/**
 *  获取消息数据。
 *  该协议可以帮助您实现：
 *  1、当前网络状态为连接失败/未连接时，调用 IM SDK 中 TIMConversation 类的 getLocalMessage 接口从本地拉取消息。
 *  2、当当前网络状态正常时，调用 IM SDK 中 TIMConversation 类的 getMessage 接口在线拉取消息。
 *
 *  @param conv 会话示例，负责提供消息的拉取功能。
 *  @param count 想要拉取的消息数目。
 *  @param last 上次最后一条消息
 *  @param succ 成功回调。
 *  @param fail 失败回调。
 *
 *  @return 0:本次操作成功；1:本次操作失败。
 */
- (int)getMessage:(TIMConversation *)conv count:(int)count last:(TIMMessage*)last succ:(TIMGetMsgSucc)succ fail:(TIMFail)fail;

@end


@class JMMessageTableViewController;
@protocol JMMessageTableViewControllerDelegate <NSObject>
- (void)didTapInMessageController:(JMMessageTableViewController *)controller;
- (void)isDominatorController:(JMMessageTableViewController *)controller;
- (void)videoInterviewController:(JMMessageTableViewController *)controller;
//- (void)didHideMenuInMessageController:(JMMessageTableViewController *)controller;
//- (BOOL)messageController:(JMMessageTableViewController *)controller willShowMenuInView:(UIView *)view;
//- (void)messageController:(JMMessageTableViewController *)controller didSelectMessages:(NSMutableArray *)msgs atIndex:(NSInteger)index;
@end
@interface JMMessageTableViewController : UITableViewController

- (void)setMyConvModel:(JMMessageListModel *)myConvModel;

@property (nonatomic, weak) id<JMMessageTableViewControllerDelegate> delegate;
@property (nonatomic, assign)BOOL isSelfIsSender;

-(void)sendMessage:(JMMessageCellData *)data;
- (void)sendMessage2:(JMMessageCellData *)msg;
- (void)scrollToBottom:(BOOL)animate;
/**
 *  发送图像信息
 *  本函数整合调用了 IM SDK 的发送接口，可以轻松接入 SDK。
 *  1、首先将图片压缩并生成相关路径。
 *  2、将压缩后的图片保存在本地的刚刚生成的路径中。
 *  3、创建 JMImageMessageCellData 实例，并将 path 和压缩后图片的体积存放于 JMImageMessageCellData 中。
 *  4、调用已封装好的 sendMessage 函数将 cellData 进行发送。
 *  5、上传进度由在 NSNotificationCenter 创建的上传进度监听事件进行监听与更新。
 *
 *  @param image 需要发送的图像
 */
- (void)sendImageMessage:(UIImage *)image;

/**
 *  设置会话
 *
 *  @param conversation 需要设置的会话
 */
- (void)setConversation:(TIMConversation *)conversation;

@end

NS_ASSUME_NONNULL_END
