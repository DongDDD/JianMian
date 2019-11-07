//
//  JMMPersonalCenterHeaderView.h
//  JMian
//
//  Created by mac on 2019/5/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMMPersonalCenterHeaderViewDelegate <NSObject>

-(void)didClickSetting;
-(void)didClickMyTask;
-(void)didClickMyOrder;



@end
@interface JMMPersonalCenterHeaderView : UIView
@property(nonatomic,weak)id<JMMPersonalCenterHeaderViewDelegate>delegate;
@property(nonatomic,strong)UIView *taskBadgeView;
@property(nonatomic,strong)UIView *orderBadgeView;
@end

NS_ASSUME_NONNULL_END
