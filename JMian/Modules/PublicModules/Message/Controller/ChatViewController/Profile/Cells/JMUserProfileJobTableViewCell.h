//
//  JMUserProfileJobTableViewCell.h
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCompanyInfoModel.h"
#import "JMTaskListCellData.h"
#import "JMVitaDetailModel.h"
#import "JMAbilityCellData.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMUserProfileJobTableViewCellIdentifier;

@interface JMUserProfileJobTableViewCell : UITableViewCell
@property(nonatomic,strong)JMWorkModel *jobData;
@property(nonatomic,strong)JMTaskListCellData *taskListData;//B
@property(nonatomic,strong)JMAbilityCellData *abilityCellData;//C


@property(nonatomic,strong)JMVitaDetailModel * vitaCModel; //C端用户全职简历

@end

NS_ASSUME_NONNULL_END
