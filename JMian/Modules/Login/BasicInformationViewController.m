//
//  BasicInformationViewController.m
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BasicInformationViewController.h"
#import "JobIntensionViewController.h"
#import "JMHTTPManager+UpdateInfo.h"


@interface BasicInformationViewController ()

@property(nonatomic,strong)NSNumber *sex;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *numberText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;


@end

@implementation BasicInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self setRightBtnTextName:@"下一步"];
   // Do any additional setup after loading the view from its nib.
}

- (IBAction)manBtn:(id)sender {
    self.sex = @(1);
    
    
}

- (IBAction)womanBtn:(id)sender {
    self.sex = @(2);
}


-(void)rightAction{
    
    [[JMHTTPManager sharedInstance]updateUserInfoType:@(1) password:nil avatar:nil nickname:nil email:self.emailText.text name:self.nameText.text sex:self.sex ethnic:nil birthday:nil address:nil number:self.numberText.text image_front:nil image_behind:nil user_step:@"3" enterprise_step:nil real_status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请求成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
   
    JobIntensionViewController *jobIntension = [[JobIntensionViewController alloc]init];
    
    [self.navigationController pushViewController:jobIntension animated:YES];
    
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
