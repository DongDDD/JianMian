//
//  JMLabChooseView.h
//  JMian
//
//  Created by mac on 2019/7/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMLabChooseBottomViewDelegate <NSObject>

-(void)labChooseBottomLeftAction;
-(void)labChooseBottomRightAction;

@end

@interface JMLabChooseBottomView : UIView

@property(nonatomic,weak)id<JMLabChooseBottomViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
