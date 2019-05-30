//
//  JMAddMyJobTableViewController.h
//  JMian
//
//  Created by mac on 2019/5/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMVitaDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JMAddMyJobTableViewType) {
    JMAddMyJobTableViewTypeEdit,
    JMAddMyJobTableViewTypeAdd,
};
@interface JMAddMyJobTableViewController : UITableViewController

@property(nonatomic,strong)JMMyJobsModel *model;
@property(nonatomic,assign)JMAddMyJobTableViewType viewType;
@end

NS_ASSUME_NONNULL_END
