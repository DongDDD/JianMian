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
@property (nonatomic, assign)CGFloat changeHeight;
@property(nonatomic,strong)UIButton *moreBtn;

@end

@implementation JMJobExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datePckerView.backgroundColor = BG_COLOR;
    self.scrollView.delegate = self;
    [self.scrollView addSubview:self.moreBtn];
    [self.view addSubview:_datePckerView];

    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenDatePickerAction)];
    [self.view addGestureRecognizer:bgTap];
    // Do any additional setup after loading the view from its nib.
    
    switch (self.viewType) {
        case JMJobExperienceViewTypeDefault:
            [self setRightBtnTextName:@"下一步"];
            [self setIsHiddenBackBtn:YES];
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
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*1.2);
    
}

- (void)viewDidDisappear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//- (void)keyboardWillShow:(NSNotification *)aNotification {
//    [self.datePckerView setHidden:YES];
//    NSDictionary *userInfo = aNotification.userInfo;
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = aValue.CGRectValue;
//    CGRect frame = self.jobDescriptionText.frame;
//    self.changeHeight = keyboardRect.size.height - (frame.origin.y+frame.size.height);
//    CGRect rect= CGRectMake(0,_changeHeight,SCREEN_WIDTH,SCREEN_HEIGHT);
//    if (_changeHeight < 0) {
//
//        [UIView animateWithDuration:0.3 animations:^ {
//            self.scrollView.frame = rect;
//
//        }];
//    }
//    /* 输入框上移 */
//    //    CGFloat padding = 20;
//    //    CGRect frame = self.nameText.frame;
//    //    self.changeHeight = _keyboardRect.size.height - (frame.origin.y+frame.size.height);
//    //    if (self.changeHeight < 0) {
//    //        [UIView animateWithDuration:0.3 animations:^ {
//    //
//    //            self.topToView.constant += self.changeHeight-10;
//    //
//    //        }];
//    //    }
//
//}
//
//- (void)keyboardWillHide:(NSNotification *)aNotification {
//    float width = SCREEN_WIDTH;
//    float height = SCREEN_HEIGHT;
//    //上移n个单位，按实际情况设置
//    if (_changeHeight < 0) {
//        CGRect rect=CGRectMake(0,-_changeHeight,width,height);
//        self.scrollView.frame=rect;
//
//    }
//
//}


#pragma mark - 点击事件


-(void)hiddenDatePickerAction{
    self.datePckerView.hidden = YES;
    [_companyNameText resignFirstResponder];
    [_jobDescriptionText resignFirstResponder];
    
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
    [_jobDescriptionText resignFirstResponder];
    [self.datePckerView setHidden:NO];
     self.pickerState = startWorkState;
}


- (IBAction)endWorkAction:(UIButton *)sender {
    [_companyNameText resignFirstResponder];
    [_jobDescriptionText resignFirstResponder];
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

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
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


-(UIButton *)moreBtn{
    if (_moreBtn == nil) {
        _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,self.jobDescriptionText.frame.origin.y+self.jobDescriptionText.frame.size.height+10, SCREEN_WIDTH, 40)];
        
        [_moreBtn setTitle:@"更多操作" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _moreBtn;
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
