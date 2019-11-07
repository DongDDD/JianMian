//
//  JMAnswerOrHangUpView.h
//  JMian
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"
NS_ASSUME_NONNULL_BEGIN
@protocol JMAnswerOrHangUpViewDelegate <NSObject>

-(void)answerAction;
-(void)didClickClose;
@end

@interface JMAnswerOrHangUpView : UIView

@property(nonatomic,weak)id<JMAnswerOrHangUpViewDelegate>delegate;
@property (nonatomic, strong) AVAudioPlayer *player;

@end

NS_ASSUME_NONNULL_END
