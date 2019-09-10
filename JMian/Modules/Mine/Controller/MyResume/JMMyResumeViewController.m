//
//  JMMyResumeViewController.m
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeViewController.h"
#import "JMMyResumeCellConfigures.h"
#import "JMHTTPManager+Vita.h"
#import "JMVitaDetailModel.h"
#import "BasicInformationViewController.h"
#import "JMJobExperienceViewController.h"
#import "JMEducationExperienceViewController.h"
#import "JMMyDescriptionViewController.h"
#import "PositionDesiredViewController.h"
#import "JMMyPictureViewController.h"
#import "JMHTTPManager+Job.h"
#import "JMAddVitaJobViewController.h"
#import "JMMyResumeFooterView.h"
#import "JMMPersonalCenterHeaderView.h"
#import "JMMyResumeHeaderSecondTableViewCell.h"
#import "JMTitlesView.h"
#import "JMPartTimeJobResumeViewController.h"
#import "STPickerSingle.h"
#import "JMNoResumeDataView.h"
#import "JobIntensionViewController.h"


@interface JMMyResumeViewController ()<UITableViewDelegate,UITableViewDataSource,PositionDesiredDelegate,UIPickerViewDelegate,UIPickerViewDataSource,JMMyResumeFooterViewDelegate,JMMyResumeCareerStatusTableViewCellDelegate,STPickerSingleDelegate,JMNoResumeDataViewDelegate>

@property (strong, nonatomic) JMMyResumeCellConfigures *cellConfigures;
@property (strong, nonatomic) JMTitlesView *titleView;
@property (strong, nonatomic) JMPartTimeJobResumeViewController *partTimeJobVC;
@property (strong, nonatomic) UIView *BGView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) JMVitaDetailModel *model;
@property (copy, nonatomic) NSString *job_labelID;
//@property (strong, nonatomic) UIPickerView *pickerView;
//@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSArray *pickerArray;
@property (nonatomic, strong) NSNumber *salaryMin;
@property (nonatomic, strong) NSNumber *salaryMax;
@property (nonatomic, copy) NSString *work_start_date;
@property (nonatomic, copy) NSString *work_status;

@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) STPickerSingle *jobStatusPickerSingle;
@property (nonatomic, strong)JMNoResumeDataView *noResmuseDataView;

@end

@implementation JMMyResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的简历";
    [self.view addSubview:self.progressHUD];
//    [self.view addSubview:self.BGView];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self sendRequest];
}

- (void)initView {
    [self.view addSubview:self.BGView];
    [self.view addSubview:self.titleView];
    [self.BGView addSubview:self.tableView];
    [self.BGView addSubview:self.partTimeJobVC.view];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).mas_offset(self.titleView.frame.origin.y+self.titleView.frame.size.height);
        make.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
//    [self.partTimeJobVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tableView);
//        make.width.mas_equalTo(self.view);
//        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
//        make.left.mas_equalTo(self.tableView.mas_right);
//    }];
}

