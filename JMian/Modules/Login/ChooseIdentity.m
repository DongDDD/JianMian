//
//  ChooseIdentity.m
//  JMian
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ChooseIdentity.h"
#import "BasicInformationViewController.h"
#import "JMHTTPManager+UpdateInfo.h"




@interface ChooseIdentity ()

@end

@implementation ChooseIdentity

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)isSearchJob:(id)sender {
    [[JMHTTPManager sharedInstance]updateUserInfoType:@(1) password:nil avatar:nil nickname:nil email:nil name:nil sex:nil ethnic:nil birthday:nil address:nil number:nil image_front:nil image_behind:nil user_step:@"1" enterprise_step:nil real_status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

        BasicInformationViewController *basicInformation = [[BasicInformationViewController alloc]init];
        
        [self.navigationController pushViewController:basicInformation animated:YES];

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];

    
}


- (IBAction)isCompanyBtn:(id)sender {
    [[JMHTTPManager sharedInstance]updateUserInfoType:@(2) password:nil avatar:nil nickname:nil email:nil name:nil sex:nil ethnic:nil birthday:nil address:nil number:nil image_front:nil image_behind:nil user_step:nil enterprise_step:@"1" real_status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        BasicInformationViewController *basicInformation = [[BasicInformationViewController alloc]init];
        
        [self.navigationController pushViewController:basicInformation animated:YES];

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    NSLog(@"我要招人");
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
