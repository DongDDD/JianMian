//
//  JobDetailsViewController.m
//  JMian
//
//  Created by mac on 2019/3/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JobDetailsViewController.h"
#import "Masonry.h"
#import "MapBGView.h"
#import "TwoButtonView.h"
#import "JMCompanyIntroduceViewController.h"
#import "JMShareView.h"
#import "JMSendMyResumeView.h"
#import "JMHTTPManager+Work.h"
#import "JMHomeWorkModel.h"
#import "JMHTTPManager+CompanyUpdateJob.h"
#import "JMPostNewJobViewController.h"
#import "JMHTTPManager+CreateConversation.h"
#import "JMChatViewViewController.h"
#import "JMMessageListModel.h"
#import "JMMapViewController.h"
#import "JMCustomAnnotationView.h"
#import "JMHTTPManager+CompanyLike.h"
#import "JMHTTPManager+Login.h"
#import "JMIDCardIdentifyViewController.h"
#import "WXApi.h"


@interface JobDetailsViewController ()<TwoButtonViewDelegate,MAMapViewDelegate,JMShareViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIImageView *videoImageView; //视频播放

@property(nonatomic,strong)UIView *footOfVideoView;   //职位简介模块-----

@property(nonatomic,strong)UIView *companyIntroductionView; //公司简介模块----

@property(nonatomic,strong)UIView *jobDescriptionView;//职位描述模块---
@property(nonatomic,strong)UILabel *jobDoLab;//岗位职责
@property(nonatomic,strong)UILabel *jobRequireLab;//任职要求

@property(nonatomic,strong)MapBGView *mapBGView;//地图模块----
@property(nonatomic,strong)MAMapView *mapView;
@property (nonatomic,assign)CLLocationCoordinate2D locationCoordinate;


@property(nonatomic,strong)UIView *HRView;//职位发布者模块---

@property(nonatomic,strong)TwoButtonView *twoBtnView;// 和他聊聊 和 投个简历按钮

@property(nonatomic,strong)UIView *shareBgView;//灰色背景
@property(nonatomic,strong)JMShareView *shareView;//分享

@property(nonatomic,strong)JMSendMyResumeView *sendMyResumeView;//投个简历
@property(nonatomic,strong)JMHomeWorkModel *myModel;

@property (nonatomic, strong) UIActivityIndicatorView * juhua;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation JobDetailsViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationController.navigationBar.translucent = NO;
    //
    //    self.extendedLayoutIncludesOpaqueBars = NO;
    
    [self setJuhua];
    [self getUserInfo];
    //右上角分享 收藏按钮
    [self getData];
    
    if (_viewType != JobDetailsViewTypeEdit) {
        
        [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
    }
    [self setTitle:@"职位详情"];
}



