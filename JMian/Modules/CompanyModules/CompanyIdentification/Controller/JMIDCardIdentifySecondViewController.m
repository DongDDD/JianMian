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
    
    [[JMHTTPManager sharedInstance]updateUserInfoType:nil password:nil avatar:nil nickname:nil email:nil name:nil sex:nil ethnic:nil birthday:nil address:nil number:nil image_front:self.image_front image_behind:self.image_behind user_step:nil enterprise_step:nil real_status:@"1" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的信息已经提交成功， 审核结果我们会第一时间通知你" preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        JMCompanyTabBarViewController *tab = [[JMCompanyTabBarViewController alloc]init];
        
        [UIApplication sharedApplication].delegate.window.rootViewController=tab;

    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        //点击确认后需要做的事
////        C端
        
        JMCompanyTabBarViewController *tab = [[JMCompanyTabBarViewController alloc]init];
     
        [UIApplication sharedApplication].delegate.window.rootViewController=tab;

 
    }]];
    [self presentViewController:alert animated:YES completion:nil]; //注意一定要写此句，否则不会显示
    
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
