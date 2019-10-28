//
//  JMPostNewJobViewController.m
//  JMian
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostNewJobViewController.h"
#import "JMJobDescriptionViewController.h"
#import "JMWelfareViewController.h"
#import "JMManageInterviewViewController.h"
#import "JMHTTPManager+Work.h"
#import "PositionDesiredViewController.h"
#import "JMGetCompanyLocationViewController.h"
#import "STPickerSingle.h"
#import "JMHTTPManager+Work.h"



@interface JMPostNewJobViewController ()<UIPickerViewDelegate,UIScrollViewDelegate,JMWelfareDelegate,PositionDesiredDelegate,JMJobDescriptionDelegate,JMGetCompanyLocationViewControllerDelegate,UITextFieldDelegate,STPickerSingleDelegate>

@property(nonatomic,strong)JMHomeWorkModel *homeworkModel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *workNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *workNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *workPropertyBtn;
@property (weak, nonatomic) IBOutlet UIButton *expriencesBtn;
@property (weak, nonatomic) IBOutlet UIButton *educationBtn;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) STPickerSingle *expPickerSingle;
@property (nonatomic, strong) STPickerSingle *educationPickerSingle;
@property (nonatomic, strong) STPickerSingle *salaryPickerSingle;
@property (weak, nonatomic) IBOutlet UIButton *salaryBtn;
@property (weak, nonatomic) IBOutlet UIButton *welfareBtn;
@property (nonatomic,strong)UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UIButton *workLocationBtn;
@property (nonatomic, strong)AMapPOI *POIModel;
@property (weak, nonatomic) IBOutlet UIButton *jobDescriptionBtn;
@property (nonatomic, strong)NSArray *pickerArray;
@property (nonatomic, copy)NSString *pickerStr;
@property (nonatomic, assign)NSUInteger pickerRow;


//参数
@property (nonatomic,copy)NSString *work_label_id;
@property (nonatomic,copy)NSString *educationNum;
@property (nonatomic,copy)NSString *salaryMin;
@property (nonatomic,copy)NSString *salaryMax;
@property (nonatomic,copy)NSString *expriencesMin;
@property (nonatomic,copy)NSString *expriencesMax;
@property (nonatomic,copy)NSString *jobDescriptionStr;
@property (nonatomic,copy)NSString *latitude;
@property (nonatomic,copy)NSString *longitude;

@end

@implementation JMPostNewJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setTitle:@"发布新职位"];
    
    self.pickerView.delegate = self;
    self.scrollView.delegate = self;
    self.workNameTextField.delegate = self;
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    // Do any additional setup after loading the view from its nib.
    if (_viewType == JMPostNewJobViewTypeEdit) {
        [self getData];
        [self setRightBtnTextName:@"保存"];
    }else if (_viewType == JMPostNewJobViewTypeDefault) {
        [self setRightBtnTextName:@"发布"];
    }else if (_viewType ==JMPostNewJobViewTypeHistory) {
        [self getData];
        [self setRightBtnTextName:@"发布"];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.workNameTextField resignFirstResponder];
}

#pragma mark - 赋值
-(void)setupValues{
    [self.workNameBtn setTitle:self.homeworkModel.work_label_name forState:UIControlStateNormal];
    [self.workPropertyBtn setTitle:self.homeworkModel.work_name forState:UIControlStateNormal];
    self.work_label_id = self.homeworkModel.work_label_id;
    self.workNameTextField.text = self.homeworkModel.work_name;
    NSString *experienceStr = [NSString stringWithFormat:@"%@~%@年",self.homeworkModel.work_experience_min,self.homeworkModel.work_experience_max];
    [self.expriencesBtn setTitle:experienceStr forState:UIControlStateNormal];
    [self.educationBtn setTitle:[self getEducationStrWithEducation:self.homeworkModel.education] forState:UIControlStateNormal];
    NSString *str = [self getSalaryKtransformStrWithMin:self.homeworkModel.salary_min max:self.homeworkModel.salary_max];
    [self.salaryBtn setTitle:str forState:UIControlStateNormal];
    [self.workLocationBtn setTitle:self.homeworkModel.address forState:UIControlStateNormal];
    [self.jobDescriptionBtn setTitle:self.homeworkModel.Description forState:UIControlStateNormal];
    _salaryMin = self.homeworkModel.salary_min;
    _salaryMax = self.homeworkModel.salary_max;
    _educationNum = self.homeworkModel.education;
    _expriencesMin = self.homeworkModel.work_experience_min;
    _expriencesMax = self.homeworkModel.work_experience_max;
    _longitude = self.homeworkModel.longitude;
    _latitude = self.homeworkModel.latitude;
    _jobDescriptionStr = self.homeworkModel.Description;
    
}

