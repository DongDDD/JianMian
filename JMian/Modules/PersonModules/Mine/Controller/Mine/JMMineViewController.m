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
#import "JMMyOrderListViewController.h"
#import "WXApi.h"
#import "JMYoukeAction.h"//游客登陆



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
    self.navigationController.navigationBar.translucent = NO;
    [self setIsHiddenBackBtn:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    _userInfoModel = [JMUserInfoManager getUserInfo];

    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(-SafeAreaStatusHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    
        self.imageNameArr = @[@"mine_share",@"burse",@"autonym"];
        self.labelStrArr = @[@"分享APP",@"我的钱包",@"实名认证"];

    
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
    [self wxShare:0];
}

-(void)shareViewRightAction{
    [self disapearAction];
    [self wxShare:1];
}

-(void)disapearAction{
    [self.shareBgView setHidden:YES];
    [self.shareView setHidden:YES];
}
#pragma mark -- 微信分享的是链接
- (void)wxShare:(int)n
{   //检测是否安装微信
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc]init];
    sendReq.bText = NO; //不使用文本信息
    sendReq.scene = n;  //0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = @"得米，招全职，找兼职，找你想要的";
    urlMessage.description = @"来得米，招人，找活，找你想要的！";
    
    //    UIImageView *imgView = [[UIImageView alloc]init];
    //    [imgView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.company_logo_path]];
    //
    
    UIImage *image = [UIImage imageNamed:@"logo2"];
    //缩略图,压缩图片,不超过 32 KB
    NSData *thumbData = UIImageJPEGRepresentation(image, 0.25);
    [urlMessage setThumbData:thumbData];
    //分享实例
    WXWebpageObject *webObj = [WXWebpageObject object];
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    webObj.webpageUrl = userModel.share;
    
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    //发送分享
    [WXApi sendReq:sendReq];
    
}

#pragma mark - C端个人的中心
-(void)didClickSetting{
    if ([JMYoukeAction youkelimit]) {
        return;
    }
    
    JMMySettingViewController *vc = [[JMMySettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)didClickMyOrder{
    if ([JMYoukeAction youkelimit]) {
        return;
    }
    
    JMMyOrderListViewController *vc = [[JMMyOrderListViewController alloc]init];
    vc.viewType = JMMyOrderListViewControllerCUser;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)didClickMyExtension{
    if ([JMYoukeAction youkelimit]) {
        return;
    }
    JMMyOrderListViewController *vc = [[JMMyOrderListViewController alloc]init];
    vc.viewType = JMMyOrderListViewControllerCUserExtension;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

-(void)didClickMyTask{
    if ([JMYoukeAction youkelimit]) {
        return;
    }
    
    JMTaskManageViewController *vc = [[JMTaskManageViewController alloc]init];
    [vc setMyIndex:0];
    [self.personalCenterHeaderView.taskBadgeView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
}




//- (NSDictionary *)generateDicFromArray:(NSArray *)array {
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    for (id object in array) {
//        NSString *key = [NSString stringWithFormat:@"%@",object];
//        dic[key] = object;
//    }
//    return dic.copy;
//}


#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        JMMineModulesTableViewCell *modulesCell = [[JMMineModulesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        modulesCell.delegate = self;
        return modulesCell;
    }
    
    if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
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
    if ([JMYoukeAction youkelimit]) {
        return;
    }
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            [[UIApplication sharedApplication].keyWindow addSubview:self.shareBgView];
            [_shareBgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view);
                make.left.and.right.equalTo(self.view);
                make.height.equalTo(self.view);
            }];
            [self.shareView setHidden:NO];
            [self.shareBgView setHidden:NO];
            [[UIApplication sharedApplication].keyWindow addSubview:self.shareView];
            [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view);
                make.left.and.right.equalTo(self.view);
                make.height.mas_equalTo(184+SafeAreaBottomHeight);
                
            }];
            
     
        }else  if (indexPath.row == 1) {
            JMWalletViewController *vc = [[JMWalletViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else  if (indexPath.row == 2) {
            //实名认证
            JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
            if ([model.card_status isEqualToString:Card_PassIdentify]) {
                [self showAlertSimpleTips:@"提示" message:@"你已通过实名认证" btnTitle:@"好的"];

            }else if (([model.card_status isEqualToString:Card_WaitIdentify])){
                [self showAlertSimpleTips:@"提示" message:@"实名认证审核中" btnTitle:@"耐心等等"];
            }else{
//
                [self.navigationController pushViewController:[[JMIDCardIdentifyViewController alloc] init] animated:YES];
            }
        
        }
        
    }
    
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
    if ([JMYoukeAction youkelimit]) {
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
