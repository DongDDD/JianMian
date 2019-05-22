//
//  HomeViewController.m
//  JMian
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "HometableViewCell.h"
#import "LoginViewController.h"
#import "JobDetailsViewController.h"
#import "JMHTTPManager+Work.h"
#import "JMHomeWorkModel.h"
#import "JMUserInfoModel.h"
#import "JMUserInfoManager.h"
#import "Masonry.h"
#import "JMLabsChooseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "JMVideoPlayManager.h"
#import "JMPlayerViewController.h"
#import "PositionDesiredViewController.h"
#import "JMCityListViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,JMLabsChooseViewControllerDelegate,HomeTableViewCellDelegate,PositionDesiredDelegate,JMCityListViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIButton *allOfPositionBtn; //所有职位
@property (weak, nonatomic) IBOutlet UIButton *choosePositionBtn;//职位筛选
@property (weak, nonatomic) IBOutlet UIButton *companyRequireBtn;//公司要求
@property (nonatomic, strong) NSArray *arrDate;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PositionDesiredViewController *choosePositionVC;
@property (nonatomic, strong) JMLabsChooseViewController *labschooseVC;

@property(nonatomic,strong)NSMutableArray *playerArray;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

//@property (nonatomic, copy)NSString *job_lab_id;

@end

static NSString *cellIdent = @"cellIdent";


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleViewImageViewName:@"jianmian_home"];
    [self setBackBtnImageViewName:@"site_Home" textName:@"广州"];
    [self setRightBtnImageViewName:@"Search_Home" imageNameRight2:@""];

    [self setTableView];
    [self setJuhua];
//    [self getData];
    
//    [self loginIM];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - 布局UI

-(void)setTableView{

//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置普通状态的动画图片
//    [header setImages:idleImages forState:MJRefreshStateIdle];
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    [header setImages:pullingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
//    [header setImages:UIImage imageNamed:@"refresh" forState:MJRefreshStateRefreshing];
    
    
    self.tableView = [[UITableView alloc]init];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 141;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];

    [self.view addSubview:self.tableView];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self getData];
//
//    }];

    // 马上进入刷新状态
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 菊花
-(void)setJuhua{
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.progressHUD.progress = 0.0;
    self.progressHUD.dimBackground = NO; //设置有遮罩
    [self.progressHUD showAnimated:YES]; //显示进度框
    [self.view addSubview:self.progressHUD];
    
}
#pragma mark - 下拉刷新 -

-(void)loadNewData
{

    [self getData];
}

#pragma mark - 点击事件 -

