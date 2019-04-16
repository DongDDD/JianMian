//
//  JMUploadLicenseViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUploadLicenseViewController.h"
#import "JMTabBarViewController.h"
#import "JMIDCardIdentifyViewController.h" //test

@interface JMUploadLicenseViewController ()

@end

@implementation JMUploadLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
}

- (IBAction)doneAction:(id)sender {
  
    JMIDCardIdentifyViewController *vc = [[JMIDCardIdentifyViewController alloc] init];
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
