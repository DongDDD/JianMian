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
//@protocol JobDetailsViewControllerDelegate <NSObject>
//
//-(void)sendIndex:(NSString *)
//
//@end
typedef NS_ENUM(NSInteger, JobDetailsViewType) {
    JobDetailsViewTypeDefault,
    JobDetailsViewTypeEdit,
};


@interface JobDetailsViewController : BaseViewController

@property (nonatomic, strong) NSString *work_id;
@property(nonatomic,strong)JMHomeWorkModel *homeworkModel;
@property (nonatomic, strong) NSString *status;
@property(nonatomic, assign)JobDetailsViewType viewType;
@end

NS_ASSUME_NONNULL_END
