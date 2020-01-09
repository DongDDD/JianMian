//
//  JobIntensionViewController.m
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JobIntensionViewController.h"
#import "PositionDesiredViewController.h"
#import "JMJobExperienceViewController.h"
#import "JMHTTPManager+Vita.h"
#import "Masonry.h"
#import "JMHTTPManager+Login.h"
#import "JMJudgeViewController.h"
#import "NavigationViewController.h"
#import "LoginViewController.h"
#import "STPickerDate.h"
#import "STPickerSingle.h"
#import "JMHTTPManager+Vita.h"
#import "JMVitaDetailModel.h"
#import "JMHTTPManager+Job.h"
#import "JMBAndCTabBarViewController.h"
#import "JMDataTransform.h"


//typedef enum _PickerState {
//    SalaryState,
//    DateState,
//    EducationState
//} _PickerState;

@interface JobIntensionViewController ()<UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,PositionDesiredDelegate,STPickerDateDelegate,STPickerSingleDelegate>
@property (weak, nonatomic) IBOutlet UIButton *statusBtn4;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn1;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn2;
@property (weak, nonatomic) IBOutlet UIButton *positionBtn;
@property (weak, nonatomic) IBOutlet UIButton *salaryBtn;
@property (weak, nonatomic) IBOutlet UIButton *startWorkBtn;
@property (weak, nonatomic) IBOutlet UIButton *educationBtn;
//@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) STPickerDate *pickerData;
@property (nonatomic, strong) STPickerSingle *salaryPickerSingle;
@property (nonatomic, strong) STPickerSingle *educationPickerSingle;
@property (nonatomic, copy) NSString *user_job_id;
@property (nonatomic, strong) JMVitaDetailModel *vitaDetailModel;



@property (nonatomic, strong) NSString *statusStr;//求职状态
@property (nonatomic, copy) NSString *job_labelID;//期望职位
@property (nonatomic, copy) NSString *salaryMin;//薪资要求
@property (nonatomic, copy) NSString *salaryMax;
@property (nonatomic, copy) NSString *work_start_date;//参加工作时间
@property (nonatomic, copy) NSString *education;//我的学历

//@property (strong, nonatomic) UIPickerView *pickerView;
//@property (strong, nonatomic) NSArray *salaryArray;
//@property (nonatomic, strong) NSArray *pickerArray;

//@property (nonatomic,assign) _PickerState pickerState;

@property(nonatomic,strong)UIButton *moreBtn;

@end

@implementation JobIntensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
//    [self setIsHiddenBackBtn:YES];
    [self.scrollView addSubview:self.moreBtn];
    if (self.loginViewType == JMJLoginViewTypeMemory) {
        [self setIsHiddenBackBtn:YES];
    }else if (self.loginViewType == JMLoginViewTypeNextStep) {
        [self setIsHiddenBackBtn:NO];
    }
    [self setRightBtnTextName:@"下一步"];
    
    self.statusStr = @"1";
//    self.datePicker.backgroundColor = BG_COLOR;
    
//    [self setPickerVIewUI];
//    [self.view addSubview:_datePicker];

    self.scrollView.delegate = self;
//    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenDatePickerAction)];
//    [self.view addGestureRecognizer:bgTap];
    
    // Do any additional setup after loading the view from its nib.
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getVitaInfo];

}
//-(void)setPickerVIewUI{
//     self.pickerView = [[UIPickerView alloc]init];
//    self.pickerView.backgroundColor = BG_COLOR;
//    self.pickerView.delegate = self;
//
//    self.pickerView.dataSource = self;
//
//    [self.view addSubview:self.pickerView];
//
//    self.pickerView.hidden = YES;
//
//    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(self.view);
//        make.height.mas_equalTo(180);
//        make.bottom.mas_equalTo(self.view.mas_bottom);
//    }];
//
//    self.pickerArray = [NSArray arrayWithObjects:@"初中及以下",@"中专/中技",@"高中",@"大专",@"本科",@"硕士",@"博士",nil];
//
//}

