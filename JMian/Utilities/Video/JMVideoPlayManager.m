//
//  JMVideoPlayManager.m
//  JMian
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVideoPlayManager.h"
#import "JMHTTPManager+Vita.h"
#import "JMHTTPManager+CompanyLike.h"
#import "JMHTTPManager+FetchCompanyInfo.h"
#import "WXApi.h"


@implementation JMVideoPlayManager

+ (instancetype)sharedInstance {
    static JMVideoPlayManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[JMVideoPlayManager alloc] init];
//        _manager.B_User_playArray = [NSMutableArray array];
//        _manager.C_User_playArray = [NSMutableArray array];
        [_manager setBackBtnImageViewName:@"icon_return_nav" textName:@""];
//        [_manager setUI];
//        [_manager initCloseBtn];
    });
    return _manager;
}

- (void)fanhui {
    [self.navigationController popViewControllerAnimated:YES];
    [self.player pause];
}

//-(void)closeAction{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(closeVideoAction)]) {
//        [self.delegate closeVideoAction];
//    }
//    
//}

- (void)setBackBtnImageViewName:(NSString *)imageName textName:(NSString *)textName{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 19)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 21);
    [leftBtn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(leftBtn.frame.origin.x+leftBtn.frame.size.width-5, 0, 100,leftBtn.frame.size.height)];
    leftLab.text = textName;
    leftLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    leftLab.font = [UIFont systemFontOfSize:13];
    
    [bgView addSubview:leftLab];
    [bgView addSubview:leftBtn];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)setBUI{
    [self.likeBtn setHidden:YES];
    [self.shareBtn setHidden:YES];
    [self.comVideoDetailInfoView setHidden:NO];
    [self.videoDetailInfoView setHidden:YES];
    [self.view addSubview:self.comVideoDetailInfoView];
    [self.comVideoDetailInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-130);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(58);
    }];
}


-(void)setCUI{
    [self.likeBtn setHidden:NO];
    [self.shareBtn setHidden:NO];
    [self.comVideoDetailInfoView setHidden:YES];
    [self.videoDetailInfoView setHidden:NO];
    if (self.vitaModel.favorites_favorite_id) {
        self.likeBtn.selected = YES;
    }else{
        self.likeBtn.selected = NO;
        
    }
    [self.view addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view).offset(-40);
        make.right.mas_equalTo(self.view).offset(-18);
        make.width.height.mas_equalTo(50);
    }];
    [self.view addSubview:self.shareBtn];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.likeBtn.mas_bottom).offset(63);
        make.left.mas_equalTo(self.likeBtn);
        make.width.height.mas_equalTo(50);
    }];
    [self.view addSubview:self.videoDetailInfoView];
    [self.videoDetailInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-130);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(74);
    }];
    
}

#pragma mark - Setup

- (void)setupPlayer_UrlStr:(NSString *)urlStr {
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"视频播放";
    self.showsPlaybackControls = YES;
    //        NSURL *url = [NSURL URLWithString:@"http://gedftnj8mkvfefuaefm.exp.bcevod.com/mda-hc2s2difdjz6c5y9/hd/mda-hc2s2difdjz6c5y9.mp4?playlist%3D%5B%22hd%22%5D&auth_key=1500559192-0-0-dcb501bf19beb0bd4e0f7ad30c380763&bcevod_channel=searchbox_feed&srchid=3ed366b1b0bf70e0&channel_id=2&d_t=2&b_v=9.1.0.0"];
    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURL *url = [NSURL URLWithString:@"https://jmsp-videos-1257721067.cos.ap-guangzhou.myqcloud.com/storage/videos/2019/05/23/GGR5I1FEPg1tRGQDneb2HjjlyHBKcAZLtj26NTHt.mp4"];
    VIResourceLoaderManager *resourceLoaderManager = [VIResourceLoaderManager new];
    self.resourceLoaderManager = resourceLoaderManager;
    
    AVPlayerItem *playerItem = [resourceLoaderManager playerItemWithURL:url];
//    self.playerItem = playerItem;
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    //    AVPlayer *player = [AVPlayer playerWithURL:url];
    player.automaticallyWaitsToMinimizeStalling = NO;
    self.player = player;
    
    VICacheConfiguration *configuration = [VICacheManager cacheConfigurationForURL:url];
    if (configuration.progress >= 1.0) {
        NSLog(@"cache completed");
    }
    
    [self.videoDetailInfoView setHidden:YES];
    [self.comVideoDetailInfoView setHidden:YES];
    [self.likeBtn setHidden:YES];
    [self.shareBtn setHidden:YES];
}

