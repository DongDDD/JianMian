//
//  JMAddVitaJobViewController.m
//  JMian
//
//  Created by mac on 2019/6/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMAddVitaJobViewController.h"
#import "DimensMacros.h"
#import "PositionDesiredViewController.h"
#import "JMCityListViewController.h"
#import "JMHTTPManager+Vita.h"
#import "JMHTTPManager+Job.h"
#import "DimensMacros.h"
#import "STPickerSingle.h"

@interface JMAddVitaJobViewController ()<UITableViewDelegate,UITableViewDataSource,JMCityListViewControllerDelegate,PositionDesiredDelegate,STPickerSingleDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSMutableArray *rightTextArray;
//@property(nonatomic,strong) NSArray *pickerArray;
//@property (strong, nonatomic) UIPickerView *pickerView;

@property (nonatomic, copy) NSString *user_job_id;
@property (nonatomic, copy) NSString *job_labelID;
@property (nonatomic, copy) NSString *salaryMin;
@property (nonatomic, copy) NSString *salaryMax;
@property (nonatomic, copy)NSString *city_id;
@property (weak, nonatomic) IBOutlet UIView *myBottomView;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
//@property (strong, nonatomic) JMBottom2View *bottomView;
@property (nonatomic, strong) STPickerSingle *salaryPickerSingle;
@property (nonatomic, assign)BOOL isChange;
@end
static NSString *cellIdent = @"cellIdent";

@implementation JMAddVitaJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"期望职位",@"薪资要求",@"工作城市"];
    
    if (_viewType == JMAddVitaJobViewTypeAdd) {
        [self setRightBtnTextName:@"添加"];
        self.title =@"新增期望职位";
        [self.myBottomView setHidden:YES];
        
    }else if (_viewType == JMAddVitaJobViewTypeEdit){
        self.title =@"编辑期望职位";
        [self setRightBtnTextName:@"保存"];
        [self.myBottomView setHidden:NO];

        
    }
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.myBottomView];
    
    [self setBackBtnImageViewName:@"icon_return_nav" textName:@""];

    // Do any additional setup after loading the view from its nib.
}
#pragma mark - action

-(void)rightAction{
    if (_viewType == JMAddVitaJobViewTypeAdd) {
        [self addJobRequest];
    }else if (_viewType == JMAddVitaJobViewTypeEdit){
        [self updateJobResquest];
    }
    
}

