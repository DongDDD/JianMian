//
//  JMAnswerOrHangUpView.h
//  JMian
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMAnswerOrHangUpViewDelegate <NSObject>

-(void)answerAction;
-(void)hangupAction;
@end

@interface JMAnswerOrHangUpView : UIView
@property(nonatomic,weak)id<JMAnswerOrHangUpViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
