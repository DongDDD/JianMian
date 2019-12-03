//
//  JMBMineViewController.m
//  JMian
//
//  Created by mac on 2019/7/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBMineViewController.h"
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
#import "JMBMineInfoView.h"
#import "JMBMineMoreFunctionView.h"
#import "JMShareView.h"
#import "JMWalletViewController.h"
#import "JMVIPViewController.h"
#import "JMMyOrderListViewController.h"
#import "WXApi.h"
#import "JMYoukeAction.h"

@interface JMBMineViewController ()<JMMineModulesTableViewCellDelegate,JMMPersonalCenterHeaderViewDelegate,JMBUserCenterHeaderViewDelegate,JMBUserCenterHeaderSubViewDelegate,JMBMineInfoViewDelegate,JMBMineMoreFunctionViewDelegate,JMShareViewDelegate>

@property (strong, nonatomic) JMBUserCenterHeaderView *BUserCenterHeaderView;
@property (strong, nonatomic) JMBMineInfoView *BMineInfoView;
@property (strong, nonatomic) JMBMineMoreFunctionView *BMineMoreFunctionView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property(nonatomic,strong)JMShareView *shareView;//分享
@property(nonatomic,strong)UIView *shareBgView;//灰色背景

@end

@implementation JMBMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BG_COLOR;
    
   self.navigationController.navigationBar.translucent = NO;
   
    [self initView];

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.BMineMoreFunctionView.frame.origin.y+self.BMineMoreFunctionView.frame.size.height+20);
    [self getUserData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - Action

-(void)disapearAction{
 
    [self.shareBgView setHidden:YES];
    [self.shareView setHidden:YES];
}
#pragma mark - data

-(void)getUserData{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        if ([userInfo.deadline isEqualToString:@"0"]) {
            [self.BUserCenterHeaderView.VIPImg setHidden:YES];
        }else{
            [self.BUserCenterHeaderView.VIPImg setHidden:NO];
            
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}



#pragma mark - 布局
-(void)initView{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.BUserCenterHeaderView];
    [self.scrollView addSubview:self.BMineInfoView];
    [self.scrollView addSubview:self.BMineMoreFunctionView];

}

#pragma mark - myDelegate
// - B端个人的中心
-(void)BTaskClick{
    if ([JMYoukeAction youkelimit]) {
         return;
     }
     
    JMTaskManageViewController *vc = [[JMTaskManageViewController alloc]init];
    vc.title = @"任务管理";
    [vc setMyIndex:0];
    [_BUserCenterHeaderSubView.taskBadgeView setHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)BVIPClick{
    if ([JMYoukeAction youkelimit]) {
         return;
     }
     
    JMVIPViewController *vc = [[JMVIPViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)BOrderClick{
    if ([JMYoukeAction youkelimit]) {
         return;
     }
     
    JMMyOrderListViewController *vc = [[JMMyOrderListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)didClickSetting{
    if ([JMYoukeAction youkelimit]) {
         return;
     }
     
    JMMySettingViewController *vc = [[JMMySettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)didSelectItemWithRow:(NSInteger)row{
    if ([JMYoukeAction youkelimit]) {
         return;
     }
     
    if (row == 0) {
        //职位管理
        JMPositionManageViewController *vc = [[JMPositionManageViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (row == 1) {
        JMCompanyInfoMineViewController *vc = [[JMCompanyInfoMineViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (row == 2) {
        JMManageInterviewViewController *vc = [[JMManageInterviewViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (row == 3) {
        JMCompanyLikeViewController *vc = [[JMCompanyLikeViewController alloc]init];
        vc.title = @"人才收藏";
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)didSelectCellWithRow:(NSInteger)row{
    if ([JMYoukeAction youkelimit]) {
         return;
     }
     
    if (row == 0) {
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
    }else  if (row == 1) {
        JMWalletViewController *vc = [[JMWalletViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else  if (row == 2) {
    
        //实名认证
        JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
        if ([model.card_status isEqualToString:Card_PassIdentify]) {
            [self showAlertVCSucceesSingleWithMessage:@"你已通过实名认证" btnTitle:@"好的"];
            
        }else if (([model.card_status isEqualToString:Card_WaitIdentify])){
            [self showAlertSimpleTips:@"提示" message:@"审核实名认证中" btnTitle:@"好的"];
        }else{
            
            [self.navigationController pushViewController:[[JMIDCardIdentifyViewController alloc] init] animated:YES];
        }
    
    }
}

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
#pragma mark - lazy

-(JMBUserCenterHeaderView *)BUserCenterHeaderView{
    if (!_BUserCenterHeaderView) {
        _BUserCenterHeaderView =  [[JMBUserCenterHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 135)];
        _BUserCenterHeaderView.delegate = self;
        [_BUserCenterHeaderView addGradualLayerWithColors:@[(__bridge id)UIColorFromHEX(0x00E4FC).CGColor,
                                                            (__bridge id)UIColorFromHEX(0x4AA2FB).CGColor,
                                                            (__bridge id)UIColorFromHEX(0x258ff2).CGColor
                                                            ]];
        
        _BUserCenterHeaderSubView = [[JMBUserCenterHeaderSubView alloc]initWithFrame:CGRectMake(13, 85, SCREEN_WIDTH-26, 105)];
        
        _BUserCenterHeaderSubView.delegate = self;
        _BUserCenterHeaderSubView.layer.shadowColor = [UIColor colorWithRed:20/255.0 green:31/255.0 blue:87/255.0 alpha:0.1].CGColor;
        _BUserCenterHeaderSubView.layer.shadowOffset = CGSizeMake(0,1);
        _BUserCenterHeaderSubView.layer.shadowOpacity = 1;
        _BUserCenterHeaderSubView.layer.shadowRadius = 6;
        _BUserCenterHeaderSubView.layer.cornerRadius = 10;
        _BUserCenterHeaderSubView.backgroundColor = [UIColor whiteColor];
        
        
        [_BUserCenterHeaderView addSubview:_BUserCenterHeaderSubView];
        //
        
        
    }
    return _BUserCenterHeaderView;
}


-(JMBMineInfoView *)BMineInfoView{
    if (!_BMineInfoView) {
        _BMineInfoView = [[JMBMineInfoView alloc]initWithFrame:CGRectMake(0, self.BUserCenterHeaderView.frame.origin.y+self.BUserCenterHeaderView.frame.size.height+74, SCREEN_WIDTH, 162)];
        _BMineInfoView.delegate = self;
    }
    return _BMineInfoView;
}

-(JMBMineMoreFunctionView *)BMineMoreFunctionView{
    if (!_BMineMoreFunctionView) {
        _BMineMoreFunctionView = [[JMBMineMoreFunctionView alloc]initWithFrame:CGRectMake(0, self.BMineInfoView.frame.origin.y+self.BMineInfoView.frame.size.height, SCREEN_WIDTH, 274)];
        _BMineMoreFunctionView.delegate = self;
    }
    return _BMineMoreFunctionView;
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.scrollEnabled = NO;
        _scrollView.backgroundColor = BG_COLOR;
    }
    return _scrollView;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
