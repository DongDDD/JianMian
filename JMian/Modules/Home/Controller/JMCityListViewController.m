//
//  JMCityListViewController.m
//  JMian
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCityListViewController.h"
#import "JMHTTPManager+PositionDesired.h"
#import "JMCityModel.h"

@interface JMCityListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;

@property (nonatomic, strong)NSArray *firstArray;
@property (nonatomic, strong)NSMutableArray *leve1ModelArray;
@property (nonatomic, strong)NSMutableArray *leve2ModelArray;//第一列表
@property (nonatomic, strong)NSMutableArray *leve3ModelArray;//第二列表
@property (nonatomic, copy)NSString *city_id;
@property (nonatomic, copy)NSString *city_name;



@end
static NSString *cellIdent = @"cellIdent";

@implementation JMCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作城市";
//    [self setRightBtnTextName:@"保存"];
    [self getData];
    [self.view addSubview:self.tableView1];
    [self.view addSubview:self.tableView2];

    // Do any additional setup after loading the view from its nib.
    
}

-(void)getData{
    
    [[JMHTTPManager sharedInstance]fetchCityListWith_mode:@"tree" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.firstArray = [JMCityModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
        }
        if (_viewType == JMCityListViewPartTime) {
            [self getPartTimeCityList];
        }else{
            [self getHomeCityList];

        }
        
        
        [_tableView1 reloadData];
        [_tableView2 reloadData];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

//首页筛选数据
-(void)getHomeCityList{

    for (JMCityModel *cityModel in self.firstArray) {
        if ([cityModel.level isEqualToString:@"1"]) {
            //省级别，去到第二层获取城市列表
            for (JMCityModel *leve2model in cityModel.children) {
                JMCityModel *model = [JMCityModel mj_objectWithKeyValues:leve2model];
                [self.leve2ModelArray addObject:model];
            }
        }else{
            //第一层就城市级别，不用去第二层
            [self.leve2ModelArray addObject:cityModel];
        }
    }
    
    JMCityModel *allchooseModel = [[JMCityModel alloc]init];
    allchooseModel.city_name = @"全国";
    [self.leve2ModelArray addObject:allchooseModel];
    
    //        for (int i = 0; i < self.leve2ModelArray.count; i++) {
    JMCityModel *cityModel = self.leve2ModelArray[0];
    for (NSDictionary *dic in cityModel.children) {
        JMCityModel *model = [JMCityModel mj_objectWithKeyValues:dic];
        [self.leve3ModelArray addObject:model];
    }
}

//发布任务数据
-(void)getPartTimeCityList{
    for (JMCityModel *cityModel in self.firstArray) {
        if ([cityModel.level isEqualToString:@"1"]) {
             [self.leve2ModelArray addObject:cityModel];
            //省级别，去到第二层获取城市列表
//            for (JMCityModel *leve2model in cityModel.children) {
//                JMCityModel *model = [JMCityModel mj_objectWithKeyValues:leve2model];
//                [self.leve2ModelArray addObject:model];
//            }
        }else{
            //第一层就城市级别，不用去第二层
            [self.leve2ModelArray addObject:cityModel];
        }
    }
    
    JMCityModel *allchooseModel = [[JMCityModel alloc]init];
    allchooseModel.city_name = @"全国";
    [self.leve2ModelArray addObject:allchooseModel];
    
    //        for (int i = 0; i < self.leve2ModelArray.count; i++) {
    JMCityModel *cityModel = self.leve2ModelArray[0];
    for (NSDictionary *dic in cityModel.children) {
        JMCityModel *model = [JMCityModel mj_objectWithKeyValues:dic];
        [self.leve3ModelArray addObject:model];
    }
    
}

-(void)rightAction{
    [self.navigationController popViewControllerAnimated:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCity_id:city_name:)]) {
        [_delegate didSelectedCity_id:_city_id city_name:_city_name];
    }
}

#pragma mark - tableView DataSource -

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableView1) {
        return self.leve2ModelArray.count;
    }else if(tableView == _tableView2){
        return self.leve3ModelArray.count;
    }
    return 0;
    
}


#pragma mark - tableView Delegate -

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = TITLE_COLOR;
    
    if (tableView == _tableView1) {
        JMCityModel *model = self.leve2ModelArray[indexPath.row];
        cell.textLabel.text = model.city_name;
        cell.backgroundColor = BG_COLOR;
        
    }else if (tableView == _tableView2){
        JMCityModel *model = self.leve3ModelArray[indexPath.row];
        cell.textLabel.text = model.city_name;
    }
    //    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    
    return cell;
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (tableView == _tableView1) {
        //选择城市一级
        [self setRightBtnTextName:@""];
        self.leve3ModelArray = [NSMutableArray array];
        //选择第一层的哪个城市，选择完获取到区数组
        JMCityModel *cityModel = self.leve2ModelArray[indexPath.row];
        if (![cityModel.city_name isEqualToString:@"全国"]) {
            for (NSDictionary *dic in cityModel.children) {
                JMCityModel *model = [JMCityModel mj_objectWithKeyValues:dic];
                [self.leve3ModelArray addObject:model];
            }
        }else{
            //--------选择全部---------，清空第二层级的数组
            self.leve3ModelArray = [NSMutableArray array];
            _city_id = nil;
            _city_name = @"全国";
            [self setRightBtnTextName:@"保存"];
        }
        
        [_tableView2 reloadData];
    }else if (tableView == _tableView2) {
        //选择区，二级 传这个层级的city_id
        [self setRightBtnTextName:@"保存"];
        if (self.leve3ModelArray.count > 0) {
            JMCityModel *model = self.leve3ModelArray[indexPath.row];
            _city_id = model.city_id;
            _city_name = model.city_name;
        }
    }
}


#pragma mark - lazy -

-(UITableView *)tableView1{
    if (!_tableView1) {
        _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        _tableView1.rowHeight = 78.0f;
        _tableView1.backgroundColor = BG_COLOR;
        _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _tableView1;

}

-(UITableView *)tableView2{
    if (!_tableView2) {
        _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(_tableView1.frame.size.width, 0, SCREEN_WIDTH-_tableView1.frame.size.width, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        _tableView2.rowHeight = 78.0f;
        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView2;
    
}

-(NSMutableArray *)leve1ModelArray{
    if (_leve1ModelArray == nil) {
        _leve1ModelArray = [NSMutableArray array];
    }
    return _leve1ModelArray;
}
-(NSMutableArray *)leve2ModelArray{
    if (_leve2ModelArray == nil) {
        _leve2ModelArray = [NSMutableArray array];
    }
    return _leve2ModelArray;
}

-(NSMutableArray *)leve3ModelArray{
    if (_leve3ModelArray == nil) {
        _leve3ModelArray = [NSMutableArray array];
    }
    return _leve3ModelArray;
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
