//
//  JMCDetailViewController.h
//  JMian
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMCDetailDefaultType,
    JMCDetailPreviewType,
} JMCDetailViewType;
@interface JMCDetailViewController : BaseViewController
@property(nonatomic,copy)NSString *task_id;
@property(nonatomic,assign)JMCDetailViewType viewType;
@end

NS_ASSUME_NONNULL_END
