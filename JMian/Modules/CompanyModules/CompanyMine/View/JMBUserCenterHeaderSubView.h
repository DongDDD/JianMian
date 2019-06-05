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
-(void)BOrderClick;
-(void)BVIPClick;
@end


@interface JMBUserCenterHeaderSubView : UIView
@property(nonatomic,weak)id<JMBUserCenterHeaderSubViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
