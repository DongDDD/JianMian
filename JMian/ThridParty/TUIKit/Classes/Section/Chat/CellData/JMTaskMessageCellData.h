//
//  JMTaskMessageCellData.h
//  JMian
//
//  Created by mac on 2020/3/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "TUITextMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN
/**
* 【模块名称】JMTaskMessageCellData
* 【功能说明】文本消息自定义单元数据源。（得米任务申请）
*  继承文本消息单元，即在多数信息收发情况下最常见的消息单元。
*  继承文本消息单元数据源则是为文本消息单元提供一系列所需的数据与信息。
*  数据源帮助实现了 MVVM 架构，使数据与 UI 进一步解耦，同时使 UI 层更加细化、可定制化。
*/
@interface JMTaskMessageCellData : TUITextMessageCellData
//自定义消息
@property (nonatomic, strong)NSData *data;

@property (nonatomic, copy)NSString *desc;

@property (nonatomic, copy)NSString *ext;

@end

NS_ASSUME_NONNULL_END
