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
#import "JMUploadVideoViewController.h"
#import "JMIDCardIdentifyViewController.h"
#import "JMBUserInfoViewController.h"
#import "UIView+addGradualLayer.h"
#import "JMBUserCenterHeaderView.h"
#import "JMBUserCenterHeaderSubView.h"
#import "JMBUserMineSectionView.h"
#import "JMPositionManageViewController.h"
#import "JMTaskManageViewController.h"
#import "JMTaskManageViewController.h"
#import "UITabBar+XSDExt.h"
#import "JMShareView.h"
#import "JMWalletViewController.h"




@interface JMMineViewController ()<UITableViewDelegate,UITableViewDataSource,JMMineModulesTableViewCellDelegate,JMMPersonalCenterHeaderViewDelegate,JMBUserCenterHeaderViewDelegate,JMBUserCenterHeaderSubViewDelegate,JMShareViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *imageNameArr,*labelStrArr;
@property (strong, nonatomic) JMUserInfoModel *userInfoModel;
//@property (strong, nonatomic) JMBUserCenterHeaderView *BUserCenterHeaderView;
@property(nonatomic,strong)JMShareView *shareView;//分享
@property(nonatomic,strong)UIView *shareBgView;//灰色背景



@end

@implementation JMMineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setIsHiddenBackBtn:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    _userInfoModel = [JMUserInfoManager getUserInfo];

    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(-SafeAreaStatusHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    
//    JMVersionModel *model = [JMVersionManager getVersoinInfo];
//    if (![model.test isEqualToString:@"1"]) {
//        self.imageNameArr = @[@"mine_share",@"burse",@"autonym"];
//        self.labelStrArr = @[@"分享APP",@"我的钱包",@"实名认证"];
//        
//    }else{
        self.imageNameArr = @[@"burse",@"autonym"];
        self.labelStrArr = @[@"我的钱包",@"实名认证"];

//    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self getUserData];
    if (_personalCenterHeaderView.taskBadgeView.hidden && _personalCenterHeaderView.orderBadgeView.hidden) {
        self.tabBarItem.badgeValue = nil;
    }
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}


#pragma mark - 获取数据

-(void)getUserData{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
//        if ([userInfo.deadline isEqualToString:@"0"]) {
//            [self.BUserCenterHeaderView.VIPImg setHidden:YES];
//        }else{
//            [self.BUserCenterHeaderView.VIPImg setHidden:NO];
//
//        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
 
}

