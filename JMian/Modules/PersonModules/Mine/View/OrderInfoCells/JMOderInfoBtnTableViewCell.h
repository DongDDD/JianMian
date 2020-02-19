//
//  JMOderInfoBtnTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, JMOderInfoBtnTableViewCelllType){
//    JMOderInfoBtnTypeTradeSuccessfully = 0 ,
//    JMOderInfoBtnTypeDidRefund,
//    JMOderInfoBtnTypeWaitSalesReturn,
//    JMOderInfoBtnTypeWaitDeliverGoods,
//    JMOderInfoBtnTypeNoPay,
//    JMOderInfoBtnTypeDidDeliverGoods,
//};
@protocol JMOderInfoBtnTableViewCellDelegate <NSObject>

-(void)didClickBtnWithBtnTtitle:(NSString *_Nonnull)btnTtitle;

@end
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMOderInfoBtnTableViewCellIdentifier;

@interface JMOderInfoBtnTableViewCell : UITableViewCell
//@property(nonatomic,assign)JMOderInfoBtnTableViewCelllType viewType;
@property(nonatomic,weak)id<JMOderInfoBtnTableViewCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *btn;//确认申请
@property (weak, nonatomic) IBOutlet UIButton *btn0;//再次申请
@property (weak, nonatomic) IBOutlet UIButton *btn1;//拒绝申请
@property (weak, nonatomic) IBOutlet UIButton *btn2;//联系买家
@property (weak, nonatomic) IBOutlet UIButton *btn3;//客服介入
@property (weak, nonatomic) IBOutlet UIButton *btn4;//申请退款
@property (weak, nonatomic) IBOutlet UIButton *btn5;//确认退款
@property (weak, nonatomic) IBOutlet UIButton *btn6;//去发货
@property (weak, nonatomic) IBOutlet UIButton *btn7;//确认收货
@property (weak, nonatomic) IBOutlet UIButton *btn8;//售后中
@property (weak, nonatomic) IBOutlet UIButton *btn9;//申请售后
@property (weak, nonatomic) IBOutlet UIButton *btn10;//撤销申请
@property (weak, nonatomic) IBOutlet UIButton *btn11;//联系卖家
@property (weak, nonatomic) IBOutlet UIButton *btn12;//同意申请
@property (weak, nonatomic) IBOutlet UIButton *btn13;//取消订单

@end

NS_ASSUME_NONNULL_END
