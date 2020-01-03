//
//  JMTransferMessageCellData.h
//  JMian
//
//  Created by mac on 2019/12/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TUIBubbleMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMTransferMessageCellData : TUIBubbleMessageCellData

//自定义消息
@property (nonatomic, strong)NSData *data;

@property (nonatomic, copy)NSString *desc;

@property (nonatomic, copy)NSString *ext;

@end

NS_ASSUME_NONNULL_END
