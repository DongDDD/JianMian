//
//  JMContactOfPersonDetailViewController.m
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMContactOfPersonDetailViewController.h"
#import "DimensMacros.h"

@interface JMContactOfPersonDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *emailLab;

@end

@implementation JMContactOfPersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if (_phoneNumberStr.length >10 && _emailStr.length > 10) {
        if ([userModel.deadline isEqualToString:@"0"]) {
            
            _phoneNumberStr =[_phoneNumberStr stringByReplacingOccurrencesOfString:[_phoneNumberStr substringWithRange:NSMakeRange(2,5)]withString:@"*****"];
            NSLog(@"_phoneNumberStr:%@",_phoneNumberStr);
            _emailStr =[_emailStr stringByReplacingOccurrencesOfString:[_emailStr substringWithRange:NSMakeRange(3,6)]withString:@"******"];
            NSLog(@"_phoneNumberStr:%@",_emailStr);
        }
        
        _phoneNumberLab.text = _phoneNumberStr;
        _emailLab.text = _emailStr;
        
    }

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
