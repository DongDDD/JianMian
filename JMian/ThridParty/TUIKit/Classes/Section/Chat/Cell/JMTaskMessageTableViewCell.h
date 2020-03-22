//
//  JMTaskMessageTableViewCell.h
//  JMian
//
//  Created by mac on 2020/3/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "TUITextMessageCell.h"
#import "JMTaskMessageCellData.h"
NS_ASSUME_NONNULL_BEGIN

@interface JMTaskMessageTableViewCell : TUITextMessageCell
@property(nonatomic,strong)JMTaskMessageCellData *taskData;
- (void)fillWithData:(JMTaskMessageCellData *)data;

@end

NS_ASSUME_NONNULL_END
