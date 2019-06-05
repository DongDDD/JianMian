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

@interface JMPositionManageViewController ()

@property(nonatomic, strong)JMTitlesView *titleView;
@property(nonatomic, strong)JMPostJobHomeViewController *postJobHomeListVC;
@end

@implementation JMPositionManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"职位管理";
    [self setRightBtnTextName:@"发布全职"];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.postJobHomeListVC.view];

}
#pragma mark - getter

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"全职职位", @"兼职职位"]];
        _titleView.viewType = JMTitlesViewPositionManage;
        [_titleView setCurrentTitleIndex:0];
        __weak JMPositionManageViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
//            [weakSelf.pageView setCurrentIndex:index];
//            _index = index;
        };
    }
    
    return _titleView;
}

-(JMPostJobHomeViewController *)postJobHomeListVC{
    if (!_postJobHomeListVC) {
        _postJobHomeListVC = [[JMPostJobHomeViewController alloc]init];
        _postJobHomeListVC.view.frame = CGRectMake(0, _titleView.frame.size.height, SCREEN_WIDTH, self.view.frame.size.height-_titleView.frame.size.height);
        [self addChildViewController:_postJobHomeListVC];
    }
    return _postJobHomeListVC;
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
