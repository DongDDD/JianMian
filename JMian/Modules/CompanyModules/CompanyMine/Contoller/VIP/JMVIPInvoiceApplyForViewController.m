//
//  JMVIPInvoiceApplyForViewController.m
//  JMian
//
//  Created by mac on 2019/7/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVIPInvoiceApplyForViewController.h"
#import "JMVIPInvoiceView.h"
#import "JMVIPInvoicePayTableViewCell.h"
#import "JMMakeOutBillView.h"
#import "JMInvoiceHeaderView.h"
#import "JMHTTPManager+OrderPay.h"
#import "JMOrderPaymentModel.h"
#import "JMHTTPManager+FectchInvoiceInfo.h"
#import "JMInvoiceModel.h"
//#import "WXApi.h"
#import "JMProtocalWebViewController.h"
#import <StoreKit/StoreKit.h>


@interface JMVIPInvoiceApplyForViewController ()<UITableViewDelegate,UITableViewDataSource,JMMakeOutBillViewDelegate,JMInvoiceHeaderViewDelegate,UITextFieldDelegate,JMVIPInvoicePayTableViewCellDelegate,SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong)JMVIPInvoiceView *vipInvoiceView;
@property (nonatomic, strong)JMMakeOutBillView *makeOutBillView;
@property (nonatomic, strong)JMInvoiceHeaderView *makeOutBillHeaderView;
@property (nonatomic, strong)JMInvoiceModel *invoiceModel;
@property (strong, nonatomic)JMOrderPaymentModel *orderPaymentModel;

@property (nonatomic, strong)UIView *footerView;
@property (nonatomic, copy)NSString *is_invoice;
@property (nonatomic, copy)NSString *invoice_title;
@property (nonatomic, copy)NSString *invoice_tax_number;
@property (nonatomic, copy)NSString *invoice_email;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *comfirmBtn;
@property (nonatomic, strong)NSArray *imagArr;
@property (nonatomic, strong)NSArray *labArr;
@property (nonatomic, copy)NSString *payName;

@property(nonatomic,strong)NSArray*products;

@end

@implementation JMVIPInvoiceApplyForViewController
static NSString *cellIdent = @"payCellIdent";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.view addSubview:self.makeOutBillHeaderView];
//    [self.makeOutBillHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.tableView.mas_bottom);
//    }];·
    self.title = @"确认支付";
    [self initView];
//    _imagArr = @[@"vvip"];
//    _labArr = @[@"购买一年VIP"];
    [self getInvoiceInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];

}
    
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //44.移除监听者
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

#pragma mark - UI
-(void)initView{
    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.mas_topLayoutGuideTop);
//        make.bottom.mas_equalTo(self.bottomView);
//        make.width.mas_equalTo(self.view);
//        make.centerX.mas_equalTo(self.view);
//    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-SafeAreaBottomHeight);
        make.height.mas_equalTo(80);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
    }];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(25,749.5,332.5,50);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:217/255.0 blue:151/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:202/255.0 blue:112/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    
    [self.bottomView.layer addSublayer:gl];

}

#pragma mark - data
//获取 -默认- 发票信息
-(void)getInvoiceInfo{
    
    [[JMHTTPManager sharedInstance]fectchInvoiceInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            _invoiceModel = [JMInvoiceModel mj_objectWithKeyValues:responsObject[@"data"]];
            
//            if (_viewType == JMBUserPostPartTimeJobTypeAdd) {//添加状态
                if (![responsObject[@"data"][@"invoice"] isEqual:[NSNull null]]) {
                    //                    [self setInvoiceValuesWithModel:_invoiceModel];
                    [self didClickBillActionWithTag:1000];
                    
                    
                }else{
                    [self didClickBillActionWithTag:1001];
                    
                }
                
//            }
        }
        
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}

