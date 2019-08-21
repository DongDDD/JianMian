//
//  JMPersonDetailsViewController.m
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPersonDetailsViewController.h"
#import "JMPageView.h"
#import "JMTitlesView.h"
#import "JMVitaOfPersonDetailViewController.h"
#import "JMContactOfPersonDetailViewController.h"
#import "JMPictureOfPersonDetailViewController.h"
#import "JMHeaderOfPersonDetailView.h"
#import "JMBottomView.h"
#import "JMHTTPManager+Vita.h"
#import "JMVitaDetailModel.h"
#import "Masonry.h"
#import "JMHTTPManager+InterView.h"
#import "JMChatViewController.h"
#import "JMHTTPManager+CreateConversation.h"
#import "THDatePickerView.h"
#import "JMPlayerViewController.h"
#import "JMVideoPlayManager.h"
#import "JMHTTPManager+CompanyLike.h"
#import "JMHTTPManager+Login.h"
#import "JMIDCardIdentifyViewController.h"
#import "WXApi.h"
#import "JMShareView.h"
#import "JMMessageListModel.h"


@interface JMPersonDetailsViewController ()<UIScrollViewDelegate,BottomViewDelegate,THDatePickerViewDelegate,JMHeaderOfPersonDetailViewDelegate,JMShareViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) JMHeaderOfPersonDetailView *headerView;
@property (nonatomic, strong) JMPageView *pageView;
@property (nonatomic, strong) JMTitlesView *titleView;
@property (nonatomic, strong) JMBottomView *bottomView;
@property(nonatomic,strong)JMShareView *shareView;//分享


@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *childVCs;
@property (nonatomic, strong) UITableViewController *currentVC;

@property (nonatomic, strong)JMVitaDetailModel *vitaModel;
@property (nonatomic, strong)JMVitaOfPersonDetailViewController *vitaVc;
@property (nonatomic, strong)JMContactOfPersonDetailViewController *contactVc;
@property (nonatomic, strong)JMPictureOfPersonDetailViewController *pictureVc;

@property (nonatomic, strong) UIActivityIndicatorView * juhua;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) UIView *pageContentView;
//@property (nonatomic, strong) JMChooseTimeViewController *chooseTimeVC;

@property (weak, nonatomic) THDatePickerView *dateView;
@property (strong, nonatomic) UIButton *BgBtn;//点击背景  隐藏时间选择器
@property (copy, nonatomic) NSString *favorite_id;
@property(nonatomic,strong)UIView *shareBgView;//灰色背景

@end

