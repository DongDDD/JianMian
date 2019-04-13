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
    [[JMHTTPManager sharedInstance]updateUserInfoType:@(1) password:@"1234657955" avatar:nil nickname:nil email:@"379247101@qq.com" name:nil sex:nil ethnic:nil birthday:nil address:nil number:nil image_front:nil image_behind:nil user_step:@"0" enterprise_step:nil real_status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];

    BasicInformationViewController *basicInformation = [[BasicInformationViewController alloc]init];
    
    [self.navigationController pushViewController:basicInformation animated:YES];
    
}


- (IBAction)isCompanyBtn:(id)sender {
    [[JMHTTPManager sharedInstance]updateUserInfoType:@(2) password:@"1234657955" avatar:nil nickname:nil email:@"379247101@qq.com" name:nil sex:nil ethnic:nil birthday:nil address:nil number:nil image_front:nil image_behind:nil user_step:nil enterprise_step:@"1" real_status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
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
