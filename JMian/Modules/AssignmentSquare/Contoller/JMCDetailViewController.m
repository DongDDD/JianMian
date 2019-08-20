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

//@property (nonatomic, strong) UIView *headerTitleView;
@property (nonatomic, strong) JMTaskDetailHeaderView *taskDetailHeaderView;

@property (nonatomic, strong) JMTitlesView *titleView;
@property (assign, nonatomic) NSUInteger index;

@end

@implementation JMCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ininView];
    // Do any additional setup after loading the view from its nib.
}


-(void)ininView{
//    [self.view addSubview:self.taskDetailHeaderView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view);
    }];

}

#pragma mark - UITableViewDataSource
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (section == 0) {
//        return  10;
//    }
//    return 0;
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
//        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor redColor];
//    }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
         return 1;
    }else if (section == 1) {
        return 2;
    }else if (section == 2) {
        return 10;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        return 105;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 299;
        }else  if (indexPath.row == 1) {
            return 364;
        }
    }else if (indexPath.section == 2) {
        return 105;
        
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.titleView;
    }
//    else if (section == 2) {
//        return self.titleView;
//
//    }
    return [UIView new];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }
//    else if (section == 2) {
//        return 44;
//
//    }
    return 0;

}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        JMTaskDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMTaskDetailHeaderTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
        return cell;
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            JMCDetailTaskDecriTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailTaskDecriTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
            return cell;
            
        }else if (indexPath.row == 1) {
            JMCDetailTaskDecri2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailTaskDecri2TableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
            return cell;
        }
    
    }else if (indexPath.section == 2) {
        JMTaskDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMTaskDetailHeaderTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //            [cell setUserInfo:[JMUserInfoManager getUserInfo]];
        return cell;
    }

    return nil;
}


-(void)showPageContentView{
    switch (_index) {
        case 0:
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        case 1:
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        default:
            break;
    }

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
            [weakSelf showPageContentView];
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
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecriTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailTaskDecriTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecri2TableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailTaskDecri2TableViewCellIdentifier];
        
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
