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
#import "JMHTTPManager+CreateTask.h"
#import "JMHTTPManager+FectchTaskInfo.h"
#import "JMTaskPartTimejobDetailModel.h"
#import "JMTaskGoodsDetailModel.h"
#import "JMHTTPManager+UpdateTask.h"
#import "JMHTTPManager+DeleteTask.h"

#define RightTITLE_COLOR [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]
@interface JMBUserPostPartTimeJobViewController ()<JMPartTimeJobResumeFooterViewDelegate,JMMakeOutBillHeaderViewDelegate,JMBUserPartTimeJobDetailViewDelegate,JMCityListViewControllerDelegate,JMIndustryWebViewControllerDelegate,JMPartTimeJobTypeLabsViewControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,JMComfirmPostBottomViewDelegate,UIScrollViewDelegate>
@property(nonatomic, strong)JMBUserPartTimeJobDetailView *partTimeJobDetailView;
@property (strong, nonatomic)NSArray *leftTextArray;
@property (strong, nonatomic)UIScrollView *scrollView;
@property (nonatomic,strong)JMPartTimeJobResumeFooterView *decriptionTextView;
@property (nonatomic,strong)JMMakeOutBillView *makeOutBillView;
@property (nonatomic,strong)JMMakeOutBillHeaderView *makeOutBillHeaderView;
@property (nonatomic,strong)JMComfirmPostBottomView *comfirmPostBottomView;
@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,strong)NSArray *quantityArray;;
@property (nonatomic,strong)UIDatePicker *dataPickerView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic ,assign)BOOL isChange;

//请求参数
@property (copy, nonatomic)NSString *type_label_id;//职位ID
@property (copy, nonatomic)NSString *task_title;//职位名称
@property (copy, nonatomic)NSString *unit;//计价单位
@property (copy, nonatomic)NSString *payment_money;//任务金额
@property (copy, nonatomic)NSString *quantity_max;//招募人数
@property (strong, nonatomic)NSMutableArray *industry_arr;//适合行业
@property (copy, nonatomic)NSString *city_id;//地区
@property (copy, nonatomic)NSString *myDecription;//职位描述
@property (copy, nonatomic)NSString *deadline;//有效日期

//
@property (copy, nonatomic)NSString *cityName;//地区
@property (nonatomic,copy)NSString *labsJson;
@property (assign, nonatomic)BOOL isReadProtocol;//是否阅读了协议

@end

@implementation JMBUserPostPartTimeJobViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
    [self initLayout];
    self.title = @"发布兼职";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePickView)];
    [self.view addGestureRecognizer:tap];
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
    if (self.task_id) {
        [self getData];
        self.bottomView.hidden = NO;
        [self.view addSubview:self.bottomView];
        [self.comfirmPostBottomView setHidden:YES];
    }

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
-(void)didChooseWithType_id:(NSString *)type_id typeName:(NSString *)typeName{
    _isChange = YES;
    _type_label_id = type_id;
    [self.partTimeJobDetailView.jobTypeBtn setTitle:typeName forState:UIControlStateNormal];
    [self.partTimeJobDetailView.jobTypeBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];

}

- (void)sendlabsWithJson:(nonnull NSString *)json {
    _isChange = YES;

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
    [self.partTimeJobDetailView.industryBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];

    NSLog(@"_industry_arr%@",rightStr);

}

