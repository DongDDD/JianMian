//
//  JMJobTypeChooseView.h
//  JMian
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMJobTypeChooseViewDelegate <NSObject>

-(void)jobActionDelegate;
-(void)partTimeJobActionDelegate;

@end
@interface JMJobTypeChooseView : UIView
@property(nonatomic,weak)id<JMJobTypeChooseViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
