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
#import "UIView+addGradualLayer.h"
#import "JMMyOrderListViewController.h"
#import "JMBUserCenterHeaderView.h"
#import "JMBUserCenterHeaderSubView.h"
#import "JMBUserMineSectionView.h"
#import "JMPositionManageViewController.h"
#import "JMTaskManageViewController.h"
#import "JMVIPViewController.h"
#import "JMTaskManageViewController.h"
#import "UITabBar+XSDExt.h"
#import "WXApi.h"






@interface JMMineViewController ()<UITableViewDelegate,UITableViewDataSource,JMMineModulesTableViewCellDelegate,JMMPersonalCenterHeaderViewDelegate,JMBUserCenterHeaderViewDelegate,JMBUserCenterHeaderSubViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *imageNameArr,*labelStrArr;
@property (strong, nonatomic) JMUserInfoModel *userInfoModel;
//@property (strong, nonatomic) JMBUserCenterHeaderView *BUserCenterHeaderView;



@end

@implementation JMMineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setIsHiddenBackBtn:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    _userInfoModel = [JMUserInfoManager getUserInfo];
//    if ([_userInfoModel.type isEqualToString:B_Type_UESR]) {
//
//        [[UIApplication sharedApplication].keyWindow addSubview:self.BUserCenterHeaderView];
////        [[UIApplication sharedApplication].keyWindow addSubview:self.BUserCenterHeaderSubView];
//
//    }else if ([_userInfoModel.type isEqualToString:C_Type_USER]){
//
//        [[UIApplication sharedApplication].keyWindow addSubview:self.personalCenterHeaderView];
//    }

//    [self setRightBtnImageViewName:@"upinstall" imageNameRight2:@""];
 
    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        if ([_userInfoModel.type isEqualToString:B_Type_UESR]) {
//
//            make.top.mas_equalTo(self.mas_topLayoutGuide).offset(130);
//        }else{
//            make.top.mas_equalTo(self.mas_topLayoutGuide).mas_offset(80);
//
//        }
//
//        make.left.right.bottom.equalTo(self.view);
//    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(-40);
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
#pragma mark - C端个人的中心
-(void)didClickSetting{
    JMMySettingViewController *vc = [[JMMySettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)didClickMyOrder{
    JMMyOrderListViewController *vc = [[JMMyOrderListViewController alloc]init];
    vc.viewType = JMMyOrderListViewControllerCUser;
    [self.personalCenterHeaderView.orderBadgeView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)didClickMyTask{
    JMTaskManageViewController *vc = [[JMTaskManageViewController alloc]init];
    vc.title = @"我的任务";
    [vc setMyIndex:0];
    [self.personalCenterHeaderView.taskBadgeView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//#pragma mark - B端个人的中心
//
//-(void)BTaskClick{
//    JMTaskManageViewController *vc = [[JMTaskManageViewController alloc]init];
//    vc.title = @"任务管理";
//    [vc setMyIndex:0];
//    [_BUserCenterHeaderSubView.taskBadgeView setHidden:YES];
//
//    [self.navigationController pushViewController:vc animated:YES];
//
//}
//
//-(void)BOrderClick{
//    JMMyOrderListViewController *vc = [[JMMyOrderListViewController alloc]init];
//    vc.viewType = JMMyOrderListViewControllerBUser;
//    [_BUserCenterHeaderSubView.orderBadgeView setHidden:YES];
//    [self.navigationController pushViewController:vc animated:YES];
//
//}
//
//-(void)BVIPClick{
//    JMVIPViewController *vc = [[JMVIPViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//}
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            //微信分享
            [self wxShare:0];
        }else if (indexPath.row == 1) {
            //我的钱包
            [self.navigationController pushViewController:[[JMWalletViewController alloc] init] animated:YES];
        }else  if (indexPath.row == 2) {
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

#pragma mark -- 微信分享的是链接
- (void)wxShare:(int)n
{   //检测是否安装微信
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc]init];
    sendReq.bText = NO; //不使用文本信息
    sendReq.scene = n;  //0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = @"得米";
    urlMessage.description = @"来得米，招人，找活，找你想要的！" ;
    
    //    UIImageView *imgView = [[UIImageView alloc]init];
    //    [imgView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.company_logo_path]];
    //
    
    UIImage *image = [UIImage imageNamed:@"demi_home"];
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
