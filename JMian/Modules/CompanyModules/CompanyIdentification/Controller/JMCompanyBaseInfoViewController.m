//
//  JMCompanyBaseInfoViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyBaseInfoViewController.h"
#import "JMCompanyInfoViewController.h"


@interface JMCompanyBaseInfoViewController ()

@end

@implementation JMCompanyBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
 
    [self setRightBtnTextName:@"下一步"];
    // Do any additional setup after loading the view from its nib.
}


-(void)rightAction{
    JMCompanyInfoViewController *vc = [[JMCompanyInfoViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];


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
