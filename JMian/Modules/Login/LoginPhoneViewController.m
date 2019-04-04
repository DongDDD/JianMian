//
//  LoginPhoneViewController.m
//  JMian
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LoginPhoneViewController.h"
#import "ChooseIdentity.h"
#import "JMHTTPManager+Login.h"
#import "JMLoginInfoModel.h"



@interface LoginPhoneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;
@property (weak, nonatomic) IBOutlet UITextField *captchaText;


@end

@implementation LoginPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)loginPhoneBtn:(id)sender {
    
    [[JMHTTPManager sharedInstance]loginWithMode:@"sms" phone:self.phoneNumText.text captcha:self.captchaText.text sign_id:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMLoginInfoModel *model = [JMLoginInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        NSLog(@"用户手机号：----%@",model.phone);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登陆成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
       [alert show];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
    ChooseIdentity *chooseId = [[ChooseIdentity alloc]init];
    
    [self.navigationController pushViewController:chooseId animated:YES];
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
