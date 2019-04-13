//
//  JobIntensionViewController.m
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JobIntensionViewController.h"
#import "PositionDesiredViewController.h"
#import "JMJobExperienceViewController.h"
#import "JMHTTPManager+UpdateInfo.h"


@interface JobIntensionViewController ()

@end

@implementation JobIntensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    if (_isHiddenBackBtn) {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }
    [self setRightBtnTextName:@"下一步"];
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)wantToJob:(id)sender {
    
    PositionDesiredViewController *vc = [[PositionDesiredViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


-(void)rightAction{
    [[JMHTTPManager sharedInstance]updateUserInfoType:@(1) password:nil avatar:nil nickname:nil email:@"" name:@"" sex:@(1) ethnic:nil birthday:nil address:nil number:@"" image_front:nil image_behind:nil user_step:@"2" enterprise_step:nil real_status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
       
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
 
    JMJobExperienceViewController *vc = [[JMJobExperienceViewController alloc]init];
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
