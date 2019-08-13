//
//  JMHistoryViewController.m
//  JMian
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHistoryViewController.h"
#import "JMPartTimeJobResumeViewController.h"

@interface JMHistoryViewController ()<JMPartTimeJobResumeViewControllerDelegate>

@property(nonatomic, strong)JMPartTimeJobResumeViewController *partTimeJobHomeListVC;

@end

@implementation JMHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择历史模板";
    [self.view addSubview:self.partTimeJobHomeListVC.view];
    [self.partTimeJobHomeListVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideTop);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.left.and.right.mas_equalTo(self.view);
    }];
    // Do any additional setup after loading the view from its nib.
}



//兼职职位
-(JMPartTimeJobResumeViewController *)partTimeJobHomeListVC{
    if (!_partTimeJobHomeListVC) {
        _partTimeJobHomeListVC = [[JMPartTimeJobResumeViewController alloc]init];
        _partTimeJobHomeListVC.delegate = self;
        _partTimeJobHomeListVC.viewType = JMPartTimeJobTypeHistory;
        _partTimeJobHomeListVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addChildViewController:_partTimeJobHomeListVC];
    }
    return _partTimeJobHomeListVC;
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
