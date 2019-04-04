//
//  LoginViewController.m
//  JMian
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginPhoneViewController.h"
#import "PositionDesiredViewController.h" //test 后期可删除
#import "WorkExperienceViewController.h" //test 后期可删除
#import "FailedLoadingViewController.h"//test 后期可删除
#import "PositionDesiredSecondViewController.h"//test 后期可删除







@interface LoginViewController ()


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view from its nib.

}
- (IBAction)testAction:(id)sender {
    PositionDesiredSecondViewController *postionD = [[PositionDesiredSecondViewController alloc]init];
    
    [self.navigationController pushViewController:postionD animated:YES];

}

- (IBAction)phoneLogin:(id)sender {
    
    
    LoginPhoneViewController *loginPhone = [[LoginPhoneViewController alloc]initWithNibName:@"LoginPhoneViewController" bundle:nil];
    
    [self.navigationController pushViewController:loginPhone animated:YES];
    
    
    
}

-(void)loginRequest{


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
