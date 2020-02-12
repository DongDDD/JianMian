//
//  JMCDetailViewController.h
//  JMian
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMCDetailModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMCDetailDefaultType,
    JMCDetailPreviewType,
    JMCDetailSnapshootViewType,

} JMCDetailViewType;
@interface JMCDetailViewController : BaseViewController
@property(nonatomic,copy)NSString *task_id;
@property(nonatomic,assign)JMCDetailViewType viewType;
@property(nonatomic,strong)JMCDetailModel *model;
@end

NS_ASSUME_NONNULL_END
