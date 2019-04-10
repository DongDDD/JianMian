//
//  JMJobExperienceViewController.m
//  JMian
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMJobExperienceViewController.h"
#import "JMHTTPManager+CreateExperience.h"
#import "HomeViewController.h"

@interface JMJobExperienceViewController ()
@property (weak, nonatomic) IBOutlet UITextField *companyNameText;
@property (weak, nonatomic) IBOutlet UIButton *startDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *endDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *jobLabelId;
@property (weak, nonatomic) IBOutlet UITextField *jobDescriptionText;

@end

@implementation JMJobExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightBtnTextName:@"下一步"];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - 点击事件
-(void)rightAction{
    [[JMHTTPManager sharedInstance]createExperienceWithCompany_name:self.companyNameText.text job_label_id:@(1)start_date:@"2011-05-03" end_date:@"2012-05-03" description:self.jobDescriptionText.text successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

        NSLog(@"%@",responsObject);

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];
    
//    HomeViewController *vc = [[HomeViewController alloc]init];
    [self.navigationController popToRootViewControllerAnimated:YES];
  



}
- (IBAction)finishBtn:(id)sender {
    
    
    
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
