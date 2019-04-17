//
//  JMIDCardIdentifySecondViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMIDCardIdentifySecondViewController.h"
#import "JMTabBarViewController.h"

@interface JMIDCardIdentifySecondViewController ()

@end

@implementation JMIDCardIdentifySecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"实名认证"];
        self.navigationController.navigationBar.translucent = NO;
    
        self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    // Do any additional setup after loading the view from its nib.
    
    
}
- (IBAction)commitAction:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的信息已经提交成功， 审核结果我们会第一时间通知你" preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //点击确认后需要做的事
        
        JMTabBarViewController *tab = [[JMTabBarViewController alloc]init];
        tab.isCompany = YES;
        [UIApplication sharedApplication].delegate.window.rootViewController=tab;

 
    }]];
    [self presentViewController:alert animated:YES completion:nil]; //注意一定要写此句，否则不会显示
    
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