-(void)setVideoListCellData:(JMVideoListCellData *)videoListCellData{
    if (videoListCellData.company_id) {
        //获取公司信息
        [self getBDataWithCompany_id:videoListCellData.company_id];
    }else if (videoListCellData.user_user_id) {
        //获取个人简历
        [self getCDataWithUser_job_id:videoListCellData.user_job_id];
     

    }
    
}



-(NSString *)getExpWithWork_start_date:(NSString *)work_start_date{
    //创建两个日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [dateFormatter dateFromString:work_start_date];
    NSDate *endDate = [NSDate date];
    
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendarUnit unit = NSCalendarUnitYear;//只比较天数差异
    //比较的结果是NSDateComponents类对象
    NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    //打印
    NSLog(@"%@",delta);
    //获取其中的"年"
    NSLog(@"----年：%ld",delta.year);
    NSString *expYear = [NSString stringWithFormat:@"%ld",(long)delta.year];
    return expYear;
}

//学历数据转化
-(NSString *)getEducationStrWithEducation:(NSString *)education{
    NSInteger myInt = [education integerValue];
    
    switch (myInt) {
        case 0:
            return @"不限";
            break;
        case 1:
            return @"初中及以下";
            break;
        case 2:
            return @"中专/中技";
            break;
        case 3:
            return @"高中";
            break;
        case 4:
            return @"大专";
            break;
        case 5:
            return @"本科";
            break;
        case 6:
            return @"硕士";
            break;
        case 7:
            return @"博士";
            break;
            
        default:
            break;
    }
    return @"不限";
    
}

