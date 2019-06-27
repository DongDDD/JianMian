//
//  JMMyTopViewNavView.h
//  JMian
//
//  Created by mac on 2019/6/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMMyTopViewNavViewDelegate <NSObject>

-(void)backAction;

@end
@interface JMMyTopViewNavView : UIView
@property(nonatomic, weak)id<JMMyTopViewNavViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