- (void)setRightBtnImageViewName:(NSString *)imageName  imageNameRight2:(NSString *)imageNameRight2 {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *colectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colectBtn.frame = CGRectMake(45, 0, 25, 25);
    [colectBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [colectBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [colectBtn setImage:[UIImage imageNamed:@"Collection_of_selected"] forState:UIControlStateSelected];
    
    [bgView addSubview:colectBtn];
    if (imageNameRight2 != nil) {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(0, 0, 25, 25);
        JMVersionModel *model = [JMVersionManager getVersoinInfo];
        if ([model.test isEqualToString:@"1"]) {
            [shareBtn setHidden:YES];
            
        }
        [shareBtn addTarget:self action:@selector(right2Action) forControlEvents:UIControlEventTouchUpInside];
        [shareBtn setImage:[UIImage imageNamed:imageNameRight2] forState:UIControlStateNormal];
        [bgView addSubview:shareBtn];
        
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.mapBGView.frame.origin.y+self.mapBGView.frame.size.height+150);
    
    //    self.scrollView.contentOffset= CGPointMake(0, -80);
}

#pragma mark - 懒加载

-(UIView *)shareBgView{
    
    if (!_shareBgView) {
        
        _shareBgView = [[UIView alloc]init];
        _shareBgView.backgroundColor =  [UIColor colorWithRed:48/255.0 green:48/255.0 blue:51/255.0 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapearAction)];
        [_shareBgView addGestureRecognizer:tap];
        
    }
    
    return _shareBgView;
    
}


-(JMSendMyResumeView *)sendMyResumeView{
    
    if (!_sendMyResumeView) {
        
        _sendMyResumeView = [[JMSendMyResumeView alloc]init];
        
    }
    
    return _sendMyResumeView;
}


#pragma mark - 点击事件
-(void)disapearAction{
    NSLog(@"222");
    [self.shareBgView setHidden:YES];
    [self.shareView setHidden:YES];
    [self.sendMyResumeView setHidden:YES];
    
}

-(void)getUserInfo{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}



-(void)chatAction{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self loginOut];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    
    if ([userModel.card_status isEqualToString:Card_PassIdentify]) {
        
        [[JMHTTPManager sharedInstance]createChat_type:@"1" recipient:self.myModel.user_id foreign_key:self.myModel.work_label_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            if(responsObject[@"data"]){
                
                JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
                
                JMChatViewViewController *vc = [[JMChatViewViewController alloc]init];
                
                vc.myConvModel = messageListModel;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
            
        }];
        
        
    }else{
        
        [self showAlertWithTitle:@"提示" message:@"实名认证后才能申请兼职" leftTitle:@"返回" rightTitle:@"去实名认证"];
        
    }
    
    
    
    
}
-(void)alertRightAction{
    JMIDCardIdentifyViewController *vc = [[JMIDCardIdentifyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)rightAction:(UIButton *)sender{
    NSLog(@"收藏");
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self loginOut];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    sender.selected = !sender.selected;
    [[JMHTTPManager sharedInstance]createLikeWith_type:@"1" Id:self.myModel.work_id mode:@"1" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}




-(void)right2Action{
    
    if (self.shareView == nil) {
        
        [self.view addSubview:self.shareBgView];
        
        [_shareBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.and.right.equalTo(self.view);
            make.height.equalTo(self.view);
        }];
        
        self.shareView = [[JMShareView alloc]init];
        self.shareView.delegate = self;
        [self.view addSubview:self.shareView];
        
        [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
            make.left.and.right.equalTo(self.view);
            make.height.mas_equalTo(184+20);
            
        }];
        NSLog(@"分享");
        
    }
    
    if (self.shareBgView.hidden == YES) {
        [self.shareBgView setHidden:NO];
        [self.shareView setHidden:NO];
    }
    
    
}

