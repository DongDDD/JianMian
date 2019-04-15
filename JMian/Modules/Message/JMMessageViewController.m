//
//  JMMessageViewController.m
//  JMian
//
//  Created by chitat on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMessageViewController.h"
#import "JMTitlesView.h"
#import "JMPageView.h"
#import "JMAllMessageTableViewController.h"
#import "JMLookMeTableViewController.h"

@interface JMMessageViewController ()

@property (nonatomic, strong) JMTitlesView *titleView;
@property (nonatomic, strong) JMPageView *pageView;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *childVCs;
@property (nonatomic, strong) UITableViewController *currentVC;
@property (nonatomic, assign) CGFloat oldOffsetY;



@end

@implementation JMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"聊出好机会"];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
  
    
    [self setupInit];
    // Do any additional setup after loading the view from its nib.
}


- (void)setupInit {
    [self.view addSubview:self.pageView];
    [self.view addSubview:self.titleView];
    [self.pageView setCurrentIndex:1];//添加子视图”谁看过我“
    [self.pageView setCurrentIndex:0];//添加子视图”全部信息“
    
    
}


- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"全部消息", @"谁看过我"]];
        __weak JMMessageViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            [weakSelf.pageView setCurrentIndex:index];
            _index = index;
        };
    }
    
    return _titleView;
}


- (JMPageView *)pageView {
    if (!_pageView) {
        _pageView = [[JMPageView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, SCREEN_HEIGHT) childVC:self.childVCs];
        __weak JMMessageViewController *weakSelf = self;
        _pageView.didEndScrollView = ^(NSInteger index) {
            [weakSelf.titleView setCurrentTitleIndex:index];
            _index = index;
        };
    }
    return _pageView;
}

- (NSArray *)childVCs {
    if (!_childVCs) {
        __weak JMMessageViewController *weakSelf = self;

        };
        
        JMAllMessageTableViewController *allMessageVC = [[JMAllMessageTableViewController alloc] init];

        JMLookMeTableViewController *lookMeVC = [[JMLookMeTableViewController alloc] init];

    
        [self addChildViewController:allMessageVC];
        [self addChildViewController:lookMeVC];
        
        _childVCs = @[allMessageVC, lookMeVC];
//    }
    return _childVCs;
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