- (void)getPayInfoData
{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    [self showProgressHUD_view:self.view];
    [[JMHTTPManager sharedInstance]fectchOrderPaymentInfoWithOrder_id:userModel.user_id  scenes:@"app" type:@"3" mode:@"3" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {            
            self.orderPaymentModel = [JMOrderPaymentModel mj_objectWithKeyValues:responsObject[@"data"]];
            if ([self.payName isEqualToString:@"微信DEMI001"]) {
                [self wechatPayWithModel:_orderPaymentModel];
            }else if ([self.payName isEqualToString:@"宝宝"]) {
                
            }

            [self hiddenHUD];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

- (void)wechatPayWithModel:(JMOrderPaymentModel *)model{
//    if([WXApi isWXAppInstalled])
//    {
//        PayReq* req = [[PayReq alloc] init];
//        req.partnerId = model.wx_partnerid;
//        req.prepayId = model.wx_prepayid;
//        req.nonceStr = model.wx_noncestr;
//        req.timeStamp = model.wx_timestamp;
//        req.package = model.wx_package;
//        req.sign = model.wx_sign;
//        [WXApi sendReq:req];
//    }else{
//    }
    
}


#pragma mark - actoin
-(void)protocalAction{
    NSLog(@"protocal");
    JMProtocalWebViewController *vc = [[JMProtocalWebViewController alloc]init];
    vc.viewType = JMProtocalWebNoPay;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)comfirmAction:(id)sender {
//    [self getPayInfoData];
//    NSString *product = self.profuctIdArr[sender.tag-100];

//    //1.� 加载plist文件(模拟想要销售的商品)
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"Withint.plist" ofType:nil];
//    NSArray *productsArray = [NSArray arrayWithContentsOfFile:path];
//    //2. 取出所有想要销售的商品productID
//    NSArray *productIDArray = [productsArray valueForKey:@"productID"];
//    //3. 将所有的product放在NSSet里面
//    NSSet *productIDSet = [NSSet setWithArray:productIDArray];
//    //4. 创建请求对象
//    SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:productIDSet];
//    //4.1 设置代理
//    request.delegate = self;
//    //5. 开始请求可销售的商品
//    [request start];
    
    if ([SKPaymentQueue canMakePayments]) {
        NSArray *arr = @[@"com.hanyue.JianMianTest6"];
        NSSet * set = [NSSet setWithArray:arr];
        SKProductsRequest * request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        request.delegate = self;
        [request start];
     }else{
        NSLog(@"失败,用户禁止应用内付费购买");
    }
    
}

    /**
     代理方法
     当请求到可销售的商品的时候,会调用此方法
     */
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response NS_AVAILABLE_IOS(3_0){
    NSLog(@"--%ld",response.products.count);
        for(SKProduct *product in response.products){
            NSLog(@"%@",product.localizedTitle);//名称
            NSLog(@"%@",product.localizedDescription);//描述
            NSLog(@"%@",product.price);//价格
            NSLog(@"%@",product.productIdentifier);//id
        }
    //1. 保留所有的可销售的产品
    self.products = response.products;
    SKPayment * payment = [SKPayment paymentWithProduct:self.products[0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}
    
/**
当交易队列当中 有交易状态发生改变的时候会执行该方法
*/
-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
/**
     SKPaymentTransactionStatePurchasing,//正在购买
     SKPaymentTransactionStatePurchased, //已经购买(向服务器发送请求 给用户请求 停止该交易)
     SKPaymentTransactionStateFailed,//购买失败
     SKPaymentTransactionStateRestored,//恢复购买成功(向服务器发送请求 给用户请求 停止该交易):换个手机登录此app
     SKPaymentTransactionStateDeferred//用户未决定最终状态(已经有票据)
*/
    //transactions是交易队列里面所有的交易
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
            NSLog(@"用户正在购买");
            break;
            case SKPaymentTransactionStatePurchased:
            NSLog(@"用户购买成功");
            [self completeTransaction:transaction];
            //1. 停止所有交易
            [queue finishTransaction:transaction];
            //2 .请求给用户商品
            break;
            case SKPaymentTransactionStateFailed:
            NSLog(@"用户正购买失败");
            break;
            case SKPaymentTransactionStateRestored:
            NSLog(@"用户恢复购买成功");
            //1. 停止所有交易
            [queue finishTransaction:transaction];
            //2 .请求给用户商品
            break;
            case SKPaymentTransactionStateDeferred:
            NSLog(@"用户未决定最终状态");
            break;
            default:
            break;
        }
    }
}
    
//交易完成后的操作
-(void)completeTransaction:(SKPaymentTransaction *)transaction{
    
//    NSString *productIdentifier = transaction.payment.productIdentifier;
//    NSData *transactionReceiptData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
//    NSString *receipt = [transactionReceiptData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];

    NSLog(@"向自己的服务器验证购买凭证receiptData%@",receiptData);

    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *receipt_data = [receiptData base64EncodedStringWithOptions:0];
    NSString *StrData = [self toArrayOrNSDictionary:receiptData];
    NSLog(@"向自己的服务器验证购买凭证StrData%@",StrData);
    NSLog(@"向自己的服务器验证购买凭证receipt_data%@",receipt_data);

    NSLog(@"向自己的服务器验证购买凭证%@",encodeStr);

//    if ([productIdentifier length]>0) {
//        //向自己的服务器验证购买凭证
//        NSLog(@"向自己的服务器验证购买凭证%@",receipt);
//    }
    
    //移除transaction购买操作
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

//交易失败后的操作
-(void)failedTransaction:(SKPaymentTransaction *)transaction{
    
    if (transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"购买失败");
    }else{
        NSLog(@"用户取消交易");
    }
    //移除transaction购买操作
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)successfulPurchaseOfId:(NSString *)productID andReceipt:(NSData *)transactionReceipt{
    NSLog(@"successfulPurchaseOfId");

}
#pragma mark - Mydelegate

//是否需要开发票
-(void)didClickBillActionWithTag:(NSInteger)tag{
    switch (tag) {
        case 1000://需要发票
        [self.makeOutBillView setHidden:NO];
        [self changeMakeOutBillViewNeed];
        [_makeOutBillHeaderView.NOBtn setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
        [_makeOutBillHeaderView.YESBtn setImage:[UIImage imageNamed:@"组 54"] forState:UIControlStateNormal];
        self.is_invoice = @"1";
        //判断是否有写好的默认发票信息
        if (_invoiceModel) {
            [_makeOutBillView.invoiceTitleTextField setText:_invoiceModel.invoice_title];
            [_makeOutBillView.invoiceTaxNumTextField setText:_invoiceModel.invoice_tax_number];
            [_makeOutBillView.invoiceEmailTextField setText:_invoiceModel.invoice_email];
            _invoice_title = _invoiceModel.invoice_title;
            _invoice_tax_number = _invoiceModel.invoice_tax_number;
            _invoice_email = _invoiceModel.invoice_email;
        }
        [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];//恢复全部的购买
        
        break;
        case 1001://不需要发票
        [self.makeOutBillView setHidden:YES];
        [self changeMakeOutBillViewNONeed];
        [_makeOutBillHeaderView.NOBtn setImage:[UIImage imageNamed:@"组 54"] forState:UIControlStateNormal];
        [_makeOutBillHeaderView.YESBtn setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
        self.is_invoice = @"0";
        
        break;
        default:
        break;
    }
    
}

-(void)invoiceTextFieldDidEditingEndWithTextField:(UITextField *)textField{
    
    switch (textField.tag) {
        case 100:
            _invoice_title = textField.text;
            break;
        case 101:
            _invoice_tax_number = textField.text;
            break;
        case 102:
            _invoice_email = textField.text;
            break;
            
        default:
            break;
    }
    
}

-(void)changeMakeOutBillViewNONeed{
 
    [self.makeOutBillView setHidden:YES];
    
}

-(void)changeMakeOutBillViewNeed{
    [self.makeOutBillView setHidden:NO];

    
}

-(void)didChoosePayWayWithPayName:(NSString *)payName{
    _payName = payName;

}

#pragma mark - textFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _imagArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //重用单元格
    JMVIPInvoicePayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    //初始化单元格
    if(cell == nil)
    {
        cell = [[JMVIPInvoicePayTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
        //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
    }
    cell.delegate = self;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.iconImageView.image = [UIImage imageNamed:_imagArr[indexPath.row]];
    cell.titleNameLab.text = _labArr[indexPath.row];
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 45;
}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 309;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"支付即同意《“得米”平台用户服务协议》" forState:UIControlStateNormal];
    btn.titleLabel.font = kFont(13);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:177/255.0 blue:50/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(protocalAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).mas_offset(20);
        make.centerY.mas_equalTo(view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(45);
        
    }];
//    UILabel *titleLab = [[UILabel alloc]init];
//    titleLab.backgroundColor = [UIColor whiteColor];
//    titleLab.text = @"选择支付方式";
//    titleLab.font = kFont(14);
//    titleLab.textColor = TITLE_COLOR;
//    [view addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(view).offset(20);
//        make.bottom.mas_equalTo(view).mas_offset(-20);
//
//    }];
    
    return view;
}

#pragma mark - getter

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-100) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 83.0f;
        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.vipInvoiceView;
        _tableView.tableFooterView = self.footerView;
