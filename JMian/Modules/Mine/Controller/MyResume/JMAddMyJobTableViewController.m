//
//  JMAddMyJobTableViewController.m
//  JMian
//
//  Created by mac on 2019/5/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMAddMyJobTableViewController.h"
#import "DimensMacros.h"
#import "PositionDesiredViewController.h"
#import "JMCityListViewController.h"
#import "JMHTTPManager+Vita.h"
#import "JMHTTPManager+Job.h"
#import "TwoButtonView.h"
#import "DimensMacros.h"
#import "JMBottom2View.h"
#import "STPickerSingle.h"


@interface JMAddMyJobTableViewController ()<JMCityListViewControllerDelegate,PositionDesiredDelegate,UIPickerViewDelegate,UIPickerViewDataSource,JMBottom2ViewDelegate,STPickerSingleDelegate>

@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSMutableArray *rightTextArray;
//@property(nonatomic,strong) NSArray *pickerArray;
//@property (strong, nonatomic) UIPickerView *pickerView;

@property (nonatomic, copy) NSString *user_job_id;
@property (nonatomic, copy) NSString *job_labelID;
@property (nonatomic, copy) NSString *salaryMin;
@property (nonatomic, copy) NSString *salaryMax;
@property (nonatomic, copy)NSString *city_id;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (strong, nonatomic) JMBottom2View *bottomView;
@property (nonatomic, strong) STPickerSingle *salaryPickerSingle;
@property (nonatomic, assign)BOOL isChange;
@end

@implementation JMAddMyJobTableViewController
static NSString *cellIdent = @"cellIdent";

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"期望职位",@"薪资要求",@"工作城市"];
//    _pickerArray = @[@"1k-2k",
//                     @"2k-4k",
//                     @"4k-6k",
//                     @"6k-8k",
//                     @"8k-10k",
//                     @"10k-15k",
//                     @"15k-20k",
//                     @"20k-30k",
//                     @"30k-40k",
//                     @"40k-50k",
//                     @"50k-100k",
//                     ];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (_viewType == JMAddMyJobTableViewTypeAdd) {
        [self setRightBtnTextName:@"添加"];
        self.title =@"新增期望职位";

    }else if (_viewType == JMAddMyJobTableViewTypeEdit){
        self.title =@"编辑期望职位";
        [self setRightBtnTextName:@"保存"];
    
    }
    [self.view addSubview:self.bottomView];

    [self setBackBtnImageViewName:@"icon_return_nav" textName:@""];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}



- (void)setBackBtnImageViewName:(NSString *)imageName textName:(NSString *)textName{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 19)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 21);
    [leftBtn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(leftBtn.frame.origin.x+leftBtn.frame.size.width-5, 0, 100,leftBtn.frame.size.height)];
    leftLab.text = textName;
    leftLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    leftLab.font = [UIFont systemFontOfSize:13];
    
    [bgView addSubview:leftLab];
    [bgView addSubview:leftBtn];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}


-(void)setRightBtnTextName:(NSString *)rightLabName{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:rightLabName forState:UIControlStateNormal];
    [rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

//-(void)setPickerVIewUI{
//    self.pickerView = [[UIPickerView alloc]init];
//    self.pickerView.backgroundColor = BG_COLOR;
//    self.pickerView.delegate = self;
//
//    self.pickerView.dataSource = self;
//
//    [self.view addSubview:self.pickerView];
//
////    self.pickerView.hidden = YES;
//
////    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.and.right.equalTo(self.view);
////        make.height.mas_equalTo(180);
////        make.bottom.mas_equalTo(self.view.mas_bottom);
////    }];
////
//
//}

-(void)rightAction{
    if (_viewType == JMAddMyJobTableViewTypeAdd) {
        [self addJobRequest];
    }else if (_viewType == JMAddMyJobTableViewTypeEdit){
        [self updateJobResquest];
    }
    
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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你没有任何修改"
                                                      delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
        
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

-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(NSMutableArray *)setSalaryRangeWithSalaryStr:(NSString *)salaryStr{
    NSArray *array = [salaryStr componentsSeparatedByString:@"-"]; //从字符 - 中分隔成2个元素的数组
    
    NSString *minStr = array[0];
    NSString *maxStr = array[1];

    NSString *string1 = [minStr stringByReplacingOccurrencesOfString:@"k"withString:@"000"];
    NSString *string2 = [maxStr stringByReplacingOccurrencesOfString:@"k"withString:@"000"];
   
    
    NSMutableArray *arrayMinMax = [NSMutableArray arrayWithObjects:string1,string2,nil];
    
    return arrayMinMax;
    
}

-(NSString *)getSalaryKWithStr:(NSString *)str{
    NSInteger salaryInt = [str integerValue];
    NSInteger salaryInt2 = salaryInt/1000;
    NSString *salaryStr = [NSString stringWithFormat:@"%ldk",(long)salaryInt2];
    return salaryStr;
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

//返回有几列

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}

//返回指定列的行数
//
//-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//
//{
//
//    return [self.pickerArray count];
//
//}
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//
//    NSString *str = [self.pickerArray objectAtIndex:row];
//
//    return str;
//
//}


//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    _isChange = YES;
//    [self.rightTextArray replaceObjectAtIndex:1 withObject:self.pickerArray[row]];
//    NSMutableArray *array = [self setSalaryRangeWithSalaryStr:self.pickerArray[row]];
//    self.salaryMin = array[0];
//    self.salaryMax = array[1];
//    [self.tableView reloadData];
//
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    self.pickerView.hidden = YES;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

-(JMBottom2View *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[JMBottom2View alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 74)];
//        _bottomView.backgroundColor = MASTER_COLOR;
        _bottomView.delegate = self;
    }

    return _bottomView;
}

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
                                         @"50k-100K",nil];
    }
    return _salaryPickerSingle;
}
@end
