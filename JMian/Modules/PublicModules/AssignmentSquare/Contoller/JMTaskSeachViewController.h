//
//  JMTaskSeachViewController.h
//  JMian
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JMTaskSeachViewControllerDelegate <NSObject>

-(void)didInputKeywordWithStr:(NSString *)str;

@end
@interface JMTaskSeachViewController : BaseViewController
@property (nonatomic,weak)id<JMTaskSeachViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
