//
//  JMLogisticsInfoViewController.m
//  JMian
//
//  Created by mac on 2019/6/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMLogisticsInfoViewController.h"
#import "JMHTTPManager+GetLabels.h"
#import "JMLogisticsCellData.h"
#import "JMHTTPManager+CreatetLogisticsInfo.h"
#import "JMHTTPManager+ChangeOrderStatus.h"
#import "STPickerSingle.h"
@interface JMLogisticsInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,STPickerSingleDelegate>
@property (weak, nonatomic) IBOutlet UITextField *expressageNumTextField;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *listArray;
@property (strong, nonatomic) NSMutableArray *titleArray;

@property (weak, nonatomic) IBOutlet UIButton *expressCompanyBtn;
@property (strong, nonatomic) JMLogisticsCellData *logisticsCelldata;
@property (strong, nonatomic) STPickerSingle *educationPickerSingle;

@end
static NSString *cellIdent = @"wuliucellIdent";

@implementation JMLogisticsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"物流信息";
    self.view.backgroundColor = BG_COLOR;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
////    [self.view addGestureRecognizer:tap];
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.mas_topLayoutGuide);
//        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
//    }];
    
    [self getLabsData];
}

- (IBAction)chooseExpressCompany:(UIButton *)sender {
//    [self showListView];
    [self.view addSubview:self.educationPickerSingle];
    [self.educationPickerSingle show];
}

- (IBAction)saoyisaoAction:(UIButton *)sender {
    [self hideListView];

    
}

- (IBAction)saveAction:(UIButton *)sender {
    [self sendGoodsRequst];
    
}
- (IBAction)expressTextField:(UITextField *)sender {
    [self hideListView];
}


-(void)showListView{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(0,  self.view.frame.size.height -_listArray.count*55, SCREEN_WIDTH, _listArray.count*55);
    }];
}

-(void)hideListView{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(0,  self.view.frame.size.height, SCREEN_WIDTH, _listArray.count*55);
    }];
}
//-(void)tapAction{
//
//    [UIView animateWithDuration:0.3 animations:^{
//        self.tableView.frame = CGRectMake(0,  self.view.frame.size.height, SCREEN_WIDTH, _listArray.count*55);
//    }];
//
//}
#pragma mark - Data

-(void)getLabsData{
    [[JMHTTPManager sharedInstance]getLabels_Id:@"1083" mode:@"tree" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            _listArray = [JMLogisticsCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
//
         }
        [self.tableView reloadData];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}

-(void)sendGoodsRequst{
    [self.expressageNumTextField resignFirstResponder];
    NSString *logistics_no;
    NSString *logistics_id;
    if (![self.expressageNumTextField.text isEqualToString:@"无需物流"]) {
        logistics_no = self.expressageNumTextField.text;
        logistics_id = _logisticsCelldata.label_id;
    }
    
    [[JMHTTPManager sharedInstance]deliverGoodsWithOrder_id:_order_id status:@"10" logistics_no:logistics_no logistics_id:logistics_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self showAlertVCSucceesSingleWithMessage:@"物流信息提交成功" btnTitle:@"返回"];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

-(void)alertSucceesAction{
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return _listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    cell.textLabel.textColor = TITLE_COLOR;
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    JMLogisticsCellData *data = self.listArray[indexPath.row];
    cell.textLabel.text = data.name;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    // Configure the cell...
    
    return cell;
}

- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle row:(NSInteger)row
{
    [self.expressCompanyBtn setTitle: _titleArray [row] forState:UIControlStateNormal];
    [self.expressCompanyBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(0,  self.view.frame.size.height, SCREEN_WIDTH, _listArray.count*55);
    }];

}
#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;

        
    }
    return _tableView;
}

-(STPickerSingle *)educationPickerSingle{
    if (_educationPickerSingle == nil) {
        _educationPickerSingle = [[STPickerSingle alloc]init];
        _educationPickerSingle.title = @"选择物流";
        _educationPickerSingle.delegate = self;
        _educationPickerSingle.widthPickerComponent = 200;
       _titleArray = [NSMutableArray array];
        for (JMLogisticsCellData *data in  _listArray) {
            [_titleArray addObject:data.name];
        }
        [_titleArray addObject:@"其他"];
        [_titleArray addObject:@"无需物流"];
        _educationPickerSingle.arrayData = _titleArray;
    }
    return _educationPickerSingle;
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
