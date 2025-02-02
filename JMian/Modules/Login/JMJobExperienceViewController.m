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
#import "PositionDesiredViewController.h"

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
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation JMJobExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.datePckerView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView.delegate = self;
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenDatePickerAction)];
    [self.view addGestureRecognizer:bgTap];
    // Do any additional setup after loading the view from its nib.
    
    switch (self.viewType) {
        case JMJobExperienceViewTypeDefault:
            [self setRightBtnTextName:@"下一步"];
            [self.saveBtn setTitle:@"完成" forState:UIControlStateNormal];
            break;
        case JMJobExperienceViewTypeEdit:
            self.navigationItem.title = @"编辑工作经历";
            [self setRightBtnTextName:@"删除"];
            [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
            self.headerViewHeightConstraint.constant = 0;
            self.headerView.hidden = YES;
            self.companyNameText.text = self.model.company_name;
            self.jobDescriptionText.text = self.model.experiences_description;
            [self.jobLabelId setTitle:self.model.work_name forState:UIControlStateNormal];
            [self.startDateBtn setTitle:self.model.start_date forState:UIControlStateNormal];
            [self.endDateBtn setTitle:self.model.end_date forState:UIControlStateNormal];
            break;
        case JMJobExperienceViewTypeAdd:
            self.navigationItem.title = @"新增工作经历";
            [self setRightBtnTextName:@"保存"];
            [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
            self.headerViewHeightConstraint.constant = 0;
            self.headerView.hidden = YES;
            break;
        default:
            break;
    }
}


#pragma mark - 点击事件


-(void)hiddenDatePickerAction{
    self.datePckerView.hidden = YES;
    
}

- (void)deleteExperience {
    [[JMHTTPManager sharedInstance] deleteExperienceWith_experienceId:@([self.model.experience_id integerValue]) successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

- (void)updateExperience {
    [[JMHTTPManager sharedInstance] updateExperienceWith_experienceId:@([self.model.experience_id integerValue]) company_name:self.companyNameText.text job_label_id:@(1)start_date:self.startDate end_date:self.endDate description:self.jobDescriptionText.text successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
            [self.navigationController popViewControllerAnimated:YES];
       
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    

}

- (void)createExperience {
    [[JMHTTPManager sharedInstance] createExperienceWithCompany_name:self.companyNameText.text job_label_id:@(1)start_date:self.startDate end_date:self.endDate description:self.jobDescriptionText.text user_step:@6 successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        switch (self.viewType) {
            case JMJobExperienceViewTypeDefault: {
                JMTabBarViewController *tab = [[JMTabBarViewController alloc] init];
                [UIApplication sharedApplication].delegate.window.rootViewController = tab;
                break;
            }
            default:
                [self.navigationController popViewControllerAnimated:YES];
                break;
        }
 
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    

}


-(void)rightAction{
    switch (self.viewType) {
        case JMJobExperienceViewTypeDefault:
            [self createExperience];
            break;
        case JMJobExperienceViewTypeEdit:
            [self deleteExperience];
            break;
        case JMJobExperienceViewTypeAdd:
            [self createExperience];
            break;
    }
    
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
    
    switch (self.viewType) {
        case JMJobExperienceViewTypeDefault:
            [self createExperience];
            break;
        case JMJobExperienceViewTypeEdit:
            [self updateExperience];
            break;
        case JMJobExperienceViewTypeAdd:
            [self createExperience];
            break;
    }
    
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
