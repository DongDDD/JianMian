//
//  JobDetailsViewController.m
//  JMian
//
//  Created by mac on 2019/3/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JobDetailsViewController.h"

#import "Masonry.h"
#import "MapView.h"
#import "TwoButtonView.h"
#import "JMCompanyIntroduceViewController.h"
#import "JMShareView.h"
#import "JMSendMyResumeView.h"

@interface JobDetailsViewController ()<TwoButtonViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIImageView *videoImageView; //视频播放

@property(nonatomic,strong)UIView *footOfVideoView;   //职位简介模块-----

@property(nonatomic,strong)UIView *companyIntroductionView; //公司简介模块----

@property(nonatomic,strong)UIView *jobDescriptionView;//职位描述模块---
@property(nonatomic,strong)UILabel *jobDoLab;//岗位职责
@property(nonatomic,strong)UILabel *jobRequireLab;//任职要求

@property(nonatomic,strong)MapView *mapView;//地图模块----

@property(nonatomic,strong)UIView *HRView;//职位发布者模块---

@property(nonatomic,strong)TwoButtonView *twoBtnView;// 和他聊聊 和 投个简历按钮

@property(nonatomic,strong)UIView *shareBgView;//灰色背景
@property(nonatomic,strong)JMShareView *shareView;//分享

@property(nonatomic,strong)JMSendMyResumeView *sendMyResumeView;//投个简历


@end

@implementation JobDetailsViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTranslucent:true];
    //右上角分享 收藏按钮
    [self setRightBtnImageViewName:@"Collection_of_selected" imageNameRight2:@"share"];

    [self setScrollView];
    [self setVideoImgView];
    [self setFootOfVideoView];
    
    [self setCompanyIntroductionView];
    [self setJobDescriptionView];
    [self setMapView];
    [self setHRView];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    [self.view layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.HRView.frame.origin.y+self.HRView.frame.size.height+70);
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

-(void)rightAction{
    NSLog(@"收藏");
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

//投个简历
-(void)sendResumeButton{
    
    [self.view addSubview:self.shareBgView];
    
    [_shareBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(self.view);
    }];
    
    [self.view addSubview:self.sendMyResumeView];
    
    [self.sendMyResumeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(234+20);
        
    }];
    
    if (self.sendMyResumeView.hidden == YES) {
         [self.shareBgView setHidden:NO];
        [self.sendMyResumeView setHidden:NO];
    }
 
}


#pragma mark - UI布局

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


-(void)setVideoImgView{
    
    self.videoImageView = [[UIImageView alloc]init];
    self.videoImageView.backgroundColor = [UIColor yellowColor];
    [self.scrollView addSubview:self.videoImageView];
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_top).mas_offset(-88);

        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).mas_offset(-160);

    }];
    
    
    UIButton *playBtn = [[UIButton alloc]init];
    [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:playBtn];
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.videoImageView);
        make.centerY.mas_equalTo(self.videoImageView);
        make.height.and.with.mas_equalTo(141);
    }];
}


#pragma mark - 职位简介
-(void)setFootOfVideoView{
    
    self.twoBtnView = [[TwoButtonView alloc]init];
    self.twoBtnView.backgroundColor = [UIColor whiteColor];
    self.twoBtnView.delegate = self;
    [self.view addSubview:self.twoBtnView];
    
    [self.twoBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(70);
        
    }];
    
    
  
    self.footOfVideoView = [[UIView alloc]init];
    self.footOfVideoView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.footOfVideoView];
   
    [self.footOfVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.videoImageView.mas_bottom);
        make.height.mas_equalTo(172-60);
       
    }];

    
    //职位名称
    UILabel *jobNameLab = [[UILabel alloc]init];
    jobNameLab.text = @"UI设计师";
    jobNameLab.font = [UIFont systemFontOfSize:20];
    jobNameLab.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
    [self.footOfVideoView addSubview:jobNameLab];
    
    [jobNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(19);
        make.left.mas_equalTo(self.footOfVideoView.mas_left).offset(22);
        make.bottom.mas_equalTo(self.footOfVideoView.mas_bottom).offset(-86);
        
    }];
    
    //经验 学历
    
    UILabel *yearsEduLab = [[UILabel alloc]init];
    yearsEduLab.text = @"1-3年   大专";
    yearsEduLab.textColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0];
    yearsEduLab.font = [UIFont systemFontOfSize:15];
    [self.footOfVideoView addSubview:yearsEduLab];
    
    [yearsEduLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(jobNameLab.mas_left);
        make.top.mas_equalTo(jobNameLab.mas_bottom).offset(11);
        
    }];
    
    //公司福利
  
    UILabel *fuliLab = [[UILabel alloc]init];
    fuliLab.text = @"五险一金";
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
        make.left.mas_equalTo(yearsEduLab.mas_left);
        make.top.mas_equalTo(yearsEduLab.mas_bottom).offset(10);
        
    }];
    
    
    
    
}
#pragma mark - 公司简介