#pragma mark  Data
-(void)getBDataWithCompany_id:(NSString *)company_id{
    [[JMHTTPManager sharedInstance]fetchCompanyInfo_Id:company_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.companyInfoModel = [JMCompanyInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            self.comVideoDetailInfoView.titleLab.text = self.companyInfoModel.company_name;
            [self setBUI];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

-(void)getCDataWithUser_job_id:(NSString *)user_job_id{
    [[JMHTTPManager sharedInstance] fetchJobInfoWithId:user_job_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        //
        if (responsObject[@"data"]) {
            
            self.vitaModel = [JMVitaDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
            //            [self initView];
            
            [self.videoDetailInfoView.headerIcon sd_setImageWithURL:[NSURL URLWithString:self.vitaModel.user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
            self.videoDetailInfoView.nameLab.text = self.vitaModel.user_nickname;
            NSString *exp;
            NSString *educatoin;
            NSString *workName;
            
            exp = [self getExpWithWork_start_date:self.vitaModel.vita_work_start_date];
            if ([exp isEqualToString:@"0"]) {
                exp = @"应届生";
            }
            educatoin = [self getEducationStrWithEducation:self.vitaModel.vita_education];
            workName = [NSString stringWithFormat:@"%@",self.vitaModel.work_name];
            self.videoDetailInfoView.suTitleLab.text = [NSString stringWithFormat:@"%@年/%@/%@",exp,educatoin,workName];
            self.videoDetailInfoView.salaryLab.text = [self getSalaryKtransformStrWithMin:self.vitaModel.salary_min max:self.vitaModel.salary_max];
            [self setCUI];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
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

-(void)likeAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        [[JMHTTPManager sharedInstance]createLikeWith_type:nil Id:self.vitaModel.user_job_id  mode:@"1" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
//            if ([responsObject objectForKey:@"data"]) {
//                self.favorite_id = [responsObject objectForKey:@"data"][@"favorite_id"];
//
//            }
//            [self.progressHUD showAnimated:NO];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }else{
//        if (self.favorite_id !=nil) {
            [[JMHTTPManager sharedInstance]deleteLikeWith_Id:self.vitaModel.favorites_favorite_id mode:@"1"  SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"取消收藏成功"
                                                              delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
 
            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                
            }];
            
//        }
    }
    
}



#pragma mark  action

-(void)shareAction{
    NSLog(@"share");
    [self.shareView setHidden:NO];
    [self.shareBgView setHidden:NO];
    [self.view addSubview:self.shareBgView];
    [self.view addSubview:self.shareView];
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(184+SafeAreaBottomHeight);
        
    }];
    [self.shareBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(self.view);
        
    }];
}

-(void)play{
    [self.player play];
}

-(void)disapearAction{
    NSLog(@"disapearAction");

    [self.shareView setHidden:YES];
    [self.shareBgView setHidden:YES];
}
#pragma mark  delegate

-(void)shareViewCancelAction{
    [self disapearAction];
    
}

-(void)shareViewLeftAction{
    [self disapearAction];
        [self shareMiniProgram];
//    [self wxShare:0];
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
    urlMessage.title = self.vitaModel.user_nickname;
    urlMessage.description = self.vitaModel.vita_description ;
    
    
    
    UIImage *image = [self getImageFromURL:self.vitaModel.user_avatar];   //缩略图,压缩图片,不超过 32 KB
    NSData *thumbData = UIImageJPEGRepresentation(image, 0.25);
    [urlMessage setThumbData:thumbData];
    //分享实例
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = self.vitaModel.share_url;
    
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    //发送分享
    [WXApi sendReq:sendReq];
    
}

//分享小程序
-(void)shareMiniProgram {
    WXMiniProgramObject *object = [WXMiniProgramObject object];
    object.webpageUrl = self.vitaModel.share_url;
    object.userName = MiniProgramUserName;
    object.path = [NSString stringWithFormat:@"pages/person/person?id=%@",self.vitaModel.user_job_id];
    UIImage *image = [self getImageFromURL:self.vitaModel.user_avatar];   //缩略图,压缩图片,不超过 32 KB
    NSData *thumbData = UIImageJPEGRepresentation(image, 0.25);
    //缩略图,压缩图片,不超过 32 KB
    //    UIImage *image = [self handleImageWithURLStr:url];
    //    NSData *thumbData = UIImageJPEGRepresentation(image, 0.1);
    
    object.hdImageData = thumbData;
    object.withShareTicket = @"";
    object.miniProgramType = WXMiniProgramTypeRelease;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.vitaModel.user_nickname;
    //    message.description = self.configures.model.myDescription;
    message.thumbData = nil;  //兼容旧版本节点的图片，小于32KB，新版本优先
    //使用WXMiniProgramObject的hdImageData属性
    message.mediaObject = object;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;  //目前只支持会话
    [WXApi sendReq:req];
    
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}
#pragma mark  lazy
-(UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc]init];
//        _likeBtn.frame = CGRectMake(100, 200, 100, 100);
        UIImage* icon1 = [UIImage imageNamed:@"enshrine2"];
        UIImage* icon2 = [UIImage imageNamed:@"To_share_the_selected"];
        [_likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_likeBtn setImage:icon1 forState:UIControlStateNormal];
        [_likeBtn setImage:icon2 forState:UIControlStateSelected];
    }
    return _likeBtn;
}

-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc]init];
        //        _likeBtn.frame = CGRectMake(100, 200, 100, 100);
        UIImage* icon1 = [UIImage imageNamed:@"share_video"];
        [_shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
        [_shareBtn setImage:icon1 forState:UIControlStateNormal];
    }
    return _shareBtn;
}

-(JMVideoDetailInfoView *)videoDetailInfoView{
    if (!_videoDetailInfoView) {
        _videoDetailInfoView = [[JMVideoDetailInfoView alloc]init];
    }
    return _videoDetailInfoView;
}


-(JMComVideoDetailInfoView *)comVideoDetailInfoView{
    if (!_comVideoDetailInfoView) {
        _comVideoDetailInfoView = [[JMComVideoDetailInfoView alloc]init];
    }
    return _comVideoDetailInfoView;
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

@end
