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


@interface JMGetCompanyLocationViewController ()<AMapSearchDelegate,MAMapViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)CLLocation *currentLocation;
@property(nonatomic,strong)AMapSearchAPI *search;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation JMGetCompanyLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AMapServices sharedServices].apiKey = AMapAPIKey;
    
    [self initMapView];
    [self initSearchRequest_keywords:nil city:nil];
    [self.view addSubview:self.tableView];
 


}

-(void)initSearchRequest_keywords:(NSString *)keywords city:(NSString *)city
{
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = @"广州美术学院";
    request.city                = @"广州";
    request.types               = @"高等院校";
    request.requireExtension    = YES;
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    
    [_search AMapPOIKeywordsSearch:request];

}

-(void)initMapView{
    
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    _mapView.delegate = self;
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    [AMapServices sharedServices].enableHTTPS = YES;
    ///把地图添加至view
    [self.view addSubview:_mapView];
   

}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    _currentLocation = [userLocation.location copy];
    NSLog(@"用户位置更新%@",userLocation.location);


}

-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        [self initAction];
    }

}

-(void)initAction {

    if (_currentLocation) {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc]init];
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        
    }

}

//-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
//{
//    NSLog(@"response-----%@",response);
//    NSString *str1 = response.regeocode.addressComponent.city;
//    if (str1.length == 0) {
//        str1 = response.regeocode.addressComponent.province;
//    }
//
//}



- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    
    if (response.pois.count == 0)
    {
        return;
    }
    
//    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {

        [self.dataArray addObject:obj];
;
    }];
    [self.tableView reloadData];
    NSLog(@"response-----%@",response);

    //解析response获取POI信息，具体解析见 Demo
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
    AMapPOI *obj = [[AMapPOI alloc]init];
    obj = self.dataArray[indexPath.row];
    cell.textLabel.text = obj.name;
    cell.detailTextLabel.text = obj.address;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self initAction];
    AMapPOI *obj = [[AMapPOI alloc]init];
    obj = self.dataArray[indexPath.row];
    _mapView.userLocation.title = obj.name;
    _mapView.userLocation.subtitle = obj.address;
}
#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
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
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
