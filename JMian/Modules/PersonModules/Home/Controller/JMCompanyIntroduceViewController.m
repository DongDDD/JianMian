//
//  JMCompanyIntroduceViewController.m
//  JMian
//
//  Created by mac on 2019/4/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyIntroduceViewController.h"
#import "JMIntroduceContentView.h"
#import "SDCycleScrollView.h"
#import "MapBGView.h"
#import "JMCustomAnnotationView.h"
#import "JMCompanyVideoView.h"
#import "DimensMacros.h"
#import "JMTitlesView.h"
#import "JMVideoPlayManager.h"
#import "JMHTTPManager+Work.h"
#import "JMHTTPManager+FetchCompanyInfo.h"
#import "JMCompanyInfoModel.h"


@interface JMCompanyIntroduceViewController ()<SDCycleScrollViewDelegate,JMIntroduceContentViewDelegate,MAMapViewDelegate,UIScrollViewDelegate,JMCompanyVideoViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property(nonatomic,strong)JMCompanyVideoView *companyVideoView;
@property(nonatomic,strong)JMIntroduceContentView *introducetView;
@property(nonatomic,strong)UIView *pageContentView;

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;

@property(nonatomic,strong)JMTitlesView *titleView;

@property(nonatomic,strong)UIView *SDCScrollView;
@property(nonatomic,strong)JMIntroduceContentView *advantageView;
@property(nonatomic,strong)JMIntroduceContentView *brightSpoView;
@property(nonatomic,strong)MapBGView *mapBGView;
@property(nonatomic,strong)MAMapView *mapView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;

@end

@implementation JMCompanyIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    self.title = @"公司介绍";
    
    if (_viewType == JMCompanyIntroduceViewControllerCDetail) {
        [self getData];
    }else{
        [self initView];
    
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    CGRect pageFrame = self.pageContentView.frame;
    pageFrame.size.height = self.introducetView.frame.size.height + self.SDCScrollView.frame.size.height +self.advantageView.frame.size.height+self.brightSpoView.frame.size.height+self.mapView.frame.size.height;
    self.pageContentView.frame = pageFrame ;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.pageContentView.frame.size.height+self.headerView.frame.origin.y+self.headerView.frame.size.height);

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)initView{
    NSURL *url = [NSURL URLWithString:self.model.companyLogo_path];
    [self.headerImg sd_setImageWithURL:url];
    self.companyNameLab.text = self.model.companyName;
    NSString *subStr = [NSString stringWithFormat:@"%@",self.model.companyEmployee];
    self.subTitleLab.text = subStr;
    [self.scrollView addSubview:self.pageContentView];
    [self.scrollView addSubview:self.titleView];
    [self.pageContentView addSubview:self.companyVideoView];
    [self setIntroduceView];
    [self setSDCScrollView];
    [self setAdvantageView];
//    [self setBrightSpoView];
    [self setMapView];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,1800);
}


-(void)getData{
    [self showProgressHUD_view:self.view];
    [[JMHTTPManager sharedInstance]fetchCompanyInfo_Id:self.company_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            //因为这页面用homemodel赋值，现在不改变布局逻辑，建设好homeModel再布局
            JMCompanyInfoModel *comModel = [JMCompanyInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            self.model = [[JMHomeWorkModel alloc]init];
            self.model.companyName = comModel.company_name;
            self.model.companyLogo_path = comModel.logo_path;
            self.model.latitude = comModel.latitude;
            self.model.longitude = comModel.longitude;
            self.model.address = comModel.address;
            self.model.videoFile_path = [self getVideoPath_comModel:comModel];
            self.model.companyEmployee = comModel.employee;
            
            [self initView];
            
        }
        [self hiddenHUD];
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];
    
    
//    [[JMHTTPManager sharedInstance]fetchWorkInfoWith_Id:self.company_id  SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//
//
//        [self hiddenHUD];
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//
//    }];

}

