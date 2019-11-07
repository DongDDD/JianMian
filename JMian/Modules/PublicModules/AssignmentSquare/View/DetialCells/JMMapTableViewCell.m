//
//  JMMapTableViewCell.m
//  JMian
//
//  Created by mac on 2019/8/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMapTableViewCell.h"
#import "DimensMacros.h"
#import "JMCustomAnnotationView.h"

NSString *const JMMapTableViewCellIdentifier = @"JMMapTableViewCellIdentifier";

@interface JMMapTableViewCell ()<MAMapViewDelegate>
@property(nonatomic, strong)MAMapView *mapView;
@property(nonatomic, strong)JMCDetailModel *myModel;
@property(nonatomic, strong)JMCompanyInfoModel *myComModel;

@property (weak, nonatomic) IBOutlet UILabel *adressLab;

@end

@implementation JMMapTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//     self.mapBGView = [[MapBGView alloc] init];
}
-(void)setModel:(JMCDetailModel *)model{
    _myModel = model;
    _adressLab.text = self.address;
    if (model.latitude.length > 0 && model.longitude.length > 0) {
        [self addSubview:self.mapView];
        CLLocationDegrees latitude = [model.latitude doubleValue];
        CLLocationDegrees longitude = [model.longitude doubleValue];
        CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
        [self.mapView setCenterCoordinate:locationCoordinate animated:NO];
        _mapView.scrollEnabled = NO;
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = locationCoordinate;//设置地图的定位中心点坐标self.mapView.centerCoordinate = coor;//将点添加到地图上，即所谓的大头针
        [_mapView addAnnotation:pointAnnotation];
        
    }
}

-(void)setComModel:(JMCompanyInfoModel *)comModel{
    _myComModel = comModel;
    _adressLab.text = self.address;
    if (comModel.latitude.length > 0 && comModel.longitude.length > 0) {
        [self addSubview:self.mapView];
        CLLocationDegrees latitude = [self.latitude doubleValue];
        CLLocationDegrees longitude = [self.longitude doubleValue];
        CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
        [self.mapView setCenterCoordinate:locationCoordinate animated:NO];
        _mapView.scrollEnabled = NO;
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = locationCoordinate;//设置地图的定位中心点坐标self.mapView.centerCoordinate = coor;//将点添加到地图上，即所谓的大头针
        [_mapView addAnnotation:pointAnnotation];
        
    }
    
    
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
//            cusView.adressName.text = @"adressName";
            cusView.adressName.text = self.address;
            if (_myComModel) {
                cusView.companyName.text = _myComModel.company_name;

            }
            if (_myModel) {
                cusView.companyName.text = _myModel.company_company_name;

            }
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - lazy

///初始化地图
-(MAMapView *)mapView{
    
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,self.adressLab.frame.origin.y+self.adressLab.frame.size.height+17, SCREEN_WIDTH, 300)];
        _mapView.delegate = self;
        
        [self addSubview:_mapView];
        
        //        [_mapView setCenterCoordinate:locationCoordinate animated:NO];
        
        //        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        //        pointAnnotation.coordinate = locationCoordinate;//设置地图的定位中心点坐标self.mapView.centerCoordinate = coor;//将点添加到地图上，即所谓的大头针
        //        [_mapView addAnnotation:pointAnnotation];
        
    }
    return _mapView;
    
}
@end
