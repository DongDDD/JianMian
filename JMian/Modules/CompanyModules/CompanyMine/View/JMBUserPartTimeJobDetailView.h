//
//  JMBUserPartTimeJobDetailView.h
//  JMian
//
//  Created by mac on 2019/6/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMBUserPartTimeJobDetailViewDelegate <NSObject>

-(void)didClickRightBtnWithTag:(NSInteger)tag;
-(void)didWriteRightTextFieldWithtag:(NSInteger)tag text:(NSString *)text;

@end
@interface JMBUserPartTimeJobDetailView : UIView
@property (weak, nonatomic) IBOutlet UIButton *jobTypeBtn;
@property (weak, nonatomic) IBOutlet UITextField *jobNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *paymentMoneyTextField;
@property (weak, nonatomic) IBOutlet UITextField *downPaymentTextField;
@property (weak, nonatomic) IBOutlet UIButton *quantityMaxBtn;
@property (weak, nonatomic) IBOutlet UITextField *quantityMaxTextField;

@property (weak, nonatomic) IBOutlet UIButton *industryBtn;
@property (weak, nonatomic) IBOutlet UIButton *deadLineBtn;

@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (nonatomic, weak)id<JMBUserPartTimeJobDetailViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
