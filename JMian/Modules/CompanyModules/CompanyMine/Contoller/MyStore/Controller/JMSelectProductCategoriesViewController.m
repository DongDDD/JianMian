//
//  JMSelectProductCategoriesViewController.m
//  JMian
//
//  Created by mac on 2020/1/11.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMSelectProductCategoriesViewController.h"
#import "JMTitlesView.h"
#import "JMTitlesHeader.h"
#import "JMPostProductViewController.h"
#import "JMHTTPManager+GetCategoryList.h"
#import "JMCategoriesData.h"
#define Section_Open @"0"
#define Section_Close @"1"


 
@interface JMSelectProductCategoriesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
// 数据源数组 用来存储要展示的数据
@property (strong, nonatomic) NSArray *dataArray;//此数组，用在一级类目的section和展开后的cell
@property (strong, nonatomic) NSArray *secondKindDataArray;//次数组用在二级类目

// 记录收缩状态 对应的把每个区的展开收缩记录下来
@property (strong, nonatomic) NSMutableDictionary *dataDic;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property(nonatomic,strong)JMTitlesHeader *titlesheaderVIew;
//@property(nonatomic,assign)
@end

@implementation JMSelectProductCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 用一组假的数据放到 tableview上面
    self.title = @"发布商品";
//    self.dataArray = [@[@[@"詹姆斯",@"韦德",@"安东尼"],@[@"赵四",@"谢广坤",@"刘能"],@[@"骚军",@"蓬勃",@"成龙大哥"],@[@"小三",@"小四",@"小五"]] mutableCopy];
//    self.secondKindDataArray = @[@"詹姆斯",@"韦德",@"安东尼",@"詹姆斯",@"韦德",@"安东尼"].mutableCopy;
    // 初始化用于标记某一个分区的section的折叠状态的字典
    
    self.dataDic = [NSMutableDictionary dictionary];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchBar.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self getData];
    //self.dataDic = [@{@"0":@"1",@"1":@"1",@"2":@"1",@"3":@"1"} mutableCopy];
    // 这里可以给对应的区一个初始状态,也可以不设置,因为会在点击section的方法中进行赋值
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - data
-(void)getData{
    [[JMHTTPManager sharedInstance]getCategoryListWithFormat:@"tree" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.dataArray = [JMCategoriesData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self.tableView reloadData];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
         
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.secondKindDataArray.count > 0) {
        return 1;

    }else{
        return self.dataArray.count;
    
    }
}

// 判断到底是正常显示row还是row不显示(返回0行)  这里是 等于 0(字符串类型)的时候 展开

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
     if (self.secondKindDataArray.count > 0) {
         return self.secondKindDataArray.count;
     }else{
         // 取出字典中的 section 如果是第 0 个分区 那么就返回该分区的数据
         if ([[self.dataDic valueForKey:[NSString stringWithFormat:@"%ld",section]] isEqualToString:@"0"])
         {
             NSLog(@"----------------");
             JMCategoriesData *data = self.dataArray[section];
              
             return [data.children count];
         }else
         {
             NSLog(@"**************");
             return 0;
         }
     
     }
     return 0;
 }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    }
    cell.textLabel.font = kFont(15);
    cell.textLabel.textColor = TITLE_COLOR;
    if (self.secondKindDataArray.count > 0 ) {
        JMCategoriesData *data = self.secondKindDataArray[indexPath.row];
        cell.textLabel.text = data.title;
        cell.backgroundColor = [UIColor whiteColor];

    }else{
        cell.backgroundColor = UIColorFromHEX(0x161616);
        JMCategoriesData *data = self.dataArray[indexPath.section];
        JMCategoriesData *data2 = data.children[indexPath.row];
        cell.textLabel.text =data2.title;
    
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JMCategoriesData *data = self.dataArray[section];
    
    // 把分区的头视图设置成Button
    UIButton *button =[UIButton buttonWithType:(UIButtonTypeCustom)];
    button.backgroundColor = [UIColor whiteColor];
    // 设置Button的标题作为section的标题用
    [button setTitle:[NSString stringWithFormat:@"    %@",data.title] forState:(UIControlStateNormal)];
    [button setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    // 设置点击事件
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchDown)];
    button.titleLabel.font = kFont(15);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //此时文字会紧贴到做边框，我们可以设置
//    button.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 10);
    
    // 给定tag值用于确定点击的对象是哪个区
    button.tag = section + 1000;
    return button;
}

#pragma mark - tableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
//    //只能到一级，二级类目数组为空
//    if (_secondKindDataArray.count > 0) {
//        [_titlesheaderVIew  btn2Selected];
//
//        _tableView.sectionHeaderHeight = 0;
//        [self.tableView reloadData];
//
//    }else{
//        JMPostProductViewController *vc = [[JMPostProductViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }
    
    if(_titlesheaderVIew.viewType == JMCategoriesTypeFirst){
        JMCategoriesData *data1 = self.dataArray[indexPath.section];
        JMCategoriesData *data2 =  data1.children[indexPath.row];
        _secondKindDataArray = data2.children;
        if (_secondKindDataArray.count == 0) {
            //无二级类目展示
            JMPostProductViewController *vc = [[JMPostProductViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //有二级类目展示
            [_titlesheaderVIew  btn2Selected];
            _tableView.sectionHeaderHeight = 0;
            [self.tableView reloadData];
        }
        
    }else if (_titlesheaderVIew.viewType == JMCategoriesTypeSecond){

        JMPostProductViewController *vc = [[JMPostProductViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    
    }
    

}


#pragma mark - action

- (void)buttonAction:(UIButton *)sender
{
    NSInteger temp = sender.tag - 1000;
    // 修改 每个区的收缩状态  因为每次点击后对应的状态改变 temp代表是哪个section
    if ([[self.dataDic valueForKey:[NSString stringWithFormat:@"%ld",temp]] isEqualToString:@"0"] )
    {
        [self.dataDic setObject:Section_Close forKey:[NSString stringWithFormat:@"%ld",temp]];
    }else
    {
        [self.dataDic setObject:Section_Open forKey:[NSString stringWithFormat:@"%ld",temp]];
    }
    // 更新 section
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:temp] withRowAnimation:(UITableViewRowAnimationFade)];
}

-(void)titleBtn1Actoin{
    [_titlesheaderVIew  btn1Selected];
    self.secondKindDataArray = [NSArray array];
    _tableView.sectionHeaderHeight = 48;
    [self.tableView reloadData];

}

#pragma mark - lazy
//一级类目 二级类目
-(JMTitlesHeader *)titlesheaderVIew{
    if (!_titlesheaderVIew) {
        _titlesheaderVIew = [[JMTitlesHeader alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        [_titlesheaderVIew.btn1 addTarget:self action:@selector(titleBtn1Actoin) forControlEvents:UIControlEventTouchDown];
        [_titlesheaderVIew.btn2 setHidden:YES];
    }
    return _titlesheaderVIew;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        //        _tableView.backgroundColor = [UIColor whiteColor];

        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.titlesheaderVIew;
        _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
        _tableView.sectionHeaderHeight = 48;
        _tableView.sectionFooterHeight = 1;
        _tableView.rowHeight = 48;
//        [_tableView registerNib:[UINib nibWithNibName:@"JMMyStoreOrderStatusTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyStoreOrderStatusTableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMMyStoreManager1TableViewCell" bundle:nil] forCellReuseIdentifier:JMMyStoreManager1TableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMMyStoreManager2TableViewCell" bundle:nil] forCellReuseIdentifier:JMMyStoreManager2TableViewCellIdentifier];
          
        
        
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
