//
//  JMCityListViewController.h
//  JMian
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMCityListViewControllerDelegate <NSObject>

-(void)didSelectedCity_id:(NSString *)city_id city_name:(NSString *)city_name;

@end


@interface JMCityListViewController : BaseViewController
@property(nonatomic,weak)id<JMCityListViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
