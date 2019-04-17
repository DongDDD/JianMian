//
//  JMIDCardIdentifyViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMIDCardIdentifyViewController.h"
#import "JMIDCardIdentifySecondViewController.h"

@interface JMIDCardIdentifyViewController ()

@end

@implementation JMIDCardIdentifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"实名认证"];
        self.navigationController.navigationBar.translucent = NO;
    
        self.extendedLayoutIncludesOpaqueBars = YES;
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)nextAction:(id)sender {
    JMIDCardIdentifySecondViewController *vc = [[JMIDCardIdentifySecondViewController alloc]init];
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
