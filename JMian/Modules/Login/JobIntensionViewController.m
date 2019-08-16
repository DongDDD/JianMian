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

@property (nonatomic, copy) NSString *job_labelID;
@property (nonatomic, strong) NSNumber *statusNum;
@property (nonatomic, copy) NSString *salaryMin;
@property (nonatomic, copy) NSString *salaryMax;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *startWorkDate;

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
    [self setIsHiddenBackBtn:YES];
    [self.scrollView addSubview:self.moreBtn];

    [self setRightBtnTextName:@"下一步"];
    
    self.statusNum = @(1);
    
//    self.datePicker.backgroundColor = BG_COLOR;
    
//    [self setPickerVIewUI];
//    [self.view addSubview:_datePicker];

    self.scrollView.delegate = self;
    
//    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenDatePickerAction)];
//    [self.view addGestureRecognizer:bgTap];
    
    // Do any additional setup after loading the view from its nib.
    
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
- (IBAction)status1Action:(UIButton *)sender {
    [self.statusBtn2 setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
    [self.statusBtn1 setImage:[UIImage imageNamed:@"蓝点"] forState:UIControlStateNormal];
       [self.statusBtn4 setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
    self.statusNum = @1;
    
}


- (IBAction)status2Action:(UIButton *)sender {
    [self.statusBtn2 setImage:[UIImage imageNamed:@"蓝点"] forState:UIControlStateNormal];
    [self.statusBtn1 setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
       [self.statusBtn4 setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
    
    self.statusNum = @2;
    
}
- (IBAction)status4Action:(UIButton *)sender {
     [self.statusBtn4 setImage:[UIImage imageNamed:@"蓝点"] forState:UIControlStateNormal];
    [self.statusBtn2 setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
    [self.statusBtn1 setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
    
    self.statusNum = @2;
}


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
    
}

- (IBAction)choogseSalaryAction:(UIButton *)sender {
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
//                         @"50k-100K",
//                         ];
//    [self.datePicker setHidden:YES];
//    [self.pickerView setHidden:NO];

//    self.pickerState = SalaryState;
    
//    [self.pickerView reloadAllComponents];
    [self.view addSubview:self.salaryPickerSingle];

    [self.salaryPickerSingle show];
}

- (IBAction)chooseStartWorkAction:(id)sender {
    [self.view addSubview:self.pickerData];
    [self.pickerData show];
//    self.datePicker.hidden = NO;
//    [self.pickerView setHidden:YES];
    
}


- (IBAction)chooseEducationAction:(UIButton *)sender {
//    self.pickerArray = [NSArray arrayWithObjects:@"初中及以下",@"中专/中技",@"高中",@"大专",@"本科",@"硕士",@"博士",nil];
//
//    [self.pickerView setHidden:NO];
////    [self.datePicker setHidden:YES];
//
//    self.pickerState = EducationState;
//    [self.pickerView reloadAllComponents];
    [self.view addSubview:self.educationPickerSingle];
    
    [self.educationPickerSingle show];

}


//-(void)hiddenDatePickerAction{
////    self.datePicker.hidden = YES;
//    self.pickerView.hidden = YES;
//
//}

#pragma mark - 数据提交

-(void)rightAction{
    [[JMHTTPManager sharedInstance]createVitaWith_work_status:self.statusNum education:self.education work_start_date:self.startWorkDate job_label_id:self.job_labelID industry_label_id:nil city_id:nil salary_min:self.salaryMin salary_max:self.salaryMax description:nil status:nil user_step:@4 successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMUserInfoManager saveUserInfo:userInfo];
            
            JMJobExperienceViewController *vc = [[JMJobExperienceViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];

        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
 

    
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
    self.startWorkDate  = title;
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
    }else if (pickerSingle == _educationPickerSingle) {
        [self.educationBtn setTitle:selectedTitle forState:UIControlStateNormal];
        [self.educationBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    
        self.education = [self getEducationNumWithEducationStr:selectedTitle];
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
                                         @"50k-100K",nil];
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
