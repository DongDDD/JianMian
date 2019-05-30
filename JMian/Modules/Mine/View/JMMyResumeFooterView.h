//
//  JMMyResumeFooterView.h
//  JMian
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMMyResumeFooterViewDelegate <NSObject>

-(void)addJobAction;

@end
@interface JMMyResumeFooterView : UIView
@property(nonatomic,assign)id<JMMyResumeFooterViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