-(void)fanhui{
    JMCityListViewController *vc = [[JMCityListViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)didSelectedCity_id:(NSString *)city_id{
    
    

}

-(void)rightAction{
    NSLog(@"搜索");
    LoginViewController *vc = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)getData{
    [[JMHTTPManager sharedInstance]fetchWorkPaginateWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

        if (responsObject[@"data"]) {

            self.arrDate = [JMHomeWorkModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
//            [[JMVideoPlayManager sharedInstance].C_User_playArray removeAllObjects];
            
//            [self getPlayerArray];
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            [self.progressHUD setHidden:YES];
        }

    } failureBlock:^(JMHTTPRequest * _Nonnull request, NSError  *error) {


    }];
    

}


-(void)resetAction{
}

-(void)OKAction
{
    [self.labschooseVC.view setHidden:YES];
    [self.tableView.mj_header beginRefreshing];

    
}


-(void)closeVideoAction{

  

}

//-(void)getPlayerArray
//{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        for (JMHomeWorkModel *model in self.arrDate) {
//            if (model.videoFile_path) {
//                NSURL *url = [NSURL URLWithString:model.videoFile_path];
//                //直接创建AVPlayer，它内部也是先创建AVPlayerItem，这个只是快捷方法
//                AVPlayer *player = [AVPlayer playerWithURL:url];
//
//                [[JMVideoPlayManager sharedInstance].C_User_playArray addObject:player];
//            }else{
//                [[JMVideoPlayManager sharedInstance].C_User_playArray addObject:[NSNull null]];
//
//            }
//
//        }
//
//        self.playerArray = [JMVideoPlayManager sharedInstance].C_User_playArray;
//    });
//
//}

#pragma mark - 所有职位 -

- (IBAction)allPositionAction:(UIButton *)sender {
    [self.allOfPositionBtn setBackgroundColor:MASTER_COLOR];
    [self.allOfPositionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.choosePositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.choosePositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.companyRequireBtn setBackgroundColor:[UIColor whiteColor]];
    [self.companyRequireBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.labschooseVC.view setHidden:YES];
}

#pragma mark - 职位筛选 -
- (IBAction)choosePosition:(UIButton *)sender {
    [self.allOfPositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.allOfPositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.choosePositionBtn setBackgroundColor:MASTER_COLOR];
    [self.choosePositionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.companyRequireBtn setBackgroundColor:[UIColor whiteColor]];
    [self.companyRequireBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.labschooseVC.view setHidden:YES];
    [self.navigationController pushViewController:self.choosePositionVC animated:YES];
//    [self.choosePositionVC.view setHidden:NO];
   
}

-(void)sendPositoinData:(NSString *)labStr labIDStr:(NSString *)labIDStr{
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 公司要求 -

- (IBAction)companyRequire:(UIButton *)sender {
    [self.companyRequireBtn setBackgroundColor:MASTER_COLOR];
    [self.companyRequireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.allOfPositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.allOfPositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.choosePositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.choosePositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.labschooseVC.view setHidden:NO];

 
}


-(void)playAction_cell:(HomeTableViewCell *)cell{
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:cell.model.videoFile_path];
    [[JMVideoPlayManager sharedInstance] play];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
     self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:playVC animated:NO];
    
//    if (self.playerArray) {
//        JMPlayerViewController *vc = [[JMPlayerViewController alloc]init];
//        vc.player = self.playerArray[cell.indexpath.row];
//        //    vc.player = cell.player;
//        //    vc.model = cell;
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }
}


#pragma mark - tableView DataSource -

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrDate.count;
}


#pragma mark - tableView Delegate -

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
//    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    cell.indexpath = indexPath;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JMHomeWorkModel *model = self.arrDate[indexPath.row];
    [cell setModel:model];
   
    return cell;
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobDetailsViewController *vc = [[JobDetailsViewController alloc] init];
    JMHomeWorkModel *model = self.arrDate[indexPath.row];

    vc.homeworkModel = model;
    
    [self.navigationController pushViewController:vc animated:YES];
    

}
#pragma mark - lazy

-(NSMutableArray *)playerArray
{
    if (_playerArray == nil) {
        _playerArray = [NSMutableArray array];
    }
    return _playerArray;
}


-(PositionDesiredViewController *)choosePositionVC{
    if (_choosePositionVC == nil) {
        _choosePositionVC = [[PositionDesiredViewController alloc]init];
        _choosePositionVC.searchView.hidden = YES;
        _choosePositionVC.delegate = self;
        [_choosePositionVC setIsHomeViewVC:YES];
//        _choosePositionVC.view.hidden = YES;
//        [self addChildViewController:_choosePositionVC];
//        [self.view addSubview:_choosePositionVC.view];
//        [_choosePositionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.headView.mas_bottom);
//            make.left.and.right.mas_equalTo(self.view);
//            make.bottom.mas_equalTo(self.view).mas_offset(-500);
//        }];
        
    }

    return _choosePositionVC;

}


-(JMLabsChooseViewController *)labschooseVC{
    if (_labschooseVC == nil) {
        _labschooseVC = [[JMLabsChooseViewController alloc]init];
        _labschooseVC.delegate = self;
        [self addChildViewController:_labschooseVC];
        [self.view addSubview:_labschooseVC.view];
        [_labschooseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headView.mas_bottom);
            make.left.and.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-71);
        }];
    }
    return  _labschooseVC;

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
