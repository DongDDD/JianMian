//
//  JMPostNewJobViewController.h
//  JMian
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JMHomeWorkModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JMPostNewJobViewType) {
    JMPostNewJobViewTypeDefault,
    JMPostNewJobViewTypeEdit,
};

@interface JMPostNewJobViewController : BaseViewController

@property(nonatomic, assign)JMPostNewJobViewType viewType;
@property(nonatomic,strong)JMHomeWorkModel *homeworkModel;

@end

NS_ASSUME_NONNULL_END
