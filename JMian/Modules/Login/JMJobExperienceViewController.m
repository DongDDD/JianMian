//
//  JMJobExperienceViewController.m
//  JMian
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMJobExperienceViewController.h"
#import "JMHTTPManager+CreateExperience.h"
#import "JMTabBarViewController.h"
#import "AppDelegate.h"
#import "JMHTTPManager+Login.h"

typedef enum _PickerState_Exp {
    startWorkState,
    endWorkstate
} _PickerState_Exp;

@interface JMJobExperienceViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *companyNameText;

@property (weak, nonatomic) IBOutlet UIButton *startDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *endDateBtn;
@property (strong, nonatomic)NSDate *startDate;
@property (strong, nonatomic)NSDate *endDate;

@property (weak, nonatomic) IBOutlet UIButton *jobLabelId;
@property (weak, nonatomic) IBOutlet UITextField *jobDescriptionText;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePckerView;


@property (nonatomic,assign) _PickerState_Exp pickerState;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation JMJobExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_isHiddenBackBtn) {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
        
    }
    self.datePckerView.backgroundColor = [UIColor whiteColor];
    [self setRightBtnTextName:@"下一步"];
    
    self.scrollView.delegate = self;
    
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenDatePickerAction)];
    [self.view addGestureRecognizer:bgTap];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - 点击事件


-(void)hiddenDatePickerAction{
    self.datePckerView.hidden = YES;
    
    
}

-(void)rightAction{
    
    [[JMHTTPManager sharedInstance] createExperienceWithCompany_name:@"广州测试2有限公司" job_label_id:@(1)start_date:self.startDate end_date:self.endDate description:self.jobDescriptionText.text successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

        [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [JMUserInfoManager saveUserInfo:userInfo];
            
            JMTabBarViewController *tab = [[JMTabBarViewController alloc] init];
            [UIApplication sharedApplication].delegate.window.rootViewController=tab;

            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];

        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];
   
    
}
- (IBAction)startWorkAction:(UIButton *)sender {
    
    [self.datePckerView setHidden:NO];
     self.pickerState = startWorkState;
}


- (IBAction)endWorkAction:(UIButton *)sender {
    
    [self.datePckerView setHidden:NO];
    self.pickerState = endWorkstate;
}



- (IBAction)finishBtn:(id)sender {
    
    
   

    
}

- (IBAction)datePickerViewChange:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 格式化日期格式
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *date = [formatter stringFromDate:self.datePckerView.date];
    // 显示时间
    if (self.pickerState==startWorkState) {
        
        [self.startDateBtn setTitle:date forState:UIControlStateNormal];
        [self.startDateBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        self.startDate  = [formatter dateFromString:date];
    }else if(self.pickerState == endWorkstate){
        
        [self.endDateBtn setTitle:date forState:UIControlStateNormal];
        [self.endDateBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        self.endDate = [formatter dateFromString:date];
        
        
    }
    
}

#pragma mark - UIscrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.datePckerView setHidden:YES];
    
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
