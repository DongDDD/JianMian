//
//  JMPositionManageViewController.m
//  JMian
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPositionManageViewController.h"
#import "JMTitlesView.h"
#import "JMPostJobHomeViewController.h"
#import "JMPartTimeJobResumeViewController.h"
#import "JMBUserPostSaleJobViewController.h"
#import "JMBUserPostPartTimeJobViewController.h"
#import "JMPostNewJobViewController.h"
#import "JMHTTPManager+Login.h"
#import "JMPostTaskBottomView.h"
#import "JMPostTypeChooseView.h"
#import "JMHistoryViewController.h"

@interface JMPositionManageViewController ()<JMPartTimeJobResumeViewControllerDelegate,JMPostTaskBottomViewDelegate,JMPostTypeChooseViewDelegate>

@property(nonatomic, strong)JMTitlesView *titleView;
@property(nonatomic, strong)JMPostJobHomeViewController *jobHomeListVC;
@property(nonatomic, strong)JMPartTimeJobResumeViewController *partTimeJobHomeListVC;
//@property(nonatomic, strong)JMPostTaskBottomView *postTaskBottomView;
//@property(nonatomic, strong)JMPostTypeChooseView *postTypeChooseView;
//
//@property(nonatomic, strong)UIView *chooseViewBgView;
@property(nonatomic, strong)UIView *BGView;
@property(nonatomic, assign)NSUInteger index;
@property(nonatomic, strong)UIAlertController *alertController;

@end

@implementation JMPositionManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"职位管理";
//    [self setRightBtnTextName:@"发布全职"];
 
//    [self getUserInfo];
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.card_status isEqualToString:Card_PassIdentify]) {
        [self setRightBtnTextName:@"发布全职"];
        
    }
//    [self.postTaskBottomView.postTaskBtn setTitle:@"发布职位" forState:UIControlStateNormal];
    [self setIsHiddenRightBtn:YES];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.BGView];
    [self.BGView addSubview:self.partTimeJobHomeListVC.view];
    [self.BGView addSubview:self.jobHomeListVC.view];

    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
        make.left.and.right.mas_equalTo(self.view);
    }];
    [self.jobHomeListVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.BGView);
        make.bottom.mas_equalTo(self.BGView);
        make.left.and.right.mas_equalTo(self.view);
    }];
    [self.partTimeJobHomeListVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.BGView);
        make.bottom.mas_equalTo(self.BGView);
        make.left.and.right.mas_equalTo(self.view);
    }];
    
//    [self.view addSubview:self.postTaskBottomView];
//    [self.postTaskBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.view);
//        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
//        make.height.mas_equalTo(64);
//    }];
//    [[UIApplication sharedApplication].keyWindow addSubview:self.chooseViewBgView];
//    [self.chooseViewBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo([UIApplication sharedApplication].keyWindow);
//        make.left.and.right.equalTo([UIApplication sharedApplication].keyWindow);
//        make.height.mas_equalTo(SCREEN_HEIGHT-217-SafeAreaBottomHeight);
//
//    }];
//    [self.view addSubview:self.postTypeChooseView];
//    [self.postTypeChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view);
//        make.left.and.right.equalTo(self.view);
//        make.height.mas_equalTo(217+SafeAreaBottomHeight);
//
//    }];
//    [self.postTypeChooseView setHidden:YES];
//    [self.chooseViewBgView setHidden:YES];
}