#pragma mark - 点击事件
//在职
- (IBAction)status1Action:(UIButton *)sender {
    [self.statusBtn2 setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
    [self.statusBtn1 setImage:[UIImage imageNamed:@"蓝点"] forState:UIControlStateNormal];
       [self.statusBtn4 setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
    self.statusStr = @"1";
    kSaveMyDefault(@"work_status",self.statusStr);

}

//离职
- (IBAction)status2Action:(UIButton *)sender {
    [self.statusBtn2 setImage:[UIImage imageNamed:@"蓝点"] forState:UIControlStateNormal];
    [self.statusBtn1 setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
       [self.statusBtn4 setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
    
    self.statusStr = @"2";
    kSaveMyDefault(@"work_status",self.statusStr);

    
}
//应届生
- (IBAction)status4Action:(UIButton *)sender {
     [self.statusBtn4 setImage:[UIImage imageNamed:@"蓝点"] forState:UIControlStateNormal];
    [self.statusBtn2 setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
    [self.statusBtn1 setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
    
    self.statusStr = @"4";
    kSaveMyDefault(@"work_status",self.statusStr);

}

//期望职位
- (IBAction)wantToJob:(id)sender {
    
    PositionDesiredViewController *vc = [[PositionDesiredViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

//PositionDesiredViewController代理方法
-(void)sendPositoinData:(NSString *)labStr labIDStr:(NSString *)labIDStr{
    [self.positionBtn setTitle:labStr forState:UIControlStateNormal];
    [self.positionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    self.job_labelID = labIDStr;
    kSaveMyDefault(@"position",labStr);

}

- (IBAction)choogseSalaryAction:(UIButton *)sender {

    [self.view addSubview:self.salaryPickerSingle];

    [self.salaryPickerSingle show];
}

- (IBAction)chooseStartWorkAction:(id)sender {
    [self.view addSubview:self.pickerData];
    [self.pickerData show];
  
}


- (IBAction)chooseEducationAction:(UIButton *)sender {
    [self.view addSubview:self.educationPickerSingle];
    
    [self.educationPickerSingle show];

}



#pragma mark - 数据提交

-(void)rightAction{
    //判断有没创建简历
    if (self.vitaDetailModel.jobs.count > 0) {
        [self updateVita];
    }else{
        [self creatVita];
    }
    
}

-(void)creatVita{
    
    NSString *user_step;
    if ([self.statusStr isEqualToString:@"4"] ) {
        user_step = @"6";
    }else{
        user_step = @"4";
    }
    [[JMHTTPManager sharedInstance]createVitaWith_work_status:self.statusStr education:self.education work_start_date:self.work_start_date job_label_id:self.job_labelID industry_label_id:nil city_id:nil salary_min:self.salaryMin salary_max:self.salaryMax description:nil status:nil user_step:user_step successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMUserInfoManager saveUserInfo:userInfo];
            
            if ([self.statusStr isEqualToString:@"4"]) {
                JMBAndCTabBarViewController *vc = [[JMBAndCTabBarViewController alloc]init];
                JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
                userModel.isNewUser = YES;
                [JMUserInfoManager saveUserInfo:userModel];
                [UIApplication sharedApplication].delegate.window.rootViewController = vc;
            }else{
                JMJobExperienceViewController *vc = [[JMJobExperienceViewController alloc]init];
                vc.loginViewType = JMLoginViewTypeNextStep;
                [self.navigationController pushViewController:vc animated:YES];
            }
                        
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
    

}


-(void)getVitaInfo{
    [[JMHTTPManager sharedInstance] fetchVitaInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.vitaDetailModel = [JMVitaDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
            JMMyJobsModel *jobModel = self.vitaDetailModel.jobs[0];
            self.user_job_id = jobModel.user_job_id;
//            self.cellConfigures.model = self.model;
//            self.job_labelID = self.model.job_label_id;
//            self.salaryMin = @([self.model.salary_min intValue]);
//            self.salaryMax = @([self.model.salary_max intValue]);
//            [self initView];
//            //                [self setPickerVIewUI];
//            //                [self setupDateKeyPan];
//            [self.tableView reloadData];
//
//            [self.progressHUD setHidden:YES]; //显示进度框
//
            if (self.user_job_id) {
                [self setVitaValues];
            }
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

-(void)updateVita{
    [[JMHTTPManager sharedInstance] updateVitaWith_work_status:self.statusStr education:self.education work_start_date:self.work_start_date description:nil video_path:nil video_cover:nil image_paths:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self updateJob];
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}


-(void)updateJob{
    [[JMHTTPManager sharedInstance]updateJobWith_user_job_id:self.user_job_id job_label_id:_job_labelID industry_label_id:nil city_id:nil salary_min:_salaryMin salary_max:_salaryMax status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMJobExperienceViewController *vc = [[JMJobExperienceViewController alloc]init];
        vc.loginViewType = JMLoginViewTypeNextStep;
        [self.navigationController pushViewController:vc animated:YES];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    

}

#pragma mark - 赋值
-(void)setVitaValues{
    
    NSString *work_status = kFetchMyDefault(@"work_status");
    NSString *position = kFetchMyDefault(@"position");
    NSString *salary = kFetchMyDefault(@"salary");
    NSString *work_start_date = kFetchMyDefault(@"work_start_date");
    NSString *educationstr = kFetchMyDefault(@"education");
    if ([work_status isEqualToString:@"1"]) {
        [self status1Action:nil];
    }else if ([work_status isEqualToString:@"2"]) {
        [self status2Action:nil];
    }else if ([work_status isEqualToString:@"4"]) {
        [self status4Action:nil];
    }
    
    [self.positionBtn setTitle:position forState:UIControlStateNormal];
    [self.positionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];

//    JMMyJobsModel *jobModel = self.vitaDetailModel.jobs[0];
//    NSString *salaryStr = [NSString stringWithFormat:@"%@-%@",jobModel.salary_min,jobModel.salary_max];
    [self.salaryBtn setTitle:salary forState:UIControlStateNormal];
    [self.salaryBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];

    [self.startWorkBtn setTitle:work_start_date forState:UIControlStateNormal];
    [self.startWorkBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];

    [self.educationBtn setTitle:educationstr forState:UIControlStateNormal];
    [self.educationBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];

}


#pragma mark - PickerViewDelegate
- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    NSString *title = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day];
    [self.startWorkBtn setTitle:title forState:UIControlStateNormal];
    [self.startWorkBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    // 格式化日期格式
//    formatter.dateFormat = @"yyyy-MM-dd";
//    NSString *date = [formatter stringFromDate:title];
    self.work_start_date  = title;
    kSaveMyDefault(@"work_start_date",title);

//    [formatter dateFromString:date];
}

- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle row:(NSInteger)row
{
    if (pickerSingle == _salaryPickerSingle) {
        [self.salaryBtn setTitle:selectedTitle forState:UIControlStateNormal];
        [self.salaryBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        NSMutableArray *array = [self setSalaryRangeWithSalaryStr:selectedTitle];
        self.salaryMin = array[0];
        self.salaryMax = array[1];
        kSaveMyDefault(@"salary",selectedTitle);

    }else if (pickerSingle == _educationPickerSingle) {
        [self.educationBtn setTitle:selectedTitle forState:UIControlStateNormal];
        [self.educationBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        self.education = [JMDataTransform getEducationNumWithEducationStr:selectedTitle];
        NSLog(@"%@",selectedTitle);
        kSaveMyDefault(@"education",selectedTitle);
    }
    
}


#pragma mark - scrollViewDelegate

-(UIButton *)moreBtn{
    if (_moreBtn == nil) {
        _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,self.educationBtn.frame.origin.y+self.educationBtn.frame.size.height+30, SCREEN_WIDTH, 40)];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];

        [_moreBtn setTitle:@"更多操作" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

-(STPickerDate *)pickerData{
    if (_pickerData == nil) {
        _pickerData = [[STPickerDate alloc]init];
        _pickerData.delegate = self;
        _pickerData.yearLeast = 1950;
        _pickerData.yearSum = 2018;
        _pickerData.heightPickerComponent = 28;
        
    }
    return _pickerData;
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
                                         @"50k-100k",nil];
    }
    return _salaryPickerSingle;
}

-(STPickerSingle *)educationPickerSingle{
    if (_educationPickerSingle == nil) {
        _educationPickerSingle = [[STPickerSingle alloc]init];
        _salaryPickerSingle.title = @"我的学历";
        _educationPickerSingle.delegate = self;
        _educationPickerSingle.widthPickerComponent = 200;
        _educationPickerSingle.arrayData = [NSMutableArray arrayWithObjects:@"初中及以下",@"中专/中技",@"高中",@"大专",@"本科",@"硕士",@"博士",nil];
    }
    return _educationPickerSingle;
}
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//
//    NSString *str = [self.educationArray objectAtIndex:row];
//
//    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
//
//    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:TEXT_GRAY_COLOR} range:NSMakeRange(0, [AttributedString  length])];
//
//
//
//    return AttributedString;
//
//}
//返回指定列，行的高度，就是自定义行的高度

//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
//
//    return 20.0f;
//
//}

//返回指定列的宽度

//- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//
//    if (component==0) {//iOS6边框占10+10
//
//        return  self.view.frame.size.width/3;
//
//    } else if(component==1){
//
//        return  self.view.frame.size.width/3;
//
//    }
//
//    return  self.view.frame.size.width/3;
//
//}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
