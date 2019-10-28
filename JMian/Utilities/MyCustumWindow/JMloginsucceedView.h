//
//  JMloginsucceedView.h
//  JMian
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMloginsucceedViewDelegate <NSObject>
-(void)gotoVideoViewAction;
-(void)deleteLoginsucceedViewAction;
@end

@interface JMloginsucceedView : UIView
@property(nonatomic,weak)id<JMloginsucceedViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
