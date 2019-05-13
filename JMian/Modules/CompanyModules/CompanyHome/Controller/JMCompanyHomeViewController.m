//
//  JMCompanyHomeViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyHomeViewController.h"
#import "JMCompanyHomeTableViewCell.h"
#import "JMPersonDetailsViewController.h"
#import "JMHTTPManager+VitaPaginate.h"
#import "JMCompanyHomeModel.h"
#import "JMPlayerViewController.h"


@interface JMCompanyHomeViewController ()<UITableViewDelegate,UITableViewDataSource,JMCompanyHomeTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *arrDate;
//@property (strong, nonatomic) AVPlayerViewController *playerVC;

@end
static NSString *cellIdent = @"cellIdent";

@implementation JMCompanyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitleViewImageViewName:@"jianmian_home"];
    [self setBackBtnImageViewName:@"site_Home" textName:@"广州"];
    [self setRightBtnImageViewName:@"Search_Home" imageNameRight2:@""];
    
    [self getData];
    [self setTableView];
    // Do any additional setup after loading the view from its nib.
}



#pragma mark - 获取数据
-(void)getData{
    [[JMHTTPManager sharedInstance]fetchVitaPaginateWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
    
        if (responsObject[@"data"]) {
            
            self.arrDate = [JMCompanyHomeModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self.tableView reloadData];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
        
    }];



}

#pragma mark - 布局UI

-(void)setTableView{
    
    self.tableView = [[UITableView alloc]init];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = BG_COLOR;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 141;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMCompanyHomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
    
    
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrDate.count;
}


#pragma mark - tableView Delegate -

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMCompanyHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[JMCompanyHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    
    cell.delegate = self;
    JMCompanyHomeModel *model = self.arrDate[indexPath.row];
    [cell setModel:model];
//
    return cell;
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMPersonDetailsViewController *vc = [[JMPersonDetailsViewController alloc] init];

   JMCompanyHomeModel *model = self.arrDate[indexPath.row];
    vc.user_job_id = model.user_job_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 点击事件

-(void)playAction_cell:(JMCompanyHomeTableViewCell *)cell{
    JMPlayerViewController *vc = [[JMPlayerViewController alloc]init];
    vc.player = cell.player;
//    vc.model = cell;
    [self.navigationController pushViewController:vc animated:YES];
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
