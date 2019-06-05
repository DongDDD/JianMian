//
//  JMBUserCenterHeaderView.h
//  JMian
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMBUserCenterHeaderViewDelegate <NSObject>

-(void)didClickSetting;

@end

@interface JMBUserCenterHeaderView : UIView

@property(nonatomic,weak)id<JMBUserCenterHeaderViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
