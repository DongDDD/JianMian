//
//  JMPostNewJobViewController.m
//  JMian
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostNewJobViewController.h"
#import "JMJobDescriptionViewController.h"
#import "JMWelfareViewController.h"
#import "JMManageInterviewViewController.h"


@interface JMPostNewJobViewController ()

@end

@implementation JMPostNewJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setTitle:@"发布新职位"];
    
    [self setRightBtnTextName:@"发布"];
   
    // Do any additional setup after loading the view from its nib.
}


-(void)rightAction{
    JMManageInterviewViewController *vc = [[JMManageInterviewViewController alloc]init];
    
    
    [self.navigationController pushViewController:vc animated:YES];

    NSLog(@"发布");

}
- (IBAction)welFareAction:(UIButton *)sender {
    JMWelfareViewController *vc = [[JMWelfareViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)workLocationAction:(UIButton *)sender {
    
    
}

- (IBAction)jobDescriptionAction:(UIButton *)sender {
    
    JMJobDescriptionViewController *vc = [[JMJobDescriptionViewController alloc]init];
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
