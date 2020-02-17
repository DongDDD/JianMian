//
//  JMRefundDetailViewController.m
//  JMian
//
//  Created by mac on 2020/2/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMRefundDetailViewController.h"
#import "JMHTTPManager+FectchOrderInfo.h"
#import "JMOrderCellData.h"
#import "JMCreatChatAction.h"
#import "JMApplyForRefundViewController.h"
#import "JMHTTPManager+ChangeOrderStatus.h"
#import "JMGoodsListView.h"
#import "JMGoodsInfoTableViewCell.h"

@interface JMRefundDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)JMOrderCellData *model;
@property (weak, nonatomic) IBOutlet UILabel *createLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *caseLab;
@property (weak, nonatomic) IBOutlet UILabel *refundStatusLab;
@property (weak, nonatomic) IBOutlet UIButton *againBtn;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (nonatomic, strong)JMGoodsListView *goodsListView;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation JMRefundDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BG_COLOR;
       [self.view addSubview:self.tableView];
    if (_viewType == JMRefundDetailViewTypeWait) {
        self.refundStatusLab.text = @"等待商家处理";
        self.title = @"订单详情";
        [_btn2 setTitle:@"撤销申请" forState:UIControlStateNormal];
    }else if (_viewType == JMRefundDetailViewTypeRefuse) {
        self.refundStatusLab.text = @"商家拒绝退款";
        self.title = @"退款详情";
        [_btn2 setTitle:@"客服介入" forState:UIControlStateNormal];

    }
    
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Action

- (IBAction)consultHistory:(UIButton *)sender {
    
}

//联系卖家
- (IBAction)chatAction:(UIButton *)sender {
    NSString *user_id = [NSString stringWithFormat:@"%@b",self.model.shop_user_id];
    [JMCreatChatAction create4TypeChatRequstWithAccount:user_id];
    
}
//foreign_key = @"0";
//  chat_type = @"3";
//  recipient_mark = [NSString stringWithFormat:@"%@b",messagelistModel.service_id];
//  recipient_id = messagelistModel.service_id;
//  NSString *str_b = [NSString stringWithFormat:@"%@b",userModel.user_id];
//  NSString *str_a = [NSString stringWithFormat:@"%@a",userModel.user_id];
//  sender_mark = ([userModel.type isEqualToString:B_Type_UESR]) ? str_b : str_a;
//  [self createChatRequstWithType:chat_type foreign_key:foreign_key recipient:recipient_id sender_mark:sender_mark recipient_mark:recipient_mark model:messagelistModel];
//撤销申请 / 客服介入
- (IBAction)btn2Action:(UIButton *)sender {
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    NSString *service_id = kFetchMyDefault(@"service_id");
    NSString *recipient_mark = [NSString stringWithFormat:@"%@b",service_id];
    NSString *sender_mark = [NSString stringWithFormat:@"%@a",userModel.user_id];

    
    if (_viewType == JMRefundDetailViewTypeWait) {
        //撤销申请
        [self changOrderStatus:@"6" order_id:self.order_id];
    }else if (_viewType == JMRefundDetailViewTypeRefuse){
        //客服介入
        [JMCreatChatAction createServiceTypeChatRequstWithChat_type:@"3" foreign_key:@"0" user_id:service_id sender_mark:sender_mark recipient_mark:recipient_mark];
    }
    
}

//再次申请
- (IBAction)btn3Action:(UIButton *)sender {
//    JMApplyForRefundViewController *vc = [[JMApplyForRefundViewController alloc]init];
//    vc.model = self.model;
//    vc.viewType = JMApplyForRefundViewTypeRefund;
//    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - data
-(void)getData{
    [[JMHTTPManager sharedInstance]fectchOrderInfoWithOrder_id:self.order_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.model = [JMOrderCellData mj_objectWithKeyValues:responsObject[@"data"]];
  
            self.createLab.text = [NSString stringWithFormat:@"申请时间：%@",self.model.after_sale_created_at];
            self.priceLab.text = [NSString stringWithFormat:@"退款金额：¥ %@",self.model.pay_amount];
            if (self.model.after_sale_message.length > 0) {
                self.caseLab.text = [NSString stringWithFormat:@"退款原因：%@",self.model.after_sale_message];
                 
            }else{
                self.caseLab.text = @"退款原因：不喜欢/不想要";

            }
            [self.tableView reloadData];
     
//            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.mas_equalTo(self);
//                make.top.mas_equalTo(self.titleView.mas_bottom);
//                make.height.mas_equalTo(110*self.model.goods.count);
//            }];
//            self.goodsListView.goods = self.model.goods;
//            [self.view addSubview:self.goodsListView];
//            [self.goodsListView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.mas_equalTo(self);
//                make.top.mas_equalTo(self.titleView.mas_bottom);
//                make.height.mas_equalTo(110*self.model.goods.count);
//            }];
//            [self.view addSubview:self.detailView];
//            [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.right.mas_equalTo(self);
//                    make.top.mas_equalTo(self.goodsListView.mas_bottom);
//                    make.height.mas_equalTo(95);
//                }];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
        

}
    
-(void)changOrderStatus:(NSString *)status order_id:(NSString *)order_id{
    [[JMHTTPManager sharedInstance]changeOrderStatusWithOrder_id:order_id status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self.navigationController popViewControllerAnimated:YES];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.goods.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMGoodsInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMGoodsInfoTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setData:self.model.goods[indexPath.row]];

    // Configure the cell...
    return cell;
}
#pragma mark - lazy


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.titleView.frame.origin.y, SCREEN_WIDTH, 110) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"JMGoodsInfoTableViewCell" bundle:nil] forCellReuseIdentifier:JMGoodsInfoTableViewCellIdentifier];

    }
    return _tableView;
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
