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

typedef enum _PickerState {
    SalaryState,
    DateState,
    EducationState
} _PickerState;

@interface JobIntensionViewController ()<UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,PositionDesiredDelegate>
@property (weak, nonatomic) IBOutlet UIButton *statusBtn1;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn2;
@property (weak, nonatomic) IBOutlet UIButton *positionBtn;
@property (weak, nonatomic) IBOutlet UIButton *salaryBtn;
@property (weak, nonatomic) IBOutlet UIButton *startWorkBtn;
@property (weak, nonatomic) IBOutlet UIButton *educationBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, copy) NSString *job_labelID;
@property (nonatomic, strong) NSNumber *statusNum;
@property (nonatomic, strong) NSNumber *salaryMin;
@property (nonatomic, strong) NSNumber *salaryMax;
@property (nonatomic, strong) NSNumber *educationNum;
@property (nonatomic, strong) NSDate *startWorkDate;

@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *salaryArray;
@property (nonatomic, strong) NSArray *pickerArray;

@property (nonatomic,assign) _PickerState pickerState;


@end

@implementation JobIntensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
  
    [self setRightBtnTextName:@"下一步"];
    
    self.statusNum = @(1);
    
    self.datePicker.backgroundColor = [UIColor whiteColor];
    
    [self setPickerVIewUI];
    
    self.scrollView.delegate = self;
    
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenDatePickerAction)];
    [self.view addGestureRecognizer:bgTap];
    
    // Do any additional setup after loading the view from its nib.
    
}


-(void)setPickerVIewUI{
     self.pickerView = [[UIPickerView alloc]init];
    
    self.pickerView.delegate = self;
    
    self.pickerView.dataSource = self;
    
    [self.view addSubview:self.pickerView];
    
    self.pickerView.hidden = YES;
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(180);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];

    self.pickerArray = [NSArray arrayWithObjects:@"请选择",@"初中/中专",@"高中",@"大专",@"本科",@"研究生",@"博士",nil];

}
#pragma mark - 点击事件
- (IBAction)status1Action:(UIButton *)sender {
    [self.statusBtn2 setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
    [self.statusBtn1 setImage:[UIImage imageNamed:@"蓝点"] forState:UIControlStateNormal];
    self.statusNum = @1;
    
}


- (IBAction)status2Action:(UIButton *)sender {
    [self.statusBtn2 setImage:[UIImage imageNamed:@"蓝点"] forState:UIControlStateNormal];
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
    self.pickerArray = [NSArray arrayWithObjects:@"3000~5000",@"5000~8000",@"8000~10000",@"10000~20000",nil];
    [self.datePicker setHidden:YES];
    [self.pickerView setHidden:NO];

    self.pickerState = SalaryState;
    
    [self.pickerView reloadAllComponents];
}

- (IBAction)chooseStartWorkAction:(id)sender {

    self.datePicker.hidden = NO;
    [self.pickerView setHidden:YES];
    
}


- (IBAction)chooseEducationAction:(UIButton *)sender {
    self.pickerArray = [NSArray arrayWithObjects:@"初中及以下",@"中专/中技",@"高中",@"大专",@"本科",@"硕士",@"博士",nil];
    
    [self.pickerView setHidden:NO];
    [self.datePicker setHidden:YES];
    
    self.pickerState = EducationState;
    [self.pickerView reloadAllComponents];

}


-(void)hiddenDatePickerAction{
    self.datePicker.hidden = YES;
    self.pickerView.hidden = YES;
    
    
}

#pragma mark - 数据提交

-(void)rightAction{
    [[JMHTTPManager sharedInstance]createVitaWith_work_status:self.statusNum education:self.educationNum work_start_date:self.startWorkDate job_label_id:self.job_labelID industry_label_id:nil city_id:nil salary_min:self.salaryMin salary_max:self.salaryMax description:nil status:nil user_step:@4 successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
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


- (IBAction)datePickerViewChange:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 格式化日期格式
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *date = [formatter stringFromDate:self.datePicker.date];
    // 显示时间
    [self.startWorkBtn setTitle:date forState:UIControlStateNormal];
    [self.startWorkBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    
    self.startWorkDate  = [formatter dateFromString:date];
    
}



#pragma mark - PickerViewDelegate

//返回有几列

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}

//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    return [self.pickerArray count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [self.pickerArray objectAtIndex:row];
    
    return str;
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (self.pickerState == EducationState) {
        [self.educationBtn setTitle:[self.pickerArray objectAtIndex:row] forState:UIControlStateNormal];
        [self.educationBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        self.educationNum = [NSNumber numberWithInteger:row];
        
    }else if(self.pickerState == SalaryState){
        [self.salaryBtn setTitle:[self.pickerArray objectAtIndex:row] forState:UIControlStateNormal];
        [self.salaryBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    
        NSString *salaryStr =[self.pickerArray objectAtIndex:row];
        [self setSalaryRangeWithSalaryStr:salaryStr];
       
        
        //        self.salaryMin = NSNumber nu
        
//        self.educationNum = [NSNumber numberWithInteger:row];
    
    
    }
    
    
}


-(void)setSalaryRangeWithSalaryStr:(NSString *)salaryStr{
    NSArray *array = [salaryStr componentsSeparatedByString:@"~"]; //从字符 ~ 中分隔成2个元素的数组
    
    NSString *minStr = array[0];
    NSString *maxStr = array[1];
    
    NSInteger minNum = [minStr integerValue];
    NSInteger maxNum = [maxStr integerValue];
    
    
    self.salaryMin = @(minNum);
    self.salaryMax = @(maxNum);
    



}
#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.datePicker setHidden:YES];
    [self.pickerView setHidden:YES];
    
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
