//
//  JMPostPartTimeResumeViewController.h
//  JMian
//
//  Created by mac on 2019/5/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMAbilityCellData.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JMPostPartTimeResumeViewType) {
    JMPostPartTimeResumeVieweEdit,
    JMPostPartTimeResumeViewAdd,
    JMPostPartTimeResumeViewLogin,
};

@interface JMPostPartTimeResumeViewController : BaseViewController

//@property(nonatomic, strong)JMPartTimeJobModel *partTimeVitaModel;
@property(nonatomic,copy)NSString *ability_id;
@property(nonatomic,assign)JMPostPartTimeResumeViewType viewType;
@property(nonatomic,assign)BOOL isHideBackBtn;
@end

NS_ASSUME_NONNULL_END
