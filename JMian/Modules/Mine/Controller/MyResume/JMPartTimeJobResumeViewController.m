//
//  JMPartTimeJobResumeViewController.m
//  JMian
//
//  Created by mac on 2019/5/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPartTimeJobResumeViewController.h"
#import "JMPostPartTimeResumeViewController.h"
#import "JMHTTPManager+FectchAbility.h"
#import "JMPostJobHomeTableViewCell.h"
#import "JMAbilityCellData.h"
#import "JMTitlesView.h"
#import "JMHTTPManager+FectchTaskList.h"
#import "JMTaskListCellData.h"
#import "JMBUserPostPositionViewController.h"
#import "JMBUserPostPartTimeJobViewController.h"

@interface JMPartTimeJobResumeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@property (nonatomic, strong)JMTitlesView *titleView;
@property (nonatomic, assign)NSUInteger index;

//@property (nonatomic, assign)NSInteger page;
//@property (nonatomic, assign)NSInteger per_page;
@end
static NSString *cellIdent = @"PartTimePostJobCellID";
@implementation JMPartTimeJobResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    switch (_viewType) {
        case JMPartTimeJobTypeDefault:
            
            [self getData];
            break;
        case JMPartTimeJobTypeManage:
            
            [self getTaskListData];
            break;
            
        default:
            break;
    }
    
}

-(void)getData{
//    NSString *per_page = [NSString stringWithFormat:@"%ld",(long)self.per_page];
//    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [[JMHTTPManager sharedInstance]fectchAbilityList_city_id:nil type_label_id:nil industry_arr:nil myDescription:nil video_path:nil video_cover:nil image_arr:nil status:nil page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.dataArray = [JMAbilityCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
        }
        [self.tableView reloadData];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}


-(void)getTaskListData{

    [[JMHTTPManager sharedInstance]fectchTaskList_user_id:nil city_id:nil type_label_id:nil industry_arr:nil status:nil page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.dataArray = [JMTaskListCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
        }
        [self.tableView reloadData];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];

}

- (IBAction)postPartTimeResumeAction:(UIButton *)sender {
    JMPostPartTimeResumeViewController *vc = [[JMPostPartTimeResumeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addPartTimeJobResume{
    JMPostPartTimeResumeViewController *vc = [[JMPostPartTimeResumeViewController alloc]init];
    vc.viewType = JMPostPartTimeResumeViewAdd;
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMPostJobHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[JMPostJobHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    switch (_viewType) {
        case JMPartTimeJobTypeDefault:
            
            [cell setPartTimeJobModel:self.dataArray[indexPath.row]];
            break;
        case JMPartTimeJobTypeManage:
            [cell setTaskListCellData:self.dataArray[indexPath.row]];
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (_viewType) {
        case JMPartTimeJobTypeDefault:
            [self gotoPostPartTimejobResumeVC_indexPath:indexPath];
            break;
        case JMPartTimeJobTypeManage:
            [self gotoBUserVC__indexPath:indexPath];
            
            break;
            
        default:
            break;
    }

}

-(void)gotoBUserVC__indexPath:(NSIndexPath *)indexPath{
    NSString *task_id;
    NSString *type_labelID;
    JMTaskListCellData *data = self.dataArray[indexPath.row];
    type_labelID = data.type_labelID;
    task_id = data.task_id;
    if ([type_labelID isEqualToString: @"1043"]) {
        [self gotoBUserPostPositionVC_task_id:task_id];
        
    }else{
        [self gotoBUserPostPartTimeJobVC_task_id:task_id];
        
    }
    

}

//C端发布兼职简历
-(void)gotoPostPartTimejobResumeVC_indexPath:(NSIndexPath *)indexPath{

    JMPostPartTimeResumeViewController *vc = [[JMPostPartTimeResumeViewController alloc]init];
    JMAbilityCellData *model = self.dataArray[indexPath.row];
    vc.ability_id = model.ability_id;
    vc.viewType = JMPostPartTimeResumeVieweEdit;
    [self.navigationController pushViewController:vc animated:YES];

}
//B端发布网络销售
-(void)gotoBUserPostPositionVC_task_id:(NSString *)task_id{
    JMBUserPostPositionViewController *vc = [[JMBUserPostPositionViewController alloc]init];
    vc.task_id = task_id;
    [self.navigationController pushViewController:vc animated:YES];

    
}
//B端发布兼职
-(void)gotoBUserPostPartTimeJobVC_task_id:(NSString *)task_id{
    JMBUserPostPartTimeJobViewController *vc = [[JMBUserPostPartTimeJobViewController alloc]init];
    vc.task_id = task_id;
    [self.navigationController pushViewController:vc animated:YES];


}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 89;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_viewType == JMPartTimeJobTypeManage) {
        return self.titleView;

    }else{
        UIButton *headerBtn = [[UIButton alloc]init];
        headerBtn.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:246/255.0 alpha:1.0];
        [headerBtn setTitle:@"再发一份兼职简历 + " forState:UIControlStateNormal];
        [headerBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        headerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [headerBtn addTarget:self action:@selector(addPartTimeJobResume) forControlEvents:UIControlEventTouchUpInside];
        
        return headerBtn;
    }
}


#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = MASTER_COLOR;
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 43;
        _tableView.sectionFooterHeight = 0;
        [_tableView registerNib:[UINib nibWithNibName:@"JMPostJobHomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];

    }
    return _tableView;
}

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"已发布", @"已下线"]];
        __weak JMPartTimeJobResumeViewController *weakSelf = self;
        
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
//            if (index==0) {
//                _status = Position_Online;//已发布职位
//                [weakSelf getListData];
//            }else{
//                _status = Position_Downline;//已下线职位
//                [weakSelf getListData];
//            }
        };
        
    }
    return _titleView;
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
