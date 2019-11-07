//
//  JMServiceProtocolWebViewController.m
//  JMian
//
//  Created by mac on 2019/7/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMServiceProtocolWebViewController.h"

@interface JMServiceProtocolWebViewController ()

@end

@implementation JMServiceProtocolWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;

    [self setHTMLPath:@"SecondModulesHTML/C/xieyi.html"];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.bottom.mas_equalTo(self.view).offset(-Bottom_SafeHeight);
    }];
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
