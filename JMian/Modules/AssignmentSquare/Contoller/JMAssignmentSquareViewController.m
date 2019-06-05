//
//  JMAssignmentSquareViewController.m
//  JMian
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMAssignmentSquareViewController.h"
#import "JMTitlesView.h"
#import "JMSquareHeaderView.h"
#import "JMSquareHomeTableViewCell.h"
#import "JMChoosePositionTableViewController.h"


@interface JMAssignmentSquareViewController ()<UITableViewDelegate,UITableViewDataSource,JMChoosePositionTableViewControllerDelegate>
@property (nonatomic, strong) JMTitlesView *titleView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) JMChoosePositionTableViewController *choosePositionVC;//与我匹配



@end

@implementation JMAssignmentSquareViewController
static NSString *cellIdent = @"SquareCellID";
//static NSString *headerCellId = @"JMSquareHeaderModulesTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self setTitleViewImageViewName:@"jianmian_home"];
    [self setBackBtnImageViewName:@"site_Home" textName:@"广州"];

    // Do any additional setup after loading the view from its nib.
}

-(void)initTableView{

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.choosePositionVC.view];
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

   
        JMSquareHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
        if (cell == nil) {
            cell = [[JMSquareHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
        }
        return cell;
        
 

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 159;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return  0;
    }
    return 135;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//
//    return self.titleView;;
//}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        JMSquareHeaderView *view =  [JMSquareHeaderView new];
        return view;
    }
    
    if (section==1) {
        return self.titleView;        
    }
    return nil;

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 159;
    }
    
    return 43;
    
}


#pragma mark - Getter

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"推荐兼职", @"兼职分类",@"与我匹配"]];
        __weak JMAssignmentSquareViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
//            _index = index;
//            [weakSelf movePageContentView];
        };
    }
    
    return _titleView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = MASTER_COLOR;
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
//        _tableView.sectionHeaderHeight = 43;
//        _tableView.sectionFooterHeight = 0;
//        [_tableView registerNib:[UINib nibWithNibName:@"JMSquareHeaderModulesTableViewCell" bundle:nil] forCellReuseIdentifier:headerCellId];
        [_tableView registerNib:[UINib nibWithNibName:@"JMSquareHomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];

        
    }
    return _tableView;
}


-(JMChoosePositionTableViewController *)choosePositionVC{
    if (_choosePositionVC == nil) {
        _choosePositionVC = [[JMChoosePositionTableViewController alloc]init];
        _choosePositionVC.delegate = self;
        [self addChildViewController:_choosePositionVC];
//        _bgBtn = [[UIButton alloc]init];
//        _bgBtn.backgroundColor = [UIColor blackColor];
//        _bgBtn.alpha = 0.3;
//        [_bgBtn addTarget:self action:@selector(bgBtnAction) forControlEvents:UIControlEventTouchDown];
//        [self.view addSubview:_bgBtn];
        [_choosePositionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tableView.mas_top).offset(203);
            make.left.and.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
        }];

//        [_bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_choosePositionVC.view.mas_bottom);
//            make.left.and.right.mas_equalTo(_choosePositionVC.view);
//            make.bottom.mas_equalTo(self.view);
//        }];
    }
    return  _choosePositionVC;
    
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
