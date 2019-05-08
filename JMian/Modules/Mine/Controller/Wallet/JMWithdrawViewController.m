//
//  JMWithdrawViewController.m
//  JMian
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMWithdrawViewController.h"
#import "JMChooseCardViewController.h"
@interface JMWithdrawViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cashTextField;

@end

@implementation JMWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.cashTextField.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
}
-(void)hideKeyboard{
   
    [_cashTextField resignFirstResponder];

 
}

- (IBAction)chooseCardTap:(UITapGestureRecognizer *)sender {
    [self.navigationController pushViewController:[[JMChooseCardViewController alloc]init] animated:YES];
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
