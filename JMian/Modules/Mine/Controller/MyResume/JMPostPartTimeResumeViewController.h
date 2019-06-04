//
//  JMPostPartTimeResumeViewController.h
//  JMian
//
//  Created by mac on 2019/5/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMPartTimeJobModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JMPostPartTimeResumeViewType) {
    JMPostPartTimeResumeVieweEdit,
    JMPostPartTimeResumeViewAdd,
};

@interface JMPostPartTimeResumeViewController : BaseViewController

//@property(nonatomic, strong)JMPartTimeJobModel *partTimeVitaModel;
@property(nonatomic,copy)NSString *ability_id;
@property(nonatomic,assign)JMPostPartTimeResumeViewType viewType;
@end

NS_ASSUME_NONNULL_END
