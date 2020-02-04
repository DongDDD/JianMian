//
//  JMApplyForRefundViewController.m
//  JMian
//
//  Created by mac on 2020/2/4.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMApplyForRefundViewController.h"
#import "JMRefundGoodsStatusView.h"
@interface JMApplyForRefundViewController ()
@property(nonatomic,strong)JMRefundGoodsStatusView *refundGoodsStatusView;
@end

@implementation JMApplyForRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.refundGoodsStatusView];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)goodsStatusBtnAction:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
             self.refundGoodsStatusView.frame = CGRectMake(0, self.view.frame.size.height-325, SCREEN_WIDTH, 325);
    }];
}

#pragma mark - lazy

-(JMRefundGoodsStatusView *)refundGoodsStatusView{
    if (!_refundGoodsStatusView) {
        _refundGoodsStatusView = [[JMRefundGoodsStatusView alloc]init];
        _refundGoodsStatusView.frame = CGRectMake(0, self.view.frame.size.height, SCREEN_WIDTH, 325);
        _refundGoodsStatusView.layer.cornerRadius = 10;
        
    }
    return _refundGoodsStatusView;
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