- (void)sendRequest {

    [[JMHTTPManager sharedInstance] fetchVitPaginateWithCity_id:nil education:nil job_label_id:nil work_year_s:nil work_year_e:nil salary_min:nil salary_max:nil page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        [[JMHTTPManager sharedInstance] fetchVitaInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            if (responsObject[@"data"] != NULL) {
                self.model = [JMVitaDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
                self.cellConfigures.model = self.model;
                self.job_labelID = self.model.job_label_id;
                self.salaryMin = @([self.model.salary_min intValue]);
                self.salaryMax = @([self.model.salary_max intValue]);
                [self initView];
                [self.tableView reloadData];
                [self.progressHUD setHidden:YES]; //显示进度框
                if (self.model.jobs.count == 0) {
                    [self.tableView addSubview:self.noResmuseDataView];
                    [self.noResmuseDataView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.mas_equalTo(self.view);
                        make.top.mas_equalTo(self.view).offset(98+44);
                        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
                    }];
                    self.tableView.scrollEnabled = NO;
                }else{
                    self.tableView.scrollEnabled = YES;
                    [self.noResmuseDataView setHidden:YES];
                }
            }
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

//- (void)updateJob {
//    [[JMHTTPManager sharedInstance] updateJobWith_user_job_id:self.model.user_job_id job_label_id:self.job_labelID industry_label_id:nil city_id:nil salary_min:self.salaryMin salary_max:self.salaryMax status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//
//        [self sendRequest];
//
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//}

- (void)updateVita {
    [[JMHTTPManager sharedInstance] updateVitaWith_work_status:nil education:nil work_start_date:self.work_start_date description:nil video_path:nil video_cover:nil image_paths:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        [self sendRequest];

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

-(void)upDateInfo_status:(NSString *)status{
    _work_status = status;
    [[JMHTTPManager sharedInstance] updateVitaWith_work_status:status education:nil work_start_date:self.work_start_date description:nil video_path:nil video_cover:nil image_paths:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        [self sendRequest];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"yyyy-MM-dd";
//    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    
    self.work_start_date = [formatter  stringFromDate:datePicker.date];
    [self updateVita];

}

-(void)setCurrentIndex{
    __weak typeof(self) ws = self;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect Frame = ws.BGView.frame;
        Frame.origin.x = -_index * SCREEN_WIDTH;
        ws.BGView.frame = Frame;
//        CGRect Frame2 = ws.partTimeJobVC.view.frame;
//        Frame2.origin.x = -_index * SCREEN_WIDTH;
//        ws.partTimeJobVC.view.frame = Frame2;

        
    } completion:nil];
    
    
    
}
//PositionDesiredViewController代理方法
//-(void)sendPositoinData:(NSString *)labStr labIDStr:(NSString *)labIDStr{
//
//    self.job_labelID = labIDStr;
//    self.model.work_name = labStr;
//    [self updateJob];
//
//}

-(void)addJobAction{
    JMAddVitaJobViewController *vc = [[JMAddVitaJobViewController alloc]init];
    vc.viewType = JMAddVitaJobViewTypeAdd;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)fanhui{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - myDelegate

-(void)didClickCreateResumeAction{
    JobIntensionViewController *vc = [[JobIntensionViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//#pragma mark - PickerViewDelegate
//
////返回有几列
//
//-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//
//}
//
////返回指定列的行数
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
//
//
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//
//    NSString *salaryStr =[self.pickerArray objectAtIndex:row];
//    [self setSalaryRangeWithSalaryStr:salaryStr];
//}

//-(void)setSalaryRangeWithSalaryStr:(NSString *)salaryStr{
//    NSArray *array = [salaryStr componentsSeparatedByString:@"~"]; //从字符 ~ 中分隔成2个元素的数组
//
//    NSString *minStr = array[0];
//    NSString *maxStr = array[1];
//
//    NSInteger minNum = [minStr integerValue];
//    NSInteger maxNum = [maxStr integerValue];
//
//
//    self.salaryMin = @(minNum);
//    self.salaryMax = @(maxNum);
//
//}
#pragma mark - PickerViewDelegate
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle row:(NSInteger)row{
    //    _isChange = YES;
    if (pickerSingle == _jobStatusPickerSingle) {
        NSString *status = [self getJobStatusWithStatusStr:selectedTitle];
        [self upDateInfo_status:status];
        
    }
    
    
    
}
#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case JMMyResumeCellTypeIcon: {
            JMMyResumeIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeIconTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
            return cell;
        }
        case JMMyResumeCellTypeHeader:
        {
            JMMyResumeHeaderSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeaderSecondTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.delegate = self;
            [cell setWorkStatus:self.model.work_status];
            return cell;
        }
        case JMMyResumeCellTypeCareerStatus:
        {
            JMMyResumeHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeaderTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell cellConfigWithIdentifier:JMMyResumeHeaderTableViewCellIdentifier imageViewName:@"job_wanted" title:@"求职意向"];
            return cell;
        }
        case JMMyResumeCellTypeCareerObjective:
        {
            JMMyResumeCareerObjectiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeCareerObjectiveTableViewCellIdentifier
                                                                                           forIndexPath:indexPath];
            [cell setCareerObjectiveWithModel:self.cellConfigures.jobstArr[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [cell setCareerObjectiveWithRightLabelText:self.cellConfigures.careerObjectiveRightArr[indexPath.row]];
            return cell;
        }
        case JMMyResumeCellTypeHeader2:
        {
            JMMyResumeHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeader2TableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell cellConfigWithIdentifier:JMMyResumeHeader2TableViewCellIdentifier imageViewName:@"experience" title:@"工作经历"];
            return cell;
        }
        case JMMyResumeCellTypeWorkExperience:
        {
//            JMMyResumeWorkExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeWorkExperienceTableViewCellIdentifier forIndexPath:indexPath];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [cell setWorkExperienceModel:self.cellConfigures.workExperienceArr[indexPath.row]];
            JMEducationalExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMEducationalExperienceTableViewCellIdentifier forIndexPath:indexPath];
            [cell setExperiencesModel:self.cellConfigures.workExperienceArr[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case JMMyResumeCellTypeAction:
        {
            JMMyReSumeActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyReSumeActionTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case JMMyResumeCellTypeHeader3:
        {//已隐藏
            JMMyResumeHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeader3TableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell cellConfigWithIdentifier:JMMyResumeHeader3TableViewCellIdentifier imageViewName:@"resumePic" title:@"图片作品"];
            return cell;
        }
        case JMMyResumeCellTypeHeader4:
        {
            JMMyResumeHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeader4TableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell cellConfigWithIdentifier:JMMyResumeHeader4TableViewCellIdentifier imageViewName:@"education" title:@"教育经历"];
            return cell;
        }
        case JMMyResumeCellTypeEducationalExperience:
        {
            JMEducationalExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMEducationalExperienceTableViewCellIdentifier forIndexPath:indexPath];
            [cell setEducationExperienceModel:self.cellConfigures.educationalExperienceArr[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case JMMyResumeCellTypeHeaderOnlyLabel:
        {
            JMMyResumeHeader2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeaderOnlyLabelTableViewCellIdentifier forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case JMMyResumeCellTypyText:
        {
            JMMyResumeTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeTextTableViewCellIdentifier forIndexPath:indexPath];
            [cell setVitadescription:self.cellConfigures.model.myDescription];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        default:
            break;
    }
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case JMMyResumeCellTypeIcon: {
            BasicInformationViewController *vc= [[BasicInformationViewController alloc] init];
            vc.model = [JMUserInfoManager getUserInfo];
            vc.viewType = BasicInformationViewTypeEdit;
            [self.navigationController pushViewController:vc animated:YES];
            break;
         }
        case JMMyResumeCellTypeHeader:
        {
            [self.view addSubview:self.jobStatusPickerSingle];
            [self.jobStatusPickerSingle show];
            
            
            break;

        }
        case JMMyResumeCellTypeCareerStatus:
        {
            JMAddVitaJobViewController *vc = [[JMAddVitaJobViewController alloc]init];
            vc.viewType = JMAddVitaJobViewTypeAdd;
            [self.navigationController pushViewController:vc animated:YES];
            break;
            
        }
        case JMMyResumeCellTypeCareerObjective:
        {
            JMAddVitaJobViewController *vc = [[JMAddVitaJobViewController alloc]init];
            vc.model = self.cellConfigures.jobstArr[indexPath.row];
            vc.viewType = JMAddVitaJobViewTypeEdit;
            [self.navigationController pushViewController:vc animated:YES];

           
//            else if (indexPath.row == 1) {
//                self.datePicker.hidden = YES;
//                [self.pickerView setHidden:NO];
//
//            }else if (indexPath.row == 2) {
//
//            }else {
//                self.datePicker.hidden = NO;
//                [self.pickerView setHidden:YES];
//            }
            break;

        }
        case JMMyResumeCellTypeHeader2://添加工作经历
        {
            JMJobExperienceViewController *vc = [[JMJobExperienceViewController alloc] init];
            vc.viewType = JMJobExperienceViewTypeAdd;
            [self.navigationController pushViewController:vc animated:YES];
            break;

        }
        case JMMyResumeCellTypeWorkExperience://编辑工作经历
        {
            JMJobExperienceViewController *vc = [[JMJobExperienceViewController alloc] init];
            vc.viewType = JMJobExperienceViewTypeEdit;
            vc.model = self.cellConfigures.workExperienceArr[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case JMMyResumeCellTypeAction:
        {
//            JMJobExperienceViewController *vc = [[JMJobExperienceViewController alloc] init];
//            vc.viewType = JMJobExperienceViewTypeAdd;
//            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case JMMyResumeCellTypeHeader3:
        {
            JMMyPictureViewController *vc = [[JMMyPictureViewController alloc] init];
//            vc.image_paths = self.model.files;
            [self.navigationController pushViewController:vc animated:YES];
            break;

        }
        case JMMyResumeCellTypeHeader4:
        {
            JMEducationExperienceViewController *vc = [[JMEducationExperienceViewController alloc] init];
            vc.viewType = JMEducationExperienceViewTypeAdd;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case JMMyResumeCellTypeEducationalExperience:
        {
            JMEducationExperienceViewController *vc = [[JMEducationExperienceViewController alloc] init];
            vc.viewType = JMEducationExperienceViewTypeEdit;
            vc.model = self.cellConfigures.educationalExperienceArr[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case JMMyResumeCellTypeHeaderOnlyLabel:
        {
            JMMyDescriptionViewController *vc = [[JMMyDescriptionViewController alloc] init];
            vc.myDescription = self.cellConfigures.model.myDescription;
            [self.navigationController pushViewController:vc animated:YES];
            break;

        }
        case JMMyResumeCellTypyText:
        {
            
            break;
        }
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    if (section == JMMyResumeCellTypeHeader) {
//        JMMyResumeFooterView *footerView = [[JMMyResumeFooterView alloc]init];
//        footerView.delegate = self;
//
//        return footerView;
//
//    }
    return [UIView new];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 13;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellConfigures numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellConfigures heightForRowsInSection:indexPath.section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.cellConfigures heightForFooterInSection:section];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    self.pickerView.hidden = YES;
//}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeIconTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeIconTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeCareerObjectiveTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeCareerObjectiveTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeHeaderSecondTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeHeaderSecondTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeHeader2TableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeHeader3TableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeHeader4TableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeCareerStatusTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeCareerStatusTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeCareerStatusTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeCareerStatus2TableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeWorkExperienceTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeWorkExperienceTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyReSumeActionTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyReSumeActionTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMEducationalExperienceTableViewCell" bundle:nil] forCellReuseIdentifier:JMEducationalExperienceTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeHeader2TableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeHeaderOnlyLabelTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeTextTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeTextTableViewCellIdentifier];

    }
    return _tableView;
}

- (JMMyResumeCellConfigures *)cellConfigures {
    if (!_cellConfigures) {
        _cellConfigures = [[JMMyResumeCellConfigures alloc] init];
    }
    return _cellConfigures;
}

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"全职简历", @"任务简历"]];
        __weak JMMyResumeViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf setCurrentIndex];
        };
    }
    
    return _titleView;
}

-(UIView *)BGView{
    if (!_BGView) {
        _BGView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH*2, self.view.frame.size.height)];

    }
    return _BGView;
}



-(MBProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.progress = 0.6;
        _progressHUD.dimBackground = NO; //设置有遮罩
        [_progressHUD showAnimated:YES]; //显示进度框
    }
    return _progressHUD;
}

-(JMPartTimeJobResumeViewController *)partTimeJobVC{
    if (!_partTimeJobVC) {
        _partTimeJobVC = [[JMPartTimeJobResumeViewController alloc]init];
        _partTimeJobVC.view.frame = CGRectMake(SCREEN_WIDTH,self.titleView.frame.size.height, SCREEN_WIDTH, self.view.frame.size.height-self.titleView.frame.size.height);
        [self addChildViewController:_partTimeJobVC];
        
    }
    return _partTimeJobVC;
}


-(STPickerSingle *)jobStatusPickerSingle{
    if (_jobStatusPickerSingle == nil) {
        _jobStatusPickerSingle = [[STPickerSingle alloc]init];
        _jobStatusPickerSingle.delegate = self;
        _jobStatusPickerSingle.title = @"求职状态";
        _jobStatusPickerSingle.contentMode = STPickerContentModeCenter;
        _jobStatusPickerSingle.widthPickerComponent = SCREEN_WIDTH;
        _jobStatusPickerSingle.arrayData = [NSMutableArray arrayWithObjects:                                            @"应届生",
                                            @"在职",
                                            @"离职",
                                            nil];
    }
    return _jobStatusPickerSingle;
}

-(JMNoResumeDataView *)noResmuseDataView{
    if (!_noResmuseDataView) {
        _noResmuseDataView = [[JMNoResumeDataView alloc]initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _noResmuseDataView.delegate = self;
    }
    return _noResmuseDataView;
}

@end
