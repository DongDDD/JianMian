//
//  JMChangeIdentityViewController.m
//  JMian
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMChangeIdentityViewController.h"
#import "JMJudgeViewController.h"
#import "JMHTTPManager+UpdateInfo.h"

@interface JMChangeIdentityViewController ()

@end

@implementation JMChangeIdentityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];

    // Do any additional setup after loading the view from its nib.
}


- (IBAction)userChangeAction:(id)sender {
    
    [[JMHTTPManager sharedInstance]updateUserInfoType:nil password:nil avatar:nil nickname:nil email:nil name:nil sex:nil ethnic:nil birthday:nil address:nil number:nil image_front:nil image_behind:nil user_step:@"1" enterprise_step:nil real_status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
        model = [JMUserInfoManager getUserInfo];
    
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


- (IBAction)exitAction:(id)sender {
    
    
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
