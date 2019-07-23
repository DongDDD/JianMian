//
//  PositionDesiredSecondViewController.m
//  JMian
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "PositionDesiredSecondViewController.h"
#import "SearchView.h"
#import "LoginViewController.h"
#import "JMHTTPManager+PositionDesired.h"
#import "JMSystemLabelsModel.h"

@interface PositionDesiredSecondViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)SearchView *searchView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;//所有model
@property(nonatomic,strong)NSMutableArray *strArr;//拼接完被搜索的字符串
@property(nonatomic,strong)NSArray *searchDataArr;//搜索完匹配的字符串


@end

@implementation PositionDesiredSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];

    
    self.view.backgroundColor = [UIColor whiteColor];
//    NSMutableArray *provinces=[[NSMutableArray alloc] initWithObjects:@"视觉设计师",@"UI设计师",@"多媒体设计师",@"游戏场景",@"美工",@"网页设计师", nil];
//    self.dataArray = provinces;

    [self setSearchView];
    [self setTableView];
    [self getData];
    
}
#pragma mark - data -

-(void)getData{
//    [self showProgressHUD_view:self.view];
    [self showHUD];
    [[JMHTTPManager sharedInstance] fetchPositionLabelsWithMyId:@"967" mode:@"lists" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        NSArray *dataArray =  [JMSystemLabelsModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
        _strArr = [NSMutableArray array];//制作拼接完被搜索的字符串
        for (JMSystemLabelsModel *model in dataArray) {
            NSString *str1 = [model.name_relation componentsJoinedByString:@"/"];
            NSString *str2 = model.name;
            NSString *str3 = [NSString stringWithFormat:@"%@-%@-%@",str1,str2,model.label_id];
            [_strArr addObject:str3];
        }
        
        // 搜索不区分大小写
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",self.keyWord];
        self.searchDataArr =  [[NSArray alloc] initWithArray:[_strArr filteredArrayUsingPredicate:predicate]];
        NSLog(@"搜索完毕=-- %@",self.searchDataArr);
        [self.tableView reloadData];

//        if (self.keyWord) {
//            for (int i = 0; i < _strArr.count; i++) {
//                NSString *arrStr = _strArr[i];
//                if ([arrStr containsString:self.keyWord]) {
//                    [self.searchDataArr addObject:dataArray[i]];
//                }
//            }
//            NSLog(@"搜索完毕=-- %@",self.searchDataArr);
//
//            [self.tableView reloadData];
//
//        }
//
//        WSDropMenuView *dropMenu = [[WSDropMenuView alloc] initWithFrame:CGRectMake(0,self.searchView.frame.origin.y+self.searchView.frame.size.height+15, self.view.frame.size.width,SCREEN_HEIGHT)];
//        dropMenu.dataSource = self;
//        dropMenu.delegate = self;
//        [self.view addSubview:dropMenu];
        [self hiddenHUD];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
#pragma mark - 布局UI -

-(void)setTableView{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 111, SCREEN_WIDTH, SCREEN_HEIGHT-(self.searchView.frame.size.height+22)) style:UITableViewStylePlain];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 64;
    
    [self.view addSubview:self.tableView];
   
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(self.searchView.frame.origin.x, self.tableView.frame.origin.y,self.searchView.frame.size.width, 0.5)];
    headerView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self.view addSubview:headerView];



}

-(void)setSearchView{
    
    
    self.searchView = [[SearchView alloc]initWithFrame:CGRectMake(20, NAVIGATION_BAR_HEIGHT+21, SCREEN_WIDTH-40, 33)];
    self.searchView.searchTextField.placeholder = @"请输入职位名称";
    self.searchView.searchTextField.delegate = self;
    [self.view addSubview:self.searchView];

    
    
}

-(NSArray *)searchActionWithKeyWord:(NSString *)keyWord{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",self.keyWord];
    NSArray *arrays =  [[NSArray alloc] initWithArray:[_strArr filteredArrayUsingPredicate:predicate]];
    NSLog(@"搜索完毕=-- %@",arrays);
    return arrays;
}
#pragma mark - textField -
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    // 搜索不区分大小写
//    self.searchDataArr = [self searchActionWithKeyWord:textField.text];
//    NSLog(@"搜索完毕=-- %@",self.searchDataArr);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",self.keyWord];
    self.searchDataArr =  [[NSArray alloc] initWithArray:[_strArr filteredArrayUsingPredicate:predicate]];
    NSLog(@"搜索完毕=-- %@",self.searchDataArr);
    [self.tableView reloadData];
    
    return YES;
}

#pragma mark - tableView DataSource -

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchDataArr count];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIndentifier];
        //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
    }
    
    UIImage *img = [UIImage imageNamed:@"tachi.png"];
    cell.imageView.image = img;
    cell.textLabel.textColor = [UIColor colorWithRed:101/255.0 green:101/255.0 blue:101/255.0 alpha:1.0];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    
    NSString *str1 = self.searchDataArr[indexPath.row];
    NSArray *arr = [str1 componentsSeparatedByString:@"-"];
//    JMSystemLabelsModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = arr[1];
    cell.detailTextLabel.text =  arr[0];
    
    
    
    
    //添加右侧注释
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str1 = self.searchDataArr[indexPath.row];
    NSArray *arr = [str1 componentsSeparatedByString:@"-"];
    [self.navigationController popViewControllerAnimated:YES];
   
}


-(NSMutableArray *)dataArray{
    if (_dataArray.count == 0) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
