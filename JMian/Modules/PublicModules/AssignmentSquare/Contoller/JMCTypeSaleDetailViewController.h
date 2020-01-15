//
//  JMCTypeSaleDetailViewController.h
//  JMian
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    CTypeSaleViewDefaultType,
    CTypeSaleViewPreviewType,
}  CTypeSaleViewType;

@interface JMCTypeSaleDetailViewController : BaseViewController
@property(nonatomic,copy)NSString *task_id;
@property(nonatomic,assign)CTypeSaleViewType viewType;
@end

NS_ASSUME_NONNULL_END
