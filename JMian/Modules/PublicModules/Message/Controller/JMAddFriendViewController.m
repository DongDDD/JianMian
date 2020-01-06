//
//  JMAddFriendViewController.m
//  JMian
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMAddFriendViewController.h"
#import "JMHTTPManager+AddFriend.h"
#import "JMAddFriendModel.h"
#import "JMFriendTableViewCell.h"
#import "JMFriendInfoViewController.h"

@interface JMAddFriendViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,JMFriendTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)UILabel *noDataLab;
@end

static NSString *cellIdent = @"friendID";
 
@implementation JMAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.searchBar.delegate = self;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view from its nib.
//    [self getData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];

}
#pragma mark - Data
-(void)getData{
    [[JMHTTPManager sharedInstance]addFriendtWithRelation_id:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

#pragma mark - searchBarDelegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self showProgressHUD_view:self.view];
    [[JMHTTPManager sharedInstance]searchFriendtWithPhone:searchBar.text successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.dataArray = [JMAddFriendModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self.tableView reloadData];
            if (self.dataArray.count == 0) {
                [self.view addSubview:self.noDataLab];
                [self.noDataLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.centerY.mas_equalTo(self.view);
                }];
            }
            [self hiddenHUD];
            
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

 
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 79;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
    lab.text = @"     联系人";
    lab.font = [UIFont boldSystemFontOfSize:17];
    lab.textColor =  UIColorFromHEX(0x999999);
    lab.backgroundColor = UIColorFromHEX(0xEEEFF3);
    return lab;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
    
    
}




#pragma mark - tableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[JMFriendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:self.dataArray[indexPath.row]];
//    [cell setData:[_dataArray objectAtIndex:indexPath.row]];

    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    JMAddFriendModel *model = self.dataArray[indexPath.row];
//    if (model.amigo_type) {
//        JMFriendInfoViewController *vc = [[JMFriendInfoViewController alloc]init];
//        vc.model = model;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//
//}

#pragma mark - myDelegate

-(void)addFriendActionWithModel:(JMAddFriendModel *)model{
    [[JMHTTPManager sharedInstance]addFriendtWithRelation_id:model.user_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self.navigationController popViewControllerAnimated:YES];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"成功添加好友" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
             [alert show];
             
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
         
    }];
}


#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+10, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
//        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.tableView registerNib:[UINib nibWithNibName:@"JMFriendTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
        self.tableView.rowHeight = 79;
        self.tableView.separatorStyle = UITableViewCellAccessoryNone;
        
        
    }
    return _tableView;
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

-(UILabel *)noDataLab{
    if (!_noDataLab) {
        _noDataLab = [[UILabel alloc]init];
        _noDataLab.text = @"无结果";
        _noDataLab.textColor = TITLE_COLOR;
    }
    return _noDataLab;
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
