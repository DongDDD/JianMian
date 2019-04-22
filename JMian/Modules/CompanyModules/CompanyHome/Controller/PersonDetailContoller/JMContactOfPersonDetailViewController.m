//
//  JMContactOfPersonDetailViewController.m
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMContactOfPersonDetailViewController.h"

@interface JMContactOfPersonDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *emailLab;

@end

@implementation JMContactOfPersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _phoneNumberLab.text = _phoneNumberStr;
    _emailLab.text = _emailStr;
    
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
