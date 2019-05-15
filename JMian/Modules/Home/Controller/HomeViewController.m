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
#import "JMHTTPManager+PositionDesired.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "JMVideoPlayManager.h"
#import "JMPlayerViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,JMLabsChooseViewControllerDelegate,HomeTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIButton *pushPositionBtn; //j推荐职位
@property (weak, nonatomic) IBOutlet UIButton *allPositionBtn;//所有职位
@property (weak, nonatomic) IBOutlet UIButton *companyRequireBtn;//公司要求
@property (nonatomic, strong) NSArray *arrDate;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JMLabsChooseViewController *labschooseVC;
@property(nonatomic,strong)NSMutableArray *playerArray;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

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
//    self.progressHUD.mode = MBProgressHUDModeCustomView;
    self.progressHUD.progress = 0.0;
        self.progressHUD.dimBackground = NO; //设置有遮罩
        self.progressHUD.label.text = @"加载中..."; //设置进度框中的提示文字
    [self.progressHUD showAnimated:YES]; //显示进度框
    
//    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"minloading"]];
    //    imgView.frame = CGRectMake(0, 0, 68, 99);
//    self.progressHUD.customView = imgView;
    
    [self.view addSubview:self.progressHUD];
    
}
#pragma mark - 下拉刷新 -

-(void)loadNewData
{

    [self getData];
}
#pragma mark - 点击事件 -

-(void)fanhui{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    
    [[JMHTTPManager sharedInstance]fetchCityListWithMyId:userModel.user_id mode:@"lists" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

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
            [[JMVideoPlayManager sharedInstance].C_User_playArray removeAllObjects];
            
            [self getPlayerArray];
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            [self.progressHUD setHidden:YES];
        }

    } failureBlock:^(JMHTTPRequest * _Nonnull request, NSError  *error) {


    }];
    

}

-(void)getPlayerArray
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        for (JMHomeWorkModel *model in self.arrDate) {
            if (model.videoFile_path) {
                NSURL *url = [NSURL URLWithString:model.videoFile_path];
                //直接创建AVPlayer，它内部也是先创建AVPlayerItem，这个只是快捷方法
                AVPlayer *player = [AVPlayer playerWithURL:url];

                [[JMVideoPlayManager sharedInstance].C_User_playArray addObject:player];
            }else{
                [[JMVideoPlayManager sharedInstance].C_User_playArray addObject:[NSNull null]];

            }
            
        }
        
        self.playerArray = [JMVideoPlayManager sharedInstance].C_User_playArray;
    });

}

#pragma mark - 推荐职位 -

- (IBAction)pushPositionAction:(UIButton *)sender {
    [self.pushPositionBtn setBackgroundColor:MASTER_COLOR];
    [self.pushPositionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.allPositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.allPositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.companyRequireBtn setBackgroundColor:[UIColor whiteColor]];
    [self.companyRequireBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.labschooseVC.view setHidden:YES];

}


#pragma mark - 所有职位 -

- (IBAction)allPosition:(UIButton *)sender {
    [self.pushPositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.pushPositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.allPositionBtn setBackgroundColor:MASTER_COLOR];
    [self.allPositionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.companyRequireBtn setBackgroundColor:[UIColor whiteColor]];
    [self.companyRequireBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.labschooseVC.view setHidden:YES];

   
}


#pragma mark - 公司要求 -

- (IBAction)companyRequire:(UIButton *)sender {
    [self.companyRequireBtn setBackgroundColor:MASTER_COLOR];
    [self.companyRequireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.pushPositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.pushPositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.allPositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.allPositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.labschooseVC.view setHidden:NO];

 
}

-(void)resetAction{
}

-(void)OKAction
{
    [self.labschooseVC.view setHidden:YES];
  
    
}


-(void)playAction_cell:(HomeTableViewCell *)cell{
    if (self.playerArray) {
        JMPlayerViewController *vc = [[JMPlayerViewController alloc]init];
        vc.player = self.playerArray[cell.indexpath.row];
        //    vc.player = cell.player;
        //    vc.model = cell;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
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
#pragma mark - lazy

-(NSMutableArray *)playerArray
{
    if (_playerArray == nil) {
        _playerArray = [NSMutableArray array];
    }
    return _playerArray;
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
            make.height.mas_equalTo(self.view);
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
