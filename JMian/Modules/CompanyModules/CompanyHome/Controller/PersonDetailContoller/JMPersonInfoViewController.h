//
//  JMPersonInfoViewController.h
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMPersonInfoViewType) {
    JMPersonInfoViewTypeDefault,
    JMPersonInfoViewTypeVideo,
};

@interface JMPersonInfoViewController : BaseViewController
@property(nonatomic,strong)NSString *user_job_id;
@property(nonatomic,assign)JMPersonInfoViewType viewType;
@end

NS_ASSUME_NONNULL_END
