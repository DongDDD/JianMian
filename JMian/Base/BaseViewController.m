//
//  BaseViewController.m
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
//
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(-10, 50, 100, 50);
    [backBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];

   
    [backBtn addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];

    

    [self.view addSubview:backBtn];
}

-(void)butClick{
    [self.navigationController popViewControllerAnimated:YES];
    


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
