//
//  JMApplyForProtocolView.h
//  JMian
//
//  Created by mac on 2019/6/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMApplyForProtocolViewDelegate <NSObject>

-(void)isReadProtocol:(BOOL)isRead;

@end
@interface JMApplyForProtocolView : UIView
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) id<JMApplyForProtocolViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
