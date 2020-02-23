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
#import "JMHTTPManager+ChangeOrderStatus.h"
#import "JMGoodsListView.h"
#import "JMPictureAddViewController.h"
#import "JMHTTPManager+Uploads.h"

@interface JMApplyForRefundViewController ()<JMRefundCauseViewDelegate,JMPictureAddViewControllerDelegate>
//@property(nonatomic,strong)JMRefundGoodsStatusView *refundGoodsStatusView;
@property(nonatomic,strong)JMRefundCauseView *refundCauseView;
@property(nonatomic,strong)JMGoodsListView *goodsListView;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewConstrainTop;
@property (weak, nonatomic) IBOutlet UIButton *caseBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadImagBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (copy, nonatomic)NSString *msg;//原因

@property (weak, nonatomic) IBOutlet UIView *uploadImageVIew;
@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)NSArray *image_arr;

@property (strong, nonatomic)NSMutableArray *files;//图片链接



@end

@implementation JMApplyForRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BG_COLOR;
//    _BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    _BGView.backgroundColor = [UIColor blackColor];
//    _BGView.alpha = 0.5;
//    [_BGView setHidden:YES];
//    [[UIApplication sharedApplication].keyWindow addSubview:_BGView];
    self.goodsListView.goods = self.model.goods;
    [self.view addSubview:self.goodsListView];
 
    self.stackViewConstrainTop.constant = self.model.goods.count * 60;
    
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@",self.model.pay_amount];
    [[UIApplication sharedApplication].keyWindow addSubview:self.refundCauseView];
    [self.refundCauseView hide];
    if (_viewType == JMApplyForRefundViewTypeRefund) {
        [self.uploadImageVIew setHidden:YES];
    }
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)goodsStatusBtnAction:(UIButton *)sender {
     
}

- (IBAction)caseAction:(UIButton *)sender {
    [self.refundCauseView show];
}
- (IBAction)submitAction:(UIButton *)sender {
    
    if (self.msg.length > 0) {
        [self changOrderStatus:@"7" order_id:self.model.order_id msg:self.msg files:self.files];
    }else{
        [self showAlertSimpleTips:@"提示" message:@"请上传原因" btnTitle:@"好的"];
    }
    
    //    [self changOrderStatus:@"7" order_id:self.model.order_id];
}

- (IBAction)uploadBtn:(UIButton *)sender {
    JMPictureAddViewController *vc = [[JMPictureAddViewController alloc]init];
    vc.delegate = self;
    vc.image_arr = self.image_arr;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)submitActionWithMsg:(NSString *)msg{
    self.msg = msg;
    [self.caseBtn setTitle:msg forState:UIControlStateNormal];
    [self.caseBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];

}


-(void)changOrderStatus:(NSString *)status order_id:(NSString *)order_id msg:(NSString *)msg files:(NSArray *)files{
  
    [[JMHTTPManager sharedInstance]refundRequestWithOrder_id:order_id status:status msg:msg files:files successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功"
                                                             delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
               [alert show];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
         
    }];
}

-(void)uploadImgRequest:(UIImage *)img{
 
    NSArray *array = @[img];

    [[JMHTTPManager sharedInstance]uploadsWithFiles:array successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            NSString *url = responsObject[@"data"][0];
            [self.files addObject:url];
            
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)alertSucceesAction{
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - delegate
-(void)pictureAddWithImage_arr:(NSArray *)image_arr{
    _image_arr = image_arr;//用户选择后的图片数组
    //self.imageUrl_arr2//用来正确排序的数组，装服务器返回的链接
    for (int i = 0; i < self.image_arr.count; i++) {
        UIImage *img = self.image_arr[i];
        [self uploadImgRequest:img];//上传图片请求
    }
    
     [self.uploadImagBtn setTitle:@"已上传" forState:UIControlStateNormal];
     [self.uploadImagBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    
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
        _refundCauseView.delegate = self;
        _refundCauseView.titleArray = @[@"不喜欢/不想要",@"货物破损" ,@"卖家发错货",@"生产日期/保质与商品描述不符",@"其他原因"];
        _refundCauseView.titleLab.text = @"退款原因";

        _refundCauseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }
    return _refundCauseView;
}

-(JMGoodsListView *)goodsListView{
    if (!_goodsListView) {
        _goodsListView = [[JMGoodsListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.model.goods.count * 60)];
    }
    return _goodsListView;
}

-(NSMutableArray *)files{
    if (_files.count == 0) {
        _files = [NSMutableArray array];
    }
    return _files;
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
