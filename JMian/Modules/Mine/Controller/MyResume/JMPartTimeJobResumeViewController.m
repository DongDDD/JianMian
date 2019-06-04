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
#import "JMPartTimeJobModel.h"

@interface JMPartTimeJobResumeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;

@end
static NSString *cellIdent = @"PostJobCellID";
@implementation JMPartTimeJobResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
    
}
-(void)getData{
    [[JMHTTPManager sharedInstance]fectchAbilityList_city_id:nil type_label_id:nil industry_arr:nil myDescription:nil video_path:nil video_cover:nil image_arr:nil status:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.dataArray = [JMPartTimeJobModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
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
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMPostJobHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[JMPostJobHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    [cell setPartTimeJobModel:self.dataArray[indexPath.row]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JMPostPartTimeResumeViewController *vc = [[JMPostPartTimeResumeViewController alloc]init];
    JMPartTimeJobModel *model = self.dataArray[indexPath.row];
    vc.ability_id = model.ability_id;
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
    UIButton *headerBtn = [[UIButton alloc]init];
    headerBtn.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:246/255.0 alpha:1.0];
    [headerBtn setTitle:@"再发一份兼职简历 + " forState:UIControlStateNormal];
    [headerBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    headerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [headerBtn addTarget:self action:@selector(addPartTimeJobResume) forControlEvents:UIControlEventTouchUpInside];
    
    return headerBtn;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