-(NSString *)getVideoPath_comModel:(JMCompanyInfoModel *)comModel{
    if (comModel.files.count > 0) {
        for (JMFilesModel *filesModel in comModel.files) {
            if ([filesModel.files_type isEqualToString:@"1"]) {
                return filesModel.files_file_path;
            }
        }
    }
    return nil;
}
#pragma mark - 点击事件

-(void)didClickButton:(CGFloat)contentHeight{

        [self.introducetView.contenLab mas_updateConstraints:^(MASConstraintMaker *make) {
             make.bottom.mas_equalTo(self.introducetView.contenLab.mas_bottom).offset(30);
         
    
        }];
    

}
- (void)setCurrentIndex:(NSInteger)index {
   
//    [self.companyVideoView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
    
}


-(void)movePageContentView:(NSInteger)_index{
    
    __weak typeof(self) ws = self;
    
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect Frame = ws.pageContentView.frame;
        Frame.origin.x = -_index*SCREEN_WIDTH ;
        ws.pageContentView.frame = Frame;
  
    } completion:nil];
    
    switch (_index) {
        case 0:
              self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.pageContentView.frame.size.height+self.headerView.frame.origin.y+self.headerView.frame.size.height);
            break;
        case 1:
            self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.headerView.frame.size.height + SCREEN_HEIGHT);
            break;

            break;
        default:
            break;
    }
    
    
}

//
#pragma mark - 公司介绍
-(void)setIntroduceView{
    
    self.introducetView = [[JMIntroduceContentView alloc]init];

    self.introducetView.delegate = self;
    [self.view layoutIfNeeded];
    
    [self.scrollView addSubview:self.introducetView];
    
 
    [self.introducetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.left.mas_equalTo(self.pageContentView);
        make.bottom.mas_equalTo(self.introducetView.contenLab.mas_bottom).offset(30);
        make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(self.titleView.frame.size.height);
    }];


}


#pragma mark - 公司环境图片 —— 轮播图

-(void)setSDCScrollView{
    self.SDCScrollView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 211)];
//    containerView.contentSize = CGSizeMake(self.view.frame.size.width, 0);
    [self.pageContentView addSubview:self.SDCScrollView];
    
    [self.SDCScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.left.mas_equalTo(self.pageContentView);
        make.height.mas_equalTo(211);
         make.top.mas_equalTo(self.introducetView.mas_bottom);
    }];
    NSMutableArray *imagesURLStrings = [NSMutableArray array];
    for (JMComFilesModel *filesModel in self.model.files) {
        [imagesURLStrings addObject:filesModel.file_path];
        
    }
    
//    NSArray *imagesURLStrings = @[
//                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
//                                  ];

    

    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) delegate:self placeholderImage:[UIImage imageNamed:@"break"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.SDCScrollView addSubview:cycleScrollView2];
  
  
    
//    //         --- 模拟加载延迟
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
//    });
    
    
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        NSLog(@">>>>>  %ld", (long)index);
    };
    
    
//   self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.SDCScrollView.frame.origin.y+self.SDCScrollView.frame.size.height+500);
}


#pragma mark - 公司优势

-(void)setAdvantageView{
    self.advantageView = [[JMIntroduceContentView alloc]init];
    self.advantageView.contenLab.text = @"asdfasdfasdfasdfsdfssdfssf";
    [self.pageContentView addSubview:self.advantageView];
    
    [self.advantageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.SDCScrollView.mas_bottom);
        make.left.mas_equalTo(self.pageContentView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.mas_equalTo(300);
    }];

}
#pragma mark - 公司亮点
//-(void)setBrightSpoView{
//    self.brightSpoView = [[JMIntroduceContentView alloc]init];
//
//    [self.pageContentView addSubview:self.brightSpoView];
//
//    [self.brightSpoView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.advantageView.mas_bottom);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.left.mas_equalTo(self.pageContentView);
//        make.bottom.mas_equalTo(self.brightSpoView.contenLab.mas_bottom).offset(30);
//    }];
//
//}

#pragma mark - 获取视频图片

- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

#pragma mark - 高德地图

