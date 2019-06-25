//
//  JMBUserPositionDetailView.h
//  JMian
//
//  Created by mac on 2019/6/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JMBUserPositionDetailViewDelegate <NSObject>

-(void)didWriteTextFieldWithTag:(NSInteger)tag text:(NSString *)text;
-(void)didClickRightBtnWithTag:(NSInteger)tag;

@end
@interface JMBUserPositionDetailView : UIView
@property (weak, nonatomic) IBOutlet UITextField *positionNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *paymentMoneyTextField;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *deadLineBtn;
@property (weak, nonatomic) IBOutlet UITextField *quantityMaxTextField;
@property (weak, nonatomic) IBOutlet UIButton *industryBtn;
@property (weak, nonatomic) IBOutlet UIButton *goodsDescrptionBtn;
@property (weak, nonatomic) id<JMBUserPositionDetailViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
