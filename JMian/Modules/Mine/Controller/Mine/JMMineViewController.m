//
//  JMMineViewController.m
//  JMian
//
//  Created by chitat on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMineViewController.h"
#import "PositionDesiredViewController.h"
#import "JMHTTPManager+Login.h"
#import "JMMineModulesTableViewCell.h"
#import "JMMyResumeViewController.h"
#import "JMUserInfoModel.h"
#import "PositionDesiredViewController.h"
#import "JMHTTPManager+Uploads.h"
#import "JMCompanyInfoMineViewController.h"
#import "JMManageInterviewViewController.h"
#import "JMHTTPManager+FetchCompanyInfo.h"
#import "JMSettingViewController.h"




@interface JMMineViewController ()<UITableViewDelegate,UITableViewDataSource,JMMineModulesTableViewCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *imageNameArr,*labelStrArr;
@property (strong, nonatomic) JMUserInfoModel *userInfoModel;

@end

@implementation JMMineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人中心";
    [self setRightBtnImageViewName:@"upinstall" imageNameRight2:@""];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    //判断当前 C端 还是 B端
    _userInfoModel = [JMUserInfoManager getUserInfo];
    
    
    if ([_userInfoModel.type isEqualToString:@"2"]) {
        
       
    }else if ([_userInfoModel.type isEqualToString:@"1"]){
        
    }
    
    self.imageNameArr = @[@"subscribe",@"burse",@"autonym"];
    self.labelStrArr = @[@"网点拍摄预约",@"我的钱包",@"实名认证"];
    [self getUserData];

}

#pragma mark - 获取数据

-(void)getUserData{
    
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

        self.userInfoModel = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [self.tableView reloadData];
        [self getCompanyData];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];
    
}

-(void)rightAction{
    JMSettingViewController *vc = [[JMSettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)getCompanyData{
    
    
    [[JMHTTPManager sharedInstance] fetchCompanyInfo_Id:self.userInfoModel.company_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
        
    }];
    
}

- (NSDictionary *)generateDicFromArray:(NSArray *)array {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (id object in array) {
        NSString *key = [NSString stringWithFormat:@"%@",object];
        dic[key] = object;
    }
    return dic.copy;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
//        cell.accessoryType = UITableViewCellStyleSubtitle;

        cell.textLabel.text = @"paneidong\nHR";
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:14];
        cell.textLabel.textColor = UIColorFromHEX(0x4d4d4d);
        
//        cell.detailTextLabel.text = @"HR";
        cell.detailTextLabel.textColor = UIColorFromHEX(0x808080);

        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.userInfoModel.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    }
    if (indexPath.section == 1) {
        JMMineModulesTableViewCell *modulesCell = [[JMMineModulesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        modulesCell.delegate = self;
        return modulesCell;
    }
    if (indexPath.section == 2) {
        cell.textLabel.text = self.labelStrArr[indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:14];
        cell.textLabel.textColor = UIColorFromHEX(0x4d4d4d);
        cell.imageView.image = [UIImage imageNamed:self.imageNameArr[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[JMMyResumeViewController alloc] init] animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return _imageNameArr.count;
    }else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([_userInfoModel.type isEqualToString:@"2"]) {
            return  110;
        }else{
            return 100;
            
        }
    }else if(indexPath.section == 1){
        return 118;
    }else {
        return 64;
    }
}

- (void)didSelectItemWithRow:(NSInteger)row {
    if (row == 0) {
        JMCompanyInfoMineViewController *vc = [[JMCompanyInfoMineViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }if (row == 1) {
        JMManageInterviewViewController *vc = [[JMManageInterviewViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}


#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;

    }
    return _tableView;
}

@end
