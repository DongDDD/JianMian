//
//  JMGroupNameViewController.m
//  JMian
//
//  Created by mac on 2020/1/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMGroupNameViewController.h"

@interface JMGroupNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *groupNameTextField;

@end

@implementation JMGroupNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightBtnTextName:@"保存"];
    self.view.backgroundColor = BG_COLOR;
    // Do any additional setup after loading the view from its nib.
}

-(void)rightAction{
    
    [self.groupNameTextField resignFirstResponder];
    if (self.groupNameTextField.text.length > 10) {
        [self showAlertSimpleTips:@"提示" message:@"不能超过10个字" btnTitle:@"好的"];
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(groupNameController:didModiyContent:)]) {
        [_delegate groupNameController:self didModiyContent:self.groupNameTextField.text];
    }
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