- (void)didSelectedCity_id:(nonnull NSString *)city_id city_name:(nonnull NSString *)city_name {
    _isChange = YES;

    _city_id = city_id;
    [self.partTimeJobDetailView.cityBtn setTitle:city_name forState:UIControlStateNormal];
    [self.partTimeJobDetailView.cityBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
}

- (void)sendContent:(nonnull NSString *)content {
    _isChange = YES;

    _myDecription = content;
}

//信息填写DetailView点击事件
-(void)didClickRightBtnWithTag:(NSInteger)tag{
    switch (tag) {
        case 1000://职位类型
            [self gotoLabsVC];
            break;
        case 1001://任务有效期
            [self showDataPickView];
            break;
        case 1002://发布城市
            [self gotoCityListVC];
            break;
        case 1003://招募人数
            [self showPickView];
            break;
        case 1004://适合行业
            [self gotoIndustryVC];

            break;
        default:
            break;
    }
}

//信息填写DetailView的textField
-(void)didWriteRightTextFieldWithtag:(NSInteger)tag text:(nonnull NSString *)text{
    _isChange = YES;

    switch (tag) {
        case 100://职位名称
            _task_title = text;
            break;
        case 101://基本工资
            _payment_money = text;
            break;
        case 102://定金
            
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

-(void)gotoLabsVC{
    JMPartTimeJobTypeLabsViewController *vc =  [[JMPartTimeJobTypeLabsViewController alloc]init];
    vc.delegate = self;
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


- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    _deadline = dateStr;
    [self.partTimeJobDetailView.deadLineBtn setTitle:dateStr forState:UIControlStateNormal];
    [self.partTimeJobDetailView.deadLineBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
   

 }

////字符串转时间
//- (NSDate *)nsstringConversionNSDate:(NSString *)dateStr
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSDate *datestr = [dateFormatter dateFromString:dateStr];
//    return datestr;
//}

-(void)showDataPickView{
    [self.view addSubview:self.dataPickerView];
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.dataPickerView.frame = CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350);
    } completion:nil];
    
    
}

-(void)hidePickView{
    
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.dataPickerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350);
    } completion:nil];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.pickerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350);
    } completion:nil];
}


-(void)showPickView{
    [self.view addSubview:self.pickerView];
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.pickerView.frame = CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350);
    } completion:nil];
    

}

-(void)isReadProtocol:(BOOL)isRead{

    if (!isRead) {
        [self.comfirmPostBottomView.OKBtn setBackgroundColor:TEXT_GRAY_COLOR];
        self.isReadProtocol = NO;

    }else{
        [self.comfirmPostBottomView.OKBtn setBackgroundColor:MASTER_COLOR];
        self.isReadProtocol = YES;
    }

}
#pragma mark - ScrollViewdelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.partTimeJobDetailView.jobNameTextField resignFirstResponder];
    [self.partTimeJobDetailView.paymentMoneyTextField resignFirstResponder];
    [self.partTimeJobDetailView.downPaymentTextField resignFirstResponder];
    [self.decriptionTextView.contentTextView resignFirstResponder];
    [self hidePickView];
}