-(void)introduceAvtion{
    JMCompanyIntroduceViewController *vc = [[JMCompanyIntroduceViewController alloc]init];
    
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
 
    iconImage.image = [UIImage imageNamed:@"play"];
    iconImage.layer.borderWidth = 0.5;
    iconImage.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0].CGColor;
    [self.companyIntroductionView addSubview:iconImage];
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(51);
        make.left.mas_equalTo(self.companyIntroductionView).offset(23);
        make.top.mas_equalTo(self.companyIntroductionView.mas_top).offset(20);
    }];
    
    
    UILabel *companyNameLab = [[UILabel alloc]init];
    companyNameLab.text = @"空间智能科技";
    companyNameLab.font = [UIFont systemFontOfSize:16];
    companyNameLab.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
    companyNameLab.adjustsFontSizeToFitWidth = YES;
    [self.companyIntroductionView addSubview:companyNameLab];
    
    [companyNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(iconImage.mas_right).offset(14);
        make.top.mas_equalTo(self.companyIntroductionView.mas_top).offset(26);
    }];
    
    UILabel * companyMessageLab = [[UILabel alloc]init];
    companyMessageLab.text = @"移动互联网   不需要融资   20-50人";
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
    NSString  *testString = @"1.负责线上产品的界面设计视觉交互设计并为\n2.新功能新产品提供创意及设计方案等负责线上产品的界面设计视觉交互设计\n3.并为新功能新产品提供创意及设计方案等淮准确理解产品需求和交互原型输\n3.岀优质的界果图够通过视觉元素有效把控网站的整体设计风格";
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
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"任职要求";
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    [self.jobDescriptionView addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_left);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(self.jobDoLab.mas_bottom).offset(35);
    }];
    
    //职责要求内容

    self.jobRequireLab = [[UILabel alloc]init];
    self.jobRequireLab.font = [UIFont systemFontOfSize:14];
    self.jobRequireLab.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    self.jobRequireLab.numberOfLines = 0;
    
    NSMutableParagraphStyle  *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    NSString  *testString2 = @"1.负责线上产品的界面设计视觉交互设计并为\n2.新功能新产品提供创意及设计方案等负责线上产品的界面设计视觉交互设计\n3.并为新功能新产品提供创意及设计方案等淮准确理解产品需求和交互原型输\n3.岀优质的界果图够通过视觉元素有效把控网站的整体设计风格";
    NSMutableAttributedString  *setString2 = [[NSMutableAttributedString alloc] initWithString:testString2];
    [setString2  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [testString2 length])];
    [self.jobRequireLab  setAttributedText:setString2];
    [paragraphStyle2  setLineSpacing:13.5];
    
    
    [self.jobDescriptionView addSubview:self.jobRequireLab];
    
    [self.jobRequireLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label2.mas_left);
        make.right.mas_equalTo(self.jobDescriptionView.mas_right).offset(-38);
        
        make.top.mas_equalTo(label2.mas_bottom).offset(15);
        //        make.bottom.mas_equalTo(self.jobDescriptionView.mas_bottom);
    }];
    
    
    [self.jobDescriptionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.jobRequireLab.mas_bottom).offset(30);
    }];

    

    
    

}
#pragma mark - d地图

-(void)setMapView{
//
     self.mapView = [[MapView alloc] init];
    
    [self.scrollView addSubview:self.mapView];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(self.jobDescriptionView);
            make.height.mas_equalTo(346);
            make.top.mas_equalTo(self.jobDescriptionView.mas_bottom);
    }];


    
}
#pragma mark - 职位发布者

-(void)setHRView{
    
    self.HRView = [[UIView alloc]init];
    self.HRView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.HRView];
    
    [self.HRView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(166);
        make.top.mas_equalTo(self.mapView.mas_bottom);
    }];

    UILabel *label = [[UILabel alloc]init];
    label.text = @"职位发布者";
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
    [self.HRView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.jobDescriptionView.mas_left).offset(22);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(self.HRView.mas_top).offset(30);
    }];
    
    UIImageView *iconImg = [[UIImageView alloc]init];
    iconImg.backgroundColor = [UIColor redColor];
    iconImg.image = [UIImage imageNamed:@""];
   
    
    [self.HRView addSubview:iconImg];
    
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_left);
        make.width.mas_equalTo(49);
        make.height.mas_equalTo(51);
        make.top.mas_equalTo(label.mas_bottom).offset(29);
    }];
    
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.text = @"小美";
    nameLab.font = [UIFont systemFontOfSize:17];
    nameLab.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
    [self.HRView addSubview:nameLab];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImg.mas_right).offset(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(iconImg.mas_top).offset(7);
    }];
    
    UILabel *nameLab2 = [[UILabel alloc]init];
    nameLab2.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    nameLab2.text = @"空间智能科技 ： HR";
    nameLab2.font = [UIFont systemFontOfSize:13];
    [self.HRView addSubview:nameLab2];
    
    [nameLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(13);
        make.top.mas_equalTo(nameLab.mas_bottom).offset(10);
    }];
    
    UIView * xianView = [[UIView alloc]init];
    xianView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self.HRView addSubview:xianView];
    
    [xianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.HRView.mas_left).offset(22);
        make.right.mas_equalTo(self.HRView.mas_right).offset(-22);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.HRView.mas_top);
    }];
    
    
    
    



}



-(void)playAction{
   
    NSLog(@"播放按钮");
  
    [UIView animateWithDuration:0.2 animations:^{
    [self.videoImageView mas_updateConstraints:^(MASConstraintMaker *make) {

        make.height.mas_equalTo(self.view.mas_height);
        self.twoBtnView.alpha = 0.8;

    }];

        [self.view layoutIfNeeded];//强制绘制
    } completion:^(BOOL finished) {
        NSLog(@"播放视频");

    }];
//




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
