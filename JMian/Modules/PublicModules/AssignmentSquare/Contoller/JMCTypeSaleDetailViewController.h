//
//  JMCTypeSaleDetailViewController.h
//  JMian
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMCDetailModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    CTypeSaleViewDefaultType,
    CTypeSaleViewPreviewType,
    CTypeSaleViewSnapshootType,

}  CTypeSaleViewType;

@interface JMCTypeSaleDetailViewController : BaseViewController
@property(nonatomic,copy)NSString *task_id;
@property(nonatomic,copy)NSString *task_order_id;
@property(nonatomic,assign)CTypeSaleViewType viewType;
@property (strong, nonatomic) JMCDetailModel *model;

@end

NS_ASSUME_NONNULL_END
