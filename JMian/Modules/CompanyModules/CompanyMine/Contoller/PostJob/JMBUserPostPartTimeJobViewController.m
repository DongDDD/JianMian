//
//  JMBUserPostPartTimeJobViewController.m
//  JMian
//
//  Created by mac on 2019/6/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserPostPartTimeJobViewController.h"
#import "JMBUserPartTimeJobDetailView.h"
#import "JMPartTimeJobResumeFooterView.h"
#import "JMMakeOutBillView.h"
#import "JMMakeOutBillHeaderView.h"
#import "JMComfirmPostBottomView.h"
#import "JMCityListViewController.h"
#import "JMIndustryWebViewController.h"
#import "JMPartTimeJobTypeLabsViewController.h"

@interface JMBUserPostPartTimeJobViewController ()<JMPartTimeJobResumeFooterViewDelegate,JMMakeOutBillHeaderViewDelegate,JMBUserPartTimeJobDetailViewDelegate,JMCityListViewControllerDelegate,JMIndustryWebViewControllerDelegate>
@property(nonatomic, strong)JMBUserPartTimeJobDetailView *partTimeJobDetailView;
@property (strong, nonatomic)NSArray *leftTextArray;
@property (strong, nonatomic)UIScrollView *scrollView;
@property (nonatomic,strong)JMPartTimeJobResumeFooterView *decriptionTextView;
@property (nonatomic,strong)JMMakeOutBillView *makeOutBillView;
@property (nonatomic,strong)JMMakeOutBillHeaderView *makeOutBillHeaderView;
@property (nonatomic,strong)JMComfirmPostBottomView *comfirmPostBottomView;

//请求参数
@property (strong, nonatomic)NSString *task_title;//职位名称
@property (strong, nonatomic)NSString *unit;//计价单位
@property (strong, nonatomic)NSString *payment_money;//任务金额
@property (strong, nonatomic)NSString *quantity_max;//招募人数
@property (strong, nonatomic)NSMutableArray *industry_arr;//适合行业
@property (strong, nonatomic)NSString *city_id;//地区

//
@property (strong, nonatomic)NSString *cityName;//地区
@property (nonatomic,strong)NSString *labsJson;

@end

@implementation JMBUserPostPartTimeJobViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
    [self initLayout];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.comfirmPostBottomView.frame.origin.y+self.comfirmPostBottomView.frame.size.height+100);
}

-(void)initView{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.partTimeJobDetailView];//资料填写
    [self.scrollView addSubview:self.decriptionTextView];//职位描述
    [self.scrollView addSubview:self.makeOutBillHeaderView];//选择是否需要开发票
    [self.scrollView addSubview:self.makeOutBillView];//发票填写
    [self.scrollView addSubview:self.comfirmPostBottomView];//确认发布

}

-(void)initLayout{
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.partTimeJobDetailView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 446);
    self.decriptionTextView.frame = CGRectMake(0, _partTimeJobDetailView.frame.origin.y+_partTimeJobDetailView.frame.size.height, SCREEN_WIDTH, 222);
    self.makeOutBillHeaderView.frame = CGRectMake(0, _decriptionTextView.frame.origin.y+_decriptionTextView.frame.size.height, SCREEN_WIDTH, 106);
    self.makeOutBillView.frame = CGRectMake(0, _makeOutBillHeaderView.frame.origin.y+_makeOutBillHeaderView.frame.size.height, SCREEN_WIDTH, 314);
    self.comfirmPostBottomView.frame = CGRectMake(0, _makeOutBillView.frame.origin.y+_makeOutBillView.frame.size.height, SCREEN_WIDTH, 127);
}


#pragma mark - Delegate

- (void)sendlabsWithJson:(nonnull NSString *)json {
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arrayData = [self toArrayOrNSDictionary:data];
    NSLog(@"arrayData%@",arrayData);
    NSMutableArray *arrayName = [NSMutableArray array];//用于展示给用户
    _industry_arr = [NSMutableArray array];//用于提交服务器
    
    for (NSDictionary *dic in arrayData) {
        [arrayName addObject:dic[@"name"]];
        [_industry_arr addObject:dic[@"label_id"]];
    }
    NSLog(@"_industry_arr%@",_industry_arr);
    NSString *rightStr = [arrayName componentsJoinedByString:@","];
    [self.partTimeJobDetailView.industryBtn setTitle:rightStr forState:UIControlStateNormal];
    NSLog(@"_industry_arr%@",rightStr);

}

