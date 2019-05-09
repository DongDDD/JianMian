//
//  JMGetCompanyLocationViewController.h
//  JMian
//
//  Created by mac on 2019/4/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JMGetCompanyLocationViewControllerDelegate <NSObject>

-(void)sendAdress_Data:(AMapPOI *)data ;

@end

@interface JMGetCompanyLocationViewController : BaseViewController

@property(nonatomic,weak)id<JMGetCompanyLocationViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
