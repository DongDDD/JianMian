//
//  JMSquarePostTaskView.h
//  JMian
//
//  Created by mac on 2019/8/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMSquarePostTaskViewDelegate <NSObject>

-(void)didClickPostTaskAction;

@end
@interface JMSquarePostTaskView : UIView
@property (weak, nonatomic) IBOutlet UIButton *postBtn;
@property (weak, nonatomic) id<JMSquarePostTaskViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