-(void)btnAction{
    if ([_status isEqualToString:@"0"]) {
        JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
        vc.homeworkModel = self.myModel;
        vc.viewType = JMPostNewJobViewTypeEdit;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([_status isEqualToString:@"1"]) {//
        [[JMHTTPManager sharedInstance]updateJobInfoWith_Id:self.myModel.work_id job_label_id:nil industry_label_id:nil city_id:nil salary_min:nil salary_max:nil status:@"0" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"职位下线成功"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }
    
    
    
    
}

-(void)btn2Action{
    if ([_status isEqualToString:@"0"]) {
        [[JMHTTPManager sharedInstance]updateJobInfoWith_Id:self.myModel.work_id job_label_id:nil industry_label_id:nil city_id:nil salary_min:nil salary_max:nil status:@"1" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"职位上线成功"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
            
            [self.navigationController popViewControllerAnimated:YES];
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
        
    }else if ([_status isEqualToString:@"1"]) {
        JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
        vc.homeworkModel = self.myModel;
        vc.viewType = JMPostNewJobViewTypeEdit;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    
}

//投个简历
//-(void)sendResumeButton{
//
//    [self.view addSubview:self.shareBgView];
//
//    [_shareBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view);
//        make.left.and.right.equalTo(self.view);
//        make.height.equalTo(self.view);
//    }];
//
//    [self.view addSubview:self.sendMyResumeView];
//
//    [self.sendMyResumeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view.mas_bottom);
//        make.left.and.right.equalTo(self.view);
//        make.height.mas_equalTo(234+20);
//
//    }];
//
//    if (self.sendMyResumeView.hidden == YES) {
//         [self.shareBgView setHidden:NO];
//        [self.sendMyResumeView setHidden:NO];
//    }
//
//}

#pragma mark -- myDelegate


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
#pragma mark - 数据请求
-(void)getData{
    [[JMHTTPManager sharedInstance]fetchWorkInfoWith_Id:self.homeworkModel.work_id SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        
        if (responsObject[@"data"]) {
            
            self.myModel = [JMHomeWorkModel mj_objectWithKeyValues:responsObject[@"data"]];
            NSLog(@"%@",self.myModel.companyName);
            [self setUI];
            [self.juhua stopAnimating];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
}


#pragma mark - UI布局
#pragma mark - 菊花
-(void)setJuhua{
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.progressHUD.mode = MBProgressHUDModeCustomView;
    self.progressHUD.progress = 0.0;
    //    self.progressHUD.dimBackground = NO; //设置有遮罩
    //    self.progressHUD.label.text = @"加载中..."; //设置进度框中的提示文字
    [self.progressHUD showAnimated:YES]; //显示进度框
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"minloading"]];
    //    imgView.frame = CGRectMake(0, 0, 68, 99);
    self.progressHUD.customView = imgView;
    
    [self.view addSubview:self.progressHUD];
    
}


-(void)setUI{
    [self setScrollView];
    //    [self setVideoImgView];
    [self setFootOfVideoView];
    [self setCompanyIntroductionView];
    [self setJobDescriptionView];
    [self setMapView];
    //    [self setHRView];
    [self setBottomView];
}

-(void)setScrollView{
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(@SCREEN_HEIGHT);
    }];
    
}


//-(void)setVideoImgView{
//
//    self.videoImageView = [[UIImageView alloc]init];
//    self.videoImageView.backgroundColor = [UIColor yellowColor];
//    [self.scrollView addSubview:self.videoImageView];
//    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.scrollView.mas_top).mas_offset(-88);
//
//        make.left.and.right.equalTo(self.view);
//        make.height.mas_equalTo(self.view.mas_height).mas_offset(-160);
//
//    }];
//
//
//    UIButton *playBtn = [[UIButton alloc]init];
//    [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
//    [playBtn addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.scrollView addSubview:playBtn];
//    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.videoImageView);
//        make.centerY.mas_equalTo(self.videoImageView);
//        make.height.and.with.mas_equalTo(141);
//    }];
//}


#pragma mark - 职位简介
-(void)setFootOfVideoView{
    
    
    self.footOfVideoView = [[UIView alloc]init];
    self.footOfVideoView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.footOfVideoView];
    
    [self.footOfVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.scrollView);
        make.height.mas_equalTo(134);
        
    }];
    
    
    //职位名称
    UILabel *jobNameLab = [[UILabel alloc]init];
    jobNameLab.text = self.myModel.work_name;
    jobNameLab.font = [UIFont systemFontOfSize:20];
    jobNameLab.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
    [self.footOfVideoView addSubview:jobNameLab];
    
    [jobNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(19);
        make.left.mas_equalTo(self.footOfVideoView.mas_left).offset(22);
        make.top.mas_equalTo(self.footOfVideoView.mas_top).offset(30);
        
    }];
    
    //工资
    UILabel *salaryLab = [[UILabel alloc]init];
    NSString *salaryStr = [self getSalaryKtransformStrWithMin:_myModel.salary_min max:_myModel.salary_max];
    salaryLab.text = salaryStr;
    salaryLab.font = [UIFont systemFontOfSize:16];
    salaryLab.textColor = MASTER_COLOR;
    salaryLab.textAlignment = NSTextAlignmentRight;
    [self.footOfVideoView addSubview:salaryLab];
    
    [salaryLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(19);
        make.right.mas_equalTo(self.footOfVideoView.mas_right).offset(-22);
        make.centerY.mas_equalTo(jobNameLab);
        
    }];
    
    //经验 学历
    
    UILabel *yearsEduLab = [[UILabel alloc]init];
    NSString *education = [self getEducationStrWithEducation:_myModel.education];
    NSString *experienceStr = [NSString stringWithFormat:@"%@~%@年      %@ ",_myModel.work_experience_min,_myModel.work_experience_max,education];
    yearsEduLab.text = experienceStr;
    yearsEduLab.textColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0];
    yearsEduLab.font = [UIFont systemFontOfSize:15];
    [self.footOfVideoView addSubview:yearsEduLab];
    
    [yearsEduLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(400);
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(jobNameLab.mas_left);
        make.top.mas_equalTo(jobNameLab.mas_bottom).offset(11);
        
    }];
    
    //公司福利
    
    for (int i=0; i < _myModel.companyLabels.count; i++) {
        NSDictionary *dic = _myModel.companyLabels[i];
        UILabel *fuliLab = [[UILabel alloc]init];
        fuliLab.text = dic[@"name"];
        fuliLab.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:250/255.0 alpha:1.0];
        fuliLab.textAlignment = NSTextAlignmentCenter;
        fuliLab.font = [UIFont systemFontOfSize:12];
        fuliLab.adjustsFontSizeToFitWidth = YES;
        fuliLab.layer.cornerRadius = 3;
        fuliLab.textColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0];
        [self.footOfVideoView addSubview:fuliLab];
        
        [fuliLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(22);
            make.width.mas_equalTo(63);
            make.left.mas_equalTo(yearsEduLab.mas_left).offset(87*i);
            make.top.mas_equalTo(yearsEduLab.mas_bottom).offset(10);
            
        }];
        
    }
    
}


