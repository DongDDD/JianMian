//
//  JMMapViewController.h
//  JMian
//
//  Created by mac on 2019/5/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMMapViewController : BaseViewController

@property (nonatomic, assign)CLLocationCoordinate2D locationCoordinate;
@property (nonatomic, copy)NSString *adress;
@property (nonatomic, copy)NSString *companyName;
@end

NS_ASSUME_NONNULL_END
