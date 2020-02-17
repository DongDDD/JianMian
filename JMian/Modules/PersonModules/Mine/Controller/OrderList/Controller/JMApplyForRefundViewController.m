//
//  JMApplyForRefundViewController.m
//  JMian
//
//  Created by mac on 2020/2/4.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMApplyForRefundViewController.h"
#import "JMRefundGoodsStatusView.h"
#import "JMRefundCauseView.h"
#import "JMHTTPManager+ChangeOrderStatus.h"
#import "JMGoodsListView.h"

@interface JMApplyForRefundViewController ()<JMRefundCauseViewDelegate>
//@property(nonatomic,strong)JMRefundGoodsStatusView *refundGoodsStatusView;
@property(nonatomic,strong)JMRefundCauseView *refundCauseView;
@property(nonatomic,strong)JMGoodsListView *goodsListView;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewConstrainTop;
@property (weak, nonatomic) IBOutlet UIButton *caseBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadImagBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UIView *uploadImageVIew;
@property(nonatomic,strong)UIView *BGView;
@end

@implementation JMApplyForRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BG_COLOR;
//    _BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    _BGView.backgroundColor = [UIColor blackColor];
//    _BGView.alpha = 0.5;
//    [_BGView setHidden:YES];
//    [[UIApplication sharedApplication].keyWindow addSubview:_BGView];
    self.goodsListView.goods = self.model.goods;
    [self.view addSubview:self.goodsListView];
 
    self.stackViewConstrainTop.constant = self.model.goods.count * 60;
    
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@",self.model.pay_amount];
    [[UIApplication sharedApplication].keyWindow addSubview:self.refundCauseView];
    [self.refundCauseView hide];
    if (_viewType == JMApplyForRefundViewTypeRefund) {
        [self.uploadImageVIew setHidden:YES];
    }
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)goodsStatusBtnAction:(UIButton *)sender {

}

- (IBAction)caseAction:(UIButton *)sender {
    [self.refundCauseView show];
}
- (IBAction)submitAction:(UIButton *)sender {
    [self changOrderStatus:@"7" order_id:self.model.order_id];

}

-(void)submitActionWithMsg:(NSString *)msg{
    [self.caseBtn setTitle:msg forState:UIControlStateNormal];
}


-(void)changOrderStatus:(NSString *)status order_id:(NSString *)order_id{
    [[JMHTTPManager sharedInstance]changeOrderStatusWithOrder_id:order_id status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self showAlertVCSucceesSingleWithMessage:@"提交成功" btnTitle:@"好的"];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

-(void)alertSucceesAction{
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - lazy

//-(JMRefundGoodsStatusView *)refundGoodsStatusView{
//    if (!_refundGoodsStatusView) {
//        _refundGoodsStatusView = [[JMRefundGoodsStatusView alloc]init];
//        _refundGoodsStatusView.frame = CGRectMake(0, self.view.frame.size.height+400, SCREEN_WIDTH, 325);
//        _refundGoodsStatusView.layer.cornerRadius = 10;
//
//    }
//    return _refundGoodsStatusView;
//}

-(JMRefundCauseView *)refundCauseView{
    if (!_refundCauseView) {
        _refundCauseView = [[JMRefundCauseView alloc]init];
        _refundCauseView.delegate = self;
        _refundCauseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }
    return _refundCauseView;
}

-(JMGoodsListView *)goodsListView{
    if (!_goodsListView) {
        _goodsListView = [[JMGoodsListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.model.goods.count * 60)];
    }
    return _goodsListView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
