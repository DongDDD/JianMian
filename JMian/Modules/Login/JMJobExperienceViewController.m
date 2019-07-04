//
//  JMJobExperienceViewController.m
//  JMian
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMJobExperienceViewController.h"
#import "JMHTTPManager+CreateExperience.h"
#import "JMPersonTabBarViewController.h"
#import "AppDelegate.h"
#import "JMHTTPManager+Login.h"
#import "PositionDesiredViewController.h"
#import "JMJudgeViewController.h"
#import "NavigationViewController.h"
#import "LoginViewController.h"
#import "STPickerDate.h"
#import "JMPartTimeJobResumeFooterView.h"
#import "PositionDesiredViewController.h"

//typedef enum _PickerState_Exp {
//    startWorkState,
//    endWorkstate
//} _PickerState_Exp;

@interface JMJobExperienceViewController () <UIScrollViewDelegate,UITextFieldDelegate,STPickerDateDelegate,JMPartTimeJobResumeFooterViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *companyNameText;

@property (weak, nonatomic) IBOutlet UIButton *startDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *endDateBtn;
@property (strong, nonatomic)NSString *startDate;
@property (strong, nonatomic)NSString *endDate;

@property (weak, nonatomic) IBOutlet UIButton *jobLabelId;
//@property (weak, nonatomic) IBOutlet UITextField *jobDescriptionText;
//@property (weak, nonatomic) IBOutlet UIDatePicker *datePckerView;

//@property (nonatomic,assign) _PickerState_Exp pickerState;
//@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (nonatomic, assign)CGFloat changeHeight;
@property(nonatomic,strong)UIButton *moreBtn;
@property (nonatomic,strong) STPickerDate *pickerDataStart;
@property (nonatomic,strong) STPickerDate *pickerDataEnd;
@property (strong, nonatomic)JMPartTimeJobResumeFooterView *decriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *workDescTitleLab;
@property(nonatomic,copy)NSString *jobDescStr;
@property(nonatomic,strong)UIButton *saveBtn;
@property(nonatomic,copy)NSString *positionLabId;


@end

