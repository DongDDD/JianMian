//
//  TwoButtonView.h
//  JMian
//
//  Created by mac on 2019/3/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TwoButtonViewDelegate <NSObject>

@optional
-(void)sendResumeButton;

@end


@interface TwoButtonView : UIView

@property(nonatomic,weak) id<TwoButtonViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
