//
//  JMTrasferViewController.h
//  JMian
//
//  Created by mac on 2019/12/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN
@protocol JMTransferViewControllerDelegate <NSObject>

-(void)sendTransferMessage:(NSString *)money remark:(NSString *)remark;

@end

@interface JMTransferViewController : BaseViewController
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,weak)id<JMTransferViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