//工资数据转化，除以1000，转化成k
-(NSString *)getSalaryKtransformStrWithMin:(id)min max:(id)max{
    NSInteger myint = [min integerValue];
    NSInteger intMin = myint/1000;
    
    NSInteger myint2 = [max integerValue];
    NSInteger intMax = myint2/1000;
    
    NSString *salaryStr;
    salaryStr = [NSString stringWithFormat:@"%dk~%dk",  (int)intMin, (int)intMax];
    
    return salaryStr;
}


#pragma mark - 公司简介

//点击事件
-(void)introduceAvtion{
    JMCompanyIntroduceViewController *vc = [[JMCompanyIntroduceViewController alloc]init];
    vc.model = _myModel;
    vc.viewType = JMCompanyIntroduceViewControllerDefault;
    vc.videoUrl = self.homeworkModel.videoFile_path;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)setCompanyIntroductionView{
    
    self.companyIntroductionView = [[UIView alloc]init];
    self.companyIntroductionView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(introduceAvtion)];
    
    [self.companyIntroductionView addGestureRecognizer:tap];
    
    [self.scrollView addSubview:self.companyIntroductionView];
    
    [self.companyIntroductionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(90);
        make.left.and.right.mas_equalTo(self.footOfVideoView);
        make.top.mas_equalTo(self.footOfVideoView.mas_bottom);
    }];
    
    UIImageView *iconImage = [[UIImageView alloc]init];
    
    [iconImage sd_setImageWithURL:[NSURL URLWithString:_myModel.companyLogo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    iconImage.layer.borderWidth = 0.5;
    iconImage.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0].CGColor;
    [self.companyIntroductionView addSubview:iconImage];
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(51);
        make.left.mas_equalTo(self.companyIntroductionView).offset(23);
        make.top.mas_equalTo(self.companyIntroductionView.mas_top).offset(20);
    }];
    
    
    UILabel *companyNameLab = [[UILabel alloc]init];
    companyNameLab.text = _myModel.companyName;
    companyNameLab.font = [UIFont systemFontOfSize:16];
    companyNameLab.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
    companyNameLab.adjustsFontSizeToFitWidth = YES;
    [self.companyIntroductionView addSubview:companyNameLab];
    
    [companyNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImage.mas_right).offset(14);
        make.top.mas_equalTo(self.companyIntroductionView.mas_top).offset(26);
    }];
    
    UILabel * companyMessageLab = [[UILabel alloc]init];
    
    companyMessageLab.text = [NSString stringWithFormat:@"%@  |  %@",_myModel.companyFinancing,_myModel.companyEmployee];
    companyMessageLab.font = [UIFont systemFontOfSize:13];
    companyMessageLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    companyMessageLab.adjustsFontSizeToFitWidth = YES;
    [self.companyIntroductionView addSubview:companyMessageLab];
    
    [companyMessageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(companyNameLab);
        make.top.mas_equalTo(companyNameLab.mas_bottom).offset(10);
    }];
    
    UIImageView *rightImageView = [[UIImageView alloc]init];
    rightImageView.image = [UIImage imageNamed:@"icon_return "];
    [self.companyIntroductionView addSubview:rightImageView];
    
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.companyIntroductionView.mas_right).offset(-22);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(11);
        make.centerY.mas_equalTo(self.companyIntroductionView);
    }];
    
    UIView * xian1View = [[UIView alloc]init];
    xian1View.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self.companyIntroductionView addSubview:xian1View];
    
    [xian1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.companyIntroductionView.mas_left).offset(22);
        make.right.mas_equalTo(self.companyIntroductionView.mas_right).offset(-22);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.companyIntroductionView.mas_top);
    }];
    
    UIView * xian2View = [[UIView alloc]init];
    xian2View.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self.companyIntroductionView addSubview:xian2View];
    
    [xian2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.companyIntroductionView.mas_left).offset(22);
        make.right.mas_equalTo(self.companyIntroductionView.mas_right).offset(-22);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.companyIntroductionView.mas_bottom);
    }];
    
}


