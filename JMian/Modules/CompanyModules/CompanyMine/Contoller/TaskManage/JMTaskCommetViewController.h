//
//  JMTaskCommetViewController.h
//  JMian
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMTaskOrderListCellData.h"
NS_ASSUME_NONNULL_BEGIN
@protocol JMTaskCommetViewControllerDelegate <NSObject>

-(void)didComment;

@end

@interface JMTaskCommetViewController : BaseViewController

@property(nonatomic, strong)JMTaskOrderListCellData *data;
@property(nonatomic, weak)id<JMTaskCommetViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