-(void)rightAction{
    if (_index == 0) {
        JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else if(_index == 1){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"发布网络销售任务" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JMBUserPostSaleJobViewController *vc = [[JMBUserPostSaleJobViewController alloc]init];
            vc.viewType = JMBUserPostSaleJobViewTypeAdd;
            [self.navigationController pushViewController:vc animated:YES];
 
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"发布任务" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JMBUserPostPartTimeJobViewController *vc = [[JMBUserPostPartTimeJobViewController alloc]init];
            vc.viewType = JMBUserPostPartTimeJobTypeAdd;
            [self.navigationController pushViewController:vc animated:YES];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    }

}

-(void)postPartTimeJobAction{

    [self rightAction];

}

-(void)getUserInfo{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        if ([userModel.card_status isEqualToString:Card_PassIdentify]) {
            [self setRightBtnTextName:@"发布全职"];
            
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


-(void)setCurrentIndex{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.card_status isEqualToString:Card_PassIdentify]) {
        if (_index == 0) {
            _partTimeJobHomeListVC.view.hidden = YES;
            _jobHomeListVC.view.hidden = NO;
//            [self setRightBtnTextName:@"发布全职"];
//            [self.postTaskBottomView.postTaskBtn setTitle:@"发布职位" forState:UIControlStateNormal];

            
        }else if(_index == 1){
            _partTimeJobHomeListVC.view.hidden = NO;
            _jobHomeListVC.view.hidden = YES;
//            [self setRightBtnTextName:@"发布任务"];
//            [self.postTaskBottomView.postTaskBtn setTitle:@"发布任务" forState:UIControlStateNormal];

        }
    
    }

}
//-(void)disapearAction{
//
//    [self.postTypeChooseView setHidden:YES];
//    [self.chooseViewBgView setHidden:YES];
//
//}
#pragma mark - MyDelegate
//-(void)didClickPostAction{
//    if (_index == 0) {
//        JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//
//
//    }else if(_index == 1){
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
//        [alert addAction:[UIAlertAction actionWithTitle:@"发布网络销售任务" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            JMBUserPostSaleJobViewController *vc = [[JMBUserPostSaleJobViewController alloc]init];
//            vc.viewType = JMBUserPostSaleJobViewTypeAdd;
//            [self.navigationController pushViewController:vc animated:YES];
//
//        }]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"发布任务" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            JMBUserPostPartTimeJobViewController *vc = [[JMBUserPostPartTimeJobViewController alloc]init];
//            vc.viewType = JMBUserPostPartTimeJobTypeAdd;
//            [self.navigationController pushViewController:vc animated:YES];
//
//        }]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//
//        }]];
//        [self presentViewController:alert animated:YES completion:nil];
    
//        [self.postTypeChooseView setHidden:NO];
//        [self.chooseViewBgView setHidden:NO];
//    }
//
//}

//-(void)didSelectedPostTypeWithTag:(NSInteger)tag{
//    if (tag == 100) {
//        JMBUserPostSaleJobViewController *vc = [[JMBUserPostSaleJobViewController alloc]init];
//        vc.viewType = JMBUserPostSaleJobViewTypeAdd;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if (tag == 101) {
//        JMBUserPostPartTimeJobViewController *vc = [[JMBUserPostPartTimeJobViewController alloc]init];
//        vc.viewType = JMBUserPostPartTimeJobTypeAdd;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if (tag == 102) {
//        JMHistoryViewController *vc = [[JMHistoryViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//
//
//    }
////    [self disapearAction];
//}

#pragma mark - getter

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"全职职位", @"任务职位"]];
        _titleView.viewType = JMTitlesViewPositionManage;
        [_titleView setCurrentTitleIndex:0];
        __weak JMPositionManageViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf setCurrentIndex];
        };
    }
    
    return _titleView;
}

//全职职位
-(JMPostJobHomeViewController *)jobHomeListVC{
    if (!_jobHomeListVC) {
        _jobHomeListVC = [[JMPostJobHomeViewController alloc]init];
        _jobHomeListVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height-_titleView.frame.size.height-64);
        [self addChildViewController:_jobHomeListVC];
    }
    return _jobHomeListVC;
}

//兼职职位
-(JMPartTimeJobResumeViewController *)partTimeJobHomeListVC{
    if (!_partTimeJobHomeListVC) {
        _partTimeJobHomeListVC = [[JMPartTimeJobResumeViewController alloc]init];
        _partTimeJobHomeListVC.delegate = self;
        _partTimeJobHomeListVC.viewType = JMPartTimeJobTypeManage;
        _partTimeJobHomeListVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addChildViewController:_partTimeJobHomeListVC];
    }
    return _partTimeJobHomeListVC;
}

-(UIView *)BGView{
    if (!_BGView) {
        _BGView = [[UIView alloc]initWithFrame:CGRectMake(0,_titleView.frame.size.height, SCREEN_WIDTH*2, self.view.frame.size.height)];
    }
    return _BGView;
}

//-(JMPostTaskBottomView *)postTaskBottomView{
//    if (!_postTaskBottomView) {
//        _postTaskBottomView = [[JMPostTaskBottomView alloc]init];
//        _postTaskBottomView.delegate = self;
//    }
//    return _postTaskBottomView;
//}
//
//-(JMPostTypeChooseView *)postTypeChooseView{
//    if (!_postTypeChooseView) {
//        _postTypeChooseView = [[JMPostTypeChooseView alloc]init];
//        _postTypeChooseView.delegate = self;
//    }
//    return _postTypeChooseView;
//}

//-(UIView *)chooseViewBgView{
//
//    if (!_chooseViewBgView) {
//
//        _chooseViewBgView = [[UIView alloc]init];
//        _chooseViewBgView.backgroundColor =  [UIColor colorWithRed:48/255.0 green:48/255.0 blue:51/255.0 alpha:0.5];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapearAction)];
//        [_chooseViewBgView addGestureRecognizer:tap];
//
//    }
//
//    return _chooseViewBgView;
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
