//
//  JMBindBankCardViewController.m
//  JMian
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBindBankCardViewController.h"
#import "JMHTTPManager+BankCark.h"

@interface JMBindBankCardViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *openAccountTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *nextStepBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab;


@end

@implementation JMBindBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定银行卡";
    self.scrollView.delegate = self;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        self.titleNameLab.text = @"公司名称";
    }else{
        self.titleNameLab.text = @"真实姓名";
    }
 
    _companyNameTextField.delegate = self;
    _bankNameTextField.delegate = self;
    _cardNumTextField.delegate = self;
    _openAccountTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//       self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.nextStepBtn.frame.origin.y+self.nextStepBtn.frame.size.height+50);
}

//- (void)keyboardWillShow:(NSNotification *)aNotification {
//
//    NSDictionary *userInfo = aNotification.userInfo;
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = aValue.CGRectValue;
//    CGRect frame = _openAccountTextField.frame;
//    CGFloat changeHeight = keyboardRect.size.height - (frame.origin.y+frame.size.height);
//    CGRect rect= CGRectMake(0,-changeHeight-10,SCREEN_WIDTH,SCREEN_HEIGHT);
//
//        [UIView animateWithDuration:0.3 animations:^ {
//            self.scrollView.frame = rect;
//
//        }];
//
//
//}
//
//
//- (void)keyboardWillHide:(NSNotification *)aNotification {
//
//        [UIView animateWithDuration:0.3 animations:^ {
//            self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//
//        }];
//
//
//
//
//}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)hideKeyboard{

    
    [_companyNameTextField resignFirstResponder];
    [_bankNameTextField resignFirstResponder];
    [_cardNumTextField resignFirstResponder];
    [_openAccountTextField resignFirstResponder];


}



#pragma mark - textFieldDelegte
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_companyNameTextField resignFirstResponder];
    [_bankNameTextField resignFirstResponder];
    [_cardNumTextField resignFirstResponder];
    [_openAccountTextField resignFirstResponder];

    
    return YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    
}

- (IBAction)nextStepAction:(UIButton *)sender {
    
    if (self.companyNameTextField.text && self.bankNameTextField.text && self.cardNumTextField.text && self.openAccountTextField.text) {
        [[JMHTTPManager sharedInstance] createBankCard_full_name:self.companyNameTextField.text bank_name:self.bankNameTextField.text card_number:self.cardNumTextField.text bank_branch:self.openAccountTextField.text image_path:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请完善信息！"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    
    }
    

}
- (IBAction)cameraAction:(UIButton *)sender {
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