-(void)rightAction{
    JMMySettingViewController *vc = [[JMMySettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - My delegate
-(void)shareViewCancelAction{
    [self disapearAction];
    
}
    
-(void)shareViewLeftAction{
    [self disapearAction];
}
    
-(void)shareViewRightAction{
    [self disapearAction];
}

-(void)disapearAction{
    NSLog(@"222");
    [self.shareBgView setHidden:YES];
    [self.shareView setHidden:YES];
}
    
#pragma mark - C端个人的中心
-(void)didClickSetting{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        [self showAlertWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" leftTitle:@"返回" rightTitle:@"去登录"];
        return;
    }
    JMMySettingViewController *vc = [[JMMySettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)didClickMyOrder{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        [self showAlertWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" leftTitle:@"返回" rightTitle:@"去登录"];
        return;
    }
 
    
}

-(void)didClickMyTask{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        [self showAlertWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" leftTitle:@"返回" rightTitle:@"去登录"];
        return;
    }
    JMTaskManageViewController *vc = [[JMTaskManageViewController alloc]init];
    vc.title = @"我的兼职";
    [vc setMyIndex:0];
    [self.personalCenterHeaderView.taskBadgeView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
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
  
//    if (indexPath.section == 0) {
//        cell.accessoryType = UITableViewCellStyleSubtitle;
//        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
//        if ([userModel.type isEqualToString:B_Type_UESR]) {
//            cell.detailTextLabel.text = self.userInfoModel.company_position;
//        }else{
//            cell.detailTextLabel.text = @"完善简历，让机遇找到你  90%";
//
//        }
//            cell.textLabel.text = [NSString stringWithFormat:@"%@",self.userInfoModel.nickname];
//
//        cell.textLabel.numberOfLines = 0;
//        cell.textLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:18];
//        cell.textLabel.textColor = UIColorFromHEX(0x4d4d4d);
//
//        cell.detailTextLabel.textColor = UIColorFromHEX(0x808080);
//        //改变头像大小
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.userInfoModel.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
//
//        CGSize itemSize = CGSizeMake(74, 74);
//        cell.imageView.layer.cornerRadius = 37;
//        cell.imageView.layer.masksToBounds = YES;
//        UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
//        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
//        [cell.imageView.image drawInRect:imageRect];
//        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
        
//    }
    if (indexPath.section == 0) {
        JMMineModulesTableViewCell *modulesCell = [[JMMineModulesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        modulesCell.delegate = self;
        return modulesCell;
    }
    
    if (indexPath.section == 1) {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.labelStrArr[indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:14];
        cell.textLabel.textColor = UIColorFromHEX(0x4d4d4d);
        cell.imageView.image = [UIImage imageNamed:self.imageNameArr[indexPath.row]];
        return cell;
    }
    
    return nil;
}

-(void)alertRightAction{
    [self loginOut];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        [self showAlertWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" leftTitle:@"返回" rightTitle:@"去登录"];
        return;
    }
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
//            JMVersionModel *versionModel = [JMVersionManager getVersoinInfo];
//            if (![versionModel.test isEqualToString:@"1"]) {
//                //实名认证
//                JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
//                if ([model.card_status isEqualToString:Card_PassIdentify]) {
//                    [self showAlertSimpleTips:@"提示" message:@"你已通过实名认证" btnTitle:@"好的"];
//
//                }else if (([model.card_status isEqualToString:Card_WaitIdentify])){
//                    [self showAlertSimpleTips:@"提示" message:@"审核实名认证中" btnTitle:@"好的"];
//                }else{
//
//                    [self.navigationController pushViewController:[[JMIDCardIdentifyViewController alloc] init] animated:YES];
//                }
//            }
            
//            else{
//     
//                    [[UIApplication sharedApplication].keyWindow addSubview:self.shareBgView];
//                    [_shareBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.top.equalTo(self.view);
//                        make.left.and.right.equalTo(self.view);
//                        make.height.equalTo(self.view);
//                    }];
//                    [self.shareView setHidden:NO];
//                    [self.shareBgView setHidden:NO];
//                    [[UIApplication sharedApplication].keyWindow addSubview:self.shareView];
//                    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.bottom.equalTo(self.view);
//                        make.left.and.right.equalTo(self.view);
//                        make.height.mas_equalTo(184+SafeAreaBottomHeight);
//                        
//                    }];
//                    //            [self showAlertSimpleTips:@"提示" message:@"请先安装微信" btnTitle:@"好的"];
//     
//            }
            JMWalletViewController *vc = [[JMWalletViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else  if (indexPath.row == 1) {
            //实名认证
            JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
            if ([model.card_status isEqualToString:Card_PassIdentify]) {
                [self showAlertSimpleTips:@"提示" message:@"你已通过实名认证" btnTitle:@"好的"];

            }else if (([model.card_status isEqualToString:Card_WaitIdentify])){
                [self showAlertSimpleTips:@"提示" message:@"审核实名认证中" btnTitle:@"好的"];
            }else{

                [self.navigationController pushViewController:[[JMIDCardIdentifyViewController alloc] init] animated:YES];
            }
        }
        
    }
    
}
- (UIImage*)convertViewToImage:(UIView*)view{
    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - UITableViewDataSource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if ([_userInfoModel.type isEqualToString:B_Type_UESR]) {
//
//        JMBUserMineSectionView *view = [JMBUserMineSectionView new];
//        if (section == 0) {
//            [view setTitleStr:@"公司信息"];
//        }else if (section == 1) {
//            [view setTitleStr:@"更多功能"];
//        }
//        return view;
//    }
    
    return [UIView new];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if ([_userInfoModel.type isEqualToString:B_Type_UESR]) {
//        return 53;
//    }
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return _imageNameArr.count;

    }
    return 0;
//    if (section == 1) {
//        return _imageNameArr.count;
//    }else {
//        return 1;
//    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    }else if(indexPath.section == 1){
        return 69;
    }
    return 0;
}

- (void)didSelectItemWithRow:(NSInteger)row {
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        [self showAlertWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" leftTitle:@"返回" rightTitle:@"去登录"];
        return;
    }
    if (row == 0) {
        if ([_userInfoModel.type isEqualToString:C_Type_USER]) {
            JMMyResumeViewController *vc = [[JMMyResumeViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
//        else if ([_userInfoModel.type isEqualToString:B_Type_UESR]){
//            //职位管理
//            JMPositionManageViewController *vc = [[JMPositionManageViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
    
    }else if (row == 1) {
        if ([_userInfoModel.type isEqualToString:C_Type_USER]) {
            JMUploadVideoViewController *vc = [[JMUploadVideoViewController alloc]init];
            vc.title = @"视频简历";
            vc.viewType = JMUploadVideoViewTypeJobEdit;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
//        else if ([_userInfoModel.type isEqualToString:B_Type_UESR]){
//            JMCompanyInfoMineViewController *vc = [[JMCompanyInfoMineViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//
//        }
        
    }else if (row == 2) {
        JMManageInterviewViewController *vc = [[JMManageInterviewViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (row == 3) {
        JMCompanyLikeViewController *vc = [[JMCompanyLikeViewController alloc]init];
        vc.title = @"职位收藏";
        
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
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;
        _tableView.tableHeaderView = self.personalCenterHeaderView;

    }
    return _tableView;
}

-(JMMPersonalCenterHeaderView *)personalCenterHeaderView{
    if (!_personalCenterHeaderView) {
        _personalCenterHeaderView =  [[JMMPersonalCenterHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 106+65+20)];
        _personalCenterHeaderView.delegate = self;
        [_personalCenterHeaderView addGradualLayerWithColors:@[(__bridge id)UIColorFromHEX(0x00E4FC).CGColor,
                                          (__bridge id)UIColorFromHEX(0x4AA2FB).CGColor,
                                          (__bridge id)UIColorFromHEX(0x258ff2).CGColor
                                          ]];
        
        
    }
    return _personalCenterHeaderView;
}
    
-(JMShareView *)shareView{
        if (!_shareView) {
            _shareView = [[JMShareView alloc]init];
            _shareView.delegate = self;
        }
        return _shareView;
    }
    
    
-(UIView *)shareBgView{
    
    if (!_shareBgView) {
        
        _shareBgView = [[UIView alloc]init];
        _shareBgView.backgroundColor =  [UIColor colorWithRed:48/255.0 green:48/255.0 blue:51/255.0 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapearAction)];
        [_shareBgView addGestureRecognizer:tap];
        
    }
    
    return _shareBgView;
    
}
    
    
//
//-(JMBUserCenterHeaderView *)BUserCenterHeaderView{
//    if (!_BUserCenterHeaderView) {
//        _BUserCenterHeaderView =  [[JMBUserCenterHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 135)];
//        _BUserCenterHeaderView.delegate = self;
//        [_BUserCenterHeaderView addGradualLayerWithColors:@[(__bridge id)UIColorFromHEX(0x00E4FC).CGColor,
//                                                            (__bridge id)UIColorFromHEX(0x4AA2FB).CGColor,
//                                                            (__bridge id)UIColorFromHEX(0x258ff2).CGColor
//                                                            ]];
//
//        _BUserCenterHeaderSubView = [[JMBUserCenterHeaderSubView alloc]initWithFrame:CGRectMake(13, 85, SCREEN_WIDTH-26, 105)];
//
//        _BUserCenterHeaderSubView.delegate = self;
//        _BUserCenterHeaderSubView.layer.shadowColor = [UIColor colorWithRed:20/255.0 green:31/255.0 blue:87/255.0 alpha:0.1].CGColor;
//        _BUserCenterHeaderSubView.layer.shadowOffset = CGSizeMake(0,1);
//        _BUserCenterHeaderSubView.layer.shadowOpacity = 1;
//        _BUserCenterHeaderSubView.layer.shadowRadius = 6;
//        _BUserCenterHeaderSubView.layer.cornerRadius = 10;
//        _BUserCenterHeaderSubView.backgroundColor = [UIColor whiteColor];
//
//
//        [_BUserCenterHeaderView addSubview:_BUserCenterHeaderSubView];
////
//
//
//    }
//    return _BUserCenterHeaderView;
//}

//-(JMBUserCenterHeaderSubView *)BUserCenterHeaderSubView{
//    if (!_BUserCenterHeaderSubView) {
//        _BUserCenterHeaderSubView = [[JMBUserCenterHeaderSubView alloc]initWithFrame:CGRectMake(13, 85, SCREEN_WIDTH-26, 105)];
//
//        _BUserCenterHeaderSubView.delegate = self;
//        _BUserCenterHeaderSubView.layer.shadowColor = [UIColor colorWithRed:20/255.0 green:31/255.0 blue:87/255.0 alpha:0.1].CGColor;
//        _BUserCenterHeaderSubView.layer.shadowOffset = CGSizeMake(0,1);
//        _BUserCenterHeaderSubView.layer.shadowOpacity = 1;
//        _BUserCenterHeaderSubView.layer.shadowRadius = 6;
//        _BUserCenterHeaderSubView.layer.cornerRadius = 10;
//        _BUserCenterHeaderSubView.backgroundColor = [UIColor whiteColor];
//
//    }
//    return _BUserCenterHeaderSubView;
//}


@end