#pragma mark - 数据提交
-(void)rightAction{
    [self.workNameTextField resignFirstResponder];

    if (_viewType == JMPostNewJobViewTypeEdit) {
        [self updateJob];
    }else if (_viewType == JMPostNewJobViewTypeDefault || _viewType ==JMPostNewJobViewTypeHistory){
        [self createJob];
    }
    
    
}

-(void)createJob{
    [[JMHTTPManager sharedInstance]postCreateWorkWith_city_id:@"3" work_label_id:_work_label_id work_name:self.workNameTextField.text education:_educationNum work_experience_min:_expriencesMin work_experience_max:_expriencesMax salary_min:_salaryMin salary_max:_salaryMax description:_jobDescriptionStr address:self.workLocationBtn.titleLabel.text longitude:_longitude latitude:_latitude status:@"1" label_ids:nil SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    //

}

-(void)updateJob{
    [[JMHTTPManager sharedInstance]updateWorkWith_Id:self.homeworkModel.work_id city_id:@"3" work_label_id:_work_label_id work_name:self.workNameTextField.text education:_educationNum work_experience_min:_expriencesMin work_experience_max:_expriencesMax salary_min:_salaryMin salary_max:_salaryMax description:_jobDescriptionStr address:self.workLocationBtn.titleLabel.text longitude:_longitude latitude:_latitude status:@"1" label_ids:nil SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
//        [self showAlertVCSucceesSingleWithMessage:@"" btnTitle:@""];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n" message:@"更新成功" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.navigationController.viewControllers.count >=2) {
                UIViewController *listViewController =self.navigationController.viewControllers[1];
                [self.navigationController popToViewController:listViewController animated:YES];
                
             }
      
        }]];
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"purchase_succeeds"];
        [alert.view addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(alert.view).mas_offset(23);
            make.centerX.mas_equalTo(alert.view);
            make.size.mas_equalTo(CGSizeMake(75, 64));
            
        }];
        [self presentViewController:alert animated:YES completion:nil];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
}


