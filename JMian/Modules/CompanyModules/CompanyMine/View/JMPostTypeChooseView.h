//
//  JMPostTypeChooseView.h
//  JMian
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMPostTypeChooseViewDelegate <NSObject>

-(void)didSelectedPostTypeWithTag:(NSInteger)tag;

@end
@interface JMPostTypeChooseView : UIView
@property(nonatomic, weak)id<JMPostTypeChooseViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