-(void)setMapView{
    //
    self.mapBGView = [[MapBGView alloc] init];
    [self.mapBGView setModel:self.model];
    [self.pageContentView addSubview:self.mapBGView];
    
    [self.mapBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(346);
        make.left.mas_equalTo(self.pageContentView);
        make.top.mas_equalTo(self.advantageView);
    }];
    
    [self.pageContentView addSubview:self.mapView];
    CLLocationDegrees latitude = [self.model.latitude doubleValue];
    CLLocationDegrees longitude = [self.model.longitude doubleValue];
    CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    [self.mapView setCenterCoordinate:locationCoordinate animated:NO];
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = locationCoordinate;//设置地图的定位中心点坐标self.mapView.centerCoordinate = coor;//将点添加到地图上，即所谓的大头针
    [_mapView addAnnotation:pointAnnotation];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.mapBGView);
        make.height.mas_equalTo(224);
        make.bottom.mas_equalTo(self.mapBGView);
    }];
    
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id)annotation {
    //大头针标注
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        //判断是否是自己的定位气泡，如果是自己的定位气泡，不做任何设置，显示为蓝点，如果不是自己的定位气泡，比如大头针就会进入
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAAnnotationView *annotationView = (MAAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if ( annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
            
            
            JMCustomAnnotationView *cusView = [[JMCustomAnnotationView alloc]init];
            cusView.adressName.text = self.model.address;
            cusView.companyName.text = self.model.companyName;
            [annotationView addSubview:cusView];
            [cusView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(annotationView);
                make.centerY.mas_equalTo(annotationView);
                make.width.mas_equalTo(SCREEN_WIDTH*0.8);
                make.height.mas_equalTo(86);
            }];
            
            return annotationView;
        }
        
    }
    return nil;
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= _headerView.frame.origin.y+_headerView.frame.size.height){
        //只修改Y值
        self.titleView.frame = CGRectMake(self.titleView.frame.origin.x, 0, self.titleView.frame.size.width, self.titleView.frame.size.height);
        [self.view addSubview:self.titleView];
        
    }else{
        
        self.titleView.frame = CGRectMake(self.titleView.frame.origin.x, _headerView.frame.origin.y+_headerView.frame.size.height, self.titleView.frame.size.width, self.titleView.frame.size.height);
//        _pageView.frame = CGRectMake(_pageView.frame.origin.x,_titleView.frame.origin.y+_titleView.frame.size.height, _pageView.frame.size.width, _pageView.frame.size.height);
        [self.scrollView addSubview:self.titleView];
    }
    
}

#pragma mark - 播放
-(void)playAction{
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:self.videoUrl videoID:@"666"];
    [[JMVideoPlayManager sharedInstance] play];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    [self presentViewController:playVC animated:YES completion:nil];
    [[JMVideoPlayManager sharedInstance] play];
}

#pragma mark - lazy
///初始化地图
-(MAMapView *)mapView{
    
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        _mapView.delegate = self;
        _mapView.scrollEnabled = NO;

        [self.view addSubview:_mapView];
 
        
    }
    return _mapView;
    
}


- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0,self.headerView.frame.origin.y+self.headerView.frame.size.height, SCREEN_WIDTH, 43} titles:@[@"公司详情", @"公司视频"]];
        __weak JMCompanyIntroduceViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            [weakSelf movePageContentView:index];

//            _index = index;
        };
    }
    
    return _titleView;
}

-(UIView *)pageContentView{
    if (_pageContentView == nil) {
        _pageContentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.headerView.frame.origin.y + self.headerView.frame.size.height+self.titleView.frame.size.height, SCREEN_WIDTH*2, 300)];
    }
    return _pageContentView;
}

- (JMCompanyVideoView *)companyVideoView {
    if (!_companyVideoView) {
        _companyVideoView = [[JMCompanyVideoView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 460)];
        _companyVideoView.delegate = self;
        
        _companyVideoView.videoUrl = self.videoUrl;
        
        
    }
    
    return _companyVideoView;
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
