//
//  JMAddVitaJobViewController.h
//  JMian
//
//  Created by mac on 2019/6/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMVitaDetailModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMAddVitaJobViewType) {
    JMAddVitaJobViewTypeEdit,
    JMAddVitaJobViewTypeAdd,
};
@interface JMAddVitaJobViewController : BaseViewController
@property(nonatomic,strong)JMMyJobsModel *model;
@property(nonatomic,assign)JMAddVitaJobViewType viewType;
@end

NS_ASSUME_NONNULL_END
