//
//  PositionDesiredSecondViewController.m
//  JMian
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "PositionDesiredSecondViewController.h"
#import "SearchView.h"


@interface PositionDesiredSecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)SearchView *searchView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation PositionDesiredSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *provinces=[[NSMutableArray alloc] initWithObjects:@"视觉设计师",@"UI设计师",@"多媒体设计师",@"游戏场景",@"美工",@"网页设计师", nil];
    self.dataArray = provinces;
    
    
    [self setSearchView];
    [self setTableView];
    
}

-(void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, SCREEN_HEIGHT-(self.searchView.frame.size.height+22)) style:UITableViewStylePlain];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
   
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(self.searchView.frame.origin.x, self.tableView.frame.origin.y,self.searchView.frame.size.width, 0.5)];
    headerView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self.view addSubview:headerView];



}

-(void)setSearchView{
    
    
    self.searchView = [[SearchView alloc]initWithFrame:CGRectMake(20, NAVIGATION_BAR_HEIGHT+21, SCREEN_WIDTH-40, 33)];
    self.searchView.searchTextField.placeholder = @"请输入职位名称或公司";
 
    [self.view addSubview:self.searchView];

    
    
}

#pragma mark - tableView DataSource -

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}


#pragma mark - tableView Delegate -

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    //单元格ID
    //重用单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
    //初始化单元格
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
        //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
    }
    
    UIImage *img = [UIImage imageNamed:@"tachi.png"];
    cell.imageView.image = img;
    //添加图片
    cell.textLabel.textColor = [UIColor colorWithRed:101/255.0 green:101/255.0 blue:101/255.0 alpha:1.0];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"省份";
    //添加右侧注释
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
