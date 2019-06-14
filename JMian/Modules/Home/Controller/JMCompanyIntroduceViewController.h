//
//  JMCompanyIntroduceViewController.h
//  JMian
//
//  Created by mac on 2019/4/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMHomeWorkModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    JMCompanyIntroduceViewControllerDefault,
    JMCompanyIntroduceViewControllerCDetail,
} JMCompanyIntroduceViewType;


@interface JMCompanyIntroduceViewController : BaseViewController
@property(nonatomic,strong)JMHomeWorkModel *model;
@property(nonatomic,copy)NSString *videoUrl;
@property(nonatomic,assign)JMCompanyIntroduceViewType viewType;
@property(nonatomic,copy)NSString *company_id;
@end

NS_ASSUME_NONNULL_END
