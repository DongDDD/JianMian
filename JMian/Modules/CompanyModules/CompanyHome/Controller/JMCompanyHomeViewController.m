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



@interface JMCompanyHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *arrDate;

@end
static NSString *cellIdent = @"cellIdent";

@implementation JMCompanyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
////
//    self.extendedLayoutIncludesOpaqueBars = YES;
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.headerView.frame.size.height, SCREEN_WIDTH, self.view.bounds.size.height-200) style:UITableViewStylePlain];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 141;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMCompanyHomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    
    [self.view addSubview:self.tableView];
    
    
    
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
    
    
    JMCompanyHomeModel *model = self.arrDate[indexPath.row];
    [cell setModel:model];
//
    return cell;
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMPersonDetailsViewController *vc = [[JMPersonDetailsViewController alloc] init];

   JMCompanyHomeModel *model = self.arrDate[indexPath.row];
    vc.job_label_id = model.job_label_id;
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
