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

@interface JMMyResumeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) JMMyResumeCellConfigures *cellConfigures;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) JMVitaDetailModel *model;

@end

@implementation JMMyResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的简历";
    [self sendRequest];

}

- (void)initView {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.bottom.equalTo(self.view);
    }];
    }

- (void)sendRequest {
    [[JMHTTPManager sharedInstance] fetchVitPaginateWithCity_id:nil education:nil job_label_id:nil work_year_s:nil work_year_e:nil salary_min:nil salary_max:nil page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        int jobId = [responsObject[@"data"][0][@"user_job_id"] intValue];
        [[JMHTTPManager sharedInstance] fetchVitaInfoWithId:@(jobId) successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            self.model = [JMVitaDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
            self.cellConfigures.model = self.model;
            [self initView];
            [self.tableView reloadData];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case JMMyResumeCellTypeIcon: {
            JMMyResumeIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeIconTableViewCellIdentifier forIndexPath:indexPath];
            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
            return cell;
        }
        case JMMyResumeCellTypeHeader:
        {
            JMMyResumeHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeaderTableViewCellIdentifier forIndexPath:indexPath];
            [cell cellConfigWithIdentifier:JMMyResumeHeaderTableViewCellIdentifier imageViewName:@"job_wanted" title:@"求职意向"];
            return cell;
        }
        case JMMyResumeCellTypeCareerStatus:
        {
            JMMyResumeCareerStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeCareerStatusTableViewCellIdentifier forIndexPath:indexPath];
            [cell setWorkStatus:self.model.vita_work_status];
            return cell;
        }
        case JMMyResumeCellTypeCareerObjective:
        {
            JMMyResumeCareerObjectiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeCareerObjectiveTableViewCellIdentifier
                                                                                           forIndexPath:indexPath];
            [cell setCareerObjectiveWithLeftLabelText:self.cellConfigures.careerObjectiveLeftArr[indexPath.row]];
            [cell setCareerObjectiveWithRightLabelText:self.cellConfigures.careerObjectiveRightArr[indexPath.row]];
            return cell;
        }
        case JMMyResumeCellTypeHeader2:
        {
            JMMyResumeHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeader2TableViewCellIdentifier forIndexPath:indexPath];
            [cell cellConfigWithIdentifier:JMMyResumeHeader2TableViewCellIdentifier imageViewName:@"experience" title:@"工作经历"];
            return cell;
        }
        case JMMyResumeCellTypeWorkExperience:
        {
            JMMyResumeWorkExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeWorkExperienceTableViewCellIdentifier forIndexPath:indexPath];
            [cell setWorkExperienceModel:self.cellConfigures.workExperienceArr[indexPath.row]];
            return cell;
        }
        case JMMyResumeCellTypeAction:
        {
            JMMyReSumeActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyReSumeActionTableViewCellIdentifier forIndexPath:indexPath];
            return cell;
        }
        case JMMyResumeCellTypeHeader3:
        {
            JMMyResumeHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeader3TableViewCellIdentifier forIndexPath:indexPath];
            [cell cellConfigWithIdentifier:JMMyResumeHeader3TableViewCellIdentifier imageViewName:@"photograph" title:@"图片作品"];
            return cell;
        }
        case JMMyResumeCellTypeHeader4:
        {
            JMMyResumeHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeader4TableViewCellIdentifier forIndexPath:indexPath];
            [cell cellConfigWithIdentifier:JMMyResumeHeader4TableViewCellIdentifier imageViewName:@"education" title:@"教育经历"];
            return cell;
        }
        case JMMyResumeCellTypeEducationalExperience:
        {
            JMEducationalExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMEducationalExperienceTableViewCellIdentifier forIndexPath:indexPath];
            return cell;
        }
        case JMMyResumeCellTypeHeaderOnlyLabel:
        {
            JMMyResumeHeader2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeaderOnlyLabelTableViewCellIdentifier forIndexPath:indexPath];
            return cell;
        }
        case JMMyResumeCellTypyText:
        {
            JMMyResumeTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeTextTableViewCellIdentifier forIndexPath:indexPath];
            [cell setVitadescription:self.cellConfigures.vita_description];
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
            [self.navigationController pushViewController:vc animated:YES];\
            break;
         }
        case JMMyResumeCellTypeHeader:
        {
            
        }
        case JMMyResumeCellTypeCareerStatus:
        {
        }
        case JMMyResumeCellTypeCareerObjective:
        {
        }
        case JMMyResumeCellTypeHeader2:
        {
                    }
        case JMMyResumeCellTypeWorkExperience:
        {
            JMJobExperienceViewController *vc = [[JMJobExperienceViewController alloc] init];
            vc.viewType = JMJobExperienceViewTypeEdit;
            vc.model = self.cellConfigures.workExperienceArr[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case JMMyResumeCellTypeAction:
        {
            JMJobExperienceViewController *vc = [[JMJobExperienceViewController alloc] init];
            vc.viewType = JMJobExperienceViewTypeAdd;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case JMMyResumeCellTypeHeader3:
        {
           
        }
        case JMMyResumeCellTypeHeader4:
        {
        }
        case JMMyResumeCellTypeEducationalExperience:
        {
        }
        case JMMyResumeCellTypeHeaderOnlyLabel:
        {
        }
        case JMMyResumeCellTypyText:
        {
        }
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 12;
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
#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeIconTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeIconTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeCareerObjectiveTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeCareerObjectiveTableViewCellIdentifier];
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
@end
