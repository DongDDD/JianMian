//
//  JMDeleteBankCardViewController.m
//  JMian
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMDeleteBankCardViewController.h"
#import "JMBankCardData.h"
#import "JMHTTPManager+BankCark.h"


@interface JMDeleteBankCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)NSInteger index;

@property (strong, nonatomic) UIAlertAction *okAction;
@property (strong, nonatomic) UIAlertAction *cancelAction;
@end

@implementation JMDeleteBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"选择银行卡";
    [self setRightBtnTextName:@"保存"];
    [self.view addSubview:self.tableView];
    if (_arrayList.count == 0) {
        [self.view addSubview:self.noDataView];
        [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self.view);
            make.top.bottom.left.right.mas_equalTo(self.view);
        }];
    }
}


-(void)rightAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    // 确定注销
    _okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        JMBankCardData *data = [[JMBankCardData alloc]init];
        data = self.arrayList[_index];
        //    data.bank_card_id =
        [[JMHTTPManager sharedInstance]deleteBankCard_Id:data.bank_card_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            [self.navigationController popViewControllerAnimated:YES];
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }];
    
    _cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:_okAction];
    [alert addAction:_cancelAction];
    
    [self presentViewController:alert animated:true completion:nil];
    

    //    if (_isDelete == NO) {
    //        _isDelete = YES;
    //        [self.tableView reloadData];
    //    }
    //
    
}




#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrayList.count;;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:TTextMessageCell_ReuseId];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TTextMessageCell_ReuseId];
        UILabel *rightLab = [[UILabel alloc]init];
        rightLab.text = @"解除绑定";
        rightLab.font = [UIFont systemFontOfSize:14];
        rightLab.textColor = [UIColor colorWithRed:255/255.0 green:56/255.0 blue:89/255.0 alpha:1.0];
        [cell.contentView addSubview:rightLab];
        
        [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView).mas_offset(-20);
            make.centerY.mas_equalTo(cell.contentView);
        }];
    }
    JMBankCardData *data = [[JMBankCardData alloc]init];
    data = self.arrayList[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"redlining"];
    cell.textLabel.text = data.bank_name;
    cell.textLabel.textColor = TITLE_COLOR;
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    
    cell.detailTextLabel.textColor = TEXT_GRAY_COLOR;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    NSString *lastFourStr = [data.card_number substringFromIndex:data.card_number.length- 4];
    NSString *str1 = [NSString stringWithFormat:@"尾号%@ 储蓄卡",lastFourStr];
    cell.detailTextLabel.text = str1;
    
    
    return cell;
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _index = indexPath.row;
    
    
    //    [self.navigationController pushViewController:[[JMWithdrawViewController alloc]init] animated:YES];
    
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BG_COLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 10)];
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 10;
        _tableView.rowHeight = 74;
        
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
