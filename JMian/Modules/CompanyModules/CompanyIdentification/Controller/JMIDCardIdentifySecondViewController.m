//
//  JMIDCardIdentifySecondViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMIDCardIdentifySecondViewController.h"
#import "JMBAndCTabBarViewController.h"
#import "JMHTTPManager+UpdateInfo.h"

@interface JMIDCardIdentifySecondViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *IDCardText;

@end

@implementation JMIDCardIdentifySecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"实名认证"];
//    self.navigationController.navigationBar.translucent = NO;
//
//    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = BG_COLOR;
    self.nameText.delegate = self;
    self.IDCardText.delegate = self;
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];//设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。tapGestureRecognizer.cancelsTouchesInView = NO;//将触摸事件添加到当前view
//    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view from its nib.
    NSString *url1 = [NSString stringWithFormat:@"https://jmsp-images-1257721067.picgz.myqcloud.com%@",self.image_front];
    NSString *url2 = [NSString stringWithFormat:@"https://jmsp-images-1257721067.picgz.myqcloud.com%@",self.image_behind];
    
    [self.img1 sd_setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    [self.img2 sd_setImageWithURL:[NSURL URLWithString:url2] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//-(void)keyboardHide:(UITapGestureRecognizer*)tap{
//    [self.IDCardText resignFirstResponder];
//    [self.nameText resignFirstResponder];
//
//}

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
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self showAlertSimpleTips:@"提示" message:@"您的信息已经提交成功， 审核结果我们会第一时间通知你" btnTitle:@"确认"];

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];

 
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
