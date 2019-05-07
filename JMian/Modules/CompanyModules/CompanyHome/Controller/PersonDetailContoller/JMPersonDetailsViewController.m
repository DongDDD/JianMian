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
#import "JMChooseTimeViewController.h"
#import "JMChatViewViewController.h"
#import "JMHTTPManager+CreateConversation.h"


@interface JMPersonDetailsViewController ()<UIScrollViewDelegate,BottomViewDelegate,JMChooseTimeViewControllerDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) JMHeaderOfPersonDetailView *headerView;
@property (nonatomic, strong) JMPageView *pageView;
@property (nonatomic, strong) JMTitlesView *titleView;
@property (nonatomic, strong) JMBottomView *bottomView;


@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *childVCs;
@property (nonatomic, strong) UITableViewController *currentVC;

@property (nonatomic, strong) JMVitaDetailModel *model;

@property (nonatomic, strong) UIActivityIndicatorView * juhua;

@property (nonatomic, strong) JMChooseTimeViewController *chooseTimeVC;
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

#pragma mark - 获取数据
-(void)getData{
    [[JMHTTPManager sharedInstance] fetchVitaInfoWithId:self.user_job_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        //
         self.model = [JMVitaDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
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
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,_pageView.frame.origin.y+_pageView.frame.size.height+64);


}

-(void)setScrollViewUI{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];

}
-(void)setHeaderVieUI{
    self.headerView = [[JMHeaderOfPersonDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 772)];
    [self.headerView setModel:self.model];
    [self.scrollView addSubview:_headerView];

}

//-(NSString *)getDateString:(NSDate *)date{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    // 格式化日期格式
//    formatter.dateFormat = @"yyyy-MM-dd";
//    NSString *dateStr = [formatter stringFromDate:date];
//
//    return dateStr;
//
//}
- (void)setPageUI {
    [self.scrollView addSubview:self.titleView];
    [self.scrollView addSubview:self.pageView];
//    [self.pageView setCurrentIndex:1];//添加子视图”谁看过我“
    [self.pageView setCurrentIndex:0];//添加子视图”全部信息“
    
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
#pragma mark - 点击事件

-(void)bottomRightButtonAction{
    self.chooseTimeVC = [[JMChooseTimeViewController alloc]init];
    self.chooseTimeVC.delegate = self;
    [self addChildViewController:self.chooseTimeVC];
    [self.view addSubview:self.chooseTimeVC.view];
    self.chooseTimeVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
     [self.chooseTimeVC didMoveToParentViewController:self];
    NSLog(@"邀请面试");
    
}

-(void)bottomLeftButtonAction
{
    [[JMHTTPManager sharedInstance]createChat_type:@"1" recipient:self.model.user_id foreign_key:self.model.work_label_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
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

-(void)deleteInteviewTimeViewAction{

    [self.chooseTimeVC willMoveToParentViewController:nil];
    [self.chooseTimeVC removeFromParentViewController];
    [self.chooseTimeVC.view removeFromSuperview];
 
   self.navigationController.navigationBarHidden = NO;
}


-(void)OKInteviewTimeViewAction:(NSString *)interviewTime{
    [self.chooseTimeVC willMoveToParentViewController:nil];
    [self.chooseTimeVC removeFromParentViewController];
    [self.chooseTimeVC.view removeFromSuperview];
    self.navigationController.navigationBarHidden = NO;
    [[JMHTTPManager sharedInstance]createInterViewWith_user_job_id:self.model.user_job_id time:interviewTime successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邀请成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];


}

#pragma mark - lazy

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, _headerView.frame.origin.y+_headerView.frame.size.height, SCREEN_WIDTH, 43} titles:@[@"在线简历", @"联系方式",@"图片作品"]];
        __weak JMPersonDetailsViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            [weakSelf.pageView setCurrentIndex:index];
            _index = index;
        };
    }
    
    return _titleView;
}


- (JMPageView *)pageView {
    if (!_pageView) {
        _pageView = [[JMPageView alloc] initWithFrame:CGRectMake(0, _titleView.frame.origin.y+_titleView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT+300) childVC:self.childVCs];
        
        __weak JMPersonDetailsViewController *weakSelf = self;
        _pageView.didEndScrollView = ^(NSInteger index) {
            [weakSelf.titleView setCurrentTitleIndex:index];
            _index = index;
           
        };
    }
    return _pageView;
}

- (NSArray *)childVCs {


    JMVitaOfPersonDetailViewController *vc1 = [[JMVitaOfPersonDetailViewController alloc] init];
    vc1.experiencesArray = self.model.experiences;
    vc1.educationArray = self.model.education;
    vc1.shieldingArray = self.model.shielding;
    
    JMContactOfPersonDetailViewController *vc2 = [[JMContactOfPersonDetailViewController alloc] init];
    vc2.phoneNumberStr = self.model.user_phone;
    vc2.emailStr = self.model.user_email;
    
    JMPictureOfPersonDetailViewController *vc3 = [[JMPictureOfPersonDetailViewController alloc]init];
    
    
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];

    
    
    _childVCs = @[vc1, vc2, vc3];
    //    }
    return _childVCs;
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
