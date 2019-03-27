//
//  LoginPhoneViewController.m
//  JMian
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LoginPhoneViewController.h"
#import "ChooseIdentity.h"



@interface LoginPhoneViewController ()

@end

@implementation LoginPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)loginPhoneBtn:(id)sender {
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