-(void)getData{
    [[JMHTTPManager sharedInstance]fetchWorkInfoWith_Id:_work_id SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        
        if (responsObject[@"data"]) {
            
            self.homeworkModel = [JMHomeWorkModel mj_objectWithKeyValues:responsObject[@"data"]];
            [self setupValues];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
}
#pragma mark - 点击事件

- (IBAction)workNameAction:(UIButton *)sender {
    PositionDesiredViewController *vc = [[PositionDesiredViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (IBAction)workPorpertyAction:(UIButton *)sender {
//    self.pickerArray = [NSArray arrayWithObjects:@"兼职",@"全职",@"实习",nil];
//    [self.pickerView reloadAllComponents];
//    _selectedBtn = sender;
//    [self.pickerBGView setHidden:NO];
}

- (IBAction)workExpriencesAction:(UIButton *)sender {
//    self.pickerArray = [NSArray arrayWithObjects:@"1～3",@"3～5",@"5～10",nil];
//    [self.pickerView reloadAllComponents];
//    _selectedBtn = sender;
//
//    [self.pickerBGView setHidden:NO];
    [self.view addSubview:self.expPickerSingle];
    [self.expPickerSingle show];

}

-(void)setExprienceRangeWithExpStr:(NSString *)ExpStr{
    NSArray *array = [ExpStr componentsSeparatedByString:@"~"]; //从字符 ~ 中分隔成2个元素的数组
    
    NSString *minStr = array[0];
    NSString *maxStr = array[1];
    
    self.expriencesMin = minStr;
    self.expriencesMax = maxStr;
    
}

- (IBAction)educationAction:(UIButton *)sender {
//    self.pickerArray = [NSArray arrayWithObjects:@"不限",@"初中及以下",@"中专/中技",@"高中",@"大专",@"本科",@"硕士",@"博士",nil];
//    [self.pickerView reloadAllComponents];
//    _selectedBtn = sender;
//
//    [self.pickerBGView setHidden:NO];
    [self.view addSubview:self.educationPickerSingle];
    [self.educationPickerSingle show];

}

- (IBAction)salaryAction:(UIButton *)sender {
//    self.pickerArray = @[@"1k-2k",
//                         @"2k-4k",
//                         @"4k-6k",
//                         @"6k-8k",
//                         @"8k-10k",
//                         @"10k-15k",
//                         @"15k-20k",
//                         @"20k-30k",
//                         @"30k-40k",
//                         @"40k-50k",
//                         @"50k-100k",
//                         ];
//    [self.pickerView reloadAllComponents];
//    _selectedBtn = sender;
//
//    [self.pickerBGView setHidden:NO];
    [self.view addSubview:self.salaryPickerSingle];
    [self.salaryPickerSingle show];

}

- (IBAction)welFareAction:(UIButton *)sender{
 
    JMWelfareViewController *vc = [[JMWelfareViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)workLocationAction:(UIButton *)sender {
    JMGetCompanyLocationViewController *vc = [[JMGetCompanyLocationViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)jobDescriptionAction:(UIButton *)sender {
    if (self.work_label_id || _jobDescriptionStr) {
        JMJobDescriptionViewController *vc = [[JMJobDescriptionViewController alloc]init];
        vc.delegate = self;
        vc.foreign_key = self.work_label_id;
        vc.jobDescriptionStr = _jobDescriptionStr;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        [self showAlertSimpleTips:@"提示" message:@"请先选择工作岗位" btnTitle:@"好的"];
    }
}

#pragma mark - myDelegate
//PositionDesiredViewController代理方法
-(void)sendPositoinData:(NSString *)labStr labIDStr:(NSString *)labIDStr{
    [self.workNameBtn setTitle:labStr forState:UIControlStateNormal];
    [self.workNameBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    self.work_label_id = labIDStr;
    
}

//JMWelfareViewController代理方法
-(void)sendBtnLabData:(NSMutableArray *)btns{
    NSMutableArray *strArray = [[NSMutableArray alloc]init];
    for (int i=0; i<btns.count; i++) {
        UIButton *btn = btns[i];
        [strArray addObject:btn.titleLabel.text];
//        btn.titleLabel.text;
    }
    NSString *str = [strArray componentsJoinedByString:@","];
    [self.welfareBtn setTitle:str forState:UIControlStateNormal];
    [self.welfareBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
//    NSLog(@"%@",str);
}


-(void)sendAdress_Data:(AMapPOI *)data
{
    self.POIModel = data;
    NSString *adr = [NSString stringWithFormat:@"%@-%@-%@-%@",data.city,data.district,data.name,data.address];
    [self.workLocationBtn setTitle:adr forState:UIControlStateNormal];
    _longitude = [NSString stringWithFormat:@"%f",data.location.longitude];
    _latitude = [NSString stringWithFormat:@"%f",data.location.latitude];

}


-(void)sendTextView_textData:(NSString *)textData{
    if (textData.length > 0) {
        [_jobDescriptionBtn setTitle:@"已完善" forState:UIControlStateNormal];
        [_jobDescriptionBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        _jobDescriptionStr = textData;
    }
}


#pragma mark - textField delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - pickerView delegate
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle row:(NSInteger)row{
//    _isChange = YES;
    if (pickerSingle == _expPickerSingle) {
        [self.expriencesBtn setTitle:selectedTitle forState:UIControlStateNormal];
        [self.expriencesBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [self setExprienceRangeWithExpStr:selectedTitle];
    }else if (pickerSingle == _educationPickerSingle) {
        [self.educationBtn setTitle:selectedTitle forState:UIControlStateNormal];
        [self.educationBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        self.educationNum = [NSString stringWithFormat:@"%ld",(long)row];
    
    }else if (pickerSingle == _salaryPickerSingle) {
        NSMutableArray *array = [self setSalaryRangeWithSalaryStr:selectedTitle];
        self.salaryMin = array[0];
        self.salaryMax = array[1];
        [self.salaryBtn setTitle:selectedTitle forState:UIControlStateNormal];
        [self.salaryBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    }

}


-(STPickerSingle *)expPickerSingle{
    if (_expPickerSingle == nil) {
        _expPickerSingle = [[STPickerSingle alloc]init];
        _expPickerSingle.delegate = self;
        _expPickerSingle.title = @"工作经验";
        _expPickerSingle.titleUnit = @"年";
        _expPickerSingle.widthPickerComponent = SCREEN_WIDTH;
        _expPickerSingle.arrayData = [NSMutableArray arrayWithObjects:@"1~3",
                                            @"3~5",
                                            @"5~10",
                                            nil];
    }
    return _expPickerSingle;
}

-(STPickerSingle *)educationPickerSingle{
    if (_educationPickerSingle == nil) {
        _educationPickerSingle = [[STPickerSingle alloc]init];
        _educationPickerSingle.delegate = self;
        _educationPickerSingle.title = @"学历要求";
        _educationPickerSingle.widthPickerComponent = SCREEN_WIDTH;
        _educationPickerSingle.arrayData = [NSMutableArray arrayWithObjects:@"不限",
                                            @"初中",
                                            @"中专",
                                            @"高中",
                                            @"大专",
                                            @"本科",
                                            @"硕士",
                                            @"博士",
                                            nil];
    }
    return _educationPickerSingle;
}
-(STPickerSingle *)salaryPickerSingle{
    if (_salaryPickerSingle == nil) {
        _salaryPickerSingle = [[STPickerSingle alloc]init];
        _salaryPickerSingle.delegate = self;
        _salaryPickerSingle.title = @"薪资要求";
        _salaryPickerSingle.widthPickerComponent = SCREEN_WIDTH;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
