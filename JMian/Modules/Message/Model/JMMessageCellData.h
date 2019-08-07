//
//  JMMessageCellData.h
//  JMian
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@import ImSDK;
typedef void (^TDownloadProgress)(NSInteger curSize, NSInteger totalSize);
typedef void (^TDownloadResponse)(int code, NSString *desc, NSString *path);


/**
 *  消息状态枚举
 */
typedef NS_ENUM(NSUInteger, TMsgStatus) {
    Msg_Status_Init, //消息创建
    Msg_Status_Sending, //消息发送中
    Msg_Status_Sending_2, //消息发送中_2，推荐使用
    Msg_Status_Succ, //消息发送成功
    Msg_Status_Fail, //消息发送失败
};
/**
 *  消息方向枚举
 *  消息方向影响气泡图标、气泡位置等 UI 风格。
 */
typedef NS_ENUM(NSUInteger, TMsgDirection) {
    MsgDirectionIncoming, //消息接收
    MsgDirectionOutgoing, //消息发送
};

/**
 * 【模块名称】TUIMessageCellData
 * 【功能说明】聊天消息单元数据源，配合消息控制器实现消息收发的业务逻辑。
 *  用于存储消息管理与逻辑实现所需要的各类数据与信息。包括消息状态、消息发送者 ID 与头像等一系列数据。
 *  同时信息数据单元整合并调用了 IM SDK，能够通过 SDK 提供的接口实现消息的业务逻辑。
 *  数据源帮助实现了 MVVM 架构，使数据与 UI 进一步解耦，同时使 UI 层更加细化、可定制化。
 */

@interface JMMessageCellData : TCommonCellData
@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL showName;
@property (nonatomic, assign) BOOL isSelf;
@property (nonatomic, assign) TMsgStatus status;
@property (nonatomic, strong) id custom;
@property (nonatomic, strong) TIMMessage *innerMessage;

@end

NS_ASSUME_NONNULL_END