- (void)didSelectedCity_id:(nonnull NSString *)city_id city_name:(nonnull NSString *)city_name {
    _city_id = city_id;
    _cityName = city_name;
}

- (void)sendContent:(nonnull NSString *)content {
    
}

//信息填写DetailView点击事件
-(void)didClickRightBtnWithTag:(NSInteger)tag{
    switch (tag) {
        case 1000://职位类型
            [self gotoLabsVC];
            break;
        case 1001://任务有效期

            break;
        case 1002://发布城市
            [self gotoCityListVC];
            break;
        case 1003://招募人数
            
            break;
        case 1004://适合行业
            [self gotoIndustryVC];

            break;
        default:
            break;
    }
}

-(void)gotoLabsVC{
    JMPartTimeJobTypeLabsViewController *vc =  [[JMPartTimeJobTypeLabsViewController alloc]init];
//    vc.delegate = self;
    //    vc.labsJson = self.labsJson;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoIndustryVC{
    JMIndustryWebViewController *vc =  [[JMIndustryWebViewController alloc]init];
    vc.delegate = self;
//    vc.labsJson = self.labsJson;
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)gotoCityListVC{
    JMCityListViewController *vc =  [[JMCityListViewController alloc]init];
    vc.delegate = self;
    vc.viewType = JMCityListViewPartTime;
    [self.navigationController pushViewController:vc animated:YES];


}
//信息填写DetailView的textField
-(void)didWriteRightTextFieldWithtag:(NSInteger)tag text:(nonnull NSString *)text{
    switch (tag) {
        case 1000://职位名称
            _task_title = text;
            break;
        case 1001://基本工资
            _payment_money = text;
            break;
        case 1002://定金
            
            break;
        default:
            break;
    }

}

//是否需要开发票
-(void)didClickBillActionWithTag:(NSInteger)tag{

    switch (tag) {
        case 1000://需要
            [self.makeOutBillView setHidden:NO];
            [self changeMakeOutBillViewNeed];
            
            break;
        case 1001://不需要
            [self.makeOutBillView setHidden:YES];

            [self changeMakeOutBillViewNONeed];
            break;
        default:
            break;
    }

}

-(void)changeMakeOutBillViewNONeed{
    __weak typeof(self) ws = self;
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
      ws.comfirmPostBottomView.frame = CGRectMake(0, ws.makeOutBillHeaderView.frame.origin.y+ws.makeOutBillHeaderView.frame.size.height, SCREEN_WIDTH, 127);
    } completion:nil];

}

-(void)changeMakeOutBillViewNeed{
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.comfirmPostBottomView.frame = CGRectMake(0, ws.makeOutBillView.frame.origin.y+ws.makeOutBillView.frame.size.height, SCREEN_WIDTH, 127);
    } completion:nil];
  
}


-(JMBUserPartTimeJobDetailView *)partTimeJobDetailView{
    if (_partTimeJobDetailView == nil) {
        _partTimeJobDetailView = [[JMBUserPartTimeJobDetailView alloc]init];
        _partTimeJobDetailView.delegate = self;

    }
    return _partTimeJobDetailView;
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.backgroundColor = BG_COLOR;
    }
    return _scrollView;
}

- (JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(0, 350 , SCREEN_WIDTH, 229);
        _decriptionTextView.delegate = self;
        //        _decriptionTextView.contentTextView.delegate = self;
        
    }
    return _decriptionTextView;
}

- (JMMakeOutBillHeaderView *)makeOutBillHeaderView{
    if (_makeOutBillHeaderView == nil) {
        _makeOutBillHeaderView = [JMMakeOutBillHeaderView new];
        _makeOutBillHeaderView.delegate = self;
    
    }
    return _makeOutBillHeaderView;
}

- (JMMakeOutBillView *)makeOutBillView{
    if (_makeOutBillView == nil) {
        _makeOutBillView = [JMMakeOutBillView new];
//        _makeOutBillView.frame = CGRectMake(0, _makeOutBillHeaderView.frame.origin.y+_makeOutBillHeaderView.frame.size.height, SCREEN_WIDTH, 314);

    }
    return _makeOutBillView;
}

- (JMComfirmPostBottomView *)comfirmPostBottomView{
    if (_comfirmPostBottomView == nil) {
        _comfirmPostBottomView = [JMComfirmPostBottomView new];
        
    }
    return _comfirmPostBottomView;
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
