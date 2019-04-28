//
//  JMChooseTimeViewController.h
//  JMian
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol JMChooseTimeViewControllerDelegate <NSObject>

-(void)deleteInteviewTimeViewAction;
-(void)OKInteviewTimeViewAction:(NSString *)interviewTime;

@end
@interface JMChooseTimeViewController : UIViewController

@property(nonatomic,weak)id<JMChooseTimeViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
