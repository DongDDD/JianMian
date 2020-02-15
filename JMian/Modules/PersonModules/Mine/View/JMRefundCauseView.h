//
//  JMRefundCauseView.h
//  JMian
//
//  Created by mac on 2020/2/4.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMRefundCauseViewDelegate <NSObject>

-(void)submitActionWithMsg:(NSString *)msg;

@end
@interface JMRefundCauseView : UIView

@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,weak)id<JMRefundCauseViewDelegate>delegate;
-(void)show;
-(void)hide;
@end

NS_ASSUME_NONNULL_END
