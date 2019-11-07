//
//  JMPostTaskBottomView.h
//  JMian
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMPostTaskBottomViewDelegate <NSObject>

-(void)didClickPostAction;

@end
@interface JMPostTaskBottomView : UIView
@property (weak, nonatomic) IBOutlet UIButton *postTaskBtn;
@property (weak, nonatomic) id<JMPostTaskBottomViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
