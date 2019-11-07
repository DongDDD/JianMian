//
//  JMNoResumeDataView.h
//  JMian
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMNoResumeDataViewDelegate <NSObject>

-(void)didClickCreateResumeAction;

@end
@interface JMNoResumeDataView : UIView
@property(nonatomic,weak)id<JMNoResumeDataViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
