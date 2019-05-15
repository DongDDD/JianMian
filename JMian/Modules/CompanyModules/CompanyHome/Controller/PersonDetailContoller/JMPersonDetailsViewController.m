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
//#import "JMChooseTimeViewController.h"
#import "JMChatViewViewController.h"
#import "JMHTTPManager+CreateConversation.h"
#import "THDatePickerView.h"
#import "JMPlayerViewController.h"


@interface JMPersonDetailsViewController ()<UIScrollViewDelegate,BottomViewDelegate,THDatePickerViewDelegate,JMHeaderOfPersonDetailViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) JMHeaderOfPersonDetailView *headerView;
@property (nonatomic, strong) JMPageView *pageView;
@property (nonatomic, strong) JMTitlesView *titleView;
@property (nonatomic, strong) JMBottomView *bottomView;


@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *childVCs;
@property (nonatomic, strong) UITableViewController *currentVC;

@property (nonatomic, strong) JMVitaDetailModel *vitaModel;
@property (nonatomic, strong)JMVitaOfPersonDetailViewController *vitaVc;
@property (nonatomic, strong)JMContactOfPersonDetailViewController *contactVc;
@property (nonatomic, strong)JMPictureOfPersonDetailViewController *pictureVc;

@property (nonatomic, strong) UIActivityIndicatorView * juhua;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) UIView *pageContentView;
//@property (nonatomic, strong) JMChooseTimeViewController *chooseTimeVC;

@property (weak, nonatomic) THDatePickerView *dateView;
@property (strong, nonatomic) UIButton *BgBtn;//点击背景  隐藏时间选择器


@end

@implementation JMPersonDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"个人详情"];
    
    [self setRightBtnImageViewName:@"collect" imageNameRight2:@"share"];

    
//    [self setHeaderVieUI];
//    [self setPageUI];
    [self setJuhua];
    
    [self getData];
    
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
    [[JMHTTPManager sharedInstance] fetchVitaInfoWithId:self.companyModel.user_job_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        //
         self.vitaModel = [JMVitaDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
        [self initView];
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

-(void)initView{
    [self setScrollViewUI];
    [self setHeaderVieUI];
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
    
        self.headerView.videoImg.image = [UIImage imageNamed:@"loading"];
        
        NSString *str = self.companyModel.video_file_path;
        
        NSURL *URL = [NSURL URLWithString:str];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            UIImage *image = [self thumbnailImageForVideo:URL atTime:1];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.headerView.videoImg.image = image;
                self.headerView.playBtn.hidden = NO;

            });
        });
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
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
#pragma mark - 点击事件
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
    JMPlayerViewController *vc = [[JMPlayerViewController alloc]init];
    vc.player = self.player;
    vc.topTitle = self.companyModel.userNickname;
    [self.navigationController pushViewController:vc animated:YES];
    
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
//    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.pageContentView.frame.origin.y+self.vitaVc.view.frame.size.height-200);
    
//    switch (_index) {
//        case 0:
//            self.vitaVc.view.hidden = NO;
//            break;
//        case 1:
//            self.contactVc.view.hidden = NO;
//            break;
//        case 2:
//
//            break;
//        default:
//            break;
//    }
    
    
    
}



//显示时间选择器
-(void)bottomRightButtonAction{
    self.BgBtn.hidden = NO;

    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
        [self.dateView show];
    }];

    
}

//和他聊聊
-(void)bottomLeftButtonAction
{
    [[JMHTTPManager sharedInstance]createChat_type:@"1" recipient:self.vitaModel.user_id foreign_key:self.vitaModel.work_label_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
        //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"创建对话成功"
        //                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        //        [alert show];
        JMChatViewViewController *vc = [[JMChatViewViewController alloc]init];
        
        vc.myConvModel = messageListModel;
        [self.navigationController pushViewController:vc animated:YES];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    

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
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, _headerView.frame.origin.y+_headerView.frame.size.height, SCREEN_WIDTH, 43} titles:@[@"在线简历", @"联系方式",@"图片作品"]];
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