#pragma mark - 赋值
-(void)setRightBtnValues_model:(JMTaskPartTimejobDetailModel *)model{
    [self.partTimeJobDetailView.jobTypeBtn setTitle:model.type_labelName forState:UIControlStateNormal];
    [self.partTimeJobDetailView.jobTypeBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
    [self.partTimeJobDetailView.jobNameTextField setText:model.task_title];
    
    [self.partTimeJobDetailView.paymentMoneyTextField setText:model.payment_money];
    [self.partTimeJobDetailView.cityBtn setTitle:model.cityName forState:UIControlStateNormal];
    [self.partTimeJobDetailView.cityBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
    [self.partTimeJobDetailView.deadLineBtn setTitle:model.deadline forState:UIControlStateNormal];
    [self.partTimeJobDetailView.deadLineBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    [self.partTimeJobDetailView.quantityMaxBtn setTitle:model.quantity_max forState:UIControlStateNormal];
    [self.partTimeJobDetailView.quantityMaxBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    
    
    NSMutableArray *industryNameArray = [NSMutableArray array];
    for (JMTaskIndustryModel *industryModel in model.industry) {
        [industryNameArray addObject:industryModel.name];
    }
    NSString *industry = [industryNameArray componentsJoinedByString:@","];
    [self.partTimeJobDetailView.industryBtn setTitle:industry forState:UIControlStateNormal];
    [self.partTimeJobDetailView.industryBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];

}

#pragma mark - 确认发布 提交数据

-(void)OKAction{
    if (self.isReadProtocol == YES) {
        [self.decriptionTextView.contentTextView resignFirstResponder];
        [self sendRequest];
        
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请阅读并同意《平台服务协议》" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
  
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    
    }

}

-(void)sendRequest{
    [[JMHTTPManager sharedInstance]createTask_task_title:_task_title type_label_id:_type_label_id payment_method:@"3" unit:@"元" payment_money:_payment_money front_money:nil quantity_max:_quantity_max myDescription:_myDecription industry_arr:_industry_arr city_id:_city_id longitude:nil latitude:nil address:nil goods_title:nil goods_price:nil goods_desc:nil video_path:nil video_cover:nil image_arr:nil deadline:_deadline status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

- (IBAction)bottomLeftAction:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除吗" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self deleteTaskRequest];
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)bottomRightAction:(UIButton *)sender {
    [self updateTaskInfoRequest];
}

-(void)deleteTaskRequest{
    [[JMHTTPManager sharedInstance]deleteTask_Id:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"下线成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}
//更新任务请求
-(void)updateTaskInfoRequest{
    if (_isChange) {
        [[JMHTTPManager sharedInstance]updateTaskWithId:self.task_id payment_method:@"3" unit:@"元" payment_money:_payment_money front_money:nil quantity_max:_quantity_max myDescription:nil industry_arr:_industry_arr city_id:_city_id longitude:nil latitude:nil address:nil goods_title:nil goods_price:nil goods_desc:nil video_path:nil video_cover:nil image_arr:nil status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"任务更新成功" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }])];
            [self presentViewController:alertController animated:YES completion:nil];
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有任何改动" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}


#pragma mark - 获取数据
-(void)getData{
    [[JMHTTPManager sharedInstance]fectchTaskInfo_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            JMTaskPartTimejobDetailModel *model = [JMTaskPartTimejobDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
            //赋值
            [self setRightBtnValues_model:model];
            
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
}



#pragma mark pickerview function



//返回有几列

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}

//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_quantityArray count];
}

//显示的标题

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [_quantityArray objectAtIndex:row];
    
    return str;
    
}

//被选择的行

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [self.partTimeJobDetailView.quantityMaxBtn setTitle: [_quantityArray objectAtIndex:row] forState:UIControlStateNormal];
    [self.partTimeJobDetailView.quantityMaxBtn setTitleColor:RightTITLE_COLOR forState:UIControlStateNormal];
    self.quantity_max = [_quantityArray objectAtIndex:row];
    NSLog(@"_quantity%@",[_quantityArray objectAtIndex:row]);
    
}


#pragma mark - Getter

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.backgroundColor = BG_COLOR;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(JMBUserPartTimeJobDetailView *)partTimeJobDetailView{
    if (_partTimeJobDetailView == nil) {
        _partTimeJobDetailView = [[JMBUserPartTimeJobDetailView alloc]init];
        _partTimeJobDetailView.delegate = self;

    }
    return _partTimeJobDetailView;
}


- (JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(0, 350 , SCREEN_WIDTH, 229);
        _decriptionTextView.viewType = JMPartTimeJobResumeFooterViewTypeDefault;
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
        _comfirmPostBottomView.delegate = self;
        
    }
    return _comfirmPostBottomView;
}

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350)];
        _pickerView.backgroundColor = BG_COLOR;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _quantityArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    }
    return _pickerView;
}

-(UIDatePicker *)dataPickerView{
    if (!_dataPickerView) {
        _dataPickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350)];
        _dataPickerView.backgroundColor = BG_COLOR;
        //设置地区: zh-中国
        _dataPickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        
        //设置日期模式(Displays month, day, and year depending on the locale setting)
        _dataPickerView.datePickerMode = UIDatePickerModeDate;
        // 设置当前显示时间
        [_dataPickerView setDate:[NSDate date] animated:YES];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
//        [comps setYear:0];
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        //设置最小时间为：
        [_dataPickerView setMinimumDate:minDate];
        //设置时间格式
        
        //监听DataPicker的滚动
        [_dataPickerView addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _dataPickerView;
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