#pragma mark - 职位描述

-(void)setJobDescriptionView{
    self.jobDescriptionView = [[UIView alloc]init];
    self.jobDescriptionView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.jobDescriptionView];
    
    [self.jobDescriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.companyIntroductionView.mas_left);
        make.right.mas_equalTo(self.companyIntroductionView.mas_right);
        
        make.top.mas_equalTo(self.companyIntroductionView.mas_bottom);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"职位描述";
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
    [self.jobDescriptionView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.jobDescriptionView.mas_left).offset(22);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(self.jobDescriptionView.mas_top).offset(28);
    }];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"岗位职责";
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    [self.jobDescriptionView addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_left);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(label.mas_bottom).offset(28);
    }];
    
    //岗位职责内容
    self.jobDoLab =[[UILabel alloc]init];
    self.jobDoLab.font = [UIFont systemFontOfSize:14];
    self.jobDoLab.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    self.jobDoLab.numberOfLines = 0;
    
    
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //    NSString  *testString = @"1.负责线上产品的界面设计视觉交互设计并为\n2.新功能新产品提供创意及设计方案等负责线上产品的界面设计视觉交互设计\n3.并为新功能新产品提供创意及设计方案等淮准确理解产品需求和交互原型输\n3.岀优质的界果图够通过视觉元素有效把控网站的整体设计风格";
    NSString  *testString = _myModel.Description;
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:testString];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [testString length])];
    [self.jobDoLab  setAttributedText:setString];
    [paragraphStyle  setLineSpacing:13.5];
    
    [self.jobDescriptionView addSubview:self.jobDoLab];
    
    
    [self.jobDoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_left);
        make.right.mas_equalTo(self.jobDescriptionView.mas_right).offset(-24);
        
        make.top.mas_equalTo(label1.mas_bottom).offset(15);
        //        make.bottom.mas_equalTo(self.jobDescriptionView.mas_bottom);
    }];
    
    //    UILabel *label2 = [[UILabel alloc]init];
    //    label2.text = @"任职要求";
    //    label2.font = [UIFont systemFontOfSize:15];
    //    label2.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    //    [self.jobDescriptionView addSubview:label2];
    //
    //    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(label.mas_left);
    //        make.width.mas_equalTo(100);
    //        make.height.mas_equalTo(15);
    //        make.top.mas_equalTo(self.jobDoLab.mas_bottom).offset(35);
    //    }];
    //
    //    //职责要求内容
    //
    //    self.jobRequireLab = [[UILabel alloc]init];
    //    self.jobRequireLab.font = [UIFont systemFontOfSize:14];
    //    self.jobRequireLab.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    //    self.jobRequireLab.numberOfLines = 0;
    //
    //    NSMutableParagraphStyle  *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    //    NSString  *testString2 = @"1.负责线上产品的界面设计视觉交互设计并为\n2.新功能新产品提供创意及设计方案等负责线上产品的界面设计视觉交互设计\n3.并为新功能新产品提供创意及设计方案等淮准确理解产品需求和交互原型输\n3.岀优质的界果图够通过视觉元素有效把控网站的整体设计风格";
    //    NSMutableAttributedString  *setString2 = [[NSMutableAttributedString alloc] initWithString:testString2];
    //    [setString2  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [testString2 length])];
    //    [self.jobRequireLab  setAttributedText:setString2];
    //    [paragraphStyle2  setLineSpacing:13.5];
    //
    
    //    [self.jobDescriptionView addSubview:self.jobRequireLab];
    
    //    [self.jobRequireLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(label2.mas_left);
    //        make.right.mas_equalTo(self.jobDescriptionView.mas_right).offset(-38);
    //
    //        make.top.mas_equalTo(label2.mas_bottom).offset(15);
    //        //        make.bottom.mas_equalTo(self.jobDescriptionView.mas_bottom);
    //    }];
    
    
    [self.jobDescriptionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.jobDoLab.mas_bottom).offset(30);
    }];
    
    
    
}
#pragma mark - 高德地图

