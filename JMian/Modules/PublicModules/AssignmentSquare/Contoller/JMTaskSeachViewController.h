//
//  JMTaskSeachViewController.h
//  JMian
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, JMTaskSeachViewType) {
    JMTaskSeachViewTypePartimeJob,
    JMTaskSeachViewTypeJob,
};

NS_ASSUME_NONNULL_BEGIN
@protocol JMTaskSeachViewControllerDelegate <NSObject>

-(void)didInputKeywordWithStr:(NSString *)str;

@end
@interface JMTaskSeachViewController : BaseViewController
@property (nonatomic,weak)id<JMTaskSeachViewControllerDelegate>delegate;
@property (nonatomic,assign)JMTaskSeachViewType viewType;

@end

NS_ASSUME_NONNULL_END
