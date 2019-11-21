//
//  JMPushMessageCell.h
//  JMian
//
//  Created by mac on 2019/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TUITextMessageCell.h"
#import "JMPushMessageCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMPushMessageCell : TUITextMessageCell

@property(nonatomic,strong)JMPushMessageCellData *pushData;
- (void)fillWithData:(JMPushMessageCellData *)data;

@end

NS_ASSUME_NONNULL_END
