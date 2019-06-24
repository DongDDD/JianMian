//
//  JMMakeOutBillView.h
//  JMian
//
//  Created by mac on 2019/6/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMMakeOutBillViewDelegate <NSObject>

-(void)invoiceTextFieldDidEditingEndWithTextField:(UITextField *)textField;
-(void)invoiceTextRerurnActionWithTextField:(UITextField *)textField;

@end

@interface JMMakeOutBillView : UIView
@property (weak, nonatomic) IBOutlet UITextField *invoiceTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *invoiceTaxNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *invoiceEmailTextField;

@property (nonatomic, weak)id<JMMakeOutBillViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
