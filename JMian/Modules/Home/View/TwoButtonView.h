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
-(void)btnAction;
-(void)btn2Action;
@end


@interface TwoButtonView : UIView

@property(nonatomic,weak) id<TwoButtonViewDelegate> delegate;

@property (nonatomic, strong) NSString *status;

@end

NS_ASSUME_NONNULL_END