-(void)deleteJobRequest{
    [self.view addSubview:self.progressHUD];
    [[JMHTTPManager sharedInstance]deleteJobInfoWithId:self.user_job_id SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self.progressHUD setHidden:YES];
        [self.navigationController popViewControllerAnimated:YES];
        [self showAlertSimpleTips:@"提示" message:@"已删除" btnTitle:@"哦"];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

-(void)addJobRequest{
    if (_isChange) {
        [self.view addSubview:self.progressHUD];
        
        [[JMHTTPManager sharedInstance]addJobInfoWithJob_label_id:self.job_labelID industry_label_id:nil city_id:_city_id salary_min:_salaryMin salary_max:_salaryMax status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            [self.navigationController popViewControllerAnimated:YES];
            [self.progressHUD setHidden:YES];
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }else{

        [self showAlertSimpleTips:@"提示" message:@"没有任何修改" btnTitle:@"哦"];
        
    }
    
}

-(void)updateJobResquest{
    if (_isChange) {
        [[JMHTTPManager sharedInstance]updateJobWith_user_job_id:self.user_job_id job_label_id:_job_labelID industry_label_id:nil city_id:_city_id salary_min:_salaryMin salary_max:_salaryMax status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"保存成功"
                                                          delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你没有任何修改"
                                                      delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
        
    }
    
}

- (IBAction)deleteAction:(UIButton *)sender {
    [self deleteJobRequest];
}

- (IBAction)saveAction:(id)sender {
    [self rightAction];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    //    JMHomeWorkModel *model = self.choosePositionArray[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.detailTextLabel.text = self.rightTextArray[indexPath.row];
    cell.detailTextLabel.textColor = TITLE_COLOR;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //    cell.detailTextLabel.textColor = TEXT_GRAY_COLOR;
    //    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    //
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        PositionDesiredViewController *vc = [PositionDesiredViewController new];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        //        [self.view addSubview:self.pickerView];
        //        [self.pickerView setHidden:NO];
        [self.view addSubview:self.salaryPickerSingle];
        [self.salaryPickerSingle show];
        
        
    }else{
        JMCityListViewController *vc = [JMCityListViewController new];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}



#pragma mark - PickerViewDelegate
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle row:(NSInteger)row{
    _isChange = YES;
    [self.rightTextArray replaceObjectAtIndex:1 withObject:selectedTitle];
    NSMutableArray *array = [self setSalaryRangeWithSalaryStr:selectedTitle];
    self.salaryMin = array[0];
    self.salaryMax = array[1];
    [self.tableView reloadData];
    
}

- (void)didSelectedCity_id:(nonnull NSString *)city_id city_name:(nonnull NSString *)city_name{
    if (city_id) {
        [self.rightTextArray replaceObjectAtIndex:2 withObject:city_name];
        _isChange = YES;
        self.city_id = city_id;
        [self.tableView reloadData];
    }
    
}

- (void)sendPositoinData:(NSString * _Nullable)labStr labIDStr:(NSString * _Nullable)labIDStr {
    if (labIDStr) {
        _isChange = YES;
        [self.rightTextArray replaceObjectAtIndex:0 withObject:labStr];
        self.job_labelID = labIDStr;
        [self.tableView reloadData];
    }
    
}

#pragma mark - lazy

-(NSMutableArray *)rightTextArray{
    if (_rightTextArray == nil) {
        if (self.model) {
            NSString *str1 = self.model.work_name;
            NSString *str2 = [NSString stringWithFormat:@"%@~%@",
                              [self getSalaryKWithStr:self.model.salary_min],
                              [self getSalaryKWithStr:self.model.salary_max]];
            NSString *str3;
            
            _job_labelID = self.model.job_label_id;
            _salaryMin = self.model.salary_min;
            _salaryMax = self.model.salary_max;
            _user_job_id = self.model.user_job_id;
            
            if (self.model.city_city_name) {
                str3 = self.model.city_city_name;
                _city_id = self.model.city_id;
            }else{
                
                str3=@"请选择";
                
            }
            _rightTextArray = [NSMutableArray arrayWithObjects:str1,str2,str3, nil];
            
        }else{
            
            _rightTextArray = [NSMutableArray arrayWithObjects:@"请选择",@"请选择",@"请选择", nil];
            
        }
        
    }
    return _rightTextArray;
}

//-(UIPickerView *)pickerView{
//    if (_pickerView == nil) {
//
//        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-300, SCREEN_WIDTH, 300)];
//        _pickerView.backgroundColor = BG_COLOR;
//        _pickerView.delegate = self;
//        _pickerView.dataSource = self;
//
//
//    }
//
//    return _pickerView;
//}

-(MBProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.progress = 0.6;
        _progressHUD.dimBackground = NO; //设置有遮罩
        [_progressHUD showAnimated:YES]; //显示进度框
    }
    return _progressHUD;
}

//-(JMBottom2View *)bottomView{
//    if (_bottomView == nil) {
//        _bottomView = [[JMBottom2View alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 74)];
//        //        _bottomView.backgroundColor = MASTER_COLOR;
//        _bottomView.delegate = self;
//    }
//
//    return _bottomView;
//}

-(STPickerSingle *)salaryPickerSingle{
    if (_salaryPickerSingle == nil) {
        _salaryPickerSingle = [[STPickerSingle alloc]init];
        _salaryPickerSingle.delegate = self;
        _salaryPickerSingle.title = @"薪资要求";
        _salaryPickerSingle.widthPickerComponent = 200;
        _salaryPickerSingle.arrayData = [NSMutableArray arrayWithObjects:@"1k-2k",
                                         @"2k-4k",
                                         @"4k-6k",
                                         @"6k-8k",
                                         @"8k-10k",
                                         @"10k-15k",
                                         @"15k-20k",
                                         @"20k-30k",
                                         @"30k-40k",
                                         @"40k-50k",
                                         @"50k-100k",nil];
    }
    return _salaryPickerSingle;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;

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
