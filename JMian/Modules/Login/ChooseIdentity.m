//
//  ChooseIdentity.m
//  JMian
//
//  Created by mac on 2019/3/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ChooseIdentity.h"
#import "BasicInformationViewController.h"


@interface ChooseIdentity ()

@end

@implementation ChooseIdentity

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)lookUpBtn:(UIButton *)sender {
    BasicInformationViewController *basicInformation = [[BasicInformationViewController alloc]init];
    
    [self.navigationController pushViewController:basicInformation animated:YES];
    
    
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
