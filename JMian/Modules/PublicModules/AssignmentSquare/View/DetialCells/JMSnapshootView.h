//
//  JMSnapshootView.h
//  JMian
//
//  Created by mac on 2020/2/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMSnapshootViewDelegate <NSObject>

-(void)didClickNewDataBtn;

@end
@interface JMSnapshootView : UIView
@property(nonatomic,weak)id<JMSnapshootViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
