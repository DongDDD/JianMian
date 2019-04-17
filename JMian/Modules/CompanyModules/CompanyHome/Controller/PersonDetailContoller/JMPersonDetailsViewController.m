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


@interface JMPersonDetailsViewController ()<UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) JMPageView *pageView;
@property (nonatomic, strong) JMTitlesView *titleView;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *childVCs;
@property (nonatomic, strong) UITableViewController *currentVC;

@end

@implementation JMPersonDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"个人详情"];
    [self setScrollViewUI];
    [self setPageUI];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,_pageView.frame.origin.y+_pageView.frame.size.height+64);

}

-(void)setScrollViewUI{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.backgroundColor = MASTER_COLOR;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];

}


- (void)setPageUI {
    [self.scrollView addSubview:self.titleView];
    [self.scrollView addSubview:self.pageView];
//    [self.pageView setCurrentIndex:1];//添加子视图”谁看过我“
    [self.pageView setCurrentIndex:0];//添加子视图”全部信息“
    
}




- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"在线简历", @"联系方式",@"图片作品"]];
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
        _pageView = [[JMPageView alloc] initWithFrame:CGRectMake(0, _titleView.frame.origin.y+_titleView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT) childVC:self.childVCs];
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
    
    JMContactOfPersonDetailViewController *vc2 = [[JMContactOfPersonDetailViewController alloc] init];
    
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



    
}


#pragma mark - lazy

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
