//
//  JMTaskApplyForView.h
//  JMian
//
//  Created by mac on 2019/7/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMTaskApplyForViewDelegate <NSObject>
    
-(void)isReadProtocol:(BOOL)isRead;
-(void)applyForViewDeleteAction;
-(void)applyForViewComfirmAction;

@end

@interface JMTaskApplyForView : UIView
    
@property (weak, nonatomic) id<JMTaskApplyForViewDelegate>delegate;
    @property (weak, nonatomic) IBOutlet UIButton *isReadBtn;
    
@end

NS_ASSUME_NONNULL_END

