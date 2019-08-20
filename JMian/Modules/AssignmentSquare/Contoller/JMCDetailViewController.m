//
//  JMCDetailViewController.m
//  JMian
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCDetailViewController.h"
#import "JMTaskDetailHeaderView.h"
#import "JMTitlesView.h"
#import "JMTaskDetailHeaderTableViewCell.h"
#import "JMCDetailCellConfigures.h"

@interface JMCDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) UIView *headerTitleView;
@property (nonatomic, strong) JMTaskDetailHeaderView *taskDetailHeaderView;

@property (nonatomic, strong) JMTitlesView *titleView;
@property (assign, nonatomic) NSUInteger index;

@end

@implementation JMCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view);
    }];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 159;
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else  if (section == 1) {
        return 10;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    return 137;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.titleView;
    }
    return [UIView new];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }
    return 0;

}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case JMTaskDetailCellTypeHeader: {
            JMTaskDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMTaskDetailHeaderTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
            return cell;
        }
        case JMTaskDetail2CellType: {
            JMTaskDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMTaskDetailHeaderTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
            return cell;
        }
        default:
            break;
    }
    return nil;
}

#pragma mark - lazy
-(JMTaskDetailHeaderView *)taskDetailHeaderView{
    if (!_taskDetailHeaderView) {
        _taskDetailHeaderView = [[JMTaskDetailHeaderView alloc]init];
    }
    return _taskDetailHeaderView;
    
}

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"任务描述", @"信誉评价"]];
        __weak JMCDetailViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
//            [weakSelf showPageContentView];
        };
    }
    
    return _titleView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        //        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //        _tableView.sectionHeaderHeight = 43;
        //        _tableView.sectionFooterHeight = 0;
        [_tableView registerNib:[UINib nibWithNibName:@"JMTaskDetailHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMTaskDetailHeaderTableViewCellIdentifier];
   
        
    }
    return _tableView;
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
