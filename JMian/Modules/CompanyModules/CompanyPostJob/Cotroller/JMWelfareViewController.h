//
//  JMWelfareViewController.h
//  JMian
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JMWelfareDelegate <NSObject>

-(void)sendBtnLabData:(NSMutableArray *)btns;//传标签

@end


@interface JMWelfareViewController : BaseViewController

@property(weak,nonatomic)id<JMWelfareDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
