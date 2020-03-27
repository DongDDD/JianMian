//
//  JMTrasferViewController.m
//  JMian
//
//  Created by mac on 2019/12/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTransferViewController.h"
#import "TIMFriendshipManager.h"

@interface JMTransferViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconHeader;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *transferBtn;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;

@end

@implementation JMTransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转账";

    [[TIMFriendshipManager sharedInstance] getUsersProfile:@[_user_id] forceUpdate:NO succ:^(NSArray * arr) {
        for (TIMUserProfile * profile in arr) {
            NSLog(@"user=%@", profile);
            [self.iconHeader  sd_setImageWithURL:[NSURL URLWithString:profile.faceURL] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
            self.nameLab.text = profile.nickname;
        }
    }fail:^(int code, NSString * err) {
        NSLog(@"GetFriendsProfile fail: code=%d err=%@", code, err);
    }];
    
    self.moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)transferAction:(UIButton *)sender {
    [self.moneyTextField resignFirstResponder];
    [self.remarkTextField resignFirstResponder];
    if (self.remarkTextField.text.length > 10) {
        [self showAlertSimpleTips:@"提示" message:@"转账说明不能超过10个字" btnTitle:@"好的"];
        return;
    }

    NSString *str;
    if (self.remarkTextField.text.length > 0) {
        str = self.remarkTextField.text;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(sendTransferMessage:remark:)]) {
        [_delegate sendTransferMessage:self.moneyTextField.text remark:str];
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
