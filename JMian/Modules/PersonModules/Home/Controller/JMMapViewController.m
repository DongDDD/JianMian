//
//  JMMapViewController.m
//  JMian
//
//  Created by mac on 2019/5/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMapViewController.h"
#import "JMCustomAnnotationView.h"

@interface JMMapViewController ()<AMapSearchDelegate,MAMapViewDelegate,AMapLocationManagerDelegate>

@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)AMapSearchAPI *search;
@property(nonatomic,strong)AMapLocationManager *locationManager;
//@property (nonatomic ,strong)AMapPOIKeywordsSearchRequest *keywordsRequest;
@property (nonatomic ,strong)AMapPOIKeywordsSearchRequest *request;
@property (nonatomic ,strong)AMapPOI *POIModel;


@end

@implementation JMMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

   
}

-(void)setLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate{

    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    _mapView.delegate = self;

    [self.view addSubview:_mapView];

    [_mapView setCenterCoordinate:locationCoordinate animated:NO];
  
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = locationCoordinate;//设置地图的定位中心点坐标self.mapView.centerCoordinate = coor;//将点添加到地图上，即所谓的大头针
    [_mapView addAnnotation:pointAnnotation];
 
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
            cusView.adressName.text = self.adress;
            cusView.companyName.text = self.companyName;
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

  


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
