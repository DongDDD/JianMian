//
//  JMIDCardIdentifySecondViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMIDCardIdentifySecondViewController.h"
#import "JMPersonTabBarViewController.h"
#import "JMCompanyTabBarViewController.h"
#import "JMHTTPManager+UpdateInfo.h"

@interface JMIDCardIdentifySecondViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *IDCardText;

@end

@implementation JMIDCardIdentifySecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"实名认证"];
    self.navigationController.navigationBar.translucent = NO;
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];//设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。tapGestureRecognizer.cancelsTouchesInView = NO;//将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view from its nib.
    
    
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.IDCardText resignFirstResponder];
    [self.nameText resignFirstResponder];
    
}

//-(void)setImg1:(UIImageView *)img1{
//    self.img1.image = img1.image;
//
//}
//-(void)setImg2:(UIImageView *)img2{
//    self.img2.image = img2.image;
//
//}
- (IBAction)commitAction:(UIButton *)sender {
    [self.IDCardText resignFirstResponder];
    [self.nameText resignFirstResponder];
    [[JMHTTPManager sharedInstance]updateUserInfoWithCompany_position:nil type:nil password:nil avatar:nil nickname:nil email:nil name:self.nameText.text sex:nil ethnic:nil birthday:@"1980-12-09" address:nil number:self.IDCardText.text image_front:self.image_front image_behind:self.image_behind user_step:nil enterprise_step:nil real_status:@"1" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        [self showAlertWithTitle:@"提示" message:@"您的信息已经提交成功， 审核结果我们会第一时间通知你" leftTitle:@"返回" rightTitle:@"确认"];

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];

 
}

-(void)alerLeftAction{
    JMCompanyTabBarViewController *tab = [[JMCompanyTabBarViewController alloc]init];
    
    [UIApplication sharedApplication].delegate.window.rootViewController=tab;

}

-(void)alertRightAction{

    JMCompanyTabBarViewController *tab = [[JMCompanyTabBarViewController alloc]init];
    
    [UIApplication sharedApplication].delegate.window.rootViewController=tab;
    
    
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
