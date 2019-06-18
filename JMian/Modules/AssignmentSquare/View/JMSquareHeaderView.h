//
//  JMSquareHeaderView.h
//  JMian
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMSquareHeaderViewDelegate <NSObject>

-(void)didClickIncomeAction;

@end
@interface JMSquareHeaderView : UIView
@property(nonatomic,weak)id<JMSquareHeaderViewDelegate>delegate;
@property(nonatomic,strong)JMUserInfoModel *userModel;
@end

NS_ASSUME_NONNULL_END
