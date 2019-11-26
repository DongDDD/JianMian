//
//  JMVideoJobListViewController.m
//  JMian
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVideoJobListViewController.h"
#import "JMVideoJoblistTableViewCell.h"
#import "JMHTTPManager+FetchCompanyInfo.h"
#import "JobDetailsViewController.h"
#import "JMCompanyInfoModel.h"


@interface JMVideoJobListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)JMCompanyInfoModel *companyInfoModel;

@end

static NSString *cellIdent = @"cellIdent";

@implementation JMVideoJobListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"公司职位";
    [self getData];
    [self.view addSubview:self.tableView];
}


-(void)getData{
    [[JMHTTPManager sharedInstance]fetchCompanyInfo_Id:self.company_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.dataArray = [JMHomeWorkModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"][@"work"]];
            [self.tableView reloadData];
            if (self.dataArray.count == 0) {
                [self.view addSubview:self.noDataView];
            }
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //重用单元格
    JMVideoJoblistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    //初始化单元格
    if(cell == nil)
    {
        cell = [[JMVideoJoblistTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
        //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
    }
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.delegate = self;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    JMHomeWorkModel *model = self.dataArray[indexPath.row];
    [cell setModel:model];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobDetailsViewController *vc = [[JobDetailsViewController alloc] init];
    JMHomeWorkModel *model = self.dataArray[indexPath.row];
    
    vc.homeworkModel = model;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 120.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        [self.tableView registerNib:[UINib nibWithNibName:@"JMVideoJoblistTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
        
        
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
