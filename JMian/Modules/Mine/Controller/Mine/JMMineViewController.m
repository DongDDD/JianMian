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
#import "JMCompanyLikeViewController.h"
#import "JMMySettingViewController.h"
#import "JMWalletViewController.h"
#import "JMUploadVideoViewController.h"
#import "JMIDCardIdentifyViewController.h"
#import "JMBUserInfoViewController.h"




@interface JMMineViewController ()<UITableViewDelegate,UITableViewDataSource,JMMineModulesTableViewCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *imageNameArr,*labelStrArr;
@property (strong, nonatomic) JMUserInfoModel *userInfoModel;

@end

@implementation JMMineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setIsHiddenBackBtn:YES];
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
    
    
    if ([_userInfoModel.type isEqualToString:B_Type_UESR]) {
        
       
    }else if ([_userInfoModel.type isEqualToString:C_Type_USER]){
        
    }
    
    self.imageNameArr = @[@"burse",@"autonym"];
    self.labelStrArr = @[@"我的钱包",@"实名认证"];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getUserData];//    [self getCompanyData];
}

#pragma mark - 获取数据

-(void)getUserData{
    
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

        self.userInfoModel = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [self.tableView reloadData];
//        [self getCompanyData];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];
    
}

-(void)rightAction{
    JMMySettingViewController *vc = [[JMMySettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


//-(void)getCompanyData{
//
//
//    [[JMHTTPManager sharedInstance] fetchCompanyInfo_Id:self.userInfoModel.company_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//
//
//
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//
//
//    }];
//
//}

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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
//        cell.accessoryType = UITableViewCellStyleSubtitle;
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        if ([userModel.type isEqualToString:B_Type_UESR]) {
            cell.detailTextLabel.text = self.userInfoModel.company_position;
        }else{
            cell.detailTextLabel.text = @"完善简历，让机遇找到你  90%";

        }
            cell.textLabel.text = [NSString stringWithFormat:@"%@",self.userInfoModel.nickname];

        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:18];
        cell.textLabel.textColor = UIColorFromHEX(0x4d4d4d);
        
        cell.detailTextLabel.textColor = UIColorFromHEX(0x808080);
        //改变头像大小
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.userInfoModel.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        
        CGSize itemSize = CGSizeMake(74, 74);
        cell.imageView.layer.cornerRadius = 37;
        cell.imageView.layer.masksToBounds = YES;
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [cell.imageView.image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
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
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        if ([_userInfoModel.type isEqualToString:C_Type_USER]) {
            [self.navigationController pushViewController:[[JMMyResumeViewController alloc] init] animated:YES];
  
        }else{
            JMBUserInfoViewController *vc = [[JMBUserInfoViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        

    }else if (indexPath.section == 2 && indexPath.row == 0){
        
        [self.navigationController pushViewController:[[JMWalletViewController alloc] init] animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 1){
        
        JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
        if ([model.card_status isEqualToString:Card_PassIdentify]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你已通过实名认证"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
        }else if (([model.card_status isEqualToString:Card_WaitIdentify])){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"审核实名认证中"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
        }else{

            [self.navigationController pushViewController:[[JMIDCardIdentifyViewController alloc] init] animated:YES];
        }
    }
    
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
        if ([_userInfoModel.type isEqualToString:C_Type_USER]) {
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
        if ([_userInfoModel.type isEqualToString:C_Type_USER]) {
            JMUploadVideoViewController *vc = [[JMUploadVideoViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([_userInfoModel.type isEqualToString:B_Type_UESR]){
            JMCompanyInfoMineViewController *vc = [[JMCompanyInfoMineViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        
    }else if (row == 1) {
        JMManageInterviewViewController *vc = [[JMManageInterviewViewController alloc]init];
        vc.title = @"职位收藏";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (row == 2) {
        JMCompanyLikeViewController *vc = [[JMCompanyLikeViewController alloc]init];
        vc.title = @"人才收藏";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (row == 3) {
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
