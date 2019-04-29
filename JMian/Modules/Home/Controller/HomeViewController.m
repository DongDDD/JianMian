//
//  HomeViewController.m
//  JMian
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "HometableViewCell.h"
#import "LoginViewController.h"
#import "JobDetailsViewController.h"
#import "JMHTTPManager+Work.h"
#import "JMHomeWorkModel.h"
#import "JMUserInfoModel.h"




@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>



@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIButton *pushPositionBtn; //j推荐职位
@property (weak, nonatomic) IBOutlet UIButton *allPositionBtn;//所有职位
@property (weak, nonatomic) IBOutlet UIButton *companyRequireBtn;//公司要求

@property (nonatomic, strong) NSArray *arrDate;

@property (nonatomic, strong) UITableView *tableView;


@end

static NSString *cellIdent = @"cellIdent";


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleViewImageViewName:@"jianmian_home"];
    [self setBackBtnImageViewName:@"site_Home" textName:@"广州"];
    [self setRightBtnImageViewName:@"Search_Home" imageNameRight2:@""];

    [self setTableView];
    
    [self getData];
    
//    [self loginIM];
}


#pragma mark - 布局UI

-(void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headView.frame.size.height+self.headView.frame.origin.y, SCREEN_WIDTH, self.view.bounds.size.height) style:UITableViewStylePlain];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 141;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];

    [self.view addSubview:self.tableView];
    
 
    
}

#pragma mark - 点击事件 -

-(void)rightAction{
    NSLog(@"搜索");
    LoginViewController *vc = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)getData{
    
 
    [[JMHTTPManager sharedInstance]fetchWorkPaginateWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {


        if (responsObject[@"data"]) {

            self.arrDate = [JMHomeWorkModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self.tableView reloadData];
        }



    } failureBlock:^(JMHTTPRequest * _Nonnull request, NSError  *error) {


    }];
    
    
    


}

#pragma mark - 推荐职位 -

- (IBAction)pushPositionAction:(UIButton *)sender {

    
}




#pragma mark - 所有职位 -






#pragma mark - 公司要求 -








#pragma mark - tableView DataSource -

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
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
   
    JMHomeWorkModel *model = self.arrDate[indexPath.row];
    [cell setModel:model];
   
    return cell;
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobDetailsViewController *vc = [[JobDetailsViewController alloc] init];
    JMHomeWorkModel *model = self.arrDate[indexPath.row];

    vc.homeworkModel = model;
    
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
