//
//  JMPersonInfoViewController.m
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPersonInfoViewController.h"
#import "JMPersonInfoConfigures.h"

@interface JMPersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation JMPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.configures numberOfRowsInSection:section];
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return [self.configures heightForRowsInSection:indexPath];;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//}
#pragma mark - UITableViewDelegate
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        JMPersonHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPersonHeaderTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setModel:self.configures.model];
        return cell;
        
    }else if (indexPath.section == 1) {
        JMPersonVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPersonVideoTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        [cell setModel:self.configures.model];
        return cell;
    
    }else if (indexPath.section == 2) {
        JMPersonIntensionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPersonIntensionTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        [cell setModel:self.configures.model];
        return cell;
        
    }else if (indexPath.section == 3) {
        JMPersonWorkExpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPersonWorkExpTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        [cell setModel:self.configures.model];
        return cell;
        
    }else if (indexPath.section == 4) {
        JMPesonDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPesonDescTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        [cell setModel:self.configures.model];
        return cell;
        
    }else if (indexPath.section == 4) {
        JMPesonEducationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMPesonEducationTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        [cell setModel:self.configures.model];
        return cell;
        
    }
    return nil;

}

#pragma mark - lazy

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
        [_tableView registerNib:[UINib nibWithNibName:@"JMPersonHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMPersonHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPersonVideoTableViewCell" bundle:nil] forCellReuseIdentifier:JMPersonVideoTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPersonIntensionTableViewCell" bundle:nil] forCellReuseIdentifier:JMPersonIntensionTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPersonWorkExpTableViewCell" bundle:nil] forCellReuseIdentifier:JMPersonWorkExpTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPesonDescTableViewCell" bundle:nil] forCellReuseIdentifier:JMPesonDescTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMPesonEducationTableViewCell" bundle:nil] forCellReuseIdentifier:JMPesonEducationTableViewCellIdentifier];

        
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
