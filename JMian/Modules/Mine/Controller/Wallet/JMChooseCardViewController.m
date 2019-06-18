//
//  JMChooseCardViewController.m
//  JMian
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMChooseCardViewController.h"
#import "JMBindBankCardViewController.h"
#import "JMDeleteBankCardViewController.h"
#import "JMHTTPManager+BankCark.h"
#import "JMBankCardData.h"


@interface JMChooseCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *arrayList;
@end

@implementation JMChooseCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"选择银行卡";
        
    [self setRightBtnImageViewName:@"delete" imageNameRight2:@"more"];
    
    
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDataList];

}

-(void)rightAction{

    JMDeleteBankCardViewController *vc =[[JMDeleteBankCardViewController alloc]init];
    vc.arrayList = _arrayList;
    [self.navigationController pushViewController:vc animated:YES];

}


-(void)right2Action{

    [self.navigationController pushViewController:[[JMBindBankCardViewController alloc]init] animated:YES];


}
#pragma mark - 数据请求

-(void)getDataList{
    [[JMHTTPManager sharedInstance]fecthBankCardList_bank_id:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.arrayList = [JMBankCardData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self.tableView reloadData];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];


}


#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrayList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:TTextMessageCell_ReuseId];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TTextMessageCell_ReuseId];
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_delegate && [_delegate respondsToSelector:@selector(didChooseBankCardWithData:)]) {
        [_delegate didChooseBankCardWithData:self.arrayList[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
