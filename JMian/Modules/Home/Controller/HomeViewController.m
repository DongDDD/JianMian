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




@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>



@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIButton *pushPositionBtn; //j推荐职位
@property (weak, nonatomic) IBOutlet UIButton *allPositionBtn;//所有职位
@property (weak, nonatomic) IBOutlet UIButton *companyRequireBtn;//公司要求




@property(nonatomic,strong)UITableView *tableView;


@end

static NSString *cellIdent = @"cellIdent";


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleViewImageViewName:@"jianmian_home"];
    [self setBackBtnImageViewName:@"site_Home" textName:@"广州"];
    [self setRightBtnImageViewName:@"Search_Home" imageNameShare:@""];
    [self setTableView];
}

#pragma mark - 布局UI
-(void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headView.frame.size.height+self.headView.frame.origin.y, SCREEN_WIDTH, self.view.bounds.size.height) style:UITableViewStylePlain];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 141;
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HomeTableViewCell class]) bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellIdent];
    
    
    [self.view addSubview:self.tableView];
   
    
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
    return 10;
}


#pragma mark - tableView Delegate -

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobDetailsViewController *vc = [[JobDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"%d",indexPath.row);
   
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