-(void)setMapView{
    //
    self.mapBGView = [[MapBGView alloc] init];
    [self.mapBGView setModel:_myModel];
    [self.scrollView addSubview:self.mapBGView];
    
    [self.mapBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.jobDescriptionView);
        make.height.mas_equalTo(346);
        make.top.mas_equalTo(self.jobDescriptionView.mas_bottom);
    }];
    
    [self.view addSubview:self.mapView];
    CLLocationDegrees latitude = [_myModel.latitude doubleValue];
    CLLocationDegrees longitude = [_myModel.longitude doubleValue];
    CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    [self.mapView setCenterCoordinate:locationCoordinate animated:NO];
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = locationCoordinate;//设置地图的定位中心点坐标self.mapView.centerCoordinate = coor;//将点添加到地图上，即所谓的大头针
    [_mapView addAnnotation:pointAnnotation];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.mapBGView);
        make.height.mas_equalTo(224);
        make.bottom.mas_equalTo(self.mapBGView);
    }];
    _mapView.scrollEnabled = NO;
    
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id)annotation {
    //大头针标注
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        //判断是否是自己的定位气泡，如果是自己的定位气泡，不做任何设置，显示为蓝点，如果不是自己的定位气泡，比如大头针就会进入
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAAnnotationView *annotationView = (MAAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if ( annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
            
            
            JMCustomAnnotationView *cusView = [[JMCustomAnnotationView alloc]init];
            cusView.adressName.text = _myModel.address;
            cusView.companyName.text = _myModel.companyName;
            [annotationView addSubview:cusView];
            [cusView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(annotationView);
                make.centerY.mas_equalTo(annotationView);
                make.width.mas_equalTo(SCREEN_WIDTH*0.8);
                make.height.mas_equalTo(86);
            }];
            
            return annotationView;
        }
        
    }
    return nil;
    
    
    
}
#pragma mark - 职位发布者
//
//-(void)setHRView{
//
//    self.HRView = [[UIView alloc]init];
//    self.HRView.backgroundColor = [UIColor whiteColor];
//    [self.scrollView addSubview:self.HRView];
//
//    [self.HRView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.mas_equalTo(self.view);
//        make.height.mas_equalTo(166);
//        make.top.mas_equalTo(self.mapBGView.mas_bottom);
//    }];
//
//    UILabel *label = [[UILabel alloc]init];
//    label.text = @"职位发布者";
//    label.font = [UIFont systemFontOfSize:17];
//    label.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
//    [self.HRView addSubview:label];
//
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.jobDescriptionView.mas_left).offset(22);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(16);
//        make.top.mas_equalTo(self.HRView.mas_top).offset(30);
//    }];
//
//    UIImageView *iconImg = [[UIImageView alloc]init];
//    [iconImg sd_setImageWithURL:[NSURL URLWithString:_myModel.companyLogo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
//
//    [self.HRView addSubview:iconImg];
//
//    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(label.mas_left);
//        make.width.mas_equalTo(49);
//        make.height.mas_equalTo(51);
//        make.top.mas_equalTo(label.mas_bottom).offset(29);
//    }];
//
//    UILabel *nameLab = [[UILabel alloc]init];
//    nameLab.text = _myModel.user_nickname;
//    nameLab.font = [UIFont systemFontOfSize:17];
//    nameLab.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
//    [self.HRView addSubview:nameLab];
//
//    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(iconImg.mas_right).offset(15);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(16);
//        make.top.mas_equalTo(iconImg.mas_top).offset(7);
//    }];
//
//    UILabel *nameLab2 = [[UILabel alloc]init];
//    nameLab2.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
//    nameLab2.text = _myModel.companyName;
//    nameLab2.font = [UIFont systemFontOfSize:13];
//    [self.HRView addSubview:nameLab2];
//
//    [nameLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(nameLab);
//        make.width.mas_equalTo(150);
//        make.height.mas_equalTo(13);
//        make.top.mas_equalTo(nameLab.mas_bottom).offset(10);
//    }];
//
//    UIView * xianView = [[UIView alloc]init];
//    xianView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
//    [self.HRView addSubview:xianView];
//
//    [xianView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.HRView.mas_left).offset(22);
//        make.right.mas_equalTo(self.HRView.mas_right).offset(-22);
//        make.height.mas_equalTo(1);
//        make.top.mas_equalTo(self.HRView.mas_top);
//    }];
//
//}

