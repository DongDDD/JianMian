//
//  JMWalletViewController.m
//  JMian
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMWalletViewController.h"
#import "JMWalletHeaderView.h"
#import "JMWithdrawViewController.h"
#import "JMMoneyDetailsViewController.h"

@interface JMWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *imgArr;

@property(nonatomic,strong)NSArray *titleArr;

@property(nonatomic,strong)JMWalletHeaderView *walletHeaderView;

@end

@implementation JMWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱包";
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.tableView];
    self.imgArr = @[@"withdraw_deposit",@"particulars"];
    self.titleArr = @[@"提现",@"钱包明细"];
}


//section
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//
//    return 215;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//
////        JMChatViewSectionView *view=[[JMChatViewSectionView alloc] init];
////        return view ;
//    }
//    return nil;
//}

//cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titleArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:TTextMessageCell_ReuseId];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TTextMessageCell_ReuseId];
    }
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    return cell;
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[[JMWithdrawViewController alloc]init] animated:YES];
        
    }else{
          [self.navigationController pushViewController:[[JMMoneyDetailsViewController alloc]init] animated:YES];
    
    }

}


#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BG_COLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        JMWalletHeaderView *walletHeaderView = self.walletHeaderView;
        _tableView.tableHeaderView = walletHeaderView;
//        _tableView.sectionFooterHeight = 225;
        _tableView.rowHeight = 64;
        _tableView.sectionHeaderHeight = 235;
        
    }
    return _tableView;
}

-(JMWalletHeaderView *)walletHeaderView{
    if (_walletHeaderView == nil) {
        _walletHeaderView = [[JMWalletHeaderView alloc]initWithFrame:CGRectMake(0, 1, 0, 225)];
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        [_walletHeaderView setUserModel:userModel];
    }
    return _walletHeaderView;
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
