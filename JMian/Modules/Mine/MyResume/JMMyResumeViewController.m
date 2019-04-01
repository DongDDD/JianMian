//
//  JMMyResumeViewController.m
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeViewController.h"
#import "JMMyResumeCellConfigures.h"

@interface JMMyResumeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) JMMyResumeCellConfigures *cellConfigures;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation JMMyResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的简历";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.bottom.equalTo(self.view);
    }];

}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (indexPath.section) {
//        case JMMyResumeCellTypeIcon: {
//            JMMyResumeIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeIconTableViewCellIdentifier forIndexPath:indexPath];
//            return cell;
//        }
//        case JMMyResumeCellTypeHeader:
//        {
//            JMMyResumeHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeaderTableViewCellIdentifier forIndexPath:indexPath];
//            return cell;
//        }
//        case JMMyResumeCellTypeCareerObjective:
//        {
//            JMMyResumeCareerObjectiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeCareerObjectiveTableViewCellIdentifier forIndexPath:indexPath];
//            return cell;
//        }
//        case JMMyResumeCellTypeHeader2:
//        {
//            JMMyResumeHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeader2TableViewCellIdentifier forIndexPath:indexPath];
//            return cell;
//        }
//        case JMMyResumeCellTypeCareerStatus:
//        {
//            JMMyResumeHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeader2TableViewCellIdentifier forIndexPath:indexPath];
//            return cell;
//        }
//        case JMMyResumeCellTypeCareerStatus2:
//        {
//            JMMyResumeHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyResumeHeader2TableViewCellIdentifier forIndexPath:indexPath];
//            return cell;
//        }
//        default:
//            break;
//    }
    
    NSString *cellId = [self.cellConfigures cellIdForSection:indexPath.section];
    id cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
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
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeCareerStatusTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeCareerStatusTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyResumeCareerStatusTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyResumeCareerStatus2TableViewCellIdentifier];

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
