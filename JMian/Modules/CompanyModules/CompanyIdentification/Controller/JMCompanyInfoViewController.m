//
//  JMCompanyInfoViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyInfoViewController.h"
#import "JMUploadLicenseViewController.h"


@interface JMCompanyInfoViewController ()<UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation JMCompanyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.navigationController.navigationBar.translucent = NO;
    
        self.extendedLayoutIncludesOpaqueBars = YES;
    [self setRightBtnTextName:@"下一步"];
    self.pickerView.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)businessAction:(UIButton *)sender {
    [self.pickerView setHidden:NO];
    
}

- (IBAction)personAction:(UIButton *)sender {
    
    
}

- (IBAction)developStep:(UIButton *)sender {
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    
}

-(void)rightAction{
    
    JMUploadLicenseViewController *vc = [[JMUploadLicenseViewController alloc]init];
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
