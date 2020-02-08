//
//  JMStroreNotificationViewController.m
//  JMian
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMStroreNotificationViewController.h"
#import "JMPartTimeJobResumeFooterView.h"
#import "JMHTTPManager+UpdateShopInfo.h"
@interface JMStroreNotificationViewController ()<JMPartTimeJobResumeFooterViewDelegate>
@property(nonatomic,strong)JMPartTimeJobResumeFooterView *decriptionTextView;
@end

@implementation JMStroreNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightBtnTextName:@"完成"];
    [self.view addSubview:self.decriptionTextView];
    if (self.content) {
        [self.decriptionTextView setContent:self.content];
         
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)rightAction{
    [self.decriptionTextView.contentTextView resignFirstResponder];
    NSString *shop_poster = @"";
    NSString *description = @"";
    if (_viewType == JMStroreNotificationViewPoster) {
        shop_poster = self.content;
    }else if (_viewType == JMStroreNotificationViewDesc){
        description = self.content;
    }
    JMUserInfoModel *model  = [JMUserInfoManager getUserInfo];
    [[JMHTTPManager sharedInstance]updateShopInfoWithShop_id:model.shop_shop_id shop_logo:@"" shop_poster:shop_poster description:description successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}
#pragma mark - textFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)sendContent:(NSString *)content{
    self.content = content;
//    _groupIntroduce = content;
}

#pragma mark - Delegate

-(JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(10, -40, SCREEN_WIDTH-20, 300);
        _decriptionTextView.delegate = self;
//        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
        _decriptionTextView.placeHolder.text = @"请输入";
        _decriptionTextView.wordsLenghLabel.text = @"0/500";
        _decriptionTextView.contentTextView.backgroundColor = BG_COLOR;
//        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeGroup];
        //        _decriptionTextView.contentTextView.delegate = self;
        
    }
    return _decriptionTextView;
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
