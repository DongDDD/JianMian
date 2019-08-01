//
//  JMBUserCenterHeaderSubView.h
//  JMian
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JMBUserCenterHeaderSubViewDelegate <NSObject>

-(void)BTaskClick;
-(void)BVIPClick;
-(void)BOrderClick;

@end


@interface JMBUserCenterHeaderSubView : UIView
@property(nonatomic,weak)id<JMBUserCenterHeaderSubViewDelegate>delegate;
@property(nonatomic,strong)UIView *taskBadgeView;
@property(nonatomic,strong)UIView *orderBadgeView;
@property(nonatomic,strong)UIButton *leftBtn;


@end

NS_ASSUME_NONNULL_END
