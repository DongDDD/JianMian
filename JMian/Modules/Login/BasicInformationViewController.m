//
//  BasicInformationViewController.m
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BasicInformationViewController.h"
#import "JobIntensionViewController.h"


@interface BasicInformationViewController ()

@end

@implementation BasicInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)InforBtn:(UIButton *)sender {
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
