//
//  JMPayDetailViewController.h
//  JMian
//
//  Created by mac on 2019/6/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMTaskOrderListCellData.h"
NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMPayDetailViewTypeFinalPayment,
    JMPayDetailViewTypeDownPayment,
} JMPayDetailViewType;

@protocol JMPayDetailViewControllerDelegate <NSObject>

-(void)payDetailViewDownPayAction_data:(JMTaskOrderListCellData *)data;
-(void)payDetailViewAllPayAction_data:(JMTaskOrderListCellData *)data;

@end

@interface JMPayDetailViewController : BaseViewController

@property(nonatomic, strong)JMTaskOrderListCellData *data;
@property(nonatomic, assign)JMPayDetailViewType viewType;
@property(nonatomic, weak)id<JMPayDetailViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
