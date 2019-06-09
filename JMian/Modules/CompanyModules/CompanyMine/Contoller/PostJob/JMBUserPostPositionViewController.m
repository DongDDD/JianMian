//
//  JMBUserPostPositionViewController.m
//  JMian
//
//  Created by mac on 2019/6/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserPostPositionViewController.h"
#import "JMBUserPostPositionTableViewCell.h"
#import "JMBUserPositionDetailView.h"
#import "JMBUserPositionVideoView.h"
#import "Demo3ViewController.h"

@interface JMBUserPostPositionViewController ()
//@property (strong, nonatomic) UITableView *tableView;
//@property (strong, nonatomic)NSArray *leftTextArray;
//@property (strong, nonatomic)NSArray *rightTextArray;
@property (strong, nonatomic)UIScrollView *scrollView;

@property (strong, nonatomic)JMBUserPositionDetailView *detailView;
@property (strong, nonatomic)JMBUserPositionVideoView *videoView;
@property (strong, nonatomic)Demo3ViewController *demo3ViewVC;

@end
static NSString *cellIdent = @"BUserPostPositionCell";

@implementation JMBUserPostPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
    [self initLayout];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.videoView layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.demo3ViewVC.view.frame.origin.y+self.demo3ViewVC.view.frame.size.height+100);
}
-(void)initView{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.detailView];
    [self.scrollView addSubview:self.videoView];
    [self.scrollView addSubview:self.demo3ViewVC.view];

//    [self.view addSubview:self.tableView];
    
}


-(void)initLayout{

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.scrollView.mas_top);
        make.height.mas_equalTo(408);
    }];
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.detailView.mas_bottom);
        make.height.mas_equalTo(304);
    }];
    [self.demo3ViewVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.videoView.mas_bottom);
        make.height.mas_equalTo(408);
    }];
    
    

}
//
//
//#pragma mark - UITableViewDelegate
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    JMBUserPostPositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[JMBUserPostPositionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
//    }
//
//    if (!(indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2)) {
//
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//
//    }
//
//    cell.leftLab.text = self.leftTextArray[indexPath.row];
//
////    cell.detailTextLabel.text = self.rightTextArray[indexPath.row];
////    cell.detailTextLabel.font = kFont(17);
////    cell.detailTextLabel.textColor = TITLE_COLOR;
//    return cell;
//
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}
//
//#pragma mark - UITableViewDataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.leftTextArray.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 48;
//}
//


#pragma mark - Getter
//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
//        _tableView.backgroundColor = MASTER_COLOR;
//        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
//        _tableView.separatorStyle = NO;
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
//        _tableView.sectionHeaderHeight = 43;
//        _tableView.sectionFooterHeight = 0;
//        [_tableView registerNib:[UINib nibWithNibName:@"JMBUserPostPositionTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
//
//
//    }
//    return _tableView;
//}
//
//-(NSArray *)leftTextArray{
//    if (!_leftTextArray) {
//        _leftTextArray = @[@"职位名称",@"佣金/每单",@"结算方式",@"发布城市",@"任务有效期",@"招募人数",@"适合行业",@"产品描述"];
//
//    }
//    return _leftTextArray;
//}

-(JMBUserPositionDetailView *)detailView{
    if (_detailView == nil) {
        _detailView = [[JMBUserPositionDetailView alloc]init];
        
    }
    return _detailView;
}

-(JMBUserPositionVideoView *)videoView{
    if (_videoView == nil) {
        _videoView = [[JMBUserPositionVideoView alloc]init];
        
    }
    return _videoView;
}

-(Demo3ViewController *)demo3ViewVC{
    if (!_demo3ViewVC) {
        _demo3ViewVC = [[Demo3ViewController alloc]init];
        [self addChildViewController:_demo3ViewVC];
    }
    return _demo3ViewVC;
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        
    }
    return _scrollView;
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
