//
//  JMWaitForAnswerView.h
//  JMian
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMWaitForAnswerViewDelegate <NSObject>

-(void)waitforAnswerViewHangupAction;

@end

@interface JMWaitForAnswerView : UIView
@property(nonatomic,weak)id<JMWaitForAnswerViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
