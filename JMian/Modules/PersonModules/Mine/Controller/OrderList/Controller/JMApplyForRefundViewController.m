//
//  JMApplyForRefundViewController.m
//  JMian
//
//  Created by mac on 2020/2/4.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMApplyForRefundViewController.h"
#import "JMRefundGoodsStatusView.h"
#import "JMRefundCauseView.h"
@interface JMApplyForRefundViewController ()
//@property(nonatomic,strong)JMRefundGoodsStatusView *refundGoodsStatusView;
@property(nonatomic,strong)JMRefundCauseView *refundCauseView;

@property(nonatomic,strong)UIView *BGView;
@end

@implementation JMApplyForRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _BGView.backgroundColor = [UIColor blackColor];
    _BGView.alpha = 0.5;
    [_BGView setHidden:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:_BGView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.refundCauseView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BGAction)];
    [_BGView addGestureRecognizer:tap];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)goodsStatusBtnAction:(UIButton *)sender {
    [_BGView setHidden:NO];
    [UIView animateWithDuration:0.2 animations:^{
             self.refundCauseView.frame = CGRectMake(0, self.view.frame.size.height-380, SCREEN_WIDTH, 460);
    }];
}
-(void)BGAction{
    [_BGView setHidden:YES];
      [UIView animateWithDuration:0.2 animations:^{
               self.refundCauseView.frame = CGRectMake(0, self.view.frame.size.height+380, SCREEN_WIDTH, 460);
      }];
}

#pragma mark - lazy

//-(JMRefundGoodsStatusView *)refundGoodsStatusView{
//    if (!_refundGoodsStatusView) {
//        _refundGoodsStatusView = [[JMRefundGoodsStatusView alloc]init];
//        _refundGoodsStatusView.frame = CGRectMake(0, self.view.frame.size.height+400, SCREEN_WIDTH, 325);
//        _refundGoodsStatusView.layer.cornerRadius = 10;
//
//    }
//    return _refundGoodsStatusView;
//}

-(JMRefundCauseView *)refundCauseView{
    if (!_refundCauseView) {
        _refundCauseView = [[JMRefundCauseView alloc]init];
        _refundCauseView.backgroundColor = [UIColor whiteColor];
        _refundCauseView.frame = CGRectMake(0, self.view.frame.size.height+460, SCREEN_WIDTH, 460);
        _refundCauseView.layer.cornerRadius = 10;
        
    }
    return _refundCauseView;
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
