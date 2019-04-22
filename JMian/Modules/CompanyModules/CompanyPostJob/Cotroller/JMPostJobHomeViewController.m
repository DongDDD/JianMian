//
//  JMPostJobHomeViewController.m
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostJobHomeViewController.h"
#import "JMTitlesView.h"
#import "JMPageView.h"
#import "JMPostNewJobViewController.h"
#import "JMHTTPManager+Work.h"

@interface JMPostJobHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) JMTitlesView *titleView;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *childVCs;
@property (nonatomic, strong) UITableViewController *currentVC;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSNumber *statusNum;
@property (nonatomic, strong) NSArray *dataArray;



@end

@implementation JMPostJobHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    [self setTitle:@"职位管理"];
    [self setRightBtnTextName:@"发布职位"];
    
    [self setupInit];
    
    
    [self getData];
    
    
    
}

- (IBAction)gotoIdentify:(id)sender {
    self.hidesBottomBarWhenPushed=YES;

    JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    self.hidesBottomBarWhenPushed=NO;
    
}


-(void)rightAction{
    self.hidesBottomBarWhenPushed=YES;
    
    JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    self.hidesBottomBarWhenPushed=NO;
    
  

}

- (void)setupInit {
    [self.view addSubview:self.titleView];

}
#pragma mark - 获取数据

-(void)getData{
    [[JMHTTPManager sharedInstance]fetchWorkPaginateWith_city_ids:nil company_id:nil label_id:nil work_label_id:nil education:nil experience_min:nil experience_max:nil salary_min:nil salary_max:nil subway_names:nil status:_statusNum page:nil per_page:nil SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            
            [self.view addSubview:self.tableView];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
        
        
    }];



}


- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"已发布", @"已下线"]];
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            if (index==0) {
                _statusNum = @1;//已发布职位
                
            }else{
                _statusNum = @0;//已下线职位
                
            }
        };
    }
    
    return _titleView;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    //单元格ID
    //重用单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
    //初始化单元格
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIndentifier];
        //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
    }
    
    UIImage *img = [UIImage imageNamed:@"tachi.png"];
    cell.imageView.image = img;
    
    cell.textLabel.textColor = [UIColor colorWithRed:101/255.0 green:101/255.0 blue:101/255.0 alpha:1.0];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = @"UI设计师";
    //    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    
    cell.detailTextLabel.textColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.text = @"1-3年/本科/广州";

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    JMNotificationViewController *vc = [[JMNotificationViewController alloc]init];
    //
    //    [self.navigationController pushViewController:vc animated:YES];
    
}

-(UITableView *)_tableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.titleView.frame.origin.y+self.titleView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 78.0f;
    [self.view addSubview:_tableView];
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
