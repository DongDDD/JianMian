//
//  JMBottomView.h
//  JMian
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BottomViewDelegate <NSObject>

@optional
-(void)bottomRightButtonAction;

@end

@interface JMBottomView : UIView

@property(nonatomic,weak) id<BottomViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
