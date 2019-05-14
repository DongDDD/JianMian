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
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.vitaVc.view.frame.origin.y+self.vitaVc.view.frame.size.height-200);


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



#pragma mark - 布局UI
-(void)setJuhua{
    self.juhua = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    [self.view addSubview:self.juhua];
    //设置小菊花的frame
    [self.juhua mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.and.height.mas_equalTo(100);
    }];
    //设置小菊花颜色
    //    self.juhua.color = [UIColor redColor];
    //设置背景颜色
    //    self.juhua.backgroundColor = [UIColor cyanColor];
    //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
    self.juhua.hidesWhenStopped = NO;
    
}

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
    self.headerView.delegate = self;
    [self.headerView setModel:self.vitaModel];
    [self.headerView setCompanyHomeModel:self.companyModel];
    [self.scrollView addSubview:_headerView];
}


- (void)setPageUI {
    [self.scrollView addSubview:self.titleView];
    [self.scrollView addSubview:self.vitaVc.view];
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
/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    self.BgBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}
#pragma mark - 点击事件
//播放视频
-(void)playAction
{
    JMPlayerViewController *vc = [[JMPlayerViewController alloc]init];
    vc.player = self.player;
    vc.topTitle = self.companyModel.userNickname;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//显示时间选择器
-(void)bottomRightButtonAction{
    self.BgBtn.hidden = NO;

    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
        [self.dateView show];
    }];
//    self.chooseTimeVC = [[JMChooseTimeViewController alloc]init];
//    self.chooseTimeVC.delegate = self;
//    [self addChildViewController:self.chooseTimeVC];
//    [self.view addSubview:self.chooseTimeVC.view];
//    self.chooseTimeVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//     [self.chooseTimeVC didMoveToParentViewController:self];
//    NSLog(@"邀请面试");
    
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
            [weakSelf setCurrenView];
        };
    }
    
    return _titleView;
}


-(void)setCurrenView{
    
    switch (_index) {
        case 0:
            self.vitaVc.view.hidden = NO;
            break;
        case 1:
            self.contactVc.view.hidden = NO;
            break;
        case 2:
//            self.contactVc.view.hidden = NO;
            break;
        default:
            break;
    }
    
 

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
            
            weakSelf.view.frame = CGRectMake(0, self.headerView.frame.origin.y+self.headerView.frame.size.height, SCREEN_WIDTH, H);
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
        _contactVc.view.hidden = YES;
        _contactVc.view.frame = CGRectMake(0, self.headerView.frame.origin.y + self.headerView.frame.size.height, SCREEN_WIDTH, 300);
        [self addChildViewController:_contactVc];
        
    }
    
    return _contactVc;
}



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
