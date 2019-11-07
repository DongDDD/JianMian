//
//  JMShareView.h
//  JMian
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMShareViewDelegate <NSObject>

-(void)shareViewCancelAction;
-(void)shareViewLeftAction;
-(void)shareViewRightAction;

@end
@interface JMShareView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (nonatomic, weak) id<JMShareViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
