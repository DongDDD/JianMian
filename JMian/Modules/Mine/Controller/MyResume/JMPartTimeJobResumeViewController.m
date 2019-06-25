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
#import "JMBUserPostSaleJobViewController.h"
#import "JMBUserPostPartTimeJobViewController.h"

@interface JMPartTimeJobResumeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@property (nonatomic, strong) JMTitlesView *titleView;
@property (nonatomic, assign) NSUInteger index;
//@property (strong, nonatomic) NSString *status;
@property (weak, nonatomic) IBOutlet UILabel *no_dataLab;
@property (weak, nonatomic) IBOutlet UIButton *no_dataBtn;

//@property (nonatomic, assign)NSInteger page;
//@property (nonatomic, assign)NSInteger per_page;
@end
static NSString *cellIdent = @"PartTimePostJobCellID";
@implementation JMPartTimeJobResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_viewType == JMPartTimeJobTypeManage) {
        [self.view addSubview:self.titleView];
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleView.mas_bottom);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
            make.left.and.right.mas_equalTo(self.view);
        }];
        self.no_dataLab.text = @"你还没有发布任务，快去发布吧！";
        [self.no_dataBtn setTitle:@"发布任务" forState:UIControlStateNormal];
        
    }else if (_viewType == JMPartTimeJobTypeResume){
        [self.view addSubview:self.tableView];

    }
    [self showProgressHUD_view:self.view];

    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    switch (_viewType) {
        case JMPartTimeJobTypeResume:
            [self getAbilityListData];
            break;
        case JMPartTimeJobTypeManage:
            [self getCurrrentDataWithIndex:_index];
            break;
            
        default:
            break;
    }
    
}

-(void)getAbilityListData{
//    NSString *per_page = [NSString stringWithFormat:@"%ld",(long)self.per_page];
//    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [[JMHTTPManager sharedInstance]fectchAbilityList_city_id:nil type_label_id:nil industry_arr:nil myDescription:nil video_path:nil video_cover:nil image_arr:nil status:nil page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.dataArray = [JMAbilityCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            if (self.dataArray.count == 0) {
                [self.tableView setHidden:YES];
            }else{
            
                [self.tableView setHidden:NO];
            }
        }
//        [self hiddenHUD];
        [self.myProgressHUD setHidden:YES];

        [self.tableView reloadData];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}


-(void)getTaskListData_status:(NSString *)status{
  
    [[JMHTTPManager sharedInstance]fectchTaskList_user_id:nil city_id:nil type_label_id:nil industry_arr:nil status:status page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.dataArray = [JMTaskListCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            //上线状态下才需要隐藏
            if (self.dataArray.count==0) {
                if (_index == 0) {
                    [self.tableView setHidden:YES];
                }
            }else{
                [self.tableView setHidden:NO];
                
            }
            
            
        }
        [self.tableView reloadData];
        [self.myProgressHUD setHidden:YES];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];

}




- (IBAction)postPartTimeResumeAction:(UIButton *)sender {
    if (_viewType == JMPartTimeJobTypeResume) {
        
        JMPostPartTimeResumeViewController *vc = [[JMPostPartTimeResumeViewController alloc]init];
        vc.viewType = JMPostPartTimeResumeViewAdd;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (_viewType == JMPartTimeJobTypeManage) {
        if (_delegate && [_delegate respondsToSelector:@selector(postPartTimeJobAction)]) {
            [_delegate postPartTimeJobAction];
        }
    }
}

-(void)addPartTimeJobResume{
    JMPostPartTimeResumeViewController *vc = [[JMPostPartTimeResumeViewController alloc]init];
    vc.viewType = JMPostPartTimeResumeViewAdd;
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)getCurrrentDataWithIndex:(NSInteger)index{
    [self.myProgressHUD setHidden:NO];

    if (index == 0) {
        //已发布职位
        [self getTaskListData_status:Position_Online];
    }else if (index == 1) {
        //已下线职位
        [self getTaskListData_status:Position_Downline];
    }

}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMPostJobHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[JMPostJobHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    switch (_viewType) {
        case JMPartTimeJobTypeResume:
            
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
        case JMPartTimeJobTypeResume:
            [self gotoPostPartTimejobResumeVC_indexPath:indexPath];
            break;
        case JMPartTimeJobTypeManage:
            [self gotoBUserPostPartTimeVC__indexPath:indexPath];
            break;
        default:
            break;
    }

}

-(void)gotoBUserPostPartTimeVC__indexPath:(NSIndexPath *)indexPath{
    NSString *task_id;
    NSString *payment_method;
    JMTaskListCellData *data = self.dataArray[indexPath.row];
    payment_method = data.payment_method;
    task_id = data.task_id;
    if ([payment_method isEqualToString: @"1"]) {
        //网络销售
        [self gotoBUserPostPositionVC_task_id:task_id];
        
    }else{
        //其他兼职
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
    JMBUserPostSaleJobViewController *vc = [[JMBUserPostSaleJobViewController alloc]init];
    vc.viewType = JMBUserPostSaleJobViewTypeEdit;
    vc.task_id = task_id;
    [self.navigationController pushViewController:vc animated:YES];

    
}
//B端发布任务
-(void)gotoBUserPostPartTimeJobVC_task_id:(NSString *)task_id{
    JMBUserPostPartTimeJobViewController *vc = [[JMBUserPostPartTimeJobViewController alloc]init];
    vc.viewType = JMBUserPostPartTimeJobTypeEdit;
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
    if (_viewType == JMPartTimeJobTypeResume) {
        UIButton *headerBtn = [[UIButton alloc]init];
        headerBtn.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:246/255.0 alpha:1.0];
        [headerBtn setTitle:@"再发一份兼职简历 + " forState:UIControlStateNormal];
        [headerBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        headerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [headerBtn addTarget:self action:@selector(addPartTimeJobResume) forControlEvents:UIControlEventTouchUpInside];
        
        return headerBtn;
    }else{
        return [UIView new];
    }
}


#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _titleView.frame.size.height, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        if (_viewType == JMPartTimeJobTypeManage) {
            _tableView.sectionHeaderHeight = 0;
        }else{
            _tableView.sectionHeaderHeight = 43;
        }
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
            [weakSelf getCurrrentDataWithIndex:index];
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
