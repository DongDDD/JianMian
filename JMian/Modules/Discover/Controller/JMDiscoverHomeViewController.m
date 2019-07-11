//
//  JMDiscoverHomeViewController.m
//  JMian
//
//  Created by mac on 2019/5/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMDiscoverHomeViewController.h"
#import "JMTitlesView.h"
#import "JMDiscoverTopView.h"
#import "JMDiscoverCollectionViewCell.h"
#import "JMHTTPManager+FectchVideoLists.h"
#import "JMVideoListCellData.h"
#import "JMVideoPlayManager.h"
#import "JMCityListViewController.h"

//static CGFloat kMagin = 10.f;

@interface JMDiscoverHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,JMDiscoverCollectionViewCellDelegate,JMCityListViewControllerDelegate>
@property(nonatomic ,strong)JMTitlesView *titleView;
@property(nonatomic ,strong)JMDiscoverTopView *discoverTopView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *videoDataList;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, copy)NSString *mode;
@property (nonatomic, copy)NSString *city_id;
@property (nonatomic, assign)BOOL isShowAllData;
@property (nonatomic, strong)NSMutableArray *imageArray;
@end

@implementation JMDiscoverHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.navigationController.navigationBarHidden = YES;
    self.mode = @"2";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = YES;

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;

}

-(void)initView{
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.discoverTopView];
    [self.discoverTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.height.mas_equalTo(39);
    }];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.discoverTopView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
    [self setupHeaderRefresh];
    [self setupFooterRefresh];
}

#pragma mark - 下拉刷新 -
-(void)setupHeaderRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    [self.collectionView.mj_header beginRefreshing];
}

-(void)setupFooterRefresh
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreBills)];
    
    // 设置文字
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    footer.stateLabel.textColor = MASTER_COLOR;
    
    // 设置footer
    self.collectionView.mj_footer = footer;
    //     self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreBills)];
}


-(void)loadMoreBills
{
    
    [self getData_mode:self.mode];;//全职

}
-(void)refreshData
{
    [self.videoDataList removeAllObjects];
    [self.imageArray removeAllObjects];
    [self getData_mode:self.mode];;//全职

}

-(void)setCurrentIndex{
    [self.videoDataList removeAllObjects];
    [self.imageArray removeAllObjects];
    switch (_index) {
        case 0:
            self.mode = @"2";
            break;
        case 1:
            self.mode = @"1";
            break;
            
        default:
            break;
    }
    [self getData_mode:self.mode];;


}
#pragma mark Action
-(void)changeCityAction{
    JMCityListViewController *vc = [[JMCityListViewController alloc]init];
    vc.delegate = self;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        if (_index == 0) {
            vc.viewType = JMCityListViewPartTime;
            
        }else if (_index == 1) {
            vc.viewType = JMCityListViewDefault;
        }
        
    }
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark   getData
-(void)getData_mode:(NSString *)mode{
    [self showProgressHUD_view:self.view];
    [[JMHTTPManager sharedInstance]fectchVideoList_mode:mode city_id:_city_id contact_phone:nil per_page:@"10" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
//            NSMutableArray *array = [NSMutableArray array];
            self.videoDataList = [JMVideoListCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            
//            [self.videoDataList addObjectsFromArray:array]
            if (self.videoDataList.count < 10) {
                [self.collectionView.mj_footer setHidden:YES];
//                _isShowAllData = YES;
            }
            
//            [self.videoDataList addObjectsFromArray:array];
            [self.collectionView reloadData];
 

        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [self hiddenHUD];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];

}


#pragma mark   MyDelegate
-(void)didClickPlayAction_data:(JMVideoListCellData *)data{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    NSString *videoUrl;
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        videoUrl = data.video_file_path;
    }else{
        JMCVideoModel *CVideoModel = data.video[0];
 
        videoUrl = CVideoModel.file_path;
        
    
    }

    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:videoUrl];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    [self presentViewController:playVC animated:YES completion:nil];
    [[JMVideoPlayManager sharedInstance] play];
    

}
-(void)didSelectedCity_id:(NSString *)city_id city_name:(NSString *)city_name{
    
    _city_id = city_id;
    self.discoverTopView.leftLab.text = city_name;
//    self.arrDate = [NSMutableArray array];
    [self.collectionView.mj_header beginRefreshing];
    
}

#pragma mark  UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.videoDataList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JMDiscoverCollectionViewCell *cell = (JMDiscoverCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setData:self.videoDataList[indexPath.row]];
//    if (self.imageArray.count > 0) {
//        [cell setVideoImage:self.imageArray[indexPath.row]];
//    }
   
     return cell;
}




- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        //自动网格布局
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat itemWidth = (SCREEN_WIDTH ) / 3;
        
        //设置单元格大小
        flowLayout.itemSize = CGSizeMake(itemWidth, 265);
        //最小行间距(默认为10)
        flowLayout.minimumLineSpacing = 0;
        //最小item间距（默认为10）
        flowLayout.minimumInteritemSpacing = 0;
        //设置senction的内边距@
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[JMDiscoverCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.backgroundColor = BG_COLOR;
        _collectionView.layer.borderWidth = 0;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}


- (JMTitlesView *)titleView {
    if (!_titleView) {
        NSString *str1;
        NSString *str2;
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        if ([userModel.type isEqualToString:B_Type_UESR]) {
            str1 = @"兼职";
            str2 = @"全职";
        }else{
            str1 = @"企业";
            str2 = @"最新";
        }
        
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, SafeAreaTopHeight-40, SCREEN_WIDTH, 43} titles:@[str1, str2]];
        _titleView.viewType = JMTitlesViewDefault;
        [_titleView setCurrentTitleIndex:0];
        __weak JMDiscoverHomeViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf setCurrentIndex];
        };
    }
    
    return _titleView;
}

-(JMDiscoverTopView *)discoverTopView{
    if (!_discoverTopView) {
        _discoverTopView = [[JMDiscoverTopView alloc]init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeCityAction)];
        [_discoverTopView addGestureRecognizer:tap];
    }
    return  _discoverTopView;

}

-(NSMutableArray *)videoDataList{
    if (_videoDataList.count == 0) {
        _videoDataList = [NSMutableArray array];
    }
    return _videoDataList;

}

-(NSMutableArray *)imageArray{
    if (_imageArray.count == 0) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
    
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