@implementation JMPersonDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"个人详情"];
    if (_user_job_id == nil) {
        _user_job_id = self.companyModel.user_job_id;
    }
    //    [self setHeaderVieUI];
    //    [self setPageUI];
    [self setJuhua];
    [self getUserInfo];
    [self getData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取用户信息
    //    [self getUserInfo];
    //    [self getData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.pageContentView.frame.origin.y+self.vitaVc.view.frame.size.height-250);
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取数据
-(void)getData{
    [[JMHTTPManager sharedInstance] fetchJobInfoWithId:_user_job_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        //
        if (responsObject[@"data"]) {
            
            self.vitaModel = [JMVitaDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
            [self initView];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

#pragma mark - 同步获取


- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

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
#pragma mark - 布局UI

- (void)setRightBtnImageViewName:(NSString *)imageName  imageNameRight2:(NSString *)imageNameRight2 {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *colectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colectBtn.frame = CGRectMake(45, 0, 25, 25);
    if (self.vitaModel.favorites_favorite_id) {
        colectBtn.selected = YES;
    }else{
        colectBtn.selected = NO;
        
    }
    [colectBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [colectBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [colectBtn setImage:[UIImage imageNamed:@"Collection_of_selected"] forState:UIControlStateSelected];
    
    [bgView addSubview:colectBtn];
    if (imageNameRight2 != nil) {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(0, 0, 25, 25);
        [shareBtn addTarget:self action:@selector(right2Action) forControlEvents:UIControlEventTouchUpInside];
        [shareBtn setImage:[UIImage imageNamed:imageNameRight2] forState:UIControlStateNormal];
        [bgView addSubview:shareBtn];
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

-(void)initView{
    
    self.favorite_id = self.vitaModel.favorites_favorite_id;
    [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
    [self setScrollViewUI];
    [self setHeaderVieUI];
    self.titleView.frame = CGRectMake(self.titleView.frame.origin.x, _headerView.frame.origin.y+_headerView.frame.size.height-43, self.titleView.frame.size.width, self.titleView.frame.size.height);
    _pageView.frame = CGRectMake(_pageView.frame.origin.x,_titleView.frame.origin.y+_titleView.frame.size.height, _pageView.frame.size.width, _pageView.frame.size.height);
    [self.scrollView addSubview:self.titleView];
    [self setPageUI];
    
    [self setBottomViewUI];
    [self initDatePickerView];
      
}

-(void)setScrollViewUI{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
}
-(void)setHeaderVieUI{
    CGFloat H = 0.0;
    if (self.companyModel.video_file_path) {
        H = 772;
    }else{
        H = 350;
        
    }
    self.headerView = [[JMHeaderOfPersonDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, H)];
    if (self.companyModel.video_file_path) {
        if (self.companyModel.video_cover) {
            
            [self.headerView.videoImg sd_setImageWithURL:[NSURL URLWithString:self.companyModel.video_cover] placeholderImage:[UIImage imageNamed:@"loading"]];
        }
        self.headerView.playBtn.hidden = NO;

    }
    self.headerView.delegate = self;
    [self.headerView setModel:self.vitaModel];
    [self.headerView setCompanyHomeModel:self.companyModel];
    [self.scrollView addSubview:_headerView];
}


- (void)setPageUI {
    [self.scrollView addSubview:self.titleView];
    [self.scrollView addSubview:self.pageContentView];
    [self.pageContentView addSubview:self.vitaVc.view];
    [self.pageContentView addSubview:self.contactVc.view];
    [self.pageContentView addSubview:self.pictureVc.view];
    
    //    [self.scrollView addSubview:self.contactVc.view];
    //    [self.scrollView addSubview:self.pageView];
    //    [self.pageView setCurrentIndex:1];//添加子视图”谁看过我“
    //    [self.pageView setCurrentIndex:0];//添加子视图”全部信息“
    
}


-(void)setBottomViewUI{
    
    self.bottomView = [[JMBottomView alloc]init];
    self.bottomView.delegate = self;
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    
}

//时间选择器
-(void)initDatePickerView
{
    self.BgBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
    self.BgBtn.backgroundColor = [UIColor blackColor];
    self.BgBtn.hidden = YES;
    self.BgBtn.alpha = 0.3;
    [self.view addSubview:self.BgBtn];
    
    THDatePickerView *dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300)];
    dateView.delegate = self;
    dateView.title = @"请选择时间";
    //    dateView.isSlide = NO;
    //    dateView.date = @"2017-03-23 12:43";
    //    dateView.minuteInterval = 1;
    [self.view addSubview:dateView];
    self.dateView = dateView;
    
}


#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    //    self.timerLbl.text = timer;
    
    self.BgBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
    
    
    [[JMHTTPManager sharedInstance]createInterViewWith_user_job_id:self.vitaModel.user_job_id time:timer successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邀请成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
        //同时创建会话
        [[JMHTTPManager sharedInstance]createChat_type:@"1" recipient:self.vitaModel.user_id foreign_key:self.vitaModel.work_label_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            //发送消息推送
            NSString *receiver_id = [NSString stringWithFormat:@"%@a",self.vitaModel.user_id];
            [self setCustumMessage_receiverID:receiver_id dic:nil title:@"[面试邀请通知]"];
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
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
    
    //    UIImageView *imgView = [[UIImageView alloc]init];
    //    [imgView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.company_logo_path]];
    //
    
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

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}

#pragma mark - 点击事件

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

-(void)rightAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    [self.progressHUD showAnimated:YES];
    if (sender.selected == YES) {
        [[JMHTTPManager sharedInstance]createLikeWith_type:nil Id:self.vitaModel.user_job_id  mode:@"1" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功"
                                                          delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
            if ([responsObject objectForKey:@"data"]) {
                self.favorite_id = [responsObject objectForKey:@"data"][@"favorite_id"];
                
            }
            [self.progressHUD showAnimated:NO];
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
        
    }else{
        if (self.favorite_id !=nil) {
            [[JMHTTPManager sharedInstance]deleteLikeWith_Id:self.favorite_id mode:@"1"  SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"取消收藏成功"
                                                              delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
                [alert show];
                [self.progressHUD showAnimated:NO];
                
            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                
            }];
            
        }
    }
    
}

-(void)disapearAction{
    NSLog(@"222");
    [self.shareBgView setHidden:YES];
    [self.shareView setHidden:YES];
    //    [self.sendMyResumeView setHidden:YES];
    
}
/**
 时间选择取消
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    self.BgBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}

//播放视频
-(void)playAction
{
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:self.companyModel.video_file_path];
    [[JMVideoPlayManager sharedInstance] play];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    [self presentViewController:playVC animated:YES completion:nil];
    [[JMVideoPlayManager sharedInstance] play];
    //    [[UIApplication sharedApplication].keyWindow addSubview:playVC.view];
    //    [playVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.offset(0);
    //    }];
    
    //    SJVideoPlayer *_videoPlayer = [SJVideoPlayer player];
    //    _videoPlayer.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT); // 可以使用AutoLayout, 这里为了简便设置的Frame.
    //    [self.view addSubview:_videoPlayer.view];
    //    // 初始化资源
    //    _videoPlayer.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:self.companyModel.video_file_path]];
    //    [_videoPlayer play];
    //    JMPlayerViewController *vc = [[JMPlayerViewController alloc]init];
    //    vc.player = self.player;
    //    vc.topTitle = self.companyModel.userNickname;
    //    [self.navigationController pushViewController:vc animated:YES];
    
}

//展示在线简历 联系方式 图片作品视图交互
-(void)movePageContentView{
    
    __weak typeof(self) ws = self;
    
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect vitaFrame = ws.pageContentView.frame;
        vitaFrame.origin.x = -_index*SCREEN_WIDTH ;
        ws.pageContentView.frame = vitaFrame;
        //        CGRect inputFrame = ws.inputController.view.frame;
        //        inputFrame.origin.y = msgFrame.origin.y + msgFrame.size.height;
        //        inputFrame.size.height = height;
        //        ws.inputController.view.frame = inputFrame;
        
    } completion:nil];
    
    switch (_index) {
        case 0:
            _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.pageContentView.frame.origin.y+self.vitaVc.view.frame.size.height-250);
            break;
        case 1:
            _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.pageContentView.frame.origin.y+self.contactVc.view.frame.size.height);
            break;
        case 2:
            _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.pageContentView.frame.origin.y+self.pictureVc.view.frame.size.height);
            break;
        default:
            break;
    }
    
    
}


//显示时间选择器
-(void)bottomRightButtonAction{
    self.BgBtn.hidden = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
        [self.dateView show];
    }];
    
    
}


-(void)getUserInfo{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


//和他聊聊
-(void)bottomLeftButtonAction
{
    
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    
    if ([userModel.card_status isEqualToString:Card_PassIdentify]) {
        
        [[JMHTTPManager sharedInstance]createChat_type:@"1" recipient:self.vitaModel.user_id foreign_key:self.vitaModel.work_label_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            
            JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
            JMChatViewController *vc = [[JMChatViewController alloc]init];

            vc.myConvModel = messageListModel;
            [self.navigationController pushViewController:vc animated:YES];
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

#pragma mark -- 发送自定义消息

-(void)setCustumMessage_receiverID:(NSString *)receiverID dic:(NSDictionary *)dic title:(NSString *)title{
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:receiverID];
    
    // 转换为 NSData
    
    TIMCustomElem * custom_elem = [[TIMCustomElem alloc] init];
    //    [custom_elem setData:data];
    if (dic) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        [custom_elem setData:data];
        
    }
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    
    [custom_elem setDesc:title];
    TIMMessage * msg = [[TIMMessage alloc] init];
    [msg addElem:custom_elem];
    [conv sendMessage:msg succ:^(){
        NSLog(@"SendMsg Succ");
        //        [self showAlertVCWithHeaderIcon:@"purchase_succeeds" message:@"申请成功" leftTitle:@"返回" rightTitle:@"查看任务"];
    }fail:^(int code, NSString * err) {
        NSLog(@"SendMsg Failed:%d->%@", code, err);
        
        
    }];
    
    
}

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

#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= _headerView.frame.origin.y+_headerView.frame.size.height-self.titleView.frame.size.height){
        //只修改Y值
        self.titleView.frame = CGRectMake(self.titleView.frame.origin.x, 0, self.titleView.frame.size.width, self.titleView.frame.size.height);
        [self.view addSubview:self.titleView];
        
    }else{
        
        self.titleView.frame = CGRectMake(self.titleView.frame.origin.x, _headerView.frame.origin.y+_headerView.frame.size.height-43, self.titleView.frame.size.width, self.titleView.frame.size.height);
        _pageView.frame = CGRectMake(_pageView.frame.origin.x,_titleView.frame.origin.y+_titleView.frame.size.height, _pageView.frame.size.width, _pageView.frame.size.height);
        [self.scrollView addSubview:self.titleView];
    }
    
    
    
}

#pragma mark - lazy

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, _headerView.frame.origin.y+_headerView.frame.size.height, SCREEN_WIDTH, 43} titles:@[@"在线简历", @"联系方式"]];
        __weak JMPersonDetailsViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf movePageContentView];
        };
    }
    
    return _titleView;
}



//- (JMPageView *)pageView {
//    if (!_pageView) {
//        _pageView = [[JMPageView alloc] initWithFrame:CGRectMake(0, _titleView.frame.origin.y+_titleView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT) childVC:self.childVCs];
//
//        __weak JMPersonDetailsViewController *weakSelf = self;
//        _pageView.didEndScrollView = ^(NSInteger index) {
//            [weakSelf.titleView setCurrentTitleIndex:index];
//            _index = index;
//
//        };
//    }
//    return _pageView;
//}


-(JMVitaOfPersonDetailViewController *)vitaVc{
    if (_vitaVc == nil) {
        _vitaVc = [[JMVitaOfPersonDetailViewController alloc] init];
        //        _vitaVc.view.hidden = NO;
        _vitaVc.experiencesArray = self.vitaModel.experiences;
        _vitaVc.educationArray = self.vitaModel.education;
        _vitaVc.shieldingArray = self.vitaModel.shielding;
        _vitaVc.vitaDescription = self.vitaModel.vita_description;
        __weak JMVitaOfPersonDetailViewController *weakSelf = _vitaVc;
        
        _vitaVc.didLoadView = ^(CGFloat H) {
            
            weakSelf.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, H);
        };
        
        _vitaVc.view.frame = weakSelf.view.frame;
        [self addChildViewController:_vitaVc];
        
    }
    //    [self.scrollView addSubview:_vitaVc.view];
    
    return _vitaVc;
}


-(JMContactOfPersonDetailViewController *)contactVc{
    if (_contactVc == nil) {
        _contactVc = [[JMContactOfPersonDetailViewController alloc] init];
        _contactVc.phoneNumberStr = self.vitaModel.user_phone;
        _contactVc.emailStr = self.vitaModel.user_email;
        _contactVc.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-self.titleView.frame.size.height);
        [self addChildViewController:_contactVc];
        
    }
    
    return _contactVc;
}


-(JMPictureOfPersonDetailViewController *)pictureVc{
    if (_pictureVc == nil) {
        _pictureVc = [[JMPictureOfPersonDetailViewController alloc] init];
        _pictureVc.view.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT+50);
        [self addChildViewController:_pictureVc];
        
    }
    
    return _pictureVc;
}

-(UIView *)pageContentView{
    if (_pageContentView == nil) {
        _pageContentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.headerView.frame.origin.y + self.headerView.frame.size.height, SCREEN_WIDTH, 300)];
        _pageContentView.backgroundColor = [UIColor redColor];
    }
    return _pageContentView;
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

//JMPictureOfPersonDetailViewController

//@property (nonatomic, strong)JMContactOfPersonDetailViewController *contactVc;
//@property (nonatomic, strong)JMPictureOfPersonDetailViewController *pictureVc;
//JMContactOfPersonDetailViewController *vc2 = [[JMContactOfPersonDetailViewController alloc] init];
//- (UIScrollView *)scrollView {
//    if (!_scrollView){
//        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//        _scrollView.backgroundColor = MASTER_COLOR;
//        _scrollView.pagingEnabled = YES;
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.delegate = self;
////        _scollView.contentSize = CGSizeMake(SCREEN_WIDTH, _pageView.frame.origin.y+_pageView.frame.size.height);
//    }
//    return _scrollView;
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