-(void)setBottomView{
    self.twoBtnView = [[TwoButtonView alloc]init];
    [self.twoBtnView setStatus:_status];
    self.twoBtnView.backgroundColor = [UIColor whiteColor];
    self.twoBtnView.delegate = self;
    [self.view addSubview:self.twoBtnView];
    
    [self.twoBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(70);
        
    }];
}

#pragma mark -- 微信分享的是链接
- (void)wxShare:(int)n
{   //检测是否安装微信
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc]init];
    sendReq.bText = NO; //不使用文本信息
    sendReq.scene = n;  //0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = self.myModel.companyName;
    urlMessage.description = self.myModel.Description ;
    
    //    UIImageView *imgView = [[UIImageView alloc]init];
    //    [imgView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.company_logo_path]];
    //
    
    UIImage *image = [self getImageFromURL:self.myModel.companyLogo_path];   //缩略图,压缩图片,不超过 32 KB
    NSData *thumbData = UIImageJPEGRepresentation(image, 0.25);
    [urlMessage setThumbData:thumbData];
    //分享实例
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = self.myModel.share_url;
    
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    //发送分享
    [WXApi sendReq:sendReq];
    
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}
#pragma mark - lazy

///初始化地图
-(MAMapView *)mapView{
    
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        _mapView.delegate = self;
        
        [self.view addSubview:_mapView];
        
        //        [_mapView setCenterCoordinate:locationCoordinate animated:NO];
        
        //        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        //        pointAnnotation.coordinate = locationCoordinate;//设置地图的定位中心点坐标self.mapView.centerCoordinate = coor;//将点添加到地图上，即所谓的大头针
        //        [_mapView addAnnotation:pointAnnotation];
        
    }
    return _mapView;
    
}


//-(void)playAction{
//
//    NSLog(@"播放按钮");
//
//    [UIView animateWithDuration:0.2 animations:^{
//    [self.videoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//
//        make.height.mas_equalTo(self.view.mas_height);
//        self.twoBtnView.alpha = 0.8;
//
//    }];
//
//        [self.view layoutIfNeeded];//强制绘制
//    } completion:^(BOOL finished) {
//        NSLog(@"播放视频");
//
//    }];
////




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
