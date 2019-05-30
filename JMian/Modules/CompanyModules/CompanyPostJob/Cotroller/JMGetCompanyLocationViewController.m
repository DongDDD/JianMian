//
//  JMGetCompanyLocationViewController.m
//  JMian
//
//  Created by mac on 2019/4/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMGetCompanyLocationViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "DimensMacros.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "SearchView.h"
#import <AMapLocationKit/AMapLocationKit.h>



@interface JMGetCompanyLocationViewController ()<AMapSearchDelegate,MAMapViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,AMapLocationManagerDelegate>

@property(nonatomic,strong)MAMapView *mapView;
@property (nonatomic, assign)CLLocationCoordinate2D currentLocationCoordinate;
@property(nonatomic,strong)AMapSearchAPI *search;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)SearchView *searchView;
@property(nonatomic,strong)AMapLocationManager *locationManager;
//@property (nonatomic ,strong)AMapPOIKeywordsSearchRequest *keywordsRequest;
@property (nonatomic ,strong)AMapPOIKeywordsSearchRequest *request;
@property (nonatomic,assign)BOOL isHaveLocation;
@property (nonatomic ,strong)AMapPOI *POIModel;


@end

@implementation JMGetCompanyLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公司地址";
    [self initSearchView];
    [self initMapView];
    
    self.request = [[AMapPOIKeywordsSearchRequest alloc] init];
//    self.request.keywords  = @"商务住宅|餐饮服务|生活服务";
    /* 按照距离排序. */
    self.request.sortrule = 0;
    self.request.offset = 50;
    self.request.requireExtension = YES;
    [self configLocationManager];
    [self.view addSubview:self.tableView];
    [self setCenterPoint];
}

-(void)rightAction
{
    
    if(_delegate && [_delegate respondsToSelector:@selector(sendAdress_Data:)]){
        if (self.POIModel != nil) {
            [_delegate sendAdress_Data:self.POIModel];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initSearchView
{
    _searchView = [[SearchView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 40)];
    _searchView.searchTextField.delegate = self;
    [self.view addSubview:_searchView];
    
}

-(void)initMapView{
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;

    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    _mapView.delegate = self;
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
//    [AMapServices sharedServices].enableHTTPS = YES;
    ///把地图添加至view
    UIButton *localButton = [UIButton buttonWithType:UIButtonTypeCustom];
    localButton.frame = CGRectMake(SCREEN_WIDTH - 60, 235, 50, 50);
    [localButton addTarget:self action:@selector(locateAction) forControlEvents:UIControlEventTouchUpInside];
    localButton.layer.cornerRadius = 25;
    localButton.clipsToBounds = YES;
    [localButton setImage:[UIImage imageNamed:@"my_location"] forState:UIControlStateNormal];
    [self.mapView addSubview:localButton];

}

- (void)setCenterPoint{
    UIImageView *dingweiImg = [[UIImageView alloc]init];
    dingweiImg.image = [UIImage imageNamed:@"dingwei"];
    dingweiImg.layer.cornerRadius = 5;
    dingweiImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.mapView addSubview:dingweiImg];//添加注解
    [dingweiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_mapView);
        make.centerY.mas_equalTo(_mapView).mas_offset(-10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    
    
}



// 定位SDK
- (void)configLocationManager {
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //单次定位超时时间
    [self.locationManager setLocationTimeout:2];
    [self.locationManager setReGeocodeTimeout:1];
}

- (void)locateAction {
    //带逆地理的单次定位
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            NSLog(@"locError:{%ld - %@};",(long)error.code,error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed) {
                return ;
            }
        }
        //定位信息
        NSLog(@"location:%@", location);
        if (regeocode)
        {
//            self.isClickPoi = NO;
            self.currentLocationCoordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
//            self.city = regeocode.city;
            [self showMapPoint];
//            _AroundRequest = [[AMapPOIKeywordsSearchRequest alloc] init];
            _request.location = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
            [_search AMapPOIKeywordsSearch:_request];
        }
    }];
    
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{

    if (updatingLocation && _isHaveLocation == NO) {
        
        _request.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        [_search AMapPOIKeywordsSearch:_request];
        
//        [self showMapPoint];
//        CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
//        [_mapView setCenterCoordinate:locationCoordinate animated:YES];
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        _isHaveLocation = YES;
    }

}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    _dataArray = [NSMutableArray array];

    if (response.pois.count == 0)
    {
        return;
    }
    
    //    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"onPOISearchDone-----%@",obj.name);

        [self.dataArray addObject:obj];
        ;
    }];
    [self.tableView reloadData];
    NSLog(@"response-----%@",response);
    
    //解析response获取POI信息，具体解析见 Demo
}

- (void)showMapPoint{
    [_mapView setZoomLevel:15.1 animated:YES];
    [_mapView setCenterCoordinate:self.currentLocationCoordinate animated:YES];
}

#pragma mark - textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    [self initSearchRequest_keywords:textField.text request:nil];
//    _keywordsRequest = [[AMapPOIKeywordsSearchRequest alloc] init];
    self.request = [[AMapPOIKeywordsSearchRequest alloc] init];

    _request.keywords = textField.text;
    [_search AMapPOIKeywordsSearch:_request];
    [self.searchView.searchTextField resignFirstResponder];
//    [self.tableView reloadData];
    return YES;
}




#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"mapCell";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    AMapPOI *POIModel = [[AMapPOI alloc]init];
    POIModel = self.dataArray[indexPath.row];
    cell.textLabel.text = POIModel.name;
    cell.detailTextLabel.text = POIModel.address;
    NSLog(@"cell-----------%@",POIModel.name);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray) {
    [self setRightBtnTextName:@"保存"];

    self.POIModel = self.dataArray[indexPath.row];
    CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake(self.POIModel.location.latitude, self.POIModel.location.longitude);
    [_mapView setCenterCoordinate:locationCoordinate animated:YES];
    self.searchView.searchTextField.text = self.POIModel.name;
    }
//    [self initAction];
//    AMapPOI *obj = [[AMapPOI alloc]init];
//    obj = self.dataArray[indexPath.row];
//    _mapView.userLocation.title = obj.name;
//    _mapView.userLocation.subtitle = obj.address;

}
#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchView.frame.origin.y+_searchView.frame.size.height+10, SCREEN_WIDTH, self.view.frame.size.height-_searchView.frame.size.height-_searchView.frame.origin.y-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = BG_COLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = _mapView;
        //        _tableView.sectionFooterHeight = 225;
        _tableView.rowHeight = 64;
        _tableView.sectionHeaderHeight = 300;
        
    }
    return _tableView;
}
//-(NSMutableArray *)dataArray{
//    if (_dataArray == nil) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
