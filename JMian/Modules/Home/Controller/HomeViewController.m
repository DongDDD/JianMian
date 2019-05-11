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
#import "Masonry.h"
#import "JMLabsChooseViewController.h"


@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,JMLabsChooseViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIButton *pushPositionBtn; //j推荐职位
@property (weak, nonatomic) IBOutlet UIButton *allPositionBtn;//所有职位
@property (weak, nonatomic) IBOutlet UIButton *companyRequireBtn;//公司要求
@property (nonatomic, strong) NSArray *arrDate;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JMLabsChooseViewController *labschooseVC;

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

    self.tableView = [[UITableView alloc]init];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 141;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];

    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
    
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
    [self.pushPositionBtn setBackgroundColor:MASTER_COLOR];
    [self.pushPositionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.allPositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.allPositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.companyRequireBtn setBackgroundColor:[UIColor whiteColor]];
    [self.companyRequireBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.labschooseVC.view setHidden:YES];

}


#pragma mark - 所有职位 -

- (IBAction)allPosition:(UIButton *)sender {
    [self.pushPositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.pushPositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.allPositionBtn setBackgroundColor:MASTER_COLOR];
    [self.allPositionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.companyRequireBtn setBackgroundColor:[UIColor whiteColor]];
    [self.companyRequireBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.labschooseVC.view setHidden:YES];

   
}


#pragma mark - 公司要求 -

- (IBAction)companyRequire:(UIButton *)sender {
    [self.companyRequireBtn setBackgroundColor:MASTER_COLOR];
    [self.companyRequireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.pushPositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.pushPositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.allPositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.allPositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.labschooseVC.view setHidden:NO];

 
}

-(void)resetAction{
}

-(void)OKAction
{
    [self.labschooseVC.view setHidden:YES];
  
    
}






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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
#pragma mark - lazy


-(JMLabsChooseViewController *)labschooseVC{
    if (_labschooseVC == nil) {
        _labschooseVC = [[JMLabsChooseViewController alloc]init];
        _labschooseVC.delegate = self;
        [self addChildViewController:_labschooseVC];
        [self.view addSubview:_labschooseVC.view];
        [_labschooseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headView.mas_bottom);
            make.left.and.right.mas_equalTo(self.view);
            make.height.mas_equalTo(self.view);
        }];
    }
    return  _labschooseVC;

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
