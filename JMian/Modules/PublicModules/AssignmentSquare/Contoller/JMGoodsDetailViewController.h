//
//  JMGoodsDetailViewController.h
//  JMian
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMGoodsDetailDefaultType,
    JMGoodsDetailSnapshootType,

}  JMGoodsDetailType;

@interface JMGoodsDetailViewController : BaseViewController
@property(nonatomic,copy)NSString *goods_id;
@property(nonatomic,copy)NSString *task_id;
@property(nonatomic,copy)NSString *task_order_id;

@property(nonatomic,copy)NSString *effective_count;
@property(nonatomic,assign)BOOL isShare;

@property(nonatomic,assign)JMGoodsDetailType viewType;

@end

NS_ASSUME_NONNULL_END
