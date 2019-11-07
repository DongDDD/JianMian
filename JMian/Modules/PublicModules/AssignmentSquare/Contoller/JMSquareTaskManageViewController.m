//
//  JMSquareTaskManageViewController.m
//  JMian
//
//  Created by mac on 2019/8/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMSquareTaskManageViewController.h"
#import "JMPartTimeJobResumeViewController.h"

@interface JMSquareTaskManageViewController ()<JMPartTimeJobResumeViewControllerDelegate>

@property(nonatomic, strong)JMPartTimeJobResumeViewController *partTimeJobHomeListVC;
//@property (strong, nonatomic) UITableView *tableView;

@end

@implementation JMSquareTaskManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务管理";
    [self.view addSubview:self.partTimeJobHomeListVC.view];
    [self.partTimeJobHomeListVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideTop);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.left.and.right.mas_equalTo(self.view);
    }];
    // Do any additional setup after loading the view from its nib.
}



//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
//        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
//        _tableView.separatorStyle = NO;
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
////        if (_viewType == JMPartTimeJobTypeManage) {
////            _tableView.sectionHeaderHeight = 0;
////        }else if(_viewType == JMPartTimeJobTypeResume){
////            _tableView.sectionHeaderHeight = 43;
////        }else if(_viewType == JMPartTimeJobTypeHome){
////            _tableView.sectionHeaderHeight = 0;
////        }
//        _tableView.sectionFooterHeight = 0;
//        [_tableView registerNib:[UINib nibWithNibName:@"JMPostJobHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@""];
//        
//    }
//    return _tableView;
//}

//兼职职位
-(JMPartTimeJobResumeViewController *)partTimeJobHomeListVC{
    if (!_partTimeJobHomeListVC) {
        _partTimeJobHomeListVC = [[JMPartTimeJobResumeViewController alloc]init];
        _partTimeJobHomeListVC.delegate = self;
        _partTimeJobHomeListVC.viewType = JMPartTimeJobTypeManage;
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
