//
//  JMPayDetailViewController.m
//  JMian
//
//  Created by mac on 2019/6/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPayDetailViewController.h"
#import "JMHTTPManager+FectchInvoiceInfo.h"
#import "JMInvoiceModel.h"

@interface JMPayDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *headerLabs;
@property (weak, nonatomic) IBOutlet UILabel *detailViewMoney;
@property (weak, nonatomic) IBOutlet UILabel *detailViewSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailViewLab1;
@property (weak, nonatomic) IBOutlet UILabel *detailViewLab2;
@property (weak, nonatomic) IBOutlet UILabel *moneyDetailViewLab1;
@property (weak, nonatomic) IBOutlet UILabel *moneyDetailViewLab2;
@property (weak, nonatomic) IBOutlet UILabel *bottomViewLab1;
@property (weak, nonatomic) IBOutlet UILabel *bottomViewLab2;
@property (weak, nonatomic) IBOutlet UIView *invoiceView;
@property (weak, nonatomic) IBOutlet UILabel *invoiceLab;
@property (nonatomic, strong)JMInvoiceModel *invoiceModel;

@property (copy , nonatomic)NSString *didPayMoney;

@end

@implementation JMPayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_data.user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.nameLab.text = _data.user_nickname;
    self.headerLabs.text = [NSString stringWithFormat:@" %@   ",_data.snapshot_cityName];
    self.detailViewMoney.text = _data.payment_money;
    self.detailViewSubTitle.text = _data.task_title;
    if (_viewType == JMPayDetailViewTypeDownPayment) {//定金
        [self.invoiceView setHidden:YES];
        self.title = @"DEMI001定金";
        self.detailViewLab1.text = @" 完工结  ";
        self.detailViewLab2.text = [NSString stringWithFormat:@" 招募人数：%@  ",_data.snapshot_quantity_max];
        self.moneyDetailViewLab1.text = @"应付定金";
        self.moneyDetailViewLab2.text = [NSString stringWithFormat:@"%@ 元",_data.front_money];
        self.bottomViewLab1.text = @"定金";
        self.bottomViewLab2.text = [NSString stringWithFormat:@"¥%@",_data.front_money];
        self.didPayMoney = _data.front_money;
    }else if (_viewType == JMPayDetailViewTypeFinalPayment) {//尾款
        self.title = @"DEMI001尾款";
        [self getInvoiceData];
      
    }
   
}

- (IBAction)payAction:(UIButton *)sender {
    if(_viewType == JMPayDetailViewTypeDownPayment){
       
        if (_delegate && [_delegate respondsToSelector:@selector(payDetailViewDownPayAction_data:)]) {
            [_delegate payDetailViewDownPayAction_data:_data];
 
        }
    }else if (_viewType == JMPayDetailViewTypeFinalPayment){
        if (_delegate && [_delegate respondsToSelector:@selector(payDetailViewAllPayAction_data:)]) {
            [_delegate payDetailViewAllPayAction_data:_data];
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didPayMoneyWithStr:)]) {
        [_delegate didPayMoneyWithStr:self.didPayMoney];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----两个数相减------------ number1 - number2
-(NSString *)calculateBySubtractingMinuend:(NSString *)number1 subtractorNumber:(NSString *)number2
{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:number1];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:number2];
    NSDecimalNumber *addingNum = [num1 decimalNumberBySubtracting:num2];
    return [addingNum stringValue];
    
}


-(void)getInvoiceData{
    [[JMHTTPManager sharedInstance]fectchInvoiceInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            //任务总额
            self.detailViewLab1.text = [NSString stringWithFormat:@" 任务总额：%@ ",_data.payment_money];
            //已交定金
            self.detailViewLab2.text = [NSString stringWithFormat:@" 已交定金：%@  ",_data.front_money];
            _invoiceModel = [JMInvoiceModel mj_objectWithKeyValues:responsObject[@"data"]];
            //税金
            NSString *invoiceMoney = [self calculateByMultiplying:_invoiceModel.tax_b secondNumber:_data.payment_money];
            //尾款
            NSString *lastMoney = [self calculateBySubtractingMinuend:_data.payment_money subtractorNumber:_data.front_money];
            self.moneyDetailViewLab1.text = @"剩余应付";
            self.moneyDetailViewLab2.text = [NSString stringWithFormat:@"%@ 元",lastMoney];
            //        NSLog(@"剩余应付  %ld 元",(long)now);
            //合计 = 尾款 + 税金
            NSString *total = [self calculateByadding:lastMoney secondNumber:invoiceMoney];
            self.bottomViewLab1.text = @"合计";
            self.bottomViewLab2.text = total;
            self.didPayMoney = total;
        }
        
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
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
