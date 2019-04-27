//
//  JobDetailsViewController.h
//  JMian
//
//  Created by mac on 2019/3/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JMHomeWorkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobDetailsViewController : BaseViewController

@property(nonatomic,strong)JMHomeWorkModel *homeworkModel;
@property (nonatomic, strong) NSString *status;

@end

NS_ASSUME_NONNULL_END
