//
//  JMWithdrawViewController.m
//  JMian
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMWithdrawViewController.h"
#import "JMChooseCardViewController.h"
#import "JMHTTPManager+MoneyWithDraw.h"
#import "JMBankCardData.h"
@interface JMWithdrawViewController () <UITextFieldDelegate,JMChooseCardViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cashTextField;
@property (strong, nonatomic)JMBankCardData *bankCardData;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLab;

@end

@implementation JMWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"申请提现";
    self.cashTextField.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)hideKeyboard{
   
    [_cashTextField resignFirstResponder];

 
}

-(void)didChooseBankCardWithData:(JMBankCardData *)data{
    _bankCardData = data;
    self.bankNameLab.text = data.bank_name;
    NSString *lastFourStr = [data.card_number substringFromIndex:data.card_number.length- 4];
    NSString *str1 = [NSString stringWithFormat:@"尾号%@ 储蓄卡",lastFourStr];
    self.cardNumberLab.text = str1;
  
}
- (IBAction)withDrawAction:(UIButton *)sender {
    
    [self withDrawRequest];
    
}

-(void)withDrawRequest{
    [_cashTextField resignFirstResponder];
    [[JMHTTPManager sharedInstance]withdrawMoneyWithBank_card_id:_bankCardData.bank_card_id amount:_cashTextField.text successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

- (IBAction)chooseCardTap:(UITapGestureRecognizer *)sender {
    JMChooseCardViewController *vc = [[JMChooseCardViewController alloc]init];
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_cashTextField resignFirstResponder];

    return YES;
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
