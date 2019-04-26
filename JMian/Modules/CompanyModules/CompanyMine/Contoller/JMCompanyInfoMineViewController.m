//
//  JMCompanyInfoMineViewController.m
//  JMian
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyInfoMineViewController.h"
#import "JMHTTPManager+FetchCompanyInfo.h"

@interface JMCompanyInfoMineViewController ()

@end

@implementation JMCompanyInfoMineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


-(void)getData{
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    [[JMHTTPManager sharedInstance]fetchCompanyInfo_Id:model.company_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];



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
