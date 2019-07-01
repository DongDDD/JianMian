//
//  JMChoosePartTImeJobTypeLablesViewController.m
//  JMian
//
//  Created by mac on 2019/7/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMChoosePartTImeJobTypeLablesViewController.h"
#import "JMTitleToLabelsTableViewCell.h"
#import "JMHTTPManager+GetLabels.h"
#import "JMLabsData.h"
@interface JMChoosePartTImeJobTypeLablesViewController ()<UITableViewDelegate,UITableViewDataSource,JMTitleToLabelsTableViewCellDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic ,strong) NSArray *dataArray;

@end
//static NSString *cellIdent = @"LabCellsIdent1";

@implementation JMChoosePartTImeJobTypeLablesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择兼职类型";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideTop);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide).mas_offset(-20);
        make.left.right.mas_equalTo(self.view);
    }];
    [self getData];

    // Do any additional setup after loading the view from its nib.
}
-(void)getData{
    [[JMHTTPManager sharedInstance]getLabels_Id:@"1027" mode:@"tree" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            _dataArray = [JMLabsData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
       
            [self.tableView reloadData];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
#pragma mark - myDelegate
-(void)didSelectItemWithData:(JMLabsData *)data{
      if (_delegate && [_delegate respondsToSelector:@selector(didChooseWithType_id:typeName:)]) {
        [_delegate didChooseWithType_id:data.label_id typeName:data.name];
        [super fanhui];
    }
    
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMTitleToLabelsTableViewCell *cell = [[JMTitleToLabelsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell setLabsData:self.dataArray[indexPath.row] myVc:self.myVC];
    cell.delegate = self;
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell setData:self.listsArray[indexPath.row]];
//    cell.delegate = self;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
//    JMTaskOrderListCellData *data = self.listsArray[indexPath.row];
//    //C端待处理且是0状态
//    if ([data.status isEqualToString:Task_WaitDealWith] && [userModel.type isEqualToString:C_Type_USER]) {
    //        return 130;
    //    }else{
    JMLabsData *data = self.dataArray[indexPath.row];
    NSInteger labsCount = data.children.count;
    if (labsCount > 3) {
        
        return labsCount/3 * 70;
    }else{
        return 60;
    }
    
    
//        return 110;
    //
//    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*2) style:UITableViewStylePlain];
//        _tableView.backgroundColor = MASTER_COLOR;
//        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        //        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //        _tableView.sectionHeaderHeight = 43;
        //        _tableView.sectionFooterHeight = 0;
        //        [_tableView registerNib:[UINib nibWithNibName:@"JMSquareHeaderModulesTableViewCell" bundle:nil] forCellReuseIdentifier:headerCellId];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMTitleToLabelsTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
        //        [_tableView registerNib:[UINib nibWithNibName:@"JMBUserSquareTableViewCell" bundle:nil] forCellReuseIdentifier:B_cellIdent];
        
    }
    return _tableView;
}
@end
