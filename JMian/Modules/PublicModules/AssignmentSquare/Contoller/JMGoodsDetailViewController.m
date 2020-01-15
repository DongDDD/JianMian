//
//  JMGoodsDetailViewController.m
//  JMian
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMGoodsDetailViewController.h"
#import "JMGoodsDetailConfigures.h"

@interface JMGoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JMGoodsDetailConfigures *configures;
@end

@implementation JMGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.configures numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.configures heightForRowsInSection:indexPath.section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.configures heightForFooterInSection:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.configures heightForHeaderInSection:section];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == JMGoodsDetailCellTypeSDC) {
        JMScrollviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMScrollviewTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setModel:self.configures.model];
        return cell;
    }
    else if (indexPath.section == JMGoodsDetailCellTypeTitle){
        JMGoodsDetialTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMGoodsDetialTitleTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setModel:self.configures.model];
        return cell;
    }
    else if (indexPath.section == JMGoodsDetailCellTypeDesc){
        JMCDetailTaskDecri2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailDecri2TableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setModel:self.configures.model];
        return cell;
    }
    else if (indexPath.section == JMGoodsDetailCellTypeVideo){
        JMCDetailVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailVideoTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        [cell setModel:self.configures.model];
        return cell;
    }
    else if (indexPath.section == JMGoodsDetailCellTypeImages){
        JMCSaleTypeDetailGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCSaleTypeDetailGoodsTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        [cell setModel:self.configures.model];
        return cell;
    }
    else if (indexPath.section == JMGoodsDetailCellTypeMicrotitle){
        JMGoodsDetailMicrotitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMGoodsDetailMicrotitleTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //            [cell setModel:self.configures.model];
        return cell;
    }
    //        else if (indexPath.section == JMGoodsDetailCellTypeStoreGoods){
    //            JMCSaleTypeDetailGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCSaleTypeDetailGoodsTableViewCellIdentifier forIndexPath:indexPath];
    //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //            [cell setModel:self.configures.model];
    //            return cell;
//        }
    
    return nil;
}

#pragma mark - lazy

-(JMGoodsDetailConfigures *)configures{
    if (!_configures) {
        _configures = [[JMGoodsDetailConfigures alloc]init];
    }
    return _configures;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 5;
        //        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //        _tableView.sectionHeaderHeight = 43;
                _tableView.sectionFooterHeight = 5;
        [_tableView registerNib:[UINib nibWithNibName:@"JMScrollviewTableViewCell" bundle:nil] forCellReuseIdentifier:JMScrollviewTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecriTableViewCell" bundle:nil] forCellReuseIdentifier:JMGoodsDetialTitleTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecri2TableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailDecri2TableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailVideoTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailVideoTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailImageTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailImageTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCSaleTypeDetailGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:JMCSaleTypeDetailGoodsTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMGoodsDetailMicrotitleTableViewCell" bundle:nil] forCellReuseIdentifier:JMGoodsDetailMicrotitleTableViewCellIdentifier];

        
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
