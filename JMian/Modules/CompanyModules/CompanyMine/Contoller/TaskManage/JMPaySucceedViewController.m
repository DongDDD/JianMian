//
//  JMPaySucceedViewController.m
//  JMian
//
//  Created by mac on 2019/6/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPaySucceedViewController.h"
#import "JMTaskCommetViewController.h"

@interface JMPaySucceedViewController ()
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLab;

@end

@implementation JMPaySucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付成功";
    self.payMoneyLab.text = [NSString stringWithFormat:@"¥%@",self.didPayMoney];
    
    // Do any additional setup after loading the view from its nib.
}

//-(void)fanhui{
//    JMTaskCommetViewController *vc = [[JMTaskCommetViewController alloc]init];
//    vc.data = self.data;
//    [self.navigationController pushViewController:vc animated:YES];
//}

- (IBAction)leftBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)rightBtnAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (IBAction)gotoCommentVC:(UIButton *)sender {
//    if ([self.data.status isEqualToString:Task_Finish]) {
//        JMTaskCommetViewController *vc = [[JMTaskCommetViewController alloc]init];
//        vc.data = self.data;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
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
