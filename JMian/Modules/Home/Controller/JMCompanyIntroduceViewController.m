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
#import "Masonry.h"
#import "MapView.h"


@interface JMCompanyIntroduceViewController ()<SDCycleScrollViewDelegate,JMIntroduceContentViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property(nonatomic,strong)JMIntroduceContentView *contentView;
@property(nonatomic,strong)UIView *SDCScrollView;
@property(nonatomic,strong)JMIntroduceContentView *advantageView;
@property(nonatomic,strong)JMIntroduceContentView *brightSpoView;
@property(nonatomic,strong)MapView *mapView;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation JMCompanyIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setIntroduceView];
    [self setSDCScrollView];
    [self setAdvantageView];
//    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,0);
    [self setBrightSpoView];
    [self setMapView];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.mapView.frame.origin.y+self.mapView.frame.size.height);
}





#pragma mark - 点击事件

-(void)didClickButton:(CGFloat)contentHeight{

   
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.mas_equalTo(self.scrollView);
//        make.width.mas_equalTo(200);
//
//        make.bottom.mas_equalTo(self.contentView.contenLab.mas_bottom).offset(30);
//        make.top.mas_equalTo(self.headerView.mas_bottom);
//    }];
        [self.contentView.contenLab mas_updateConstraints:^(MASConstraintMaker *make) {
             make.bottom.mas_equalTo(self.contentView.contenLab.mas_bottom).offset(30);
         
    
        }];
    
//
//    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
//
//       make.height.mas_equalTo(contentHeight+64);
//
//    }];


}
//
#pragma mark - 公司介绍
-(void)setIntroduceView{
    
    
    self.contentView = [[JMIntroduceContentView alloc]init];
//    self.contentView.frame = CGRectMake(0, self.headerView.frame.origin.y+self.headerView.frame.size.height,SCREEN_WIDTH, self.contentView.contenLab.frame.origin.y+self.contentView.contenLab.frame.size.height);
    
    self.contentView.delegate = self;
    [self.view layoutIfNeeded];
    
    [self.scrollView addSubview:self.contentView];
    
    
//    [self.contentView.contenLab mas_updateConstraints:^(MASConstraintMaker *make) {
//
//        make.height.mas_equalTo(93);
//
//    }];
//
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(194);
        make.bottom.mas_equalTo(self.contentView.contenLab.mas_bottom).offset(30);
        make.top.mas_equalTo(self.headerView.mas_bottom);
    }];
    
    
//    UITapGestureRecognizer *spreadTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(spreadAction:)];
//
//
//    [self.scrollView addGestureRecognizer:spreadTap];
//
//
    

}






#pragma mark - 公司环境图片 —— 轮播图

-(void)setSDCScrollView{
    self.SDCScrollView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 211)];
//    containerView.contentSize = CGSizeMake(self.view.frame.size.width, 0);
    [self.scrollView addSubview:self.SDCScrollView];
    
    [self.SDCScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView);
        make.height.mas_equalTo(211);
         make.top.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    
    
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];

    

    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) delegate:self placeholderImage:[UIImage imageNamed:@"break"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.SDCScrollView addSubview:cycleScrollView2];
  
    
    
    
    
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
    
    
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        NSLog(@">>>>>  %ld", (long)index);
    };
    
    
//   self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,self.SDCScrollView.frame.origin.y+self.SDCScrollView.frame.size.height+500);
}


#pragma mark - 公司优势

-(void)setAdvantageView{
    self.advantageView = [[JMIntroduceContentView alloc]init];
    
    [self.scrollView addSubview:self.advantageView];
    
    [self.advantageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.SDCScrollView.mas_bottom);
        make.left.and.right.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView);
        make.bottom.mas_equalTo(self.advantageView.contenLab.mas_bottom).offset(30);
    }];

}
#pragma mark - 公司亮点
-(void)setBrightSpoView{
    self.brightSpoView = [[JMIntroduceContentView alloc]init];
    
    [self.scrollView addSubview:self.brightSpoView];
    
    [self.brightSpoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.advantageView.mas_bottom);
        make.left.and.right.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView);
        make.bottom.mas_equalTo(self.brightSpoView.contenLab.mas_bottom).offset(30);
    }];
    
}

-(void)setMapView{
    self.mapView  = [[MapView alloc]init];
    [self.scrollView addSubview:self.mapView];
    
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.brightSpoView.mas_bottom);
        make.height.mas_equalTo(316);
        make.left.and.right.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView);
    }];
    
    



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