//        _tableView.sectionFooterHeight = 309;
//        _tableView.sectionHeaderHeight = 45;
        [self.tableView registerNib:[UINib nibWithNibName:@"JMVIPInvoicePayTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
        
    }
    return _tableView;
    
}

-(JMVIPInvoiceView *)vipInvoiceView{
    if (!_vipInvoiceView) {
        _vipInvoiceView = [[JMVIPInvoiceView alloc]init];
        
    }
    return _vipInvoiceView;
}


- (JMInvoiceHeaderView *)makeOutBillHeaderView{
    if (_makeOutBillHeaderView == nil) {
        _makeOutBillHeaderView = [JMInvoiceHeaderView new];
        _makeOutBillHeaderView.delegate = self;
        
    }
    return _makeOutBillHeaderView;
}

- (JMMakeOutBillView *)makeOutBillView{
    if (_makeOutBillView == nil) {
        _makeOutBillView = [JMMakeOutBillView new];
        _makeOutBillView.invoiceTitleTextField.delegate = self;
        _makeOutBillView.invoiceTaxNumTextField.delegate = self;
        _makeOutBillView.invoiceEmailTextField.delegate = self;
        _makeOutBillView.delegate = self;
    }
    return _makeOutBillView;
}

-(UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 309)];
//        _footerView.backgroundColor = BG_COLOR;
        [_footerView addSubview:self.makeOutBillHeaderView];
        [self.makeOutBillHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_footerView);
            make.width.mas_equalTo(_footerView);
            make.centerX.mas_equalTo(_footerView);
            make.height.mas_equalTo(55);
        }];
        [self.footerView addSubview:self.makeOutBillView];
        [self.makeOutBillView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_makeOutBillHeaderView.mas_bottom);
            make.width.mas_equalTo(_footerView);
            make.centerX.mas_equalTo(_footerView);
            make.height.mas_equalTo(190);
        }];
        
    }
    return _footerView;
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
