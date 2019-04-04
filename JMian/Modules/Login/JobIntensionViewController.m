//
//  JobIntensionViewController.m
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JobIntensionViewController.h"
#import "PositionDesiredViewController.h"


@interface JobIntensionViewController ()

@end

@implementation JobIntensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];

    [self setRightBtnTextName:@"下一步"];
    // Do any additional setup after loading the view from its nib.
}


-(void)rightAction{
 
    PositionDesiredViewController *Positon = [[PositionDesiredViewController alloc]init];
    [self.navigationController pushViewController:Positon animated:YES];
    


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
