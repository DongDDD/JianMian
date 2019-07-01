//
//  JMVIPViewController.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVIPViewController.h"
#import "JMShareView.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "JMHTTPManager+OrderPay.h"
#import "JMOrderPaymentModel.h"
#import "JMShareView.h"

@interface JMVIPViewController ()<JMShareViewDelegate>
@property (strong, nonatomic) JMShareView *choosePayView;
@property (nonatomic ,strong) UIView *BGPayView;
@property (strong, nonatomic) JMOrderPaymentModel *orderPaymentModel;

@end

@implementation JMVIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"得米会员";
    [self initView];
    // Do any additional setup after loading the view from its nib.
}
-(void)initView{
    [self.view addSubview:self.choosePayView];
    [self.view addSubview:self.BGPayView];
    [self.BGPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_choosePayView.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenChoosePayView)];
    [self.BGPayView addGestureRecognizer:tap];

}

- (IBAction)payAction:(UIButton *)sender {
 
    [self getPayInfoData];
}

-(void)showChoosePayView{
    
    
    [self.choosePayView setHidden:NO];
    [self.BGPayView setHidden:NO];
    
    [UIView animateWithDuration:0.18 animations:^{
        self.choosePayView.frame =CGRectMake(0, self.view.frame.size.height-205, SCREEN_WIDTH, 205+SafeAreaBottomHeight);
        
        
    }];
    
}

-(void)hiddenChoosePayView{
    [self.choosePayView setHidden:YES];
    [self.BGPayView setHidden:YES];
    [UIView animateWithDuration:0.18 animations:^{
        self.choosePayView.frame =CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 205+SafeAreaBottomHeight);
        
        
    }];
    
}
#pragma mark - MyDelegate

-(void)shareViewCancelAction{
    [self hiddenChoosePayView];
    
}


-(void)shareViewLeftAction{
    [self wechatPayWithModel:self.orderPaymentModel];
}

-(void)rightAction{
    [self alipayWithModel:self.orderPaymentModel];

    
}


#pragma mark - 微信支付
- (void)getPayInfoData
{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    [self showProgressHUD_view:self.view];
    [[JMHTTPManager sharedInstance]fectchOrderPaymentInfoWithOrder_id:userModel.user_id  scenes:@"app" type:@"3" mode:@"3" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            
            self.orderPaymentModel = [JMOrderPaymentModel mj_objectWithKeyValues:responsObject[@"data"]];
            
            [self hiddenHUD];
            [self showChoosePayView];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}




- (void)wechatPayWithModel:(JMOrderPaymentModel *)model{
    PayReq* req = [[PayReq alloc] init];
    req.partnerId = model.wx_partnerid;
    req.prepayId = model.wx_prepayid;
    req.nonceStr = model.wx_noncestr;
    req.timeStamp = model.wx_timestamp;
    req.package = model.wx_package;
    req.sign = model.wx_sign;
    [WXApi sendReq:req];
    
    
}


//支付宝支付
-(void)alipayWithModel:(JMOrderPaymentModel *)model{
    // 发起支付
    [[AlipaySDK defaultService] payOrder:model.alipay fromScheme:@"alisdkdemo" callback:^(NSDictionary *resultDic) {
        NSLog(@"支付结果 reslut = %@",resultDic);
    }];
    
}

-(JMShareView *)choosePayView{
    if (!_choosePayView) {
        _choosePayView = [[JMShareView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 205+SafeAreaBottomHeight)];
        _choosePayView.delegate = self;
        [_choosePayView.btn1 setImage:[UIImage imageNamed:@"WeChat"] forState:UIControlStateNormal];
        [_choosePayView.btn2 setImage:[UIImage imageNamed:@"Alipay_pay"] forState:UIControlStateNormal];
        _choosePayView.lab1.text = @"微信支付";
        _choosePayView.lab2.text = @"支付宝";
    }
    return _choosePayView;
}

-(UIView *)BGPayView{
    if (!_BGPayView) {
        _BGPayView = [[UIView alloc]init];
        _BGPayView.backgroundColor = [UIColor blackColor];
        _BGPayView.alpha = 0.5;
        _BGPayView.hidden = YES;
    }
    return  _BGPayView;

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
