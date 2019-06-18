//
//  JMWalletHeaderView.h
//  JMian
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMWalletHeaderView : UIView

@property(nonatomic,strong)UILabel *money;
@property(nonatomic,strong)UILabel *money2;
@property(nonatomic,strong)JMUserInfoModel *userModel;

@end

NS_ASSUME_NONNULL_END
