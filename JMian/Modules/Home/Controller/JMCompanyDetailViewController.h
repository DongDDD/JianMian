//
//  JMCompanyDetailViewController.h
//  JMian
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMCompanyDetailViewController : BaseViewController
@property(nonatomic,copy)NSString *company_id;
@property(nonatomic,copy)NSString *longitude;
@property(nonatomic,copy)NSString *latitude;
@property(nonatomic,copy)NSString *address;

@end

NS_ASSUME_NONNULL_END
