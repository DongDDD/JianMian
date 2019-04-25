//
//  JMUserChangeWindowViewController.m
//  JMian
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUserChangeWindowViewController.h"

@interface JMUserChangeWindowViewController ()

@end

@implementation JMUserChangeWindowViewController


+(JMUserChangeWindowViewController *)sharedUserChangeWindow{
    static dispatch_once_t onceToken;
    static JMUserChangeWindowViewController *shareUserChangeWindow;
    dispatch_once(&onceToken, ^{
        shareUserChangeWindow = [[JMUserChangeWindowViewController alloc]init];
    });
    return shareUserChangeWindow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