@implementation JMJobExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.datePckerView.backgroundColor = BG_COLOR;
    self.scrollView.delegate = self;
    self.companyNameText.delegate = self;
    [self initView];
    
    switch (self.viewType) {
        case JMJobExperienceViewTypeDefault:
            [self setRightBtnTextName:@"下一步"];
//            self.title = @"工作经历";
            [self setIsHiddenBackBtn:YES];
            [self.saveBtn setTitle:@"完成" forState:UIControlStateNormal];
            break;
        case JMJobExperienceViewTypeEdit:
            self.title = @"编辑工作经历";
            [self.moreBtn setHidden:YES];
            [self setRightBtnTextName:@"删除"];
            [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
            self.headerViewHeightConstraint.constant = 0;
            self.headerView.hidden = YES;
            self.companyNameText.text = self.model.company_name;
//            self.jobDescriptionText.text = self.model.experiences_description;
            [self.jobLabelId setTitle:self.model.work_name forState:UIControlStateNormal];
            [self.jobLabelId setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            [self.startDateBtn setTitle:self.model.start_date forState:UIControlStateNormal];
            [self.startDateBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            [self.endDateBtn setTitle:self.model.end_date forState:UIControlStateNormal];
            [self.endDateBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];

            break;
        case JMJobExperienceViewTypeAdd:
            self.title = @"新增工作经历";
            [self setRightBtnTextName:@"保存"];
            
            [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
            self.headerViewHeightConstraint.constant = 0;
            self.headerView.hidden = YES;
            break;
        default:
            break;
    }
    

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.saveBtn.frame.origin.y+self.saveBtn.frame.size.height+50);
    
}

- (void)viewDidDisappear:(BOOL)animated
{
}

-(void)initView{
    [self.scrollView addSubview:self.decriptionTextView];
    [self.scrollView addSubview:self.moreBtn];
    [self.scrollView addSubview:self.saveBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.height.mas_equalTo(37);
    }];

}


#pragma mark - 点击事件


//-(void)hiddenDatePickerAction{
////    self.datePckerView.hidden = YES;
//    [_companyNameText resignFirstResponder];
//    [_jobDescriptionText resignFirstResponder];
//
//}

- (void)deleteExperience {
    [self showAlertWithTitle:@"提醒⚠️" message:@"删除后数据将不可恢复" leftTitle:@"返回" rightTitle:@"确认删除"];

}

-(void)alertRightAction{

    [[JMHTTPManager sharedInstance] deleteExperienceWith_experienceId:self.model.experience_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self.navigationController popViewControllerAnimated:YES];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

- (void)updateExperience {
    [[JMHTTPManager sharedInstance] updateExperienceWith_experienceId:self.model.experience_id company_name:self.companyNameText.text job_label_id:@"1" start_date:self.startDate end_date:self.endDate description:self.jobDescStr successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
            [self.navigationController popViewControllerAnimated:YES];
       
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    

}

- (void)createExperience {
    [[JMHTTPManager sharedInstance] createExperienceWithCompany_name:self.companyNameText.text job_label_id:self.positionLabId start_date:self.startDate end_date:self.endDate description:self.jobDescStr user_step:@6 successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        switch (self.viewType) {
            case JMJobExperienceViewTypeDefault: {
                JMPersonTabBarViewController *tab = [[JMPersonTabBarViewController alloc] init];
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
    [_companyNameText resignFirstResponder];
    [self.decriptionTextView.contentTextView resignFirstResponder];
//    [_jobDescriptionText resignFirstResponder];
//    [self.datePckerView setHidden:NO];
//     self.pickerState = startWorkState;
    [self.view addSubview:self.pickerDataStart];
    [self.pickerDataStart show];
}


- (IBAction)endWorkAction:(UIButton *)sender {
    [_companyNameText resignFirstResponder];
    [self.decriptionTextView.contentTextView resignFirstResponder];
//    [_jobDescriptionText resignFirstResponder];
//    [self.datePckerView setHidden:NO];
//    self.pickerState = endWorkstate;
    [self.view addSubview:self.pickerDataEnd];
    [self.pickerDataEnd show];
}

- (IBAction)jobTypeChooseAction:(id)sender {
    PositionDesiredViewController *vc = [[PositionDesiredViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}


//- (IBAction)finishBtn:(id)sender {
//
//    switch (self.viewType) {
//        case JMJobExperienceViewTypeDefault:
//            [self createExperience];
//            break;
//        case JMJobExperienceViewTypeEdit:
//            [self updateExperience];
//            break;
//        case JMJobExperienceViewTypeAdd:
//            [self createExperience];
//            break;
//    }
//
//}
-(void)saveBtnAction{
    [_companyNameText resignFirstResponder];
    [_decriptionTextView.contentTextView resignFirstResponder];
    [self.decriptionTextView.contentTextView resignFirstResponder];
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


//- (IBAction)datePickerViewChange:(id)sender {
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    // 格式化日期格式
//    formatter.dateFormat = @"yyyy-MM-dd";
//    NSString *date = [formatter stringFromDate:self.datePckerView.date];
//    // 显示时间
//    if (self.pickerState==startWorkState) {
//
//        [self.startDateBtn setTitle:date forState:UIControlStateNormal];
//        [self.startDateBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
//        self.startDate  = [formatter dateFromString:date];
//    }else if(self.pickerState == endWorkstate){
//
//        [self.endDateBtn setTitle:date forState:UIControlStateNormal];
//        [self.endDateBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
//        self.endDate = [formatter dateFromString:date];
//
//
//    }
//
//}
#pragma mark - MyDelegate
//PositionDesiredViewController代理方法
-(void)sendPositoinData:(NSString *)labStr labIDStr:(NSString *)labIDStr{
    [self.jobLabelId setTitle:labStr forState:UIControlStateNormal];
    [self.jobLabelId setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    self.positionLabId = labIDStr;
}


-(void)sendContent:(NSString *)content{
    _jobDescStr = content;
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    if (pickerDate == _pickerDataStart) {
        NSString *title = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day];
        [self.startDateBtn setTitle:title forState:UIControlStateNormal];
        [self.startDateBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        self.startDate = title;
    }else if (pickerDate == _pickerDataEnd) {
        NSString *title = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day];
        [self.endDateBtn setTitle:title forState:UIControlStateNormal];
        [self.endDateBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        self.endDate = title;
        
    }
    
    
}
#pragma mark - textFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIscrollView

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    [self.datePckerView setHidden:YES];
//
//}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 254){
        switch (buttonIndex) {
            case 0:
                // 取消
                return;
            case 1:
                // 切换身份
                //                sourceType = UIImagePickerControllerSourceTypeCamera;
                [self changeIdentify];
                break;
                
            case 2:
                // 退出登录
                [self logout];
                //                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
        }
        
        
    }
}

-(void)changeIdentify{
    [[JMHTTPManager sharedInstance]userChangeWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        kSaveMyDefault(@"usersig", userInfo.usersig);
        NSLog(@"usersig-----:%@",userInfo.usersig);
        JMJudgeViewController *vc = [[JMJudgeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        [[TIMManager sharedInstance] logout:^() {
            NSLog(@"logout succ");
        } fail:^(int code, NSString * err) {
            NSLog(@"logout fail: code=%d err=%@", code, err);
        }];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)logout{
    [[JMHTTPManager sharedInstance] logoutWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        kRemoveMyDefault(@"token");
        kRemoveMyDefault(@"usersig");
        //token为空执行
        
        [[TIMManager sharedInstance] logout:^() {
            NSLog(@"logout succ");
        } fail:^(int code, NSString * err) {
            NSLog(@"logout fail: code=%d err=%@", code, err);
        }];
        LoginViewController *login = [[LoginViewController alloc] init];
        NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:login];
        [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
    
}


-(void)moreAction{
    
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"切换身份",@"退出登录", nil];
    sheet.tag = 254;
    
    [sheet showInView:self.view];
    
}
-(void)doneClicked{
    [_decriptionTextView.contentTextView resignFirstResponder];
}


-(UIButton *)moreBtn{
    if (_moreBtn == nil) {
        _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,self.decriptionTextView.frame.origin.y+self.decriptionTextView.frame.size.height+10, SCREEN_WIDTH, 40)];
        
        [_moreBtn setTitle:@"更多操作" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _moreBtn;
}

-(STPickerDate *)pickerDataStart{
    if (_pickerDataStart == nil) {
        _pickerDataStart = [[STPickerDate alloc]init];
        _pickerDataStart.delegate = self;
        _pickerDataStart.yearLeast = 1950;
        _pickerDataStart.yearSum = 2018;
        _pickerDataStart.heightPickerComponent = 28;
        
    }
    return _pickerDataStart;
}

-(STPickerDate *)pickerDataEnd{
    if (_pickerDataEnd == nil) {
        _pickerDataEnd = [[STPickerDate alloc]init];
        _pickerDataEnd.delegate = self;
        _pickerDataEnd.yearLeast = 1950;
        _pickerDataEnd.yearSum = 2020;
        _pickerDataEnd.heightPickerComponent = 28;
        
    }
    return _pickerDataEnd;
}

-(JMPartTimeJobResumeFooterView *)decriptionTextView{
    if (_decriptionTextView == nil) {
        _decriptionTextView = [JMPartTimeJobResumeFooterView new];
        _decriptionTextView.frame = CGRectMake(0, self.jobLabelId.frame.origin.y+self.jobLabelId.frame.size.height+20, SCREEN_WIDTH, 150);
        _decriptionTextView.delegate = self;
        _decriptionTextView.contentTextView.inputAccessoryView = self.myToolbar;
        [_decriptionTextView setViewType:JMPartTimeJobResumeFooterViewTypeJobExpDescription];
        //        _decriptionTextView.contentTextView.delegate = self;
        
    }
    return _decriptionTextView;
}

-(UIButton *)saveBtn{
    if (_saveBtn == nil) {
        _saveBtn = [[UIButton alloc]init];
        [_saveBtn setTitle:@"完成" forState:UIControlStateNormal];
        _saveBtn.backgroundColor = MASTER_COLOR;
        [_saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveBtn.layer.cornerRadius = 18.5;
    }
    return _saveBtn;

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
